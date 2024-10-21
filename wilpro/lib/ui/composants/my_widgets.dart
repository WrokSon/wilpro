import 'package:flutter/material.dart';
import 'package:wilpro/ui/composants/my_colors.dart';

class MyWidgets {
  // normal button
  static Widget button({
    required String text,
    required void Function() onTap,
    double height = 50,
    double width = 200,
    Color? color,
    bool inverseColor = false,
    bool isEnabled = true,
  }) {
    color = color ?? MyColors.blue;
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        onPressed: isEnabled ? onTap : null,
        style: ButtonStyle(
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
                borderRadius: const BorderRadius.all(Radius.circular(5)),
                side: BorderSide(
                    color: isEnabled ? color : MyColors.backgroundNavBar)),
          ),
          backgroundColor: isEnabled
              ? WidgetStatePropertyAll(inverseColor ? MyColors.white : color)
              : WidgetStatePropertyAll(MyColors.backgroundNavBar),
        ),
        child: Text(
          text,
          style: isEnabled
              ? TextStyle(color: inverseColor ? color : MyColors.background)
              : TextStyle(color: MyColors.black),
        ),
      ),
    );
  }

  // text
  static Widget text(
      {required String text,
      double size = 17,
      bool isBold = false,
      Color color = Colors.black}) {
    return Text(
      text,
      textAlign: TextAlign.justify,
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

  static Widget checkbox(
      {required Function(bool) onChange, required bool value}) {
    return Checkbox(
      value: value,
      onChanged: (value) => onChange(value!),
    );
  }
}
