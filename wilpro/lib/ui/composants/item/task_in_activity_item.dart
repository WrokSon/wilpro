import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wilpro/model/quantity.dart';
import 'package:wilpro/service/notifier/manager_activity_notifier.dart';
import 'package:wilpro/service/notifier/task_notifier.dart';
import 'package:wilpro/service/tools.dart';
import 'package:wilpro/ui/composants/my_colors.dart';
import 'package:wilpro/ui/composants/my_widgets.dart';

class TaskInActivityItem extends StatefulWidget {
  final Quantity item;
  const TaskInActivityItem({super.key, required this.item});

  @override
  State<TaskInActivityItem> createState() => _TaskInActivityItem();
}

class _TaskInActivityItem extends State<TaskInActivityItem> {
  final managerActivityNotifier = ManagerActivityNotifier.instance;
  final quantityController = TextEditingController();
  final hourController = TextEditingController();
  final minuteController = TextEditingController();
  final secondeController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    quantityController.dispose();
    hourController.dispose();
    minuteController.dispose();
    secondeController.dispose();
  }

  // popup pour sans timer
  Future<void> _showMyWithoutDialog() async {
    final keyForm = GlobalKey<FormState>(); // Clé pour le formulaire
    quantityController.text = widget.item.value.toString();
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Form(
            key: keyForm,
            child: textFieldNumber(
              controller: quantityController,
            ),
          ),
          actions: [
            MyWidgets.button(
              text: "CHANGER",
              onTap: () {
                if (keyForm.currentState!.validate()) {
                  managerActivityNotifier.editToeditActivityList(
                      id: widget.item.id,
                      value: Tools.stringToInt(quantityController.text));
                }
                Navigator.pop(context);
              },
              inverseColor: false,
              width: double.infinity,
            ),
          ],
        );
      },
    );
  }

  // popup pour avec timer
  Future<void> _showMyTimerDialog() async {
    final keyForm = GlobalKey<FormState>(); // Clé pour le formulaire
    final DateTime timeValue =
        DateTime.fromMicrosecondsSinceEpoch(widget.item.value);
    hourController.text = Tools.twoDigits(timeValue.hour);
    minuteController.text = Tools.twoDigits(timeValue.minute);
    secondeController.text = Tools.twoDigits(timeValue.second);
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Form(
            key: keyForm,
            child: SizedBox(
              width: 250,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 50,
                    child: textFieldNumber(controller: hourController),
                  ),
                  MyWidgets.text(text: "h"),
                  SizedBox(
                    width: 50,
                    child: textFieldNumber(controller: minuteController),
                  ),
                  MyWidgets.text(text: "min"),
                  SizedBox(
                    width: 50,
                    child: textFieldNumber(controller: secondeController),
                  ),
                  MyWidgets.text(text: "s"),
                ],
              ),
            ),
          ),
          actions: [
            MyWidgets.button(
              text: "CHANGER",
              onTap: () {
                // Todo: probleme au niveau des champs
                print(
                    "${Tools.stringToInt(hourController.text)}h${Tools.stringToInt(minuteController.text)}min${Tools.stringToInt(secondeController.text)}");
                if (keyForm.currentState!.validate()) {
                  managerActivityNotifier.editToeditActivityList(
                    id: widget.item.id,
                    value: DateTime(
                      0,
                      0,
                      0,
                      Tools.stringToInt(hourController.text),
                      Tools.stringToInt(minuteController.text),
                      Tools.stringToInt(secondeController.text),
                    ).millisecondsSinceEpoch,
                  );
                }
                Navigator.pop(context);
              },
              inverseColor: false,
              width: double.infinity,
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final taskNotifier = TaskNotifier.instance;
    final task = taskNotifier.getById(widget.item.idTask);

    return Row(
      children: [
        SizedBox(
          height: 40,
          width: 100,
          child: TextButton(
            onPressed: () {
              task.withTimer ? _showMyTimerDialog() : _showMyWithoutDialog();
            },
            child: MyWidgets.text(
                text: task.withTimer
                    ? Tools.timeString(
                        DateTime.fromMicrosecondsSinceEpoch(widget.item.value),
                        enLettre: true)
                    : widget.item.value.toString(),
                size: 10),
          ),
        ),
        const Icon(Icons.arrow_right),
        Expanded(
          flex: 4,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: MyWidgets.text(text: task.title, size: 12),
          ),
        ),
        IconButton(
          onPressed: () {
            setState(() {
              managerActivityNotifier.deleteToeditActivityList(widget.item.id);
            });
          },
          icon: const Icon(
            Icons.delete,
            color: MyColors.red,
          ),
        ),
      ],
    );
  }

  Widget textFieldNumber(
          {required TextEditingController controller, int limit = 2}) =>
      TextFormField(
        maxLength: limit,
        textAlign: TextAlign.end,
        keyboardType: TextInputType.number,
        controller: controller,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly,
        ],
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          counterText: "",
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return "";
          }
          return null;
        },
      );
}
