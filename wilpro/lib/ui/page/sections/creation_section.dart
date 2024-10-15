import 'package:flutter/material.dart';
import 'package:wilpro/ui/composants/my_colors.dart';

class CreationSection extends StatefulWidget {
  const CreationSection({super.key});

  @override
  State<CreationSection> createState() => _CreationSection();
}

class _CreationSection extends State<CreationSection> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: MyColors.white,
      child: const Center(
        child: Text("Creation"),
      ),
    );
  }
}