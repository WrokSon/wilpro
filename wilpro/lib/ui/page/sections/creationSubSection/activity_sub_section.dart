import 'package:flutter/material.dart';
import 'package:wilpro/model/activity.dart';
import 'package:wilpro/ui/composants/item/activity_item.dart';
import 'package:wilpro/ui/composants/my_widgets.dart';

class ActivitySubSection extends StatefulWidget {
  const ActivitySubSection({super.key});

  @override
  State<ActivitySubSection> createState() => _ActivitySubSection();
}

class _ActivitySubSection extends State<ActivitySubSection> {
  @override
  Widget build(BuildContext context) {
    final activities = [Activity(id: "id", title: "title", tasks: [])];

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Expanded(
              child: activities.isNotEmpty
                  ? GridView.builder(
                      padding: const EdgeInsets.all(10),
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 200),
                      itemCount: activities.length,
                      itemBuilder: (BuildContext context, int index) =>
                          ActivityItem(item: activities[index]))
                  : Center(
                      child: MyWidgets.text(
                          text: "Il n'y a pas d'activité enregistré"),
                    ),
            ),
            MyWidgets.button(
              text: "AJOUTER",
              onTap: () {},
              inverseColor: false,
              width: double.infinity,
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
