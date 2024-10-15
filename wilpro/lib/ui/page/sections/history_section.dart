import 'package:flutter/material.dart';
import 'package:wilpro/ui/composants/my_colors.dart';

class HistorySection extends StatefulWidget {
  const HistorySection({super.key});

  @override
  State<HistorySection> createState() => _HistorySection();
}

class _HistorySection extends State<HistorySection> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: MyColors.background,
      child: const Center(
        child: Text("Historique"),
      ),
    );
  }
}
