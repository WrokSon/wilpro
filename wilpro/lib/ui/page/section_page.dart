import 'package:flutter/material.dart';
import 'package:backdrop/backdrop.dart';
import 'package:wilpro/service/langue.dart';
import 'package:wilpro/service/notifier/settings_notifier.dart';
import 'package:wilpro/ui/composants/my_colors.dart';
import 'package:wilpro/ui/composants/my_nav_bar.dart';
import 'package:wilpro/ui/composants/my_widgets.dart';
import 'package:wilpro/ui/page/sections/creation_section.dart';
import 'package:wilpro/ui/page/sections/history_section.dart';
import 'package:wilpro/ui/page/sections/home_section.dart';
import 'package:wilpro/ui/page/settings_page.dart';

class SectionPage extends StatefulWidget {
  const SectionPage({super.key});

  static const nameReoute = "/";

  @override
  State<SectionPage> createState() => _SectionPage();
}

class _SectionPage extends State<SectionPage> {
  int indexSection = 1; // index de la page
  final sectionCreation = const CreationSection();
  final sectionHome = const HomeSection();
  final sectionHistory = const HistorySection();
  bool isReady = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      isReady ? null : _showMyLoadingDialog();
    });
  }

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
                  onPressed: () {
                    Navigator.pushNamed(context, SettingsPage.nameReoute);
                  },
                  icon: const Icon(
                    Icons.settings,
                    color: Colors.white,
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
        sectionCreation,
        sectionHome,
        sectionHistory,
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

  // popup pour ajouter
  Future<void> _showMyLoadingDialog() async {
    final notifier = SettingsNotifier.instance;
    return showDialog<void>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SizedBox(
            height: 100,
            width: 100,
            child: FutureBuilder(
                future: notifier.init(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    isReady = true;
                    Navigator.of(context).pop();
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CircularProgressIndicator(),
                      const SizedBox(height: 15),
                      MyWidgets.text(text: Langue.instance.loading()),
                    ],
                  );
                }),
          ),
        );
      },
    );
  }
}
