import 'package:flutter/material.dart';
import 'package:wilpro/model/activity.dart';
import 'package:wilpro/ui/page/manager_activity_page.dart';
import 'package:wilpro/ui/page/section_page.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case SectionPage.nameReoute:
        return MaterialPageRoute(builder: (context) => const SectionPage());
      case ManagerActivityPage.nameReoute:
        return MaterialPageRoute(
            builder: (context) => ManagerActivityPage(
                  item: settings.arguments as Activity,
                ));
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
