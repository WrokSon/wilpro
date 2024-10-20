import 'package:flutter/material.dart';
import 'package:wilpro/service/notifier/activity_notifier.dart';
import 'package:wilpro/ui/composants/item/activity_item.dart';
import 'package:wilpro/ui/composants/my_colors.dart';
import 'package:wilpro/ui/composants/my_widgets.dart';
import 'package:wilpro/ui/page/running_activity_page.dart';

class StartActyvityPage extends StatefulWidget {
  const StartActyvityPage({super.key});
  static const nameReoute = "/start";

  @override
  State<StartActyvityPage> createState() => _StartActyvityPage();
}

class _StartActyvityPage extends State<StartActyvityPage> {
  int ativitySelected = -1;
  @override
  Widget build(BuildContext context) {
    final notifier = ActivityNotifier.instance;
    final activities = notifier.activities;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Choisi l'actvité"),
        centerTitle: true,
      ),
      body: Container(
        padding:
            const EdgeInsets.only(right: 10, left: 10, top: 10, bottom: 30),
        child: ListenableBuilder(
          listenable: notifier,
          builder: (context, child) => Column(
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
                            GestureDetector(
                          onTap: () {
                            setState(() {
                              ativitySelected =
                                  ativitySelected != index ? index : -1;
                            });
                          },
                          child: Container(
                            color: ativitySelected == index
                                ? MyColors.green
                                : null,
                            child: ActivityItem(item: activities[index]),
                          ),
                        ),
                      )
                    : Center(
                        child: MyWidgets.text(text: "Pas d'activité"),
                      ),
              ),
              MyWidgets.button(
                  text: "LANCER",
                  isEnabled: ativitySelected != -1,
                  onTap: () {
                    if (ativitySelected != -1) {
                      Navigator.pushNamedAndRemoveUntil(
                          context,
                          RunningActivityPage.nameReoute,
                          (Route<dynamic> route) => false,
                          arguments: activities[ativitySelected]);
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
