import 'package:flutter/material.dart';
import 'package:wilpro/model/activity.dart';
import 'package:wilpro/model/enum/state_task_enum.dart';
import 'package:wilpro/model/state_task.dart';
import 'package:wilpro/model/structure/music_player.dart';
import 'package:wilpro/model/structure/my_time.dart';
import 'package:wilpro/model/structure/my_timer.dart';
import 'package:wilpro/model/task.dart';
import 'package:wilpro/service/notifier/activity_notifier.dart';
import 'package:wilpro/service/notifier/history_notifier.dart';
import 'package:wilpro/service/notifier/settings_notifier.dart';
import 'package:wilpro/service/tools.dart';
import 'package:wilpro/ui/composants/my_colors.dart';
import 'package:wilpro/ui/composants/my_widgets.dart';
import 'package:wilpro/ui/page/section_page.dart';

class RunningActivityPage extends StatefulWidget {
  final Activity item;
  static const nameReoute = "/running";
  const RunningActivityPage({super.key, required this.item});

  @override
  State<RunningActivityPage> createState() => _RunningActivityPage();
}

class _RunningActivityPage extends State<RunningActivityPage> {
  final activityNotifier = ActivityNotifier.instance;
  final historyNotifier = HistoryNotifier.instance;
  final settingsNotifier = SettingsNotifier.instance;
  final List<StateTask> stateList = [];
  List<Task> listTasks = [];
  int currentTask = 0;
  bool lockButtonDown = false;
  bool isPause = false;
  bool isFinish = false;
  late DateTime beginActivity;
  late MyTimer globalTimer;
  late MyTimer taskTimer;
  // final notif = MyNotification();

  _RunningActivityPage() {
    globalTimer = MyTimer(
      update: (value) {
        // notif.showNotification(
        //   id: widget.item.id,
        //   title: widget.item.title,
        //   body: globalTimer.getText(),
        // );
        setState(() {});
      },
    );
    taskTimer = MyTimer(
      update: (value) {
        if (listTasks[currentTask].withTimer && value.getValue() == 0) {
          stateList.firstWhere((test) => test.index == currentTask).state =
              StateTaskEnum.success;
          changeTask();
        }
      },
    );
  }

