import 'package:flutter/material.dart';
import 'package:wilpro/ui/composants/my_colors.dart';

class HomeSection extends StatefulWidget {
  const HomeSection({super.key});

  @override
  State<HomeSection> createState() => _HomeSection();
}

class _HomeSection extends State<HomeSection> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: MyColors.background,
      child: Center(
        child: Text("je suis sur la home"),
      ),
    );
  }
}
