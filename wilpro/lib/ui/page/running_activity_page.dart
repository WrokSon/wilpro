import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:wilpro/model/activity.dart';
import 'package:wilpro/model/enum/state_task_enum.dart';
import 'package:wilpro/model/state_task.dart';
import 'package:wilpro/model/structure/my_time.dart';
import 'package:wilpro/model/structure/my_timer.dart';
import 'package:wilpro/model/task.dart';
import 'package:wilpro/service/notifier/activity_notifier.dart';
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
  final notifier = ActivityNotifier.instance;
  final List<StateTask> stateList = [];
  List<Task> listTasks = [];
  int currentTask = 0;
  bool lockButtonDown = false;
  bool isPause = false;
  bool isFinish = false;
  late MyTimer globalTimer;
  late MyTimer taskTimer;

  _RunningActivityPage() {
    globalTimer = MyTimer(
      update: (value) {
        if (listTasks[currentTask].withTimer && value.second < 0) {
          stateList[currentTask].state = StateTaskEnum.success;
          changeTask();
        }
        setState(() {});
      },
    );
    taskTimer = MyTimer();
  }

  @override
  void initState() {
    listTasks = notifier.getListTaskById(widget.item.id);
    globalTimer.startTimer();
    taskTimer.startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.item.title),
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
                    child:
                        MyWidgets.text(text: globalTimer.getText(), size: 50))),
            banier(listTasks[currentTask]),
            Expanded(
              flex: 2,
              child: ListView.builder(
                itemCount: listTasks.length,
                itemBuilder: (context, index) => itemListTask(index),
              ),
            ),
            const SizedBox(height: 3),
            bottom(),
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
                                stateList[currentTask].state =
                                    StateTaskEnum.success;
                                changeTask();
                              },
                              color: MyColors.black,
                            ),
                          ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: MyWidgets.button(
                        text: "PASSER",
                        onTap: () {
                          setState(() {
                            stateList[currentTask].state =
                                StateTaskEnum.failed; // avant
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

    currentTask++;
    stateList[currentTask].state = StateTaskEnum.current;
    print(stateList[currentTask].state);
    final task = listTasks[currentTask];
    taskTimer.setTimer(
        limit: task.withTimer
            ? MyTime.fromValue(widget.item.tasks[currentTask].value)
            : null);
  }

  Widget itemListTask(int index) {
    final task = listTasks[index];
    final stateTask = stateList.firstWhere(
      (element) =>
          element.idTask == task.id &&
          element.idQuantiyActivity == widget.item.tasks[index].id,
      orElse: () {
        final add = StateTask(
          idQuantiyActivity: const Uuid().v1(),
          idTask: task.id,
          state: stateList.length == currentTask
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
                  color: MyColors.white,
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
                Navigator.popAndPushNamed(context, SectionPage.nameReoute);
                globalTimer.stopTimer();
                taskTimer.stopTimer();
              },
              color: MyColors.red,
            ),
          ),
        ],
      );
}