  @override
  void initState() {
    listTasks = activityNotifier.getListTaskById(widget.item.id);
    if (listTasks[0].withTimer) {
      taskTimer.setTimer(limit: MyTime.fromValue(widget.item.tasks[0].value));
    }
    globalTimer.startTimer();
    taskTimer.startTimer();
    beginActivity = DateTime.now();
    super.initState();
    // notif.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: MyWidgets.text(text: widget.item.title, color: MyColors.black),
        backgroundColor: MyColors.background,
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        color: MyColors.background,
        child: Column(
          children: [
            Expanded(
                child: Center(
                    child: MyWidgets.text(
                        text: globalTimer.getText(),
                        size: 50,
                        color: MyColors.black))),
            banier(listTasks[currentTask]),
            Expanded(
              flex: 2,
              child: ListView.builder(
                itemCount: listTasks.length,
                itemBuilder: (context, index) => itemListTask(index),
              ),
            ),
            const SizedBox(height: 3),
            isFinish
                ? MyWidgets.button(
                    text: "Terminer",
                    onTap: endActivity,
                    width: double.infinity,
                  )
                : bottom(),
          ],
        ),
      ),
    );
  }

  Widget banier(Task task) => Padding(
        padding: const EdgeInsets.only(bottom: 50),
        child: Card(
          elevation: 10,
          color: MyColors.backgroundNavBar,
          child: Padding(
            padding:
                const EdgeInsets.only(top: 20, bottom: 10, right: 10, left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                MyWidgets.text(text: taskToString(task)),
                Padding(
                  padding: const EdgeInsets.only(bottom: 30, top: 5),
                  child: MyWidgets.text(
                    text: taskTimer.getText(),
                  ),
                ),
                Row(
                  children: [
                    task.withTimer
                        ? const SizedBox()
                        : Expanded(
                            child: MyWidgets.button(
                              text: "FINI",
                              onTap: () {
                                if (isFinish) return;
                                setState(() {
                                  stateList
                                      .firstWhere(
                                          (test) => test.index == currentTask)
                                      .state = StateTaskEnum.success;
                                  changeTask();
                                });
                              },
                              color: MyColors.black,
                            ),
                          ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: MyWidgets.button(
                        text: "PASSER",
                        onTap: () {
                          if (isFinish) return;
                          setState(() {
                            stateList
                                .firstWhere((test) => test.index == currentTask)
                                .state = StateTaskEnum.failed; // avant
                            changeTask();
                          });
                        },
                        color: MyColors.black,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      );

  String taskToString(Task task) {
    final quantity =
        widget.item.tasks.firstWhere((element) => element.idTask == task.id);
    return "${task.withTimer ? Tools.timeString(MyTime.fromValue(quantity.value), enLettre: true) : quantity.value.toString()} : ${task.title}";
  }

  void changeTask() {
    if (currentTask >= listTasks.length - 1) {
      globalTimer.stopTimer(resets: false);
      taskTimer.stopTimer(resets: false);
      isFinish = true;
      return;
    }
    settingsNotifier.playSound ? MusicPlayer.instance.playSound() : null;
    currentTask++;
    stateList.firstWhere((test) => test.index == currentTask).state =
        StateTaskEnum.current;
    final task = listTasks[currentTask];
    taskTimer.setTimer(
        limit: task.withTimer
            ? MyTime.fromValue(widget.item.tasks[currentTask].value)
            : null);
  }

  Widget itemListTask(int index) {
    final task = listTasks[index];
    final stateTask = stateList.firstWhere(
      (element) => element.idTask == task.id && element.index == index,
      orElse: () {
        final add = StateTask(
          index: index,
          idTask: task.id,
          state: index == currentTask
              ? StateTaskEnum.current
              : StateTaskEnum.notyet,
        );
        stateList.add(add);
        return add;
      },
    );

    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(20),
      width: double.infinity,
      color: stateTask.state.color,
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: Text(
        taskToString(task),
      ),
    );
  }

  Widget bottom() => Row(
        children: [
          Expanded(
            flex: 5,
            child: MyWidgets.button(
              isEnabled: lockButtonDown,
              text: isPause ? "REPRENDRE" : "PAUSE",
              onTap: () {
                if (isPause) {
                  globalTimer.startTimer(resets: false);
                  taskTimer.startTimer(resets: false);
                } else {
                  globalTimer.stopTimer(resets: false);
                  taskTimer.stopTimer(resets: false);
                }
                setState(() {
                  isPause = !isPause;
                });
              },
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              height: 50,
              margin: const EdgeInsets.symmetric(horizontal: 5),
              color: MyColors.black,
              child: IconButton(
                onPressed: () {
                  setState(() {
                    lockButtonDown = !lockButtonDown;
                  });
                },
                icon: Icon(
                  lockButtonDown ? Icons.lock_open : Icons.lock,
                  color:
                      settingsNotifier.darkMode ? Colors.black : MyColors.white,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: MyWidgets.button(
              isEnabled: lockButtonDown,
              text: "ARRETER",
              onTap: () {
                endActivity();
              },
              color: MyColors.red,
            ),
          ),
        ],
      );

  void endActivity() {
    Navigator.popAndPushNamed(context, SectionPage.nameReoute);
    settingsNotifier.autoSaveHistory
        ? historyNotifier.addHistory(
            idActivity: widget.item.id,
            duration: MyTime.fromValue(globalTimer.getValue()),
            begin: beginActivity,
          )
        : null;
    globalTimer.stopTimer();
    taskTimer.stopTimer();
  }
}
