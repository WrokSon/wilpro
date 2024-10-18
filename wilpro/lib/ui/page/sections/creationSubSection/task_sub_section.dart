import 'package:flutter/material.dart';
import 'package:wilpro/service/notifier/task_notifier.dart';
import 'package:wilpro/ui/composants/my_colors.dart';
import 'package:wilpro/ui/composants/my_widgets.dart';

class TaskSubSection extends StatefulWidget {
  const TaskSubSection({super.key});

  @override
  State<TaskSubSection> createState() => _TaskSubSection();
}

class _TaskSubSection extends State<TaskSubSection> {
  // textfield
  final newTaskController = TextEditingController();
  // notifier
  final notifier = TaskNotifier.instance;

  @override
  void dispose() {
    super.dispose();
    newTaskController.dispose();
  }

  // popup pour ajouter
  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        bool isCheck = false;
        return AlertDialog(
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextFormField(
                  maxLength: 50,
                  controller: newTaskController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    counterText: "",
                  ),
                ),
                const SizedBox(height: 5),
                DropdownButtonFormField<bool>(
                  value: isCheck,
                  items: [
                    DropdownMenuItem(
                      value: true,
                      child: MyWidgets.text(text: "AVEC chrno"),
                    ),
                    DropdownMenuItem(
                      value: false,
                      child: MyWidgets.text(text: "SANS chrno"),
                    ),
                  ],
                  onChanged: (value) {
                    isCheck = value!;
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: MyColors
                              .blue), // Couleur de la bordure du champ en cas de focus
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            MyWidgets.button(
              text: "VALIDER",
              onTap: () {
                Navigator.of(context).pop();
                final title = newTaskController.text.trim();
                if (title.isNotEmpty) {
                  notifier.addTask(title: title, withTimer: isCheck);
                }
                newTaskController.clear();
              },
              width: double.infinity,
              height: 40,
              inverseColor: false,
            ),
          ],
        );
      },
    );
  }

  // vue
  @override
  Widget build(BuildContext context) {
    final tasks = notifier.taks;

    return ListenableBuilder(
      listenable: notifier,
      builder: (BuildContext context, Widget? child) => Expanded(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Expanded(
                child: tasks.isNotEmpty
                    ? ListView.builder(
                        itemCount: tasks.length,
                        itemBuilder: (context, index) => Container(
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          padding: const EdgeInsets.all(10),
                          color: MyColors.backgroundNavBar,
                          child: MyWidgets.simpleItemList(
                              startText: tasks[index].title,
                              endText: tasks[index].withTimer
                                  ? "Avec chrono"
                                  : "Sans chrono"),
                        ),
                      )
                    : Center(
                        child: MyWidgets.text(text: "Pas de tache"),
                      ),
              ),
              MyWidgets.button(
                text: "AJOUTER",
                onTap: () {
                  _showMyDialog();
                },
                inverseColor: false,
                width: double.infinity,
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
