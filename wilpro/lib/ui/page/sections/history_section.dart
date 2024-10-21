import 'package:flutter/material.dart';
import 'package:wilpro/service/notifier/history_notifier.dart';
import 'package:wilpro/ui/composants/item/history_item.dart';
import 'package:wilpro/ui/composants/my_colors.dart';
import 'package:wilpro/ui/composants/my_widgets.dart';

class HistorySection extends StatefulWidget {
  const HistorySection({super.key});

  @override
  State<HistorySection> createState() => _HistorySection();
}

class _HistorySection extends State<HistorySection> {
  @override
  Widget build(BuildContext context) {
    final notifier = HistoryNotifier.instance;
    final listHistory = notifier.getHistorical;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      color: MyColors.background,
      child: ListenableBuilder(
        listenable: notifier,
        builder: (context, child) => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MyWidgets.text(text: "Historique", color: MyColors.black),
            Expanded(
              child: listHistory.isNotEmpty
                  ? ListView.builder(
                      itemCount: listHistory.length,
                      itemBuilder: (context, index) =>
                          HistoryItem(item: listHistory[index]))
                  : Center(
                      child: MyWidgets.text(
                          text: "Pas d'historique", color: MyColors.black)),
            )
          ],
        ),
      ),
    );
  }
}
