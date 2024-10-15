import 'package:flutter/material.dart';
import 'package:backdrop/backdrop.dart';
import 'package:wilpro/ui/composants/my_colors.dart';
import 'package:wilpro/ui/composants/my_nav_bar.dart';
import 'package:wilpro/ui/composants/my_widgets.dart';
import 'package:wilpro/ui/page/sections/creation_section.dart';
import 'package:wilpro/ui/page/sections/history_section.dart';
import 'package:wilpro/ui/page/sections/home_section.dart';

class SectionPage extends StatefulWidget {
  const SectionPage({super.key});

  @override
  State<SectionPage> createState() => _SectionPage();
}

class _SectionPage extends State<SectionPage> {
  int indexSection = 1; // index de la page

  @override
  Widget build(BuildContext context) {
    return BackdropScaffold(
      appBar: BackdropAppBar(
        title: MyWidgets.text(
            text: "Wil-Pro", isBold: true, size: 40, color: MyColors.white),
        centerTitle: true,
        actions: [
          indexSection == 1
              ? IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.settings,
                    color: MyColors.black,
                  ))
              : const SizedBox()
        ],
        automaticallyImplyLeading: false,
        backgroundColor: MyColors.blue,
      ),
      backLayer: Center(
        child: Container(
          color: MyColors.blue,
        ),
      ),
      frontLayer: [
        const CreationSection(),
        const HomeSection(),
        const HistorySection(),
      ][indexSection],
      bottomNavigationBar: MyNavBar(
        action: (value) {
          setState(() {
            indexSection = value;
          });
        },
      ),
    );
  }
}
