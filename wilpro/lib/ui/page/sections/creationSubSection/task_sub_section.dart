import 'package:flutter/material.dart';

class TaskSubSection extends StatefulWidget {
  const TaskSubSection({super.key});

  @override
  State<TaskSubSection> createState() => _TaskSubSection();
}

class _TaskSubSection extends State<TaskSubSection> {
  @override
  Widget build(BuildContext context) {
    return const Expanded(
      child: Center(
        child: Text("a venir"),
      ),
    );
  }
}
