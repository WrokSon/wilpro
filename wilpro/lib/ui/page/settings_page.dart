import 'package:flutter/material.dart';
import 'package:wilpro/model/enum/langage_enum.dart';
import 'package:wilpro/service/notifier/settings_notifier.dart';
import 'package:wilpro/ui/composants/my_colors.dart';
import 'package:wilpro/ui/composants/my_widgets.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  static const nameReoute = "/settings";

  @override
  State<SettingsPage> createState() => _SettingsPage();
}

class _SettingsPage extends State<SettingsPage> {
  LangageEnum langage = LangageEnum.french;
  final notifier = SettingsNotifier.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: MyWidgets.text(
            text: "Paramettre", color: MyColors.black),
        centerTitle: true,
        backgroundColor: MyColors.background,
      ),
      backgroundColor: MyColors.background,
      body: Container(
        padding: const EdgeInsets.all(10),
        child: ListenableBuilder(
            listenable: notifier,
            builder: (context, child) {
              return Column(
                children: [
                  Expanded(
                    child: ListView(
                      children: [
                        themeSection(),
                        historySection(),
                        musicSection(),
                        otherSection(),
                      ],
                    ),
                  ),
                  MyWidgets.button(
                    text: "A propos de nous",
                    width: double.infinity,
                    onTap: () {},
                  ),
                ],
              );
            }),
      ),
    );
  }

  Widget themeSection() {
    return Container(
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.all(10),
      color: MyColors.backgroundNavBar,
      child: Column(
        children: [
          Center(child: MyWidgets.text(text: "Theme", isBold: true)),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: MyWidgets.text(text: "Sombre", size: 10),
                ),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: MyWidgets.checkbox(
                      onChange: (value) {
                        setState(() {
                          notifier.darkMode = !notifier.darkMode;
                        });
                      },
                      value: notifier.darkMode),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget historySection() {
    return Container(
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.all(10),
      color: MyColors.backgroundNavBar,
      child: Column(
        children: [
          Center(child: MyWidgets.text(text: "Historique", isBold: true)),
          const SizedBox(height: 10),
          // sauvegarde automatique
          Row(
            children: [
              Expanded(
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: MyWidgets.text(text: "Sauvegarde auto", size: 10),
                ),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: MyWidgets.checkbox(
                      onChange: (value) {
                        setState(() {
                          notifier.autoSaveHistory = !notifier.autoSaveHistory;
                        });
                      },
                      value: notifier.autoSaveHistory),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          MyWidgets.button(
            text: "VIDER",
            color: MyColors.red,
            width: double.infinity,
            height: 30,
            onTap: () {
              notifier.clearHistory();
            },
          ),
        ],
      ),
    );
  }

  // reset + Language
  Widget otherSection() {
    return Container(
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.all(10),
      color: MyColors.backgroundNavBar,
      child: Column(
        children: [
          Center(child: MyWidgets.text(text: "Autres", isBold: true)),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: MyWidgets.text(text: "Langage", size: 10),
                ),
              ),
              Expanded(
                child: SizedBox(
                  child: DropdownButtonFormField<LangageEnum>(
                    value: langage,
                    items: [
                      DropdownMenuItem<LangageEnum>(
                        value: LangageEnum.french,
                        child: MyWidgets.text(text: "français"),
                      ),
                      DropdownMenuItem<LangageEnum>(
                        value: LangageEnum.english,
                        child: MyWidgets.text(text: "english"),
                      ),
                    ],
                    onChanged: (value) {
                      setState(() {
                        langage = value!;
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          MyWidgets.button(
            text: "REINITILISER",
            color: MyColors.red,
            width: double.infinity,
            height: 30,
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget musicSection() {
    return Container(
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.all(10),
      color: MyColors.backgroundNavBar,
      child: Column(
        children: [
          Center(child: MyWidgets.text(text: "Musique", isBold: true)),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: MyWidgets.text(text: "sons", size: 10),
                ),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: MyWidgets.checkbox(
                      onChange: (value) {
                        setState(() {
                          notifier.playSound = !notifier.playSound;
                        });
                      },
                      value: notifier.playSound),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
