import 'package:flutter/material.dart';
import 'package:wilpro/model/enum/format_time_enum.dart';
import 'package:wilpro/model/history.dart';
import 'package:wilpro/service/tools.dart';
import 'package:wilpro/ui/composants/my_colors.dart';
import 'package:wilpro/ui/composants/my_widgets.dart';

class HistoryItem extends StatefulWidget {
  final History item;
  const HistoryItem({super.key, required this.item});

  @override
  State<HistoryItem> createState() => _HistoryItem();
}

class _HistoryItem extends State<HistoryItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(17),
      color: MyColors.backgroundNavBar,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyWidgets.text(
                      text: widget.item.title.length < 25
                          ? widget.item.title
                          : "${widget.item.title.substring(0, 25)}...",
                      isBold: true),
                  MyWidgets.text(
                    text: Tools.dateString(widget.item.date),
                    size: 13,
                  ),
                ],
              ),
              MyWidgets.text(
                text: Tools.timeString(
                  widget.item.time,
                  format: FormatTimeEnum.hhmm,
                  enLettre: true,
                ),
                size: 15,
              ),
            ],
          ),
          const SizedBox(height: 15),
          MyWidgets.text(
            text: Tools.timeString(
              widget.item.duration,
              format: FormatTimeEnum.hhmmss,
            ),
            size: 20,
          ),
        ],
      ),
    );
  }
}
