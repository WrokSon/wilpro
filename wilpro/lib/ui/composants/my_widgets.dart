import 'package:flutter/material.dart';

class MyWidgets {
  // button
  static Widget button({
    required String text,
    required void Function() onTap,
    double height = 60,
    double width = 200,
  }) {
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        onPressed: onTap,
        child: Text(
          text,
          style: const TextStyle(color: Colors.white),
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
