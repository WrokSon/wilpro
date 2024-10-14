import 'package:flutter/material.dart';
import 'package:backdrop/backdrop.dart';
import 'package:wilpro/ui/composants/my_colors.dart';
import 'package:wilpro/ui/composants/my_nav_bar.dart';
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

  void _onDestinationSelected(int index) {
    setState(() {
      indexSection = index; // changement de la page
    });
  }

  @override
  Widget build(BuildContext context) {
    return BackdropScaffold(
      appBar: BackdropAppBar(
        actions: [
          indexSection == 1
              ? IconButton(onPressed: () {}, icon: Icon(Icons.settings))
              : SizedBox()
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
        CreationSection(),
        HomeSection(),
        HistorySection(),
      ][indexSection],
      // faire son nav bar
      bottomNavigationBar: MyNavBar(
        action: (value) {
          setState(() {
            indexSection = value;
          });
        },
      ) /*NavigationBar(
        selectedIndex: indexSection,
        onDestinationSelected: _onDestinationSelected,
        destinations: [
          NavigationDestination(icon: Icon(Icons.adb_sharp), label: "Création"),
          NavigationDestination(icon: Icon(Icons.home), label: "Accueil"),
          NavigationDestination(
              icon: Icon(Icons.bookmark), label: "Historique"),
        ],
      )*/
      ,
    );
  }
}
