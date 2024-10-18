import 'package:flutter/material.dart';
import 'package:wilpro/model/activity.dart';
import 'package:wilpro/model/enum/format_time_enum.dart';
import 'package:wilpro/model/enum/state_task_enum.dart';
import 'package:wilpro/model/state_task.dart';
import 'package:wilpro/model/structure/my_time.dart';
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
  @override
  Widget build(BuildContext context) {
    listTasks = notifier.getListTaskById(widget.item.id);
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
                child:
                    Center(child: MyWidgets.text(text: "00:12:05", size: 50))),
            banier(listTasks[currentTask]),
            Expanded(
              flex: 2,
              child: ListView.builder(
                itemCount: listTasks.length,
                itemBuilder: (context, index) => itemListTask(listTasks[index]),
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
                    text: Tools.timeString(
                      MyTime.fromValue(23),
                      format: FormatTimeEnum.hhmmss,
                    ),
                  ),
                ),
                Row(
                  children: [
                    task.withTimer
                        ? const SizedBox()
                        : Expanded(
                            child: MyWidgets.button(
                              text: "FINI",
                              onTap: () {},
                              color: MyColors.black,
                            ),
                          ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: MyWidgets.button(
                        text: "PASSER",
                        onTap: () {
                          setState(() {
                            currentTask = ++currentTask % listTasks.length;
                            print("object");
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

  Widget itemListTask(Task task) {
    final stateTask = stateList.firstWhere(
      (element) => element.idTask == task.id,
      orElse: () => StateTask(idTask: task.id, state: StateTaskEnum.notyet),
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
              text: "PAUSE",
              onTap: () {},
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
                  lockButtonDown ? Icons.lock : Icons.lock_open,
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
              },
              color: MyColors.red,
            ),
          ),
        ],
      );
}
