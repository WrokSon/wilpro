import 'package:flutter/material.dart';
import 'package:wilpro/model/enum/format_time_enum.dart';
import 'package:wilpro/service/tools.dart';
import 'package:wilpro/ui/composants/my_colors.dart';
import 'package:wilpro/ui/composants/my_image.dart';
import 'package:wilpro/ui/composants/my_widgets.dart';

class MyMeteo extends StatefulWidget {
  const MyMeteo({super.key});

  @override
  State<MyMeteo> createState() => _MyMeteo();
}

class _MyMeteo extends State<MyMeteo> {
  final String _idIcon = "10d";
  final double degres = -999;
  final String description = "...";
  // final _city = "orleans";

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
            MyWidgets.text(
                text: Tools.timeString(DateTime.now(),
                    format: FormatTimeEnum.hhmmss),
                size: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 100,
                  width: 100,
                  child: MyImage.network(Tools.getURLImageMeteo(_idIcon)),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    MyWidgets.text(text: '${degres.toInt()}°C'),
                    MyWidgets.text(text: description),
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
