import 'package:flutter/material.dart';
import 'package:wilpro/model/activity.dart';
import 'package:wilpro/ui/page/manager_activity_page.dart';
import 'package:wilpro/ui/page/running_activity_page.dart';
import 'package:wilpro/ui/page/section_page.dart';
import 'package:wilpro/ui/page/start_actyvity_page.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case SectionPage.nameReoute:
        return MaterialPageRoute(builder: (context) => const SectionPage());
      case StartActyvityPage.nameReoute:
        return MaterialPageRoute(
            builder: (context) => const StartActyvityPage());
      case ManagerActivityPage.nameReoute:
        return MaterialPageRoute(
          builder: (context) => ManagerActivityPage(
            item: settings.arguments as Activity,
          ),
        );
      case RunningActivityPage.nameReoute:
        return MaterialPageRoute(
          builder: (context) => RunningActivityPage(
            item: settings.arguments as Activity,
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            appBar: AppBar(
              title: const Text("Error"),
              centerTitle: true,
            ),
            body: const Center(
              child: Text("Page not found"),
            ),
          ),
        );
    }
  }
}
