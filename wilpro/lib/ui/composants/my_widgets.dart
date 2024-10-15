import 'package:flutter/material.dart';
import 'package:wilpro/ui/composants/my_colors.dart';

class MyWidgets {
  // normal button
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

  // item d'un liste
  static Widget simpleItemList({
    required String startText,
    required String endText,
    bool withPoint = false,
    double spaceStart = 4,
    EdgeInsetsGeometry margin = EdgeInsets.zero,
    double sizeText = 10,
    bool isBold = true,
  }) {
    return Container(
      margin: margin,
      width: double.infinity,
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                withPoint
                    ? const Icon(
                        Icons.circle,
                        size: 8,
                      )
                    : const SizedBox(),
                withPoint ? SizedBox(width: spaceStart) : const SizedBox(),
                text(text: startText, size: sizeText, isBold: isBold),
              ],
            ),
          ),
          text(text: endText, size: sizeText, isBold: isBold),
        ],
      ),
    );
  }
}
