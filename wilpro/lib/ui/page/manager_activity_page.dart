import 'package:flutter/material.dart';
import 'package:wilpro/model/activity.dart';
import 'package:wilpro/model/quantity.dart';
import 'package:wilpro/model/structure/my_time.dart';
import 'package:wilpro/service/langue.dart';
import 'package:wilpro/service/notifier/activity_notifier.dart';
import 'package:wilpro/service/notifier/manager_activity_notifier.dart';
import 'package:wilpro/service/notifier/settings_notifier.dart';
import 'package:wilpro/service/notifier/task_notifier.dart';
import 'package:wilpro/ui/composants/item/task_in_activity_item.dart';
import 'package:wilpro/ui/composants/my_colors.dart';
import 'package:wilpro/ui/composants/my_widgets.dart';

class ManagerActivityPage extends StatefulWidget {
  const ManagerActivityPage({super.key, required this.item});
  final Activity item;
  static const nameReoute = "/manageAcctivity";

  @override
  State<ManagerActivityPage> createState() => _ManagerActivityPage();
}

class _ManagerActivityPage extends State<ManagerActivityPage> {
  // Notifier
  final taskNotifier = TaskNotifier.instance;
  final activityNotifier = ActivityNotifier.instance;
  final managerActivityNotifier = ManagerActivityNotifier.instance;
  final settingsNotifier = SettingsNotifier.instance;
  // controller text
  final titleController = TextEditingController();
  final lang = Langue.instance;
  @override
  void initState() {
    super.initState();
    managerActivityNotifier.editList = List.from(widget.item.tasks);
    titleController.text = widget.item.title;
  }

  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
  }

  // popup pour ajouter
  Future<void> _showMyAddDialog() async {
    final listTasks = taskNotifier.taks;
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SizedBox(
            height: 300,
            width: 500,
            child: Column(
              children: [
                MyWidgets.text(text: lang.yourchoice()),
                Expanded(
                  child: ListenableBuilder(
                      listenable: managerActivityNotifier,
                      builder: (context, child) {
                        return listTasks.isNotEmpty
                            ? ListView.builder(
                                itemCount: listTasks.length,
                                itemBuilder: (context, index) =>
                                    GestureDetector(
                                  onTap: () {
                                    // add
                                    Navigator.of(context).pop();
                                    setState(() {
                                      managerActivityNotifier
                                          .addToeditActivityList(
                                              value: listTasks[index].withTimer
                                                  ? MyTime(minute: 5).getValue()
                                                  : 1,
                                              idTask: listTasks[index].id);
                                    });
                                  },
                                  child: Container(
                                    margin:
                                        const EdgeInsets.symmetric(vertical: 5),
                                    padding: const EdgeInsets.all(10),
                                    color: MyColors.backgroundNavBar,
                                    child: MyWidgets.simpleItemList(
                                        startText: listTasks[index].title,
                                        endText: listTasks[index].withTimer
                                            ? lang.withTimer()
                                            : lang.withoutTimer()),
                                  ),
                                ),
                              )
                            : Center(
                                child: MyWidgets.text(text: lang.empty()),
                              );
                      }),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isAddView = !activityNotifier.isExistById(widget.item.id);
    List<Quantity> tasks = managerActivityNotifier.editList;
    return Scaffold(
      appBar: AppBar(
        leading: IconTheme(
            data: IconThemeData(color: MyColors.black),
            child: const BackButton()),
        title: Row(
          children: [
            Expanded(
                child: Center(
                    child: MyWidgets.text(
                        text: isAddView ? lang.add() : lang.edit(),
                        color: MyColors.black))),
            isAddView
                ? const SizedBox()
                : IconButton(
                    onPressed: () {
                      activityNotifier.deleteActivityById(widget.item.id);
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.delete,
                      color: MyColors.red,
                    ))
          ],
        ),
        centerTitle: true,
        backgroundColor: MyColors.background,
      ),
      body: ListenableBuilder(
          listenable: settingsNotifier,
          builder: (context, child) {
            return Container(
              color: MyColors.background,
              padding: const EdgeInsets.all(10),
              child: ListenableBuilder(
                builder: (context, child) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyWidgets.text(text: lang.title(), color: MyColors.black),
                      Container(
                        margin: const EdgeInsets.only(bottom: 20),
                        child: TextFormField(
                          controller: titleController,
                          maxLength: 100,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: settingsNotifier.darkMode
                                        ? Colors.white
                                        : Colors.black)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: MyColors.green)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: settingsNotifier.darkMode
                                        ? Colors.white
                                        : Colors.black)),
                            counterText: "",
                          ),
                          style: TextStyle(
                              color: settingsNotifier.darkMode
                                  ? Colors.white
                                  : Colors.black),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MyWidgets.text(
                              text: lang.taskList(), color: MyColors.black),
                          IconButton(
                            onPressed: () {
                              _showMyAddDialog();
                            },
                            icon: Icon(Icons.add,
                                color: settingsNotifier.darkMode
                                    ? Colors.white
                                    : MyColors.blue),
                          )
                        ],
                      ),
                      Expanded(
                        child: tasks.isNotEmpty
                            ? ListView.builder(
                                itemCount: tasks.length,
                                itemBuilder: (context, index) =>
                                    TaskInActivityItem(item: tasks[index]),
                              )
                            : Center(
                                child: MyWidgets.text(
                                    text: lang.empty(),
                                    color: MyColors.black),
                              ),
                      ),
                      MyWidgets.button(
                        text: lang.validate(),
                        onTap: () {
                          final title = titleController.text;
                          final listTasks = managerActivityNotifier.editList;

                          if (title.isNotEmpty &&
                              !activityNotifier.isExistByTitle(title,
                                  original: widget.item.title) &&
                              listTasks.isNotEmpty) {
                            isAddView
                                ? activityNotifier.addActivity(
                                    title: title, tasks: List.from(listTasks))
                                : activityNotifier.editActivity(
                                    id: widget.item.id,
                                    title: title,
                                    tasks: List.from(listTasks),
                                  );
                            Navigator.pop(context);
                            managerActivityNotifier.clearEditList();
                          }
                        },
                        inverseColor: false,
                        width: double.infinity,
                      )
                    ]),
                listenable: managerActivityNotifier,
              ),
            );
          }),
    );
  }
}
