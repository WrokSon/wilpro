import 'package:flutter/material.dart';

enum StateTaskEnum {
  current(Color.fromARGB(255, 231, 176, 25)),
  failed(Color.fromARGB(220, 255, 7, 7)),
  success(Color.fromARGB(255, 21, 235, 28)),
  notyet(Color.fromARGB(255, 224, 224, 224));

  final Color color;
  const StateTaskEnum(this.color);
}
