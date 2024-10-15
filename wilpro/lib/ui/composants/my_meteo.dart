import 'package:flutter/material.dart';
import 'package:wilpro/ui/composants/my_colors.dart';
import 'package:wilpro/ui/composants/my_widgets.dart';

class MyMeteo extends StatefulWidget {
  const MyMeteo({super.key});

  @override
  State<MyMeteo> createState() => _MyMeteo();
}

class _MyMeteo extends State<MyMeteo> {
  @override
  Widget build(BuildContext context) {
    return Card(
    elevation: 10,
    color: MyColors.backgroundNavBar,
    child: Container(
      margin: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          MyWidgets.text(text: "00:00:00", size: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                color: Colors.black,
                height: 100,
                width: 100,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  MyWidgets.text(text: "19°C"),
                  MyWidgets.text(text: "Ensoleillé"),
                ],
              )
            ],
          ),
        ],
      ),
    ),
  );
  }
}
