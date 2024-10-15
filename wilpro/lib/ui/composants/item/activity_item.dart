import 'package:flutter/material.dart';
import 'package:wilpro/model/activity.dart';
import 'package:wilpro/ui/composants/my_colors.dart';
import 'package:wilpro/ui/composants/my_widgets.dart';

class ActivityItem extends StatefulWidget {
  final Activity item;
  const ActivityItem({super.key, required this.item});

  @override
  State<ActivityItem> createState() => _ActivityItem();
}

class _ActivityItem extends State<ActivityItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      height: 150,
      width: 150,
      color: MyColors.backgroundNavBar,
      child: Column(
        children: [
          Container(
              color: MyColors.black,
              alignment: Alignment.center,
              width: double.infinity,
              child: MyWidgets.text(
                  text: widget.item.title, color: MyColors.white)),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(5),
              itemCount: 10,
              itemBuilder: (BuildContext context, int index) =>
                  MyWidgets.simpleItemList(
                      startText: "startText ${index}",
                      endText: "",
                      withPoint: true),
            ),
          )
        ],
      ),
    );
  }
}
