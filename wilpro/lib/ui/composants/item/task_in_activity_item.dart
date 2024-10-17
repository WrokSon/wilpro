import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wilpro/model/quantity.dart';
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
  final quantityController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    quantityController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final taskNotifier = TaskNotifier.instance;
    final task = taskNotifier.getById(widget.item.idTask);
    return Row(
      children: [
        SizedBox(
          height: 35,
          width: 100,
          child: task.withTimer
              ? TextButton(
                  onPressed: () {},
                  child: MyWidgets.text(
                      text: Tools.timeString(
                          DateTime.fromMicrosecondsSinceEpoch(
                              widget.item.value),
                          enLettre: true),
                      size: 10),
                )
              : TextFormField(
                  maxLength: 10,
                  style: const TextStyle(fontSize: 9),
                  textAlign: TextAlign.end,
                  keyboardType: TextInputType.number,
                  controller: quantityController,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    counterText: "",
                  ),
                ),
        ),
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
              widget.item.value = DateTime.now().microsecondsSinceEpoch;
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
}
