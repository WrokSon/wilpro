import 'package:flutter/material.dart';
import 'package:wilpro/service/langue.dart';
import 'package:wilpro/ui/composants/my_colors.dart';
import 'package:wilpro/ui/page/sections/creationSubSection/activity_sub_section.dart';
import 'package:wilpro/ui/page/sections/creationSubSection/task_sub_section.dart';

class CreationSection extends StatefulWidget {
  const CreationSection({super.key});

  @override
  State<CreationSection> createState() => _CreationSection();
}

class _CreationSection extends State<CreationSection> {
  int _indexSelected = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: MyColors.background,
      child: Column(
        children: [
          top(),
          _indexSelected == 0
              ? const ActivitySubSection()
              : const TaskSubSection(),
        ],
      ),
    );
  }

  // selection du choix d'affichage
  Row top() {
    final lang = Langue.instance;
    return Row(
      children: [
        textButton(text: lang.activities(), index: 0),
        // separateur
        Center(
          child: Container(
            height: 10,
            width: 5,
            color: MyColors.black,
          ),
        ),
        textButton(text: lang.tasks(), index: 1),
      ],
    );
  }

  // les boutons des choix
  Widget textButton({
    required String text,
    int index = 0,
    double size = 20,
  }) {
    return Expanded(
      child: Container(
        color: index == _indexSelected
            ? MyColors.background
            : MyColors.backgroundNavBar,
        child: TextButton(
          onPressed: () {
            setState(() {
              _indexSelected = index;
            });
          },
          child: Text(
            text,
            style: TextStyle(color: MyColors.black),
          ),
        ),
      ),
    );
  }
}
