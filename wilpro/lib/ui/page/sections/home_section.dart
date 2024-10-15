import 'package:flutter/material.dart';
import 'package:wilpro/ui/composants/my_colors.dart';
import 'package:wilpro/ui/composants/my_map.dart';
import 'package:wilpro/ui/composants/my_widgets.dart';

class HomeSection extends StatefulWidget {
  const HomeSection({super.key});

  @override
  State<HomeSection> createState() => _HomeSection();
}

class _HomeSection extends State<HomeSection> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          banier,
          const MyMap(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: MyWidgets.button(text: "DEMARRER", onTap: () {}),
          ),
        ],
      ),
    );
  }

  Widget banier = Expanded(
    child: Card(
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
    ),
  );
}
