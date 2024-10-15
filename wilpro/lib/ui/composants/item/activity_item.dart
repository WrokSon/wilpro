import 'package:flutter/material.dart';
import 'package:wilpro/model/activity.dart';

class ActivityItem extends StatefulWidget {
  final Activity item;
  const ActivityItem({super.key, required this.item});

  @override
  State<ActivityItem> createState() => _ActivityItem();
}

class _ActivityItem extends State<ActivityItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.amber,
      height: 150,
      width: 150,
    );
  }
}
