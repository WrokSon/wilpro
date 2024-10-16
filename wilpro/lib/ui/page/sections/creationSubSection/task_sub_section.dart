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

  @override
  void dispose() {
    super.dispose();
    newTaskController.dispose();
  }

  // vue
  @override
  Widget build(BuildContext context) {
    final notifier = TaskNotifier.instance;
    final tasks = notifier.taks;

    return ListenableBuilder(
      listenable: notifier,
      builder: (BuildContext context, Widget? child) => Expanded(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: ListView.builder(
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
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              alignment: Alignment.center,
              height: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextFormField(
                      maxLength: 70,
                      controller: newTaskController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        notifier.addTask(
                            title: newTaskController.text.trim(),
                            withTimer: true);
                      });
                      newTaskController.clear();
                    },
                    icon: const Icon(Icons.add),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
