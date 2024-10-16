import 'package:wilpro/model/enum/format_time_enum.dart';

class Tools {
  static String twoDigits(int n) => n.toString().padLeft(2, "0");
  // convertiseur de date
  static String dateString(DateTime date) =>
      "${twoDigits(date.day)}/${twoDigits(date.month)}/${twoDigits(date.year)}";
  // convertisseur de temps
  static String timeString(DateTime time,
      {bool enLettre = false, FormatTimeEnum format = FormatTimeEnum.hhmmss}) {
    // 00h00min30s
    if (enLettre) {
      switch (format) {
        case FormatTimeEnum.hhmmss:
          return "${twoDigits(time.hour)}h${twoDigits(time.minute)}:${twoDigits(time.second)}";
        case FormatTimeEnum.hhmm:
          return "${twoDigits(time.hour)}h${twoDigits(time.minute)}";
        case FormatTimeEnum.mmss:
          if (time.hour > 0) {
            return "${twoDigits(time.hour)}h${twoDigits(time.minute)}min${twoDigits(time.second)}";
          }
          return ":${twoDigits(time.minute)}min${twoDigits(time.second)}";
      }
    }

    // heure:minutes:secondes
    switch (format) {
      case FormatTimeEnum.hhmmss:
        return "${twoDigits(time.hour)}:${twoDigits(time.minute)}:${twoDigits(time.second)}";
      case FormatTimeEnum.hhmm:
        return "${twoDigits(time.hour)}:${twoDigits(time.minute)}";
      case FormatTimeEnum.mmss:
        if (time.hour > 0) {
          return "${twoDigits(time.hour)}:${twoDigits(time.minute)}:${twoDigits(time.second)}";
        }
        return ":${twoDigits(time.minute)}:${twoDigits(time.second)}";
    }
  }

  // url image meteo
  static String getURLImageMeteo(String icon) =>  "https://openweathermap.org/img/wn/$icon@2x.png";

}