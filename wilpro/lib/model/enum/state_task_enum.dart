import 'package:flutter/material.dart';
import 'package:wilpro/ui/composants/my_colors.dart';

enum StateTaskEnum {
  current(MyColors.orange),
  failed(MyColors.red),
  success(MyColors.green),
  notyet(MyColors.backgroundNavBar);
  final Color color;
  const StateTaskEnum(this.color);
}
