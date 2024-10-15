import 'package:flutter/material.dart';
import 'package:wilpro/ui/composants/my_colors.dart';

class MyWidgets {
  // button
  static Widget button({
    required String text,
    required void Function() onTap,
    double height = 60,
    double width = 200,
    bool inverseColor = true,
  }) {
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        onPressed: onTap,
        style: ButtonStyle(
            shape: const WidgetStatePropertyAll(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  side: BorderSide(color: MyColors.blue)),
            ),
            backgroundColor: WidgetStatePropertyAll(
                inverseColor ? MyColors.white : MyColors.blue)),
        child: Text(
          text,
          style: TextStyle(
              color: inverseColor ? MyColors.blue : MyColors.background),
        ),
      ),
    );
  }

  // text
  static Widget text(
      {required String text,
      double size = 17,
      bool isBold = true,
      Color color = Colors.black}) {
    return Text(
      text,
      style: TextStyle(
        fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
        fontSize: size,
        color: color,
      ),
    );
  }
}
