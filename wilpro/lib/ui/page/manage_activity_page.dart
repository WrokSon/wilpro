import 'package:flutter/material.dart';
import 'package:wilpro/model/activity.dart';
import 'package:wilpro/model/quantity.dart';
import 'package:wilpro/service/notifier/activity_notifier.dart';
import 'package:wilpro/service/notifier/task_notifier.dart';
import 'package:wilpro/ui/composants/item/task_in_activity_item.dart';
import 'package:wilpro/ui/composants/my_colors.dart';
import 'package:wilpro/ui/composants/my_widgets.dart';

class ManageActivityPage extends StatefulWidget {
  const ManageActivityPage({super.key, required this.item});
  final Activity item;
  static const nameReoute = "/manageAcctivity";

  @override
  State<ManageActivityPage> createState() => _ManageActivityPage();
}

class _ManageActivityPage extends State<ManageActivityPage> {
  // Notifier
  final taskNotifier = TaskNotifier.instance;
  final activityNotifier = ActivityNotifier.instance;
  // controller text
  final titleController = TextEditingController();
  // taches
  List<Quantity> tasks = [
    Quantity(value: 20, idTask: "pompe"),
    Quantity(
        value: DateTime(0, 0, 0, 12, 5, 15).microsecondsSinceEpoch,
        idTask: "jouer")
  ];

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
                MyWidgets.text(text: "Votre choix"),
                Expanded(
                  child: ListView.builder(
                    itemCount: listTasks.length,
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: () {
                        // add
                        Navigator.of(context).pop();
                        setState(() {
                          tasks.add(
                            Quantity(
                                value: listTasks[index].withTimer
                                    ? DateTime(0, 0, 0, 12, 5, 15)
                                        .microsecondsSinceEpoch
                                    : 20,
                                idTask: listTasks[index].id),
                          );
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        padding: const EdgeInsets.all(10),
                        color: MyColors.backgroundNavBar,
                        child: MyWidgets.simpleItemList(
                            startText: listTasks[index].title,
                            endText: listTasks[index].withTimer
                                ? "Avec chrono"
                                : "Sans chrono"),
                      ),
                    ),
                  ),
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
    return Scaffold(
      appBar: AppBar(
        title: Text(isAddView ? "Ajouter" : "Modifier"),
        centerTitle: true,
      ),
      body: Container(
        color: MyColors.background,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyWidgets.text(text: "Titre"),
              Container(
                margin: const EdgeInsets.only(bottom: 20),
                child: TextFormField(
                  controller: titleController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MyWidgets.text(text: "Liste des taches"),
                  IconButton(
                    onPressed: () {
                      _showMyAddDialog();
                    },
                    icon: const Icon(Icons.add, color: MyColors.blue),
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
                            text: "Votre Activité n'a pas de taches"),
                      ),
              ),
              MyWidgets.button(
                text: "VALIDER",
                onTap: () {},
                inverseColor: false,
                width: double.infinity,
              )
            ],
          ),
        ),
      ),
    );
  }
}
