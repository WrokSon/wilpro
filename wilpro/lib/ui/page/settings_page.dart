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
  final notifier = SettingsNotifier.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: MyWidgets.text(text: "Paramettre", color: MyColors.black),
        centerTitle: true,
        backgroundColor: MyColors.background,
        leading: IconTheme(
            data: IconThemeData(color: MyColors.black),
            child: const BackButton()),
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
                    onTap: () {
                      _showMyAboutUsDialog();
                    },
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
                    value: notifier.language,
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
                        notifier.language = value!;
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
            onTap: () {
              notifier.restartApp();
            },
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

  Future<void> _showMyAboutUsDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            height: 300,
            width: 500,
            padding:
                const EdgeInsets.only(top: 20, right: 15, left: 15, bottom: 3),
            child: ListView(
              children: [
                Center(child: MyWidgets.text(text: "Wil-Pro", isBold: true)),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 15),
                  child: MyWidgets.text(
                      size: 13,
                      text:
                          "Je suis un étudiant en deuxième année de Master à Orleans. Je code des applications gratuites afin de répondre à un besoin ou des demandes. Je travaille tout seul donc s’il y a des améliorations que vous voulez voir sur cette application faite le moi savoir et je me pencherai sur cette amélioration durant mes temps libres."),
                ),
                MyWidgets.text(
                    text: "Contact : deliremassam@gmail.com", size: 13),
                const SizedBox(height: 10),
                Center(child: MyWidgets.text(text: "Version 1.0", size: 13)),
              ],
            ),
          ),
        );
      },
    );
  }
}
