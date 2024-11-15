import 'package:flutter/material.dart';
import 'package:wilpro/model/enum/format_time_enum.dart';
import 'package:wilpro/model/enum/key_api.dart';
import 'package:wilpro/model/structure/my_gps.dart';
import 'package:wilpro/service/tools.dart';
import 'package:wilpro/ui/composants/my_colors.dart';
import 'package:wilpro/ui/composants/my_image.dart';
import 'package:wilpro/ui/composants/my_widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MyMeteo extends StatefulWidget {
  const MyMeteo({super.key});

  @override
  State<MyMeteo> createState() => _MyMeteo();
}

class _MyMeteo extends State<MyMeteo> {
  String _idIcon = "10d";
  double? degres;
  String description = "...";
  String? _city;

  Future<void> _getMeteo() async {
    try {
      final position = await MyGps.instance.getCurrentLocation();
      final apiUrl =
          "https://api.openweathermap.org/data/2.5/weather?lat=${position.latitude}&lon=${position.longitude}&appid=${KeyApi.meteo.value}&units=metric&lang=fr";

      final reponse = await http.get(Uri.parse(apiUrl));

      if (reponse.statusCode == 200) {
        Map<String, dynamic> meteoData = json.decode(reponse.body);
        setState(() {
          description = meteoData['weather'][0]['description'];
          _idIcon = meteoData["weather"][0]["icon"];
          degres = meteoData['main']['temp'];
          _city = meteoData['name'];
        });
      }
    } catch (e) {
      degres = null;
    }
  }

  @override
  void initState() {
    super.initState();
    _getMeteo();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _getMeteo();
        });
      },
      child: Card(
        elevation: 10,
        color: MyColors.backgroundNavBar,
        child: Container(
          margin: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              MyWidgets.text(
                  text: Tools.timeString2(DateTime.now(),
                      format: FormatTimeEnum.hhmmss),
                  size: 30),
              _city == null ? const SizedBox() : MyWidgets.text(text: _city!),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 100,
                    width: 100,
                    child: MyImage.network(Tools.getURLImageMeteo(_idIcon)),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      MyWidgets.text(
                          text: degres == null
                              ? "???°C"
                              : '${degres!.toInt()}°C'),
                      MyWidgets.text(text: description),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
