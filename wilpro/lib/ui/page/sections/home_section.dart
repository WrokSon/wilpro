import 'package:flutter/material.dart';
import 'package:wilpro/service/langue.dart';
import 'package:wilpro/service/notifier/settings_notifier.dart';
import 'package:wilpro/ui/composants/my_colors.dart';
import 'package:wilpro/ui/composants/my_map.dart';
import 'package:wilpro/ui/composants/my_meteo.dart';
import 'package:wilpro/ui/composants/my_widgets.dart';
import 'package:wilpro/ui/page/start_actyvity_page.dart';

class HomeSection extends StatefulWidget {
  const HomeSection({super.key});

  @override
  State<HomeSection> createState() => _HomeSection();
}

class _HomeSection extends State<HomeSection> {
  final settingsNotifier = SettingsNotifier.instance;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ListenableBuilder(
          listenable: settingsNotifier,
          builder: (context, child) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              width: double.infinity,
              color: MyColors.background,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const MyMeteo(),
                  const MyMap(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: MyWidgets.button(
                        text: Langue.instance.start(),
                        inverseColor: true,
                        height: 60,
                        onTap: () {
                          Navigator.pushNamed(
                              context, StartActyvityPage.nameReoute);
                        }),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
