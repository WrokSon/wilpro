import 'package:wilpro/model/enum/format_time_enum.dart';
import 'package:wilpro/model/structure/my_time.dart';

class Tools {
  static String twoDigits(int n) => n.toString().padLeft(2, "0");
  // convertiseur de date
  static String dateString(DateTime date) =>
      "${twoDigits(date.day)}/${twoDigits(date.month)}/${twoDigits(date.year)}";

  // convertisseur de temps
  static String timeString(MyTime time,
      {bool enLettre = false, FormatTimeEnum format = FormatTimeEnum.auto}) {
    // 00h00min30s
    if (enLettre) {
      switch (format) {
        case FormatTimeEnum.hhmmss:
          return "${twoDigits(time.hour)}h${twoDigits(time.minute)}min${twoDigits(time.second)}";
        case FormatTimeEnum.hhmm:
          return "${twoDigits(time.hour)}h${twoDigits(time.minute)}";
        case FormatTimeEnum.mmss:
          if (time.hour > 0) {
            return "${twoDigits(time.hour)}h${twoDigits(time.minute)}min${twoDigits(time.second)}";
          }
          return "${twoDigits(time.minute)}min${twoDigits(time.second)}";
        case FormatTimeEnum.auto:
        default:
          if (time.hour <= 0) {
            if (time.minute <= 0) {
              return "${twoDigits(time.second)}s";
            }
            return "${twoDigits(time.minute)}min${twoDigits(time.second)}";
          }
          return "${twoDigits(time.hour)}h${twoDigits(time.minute)}min${twoDigits(time.second)}";
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
        return "${twoDigits(time.minute)}:${twoDigits(time.second)}";
      case FormatTimeEnum.auto:
      default:
        if (time.hour <= 0) {
          if (time.minute <= 0) {
            return twoDigits(time.second);
          }
          return "${twoDigits(time.minute)}:${twoDigits(time.second)}";
        }
        return "${twoDigits(time.hour)}:${twoDigits(time.minute)}:${twoDigits(time.second)}";
    }
  }

  // url image meteo
  static String getURLImageMeteo(String icon) =>
      "https://openweathermap.org/img/wn/$icon@2x.png";

  static int stringToInt(String value) {
    final res = value.trim().replaceFirst(RegExp(r'^0+'), '');
    return int.parse(res.isNotEmpty ? res : "0");
  }

  // convertisseur de temps
  // convertisseur de temps
  static String timeString2(DateTime time,
      {bool enLettre = false, FormatTimeEnum format = FormatTimeEnum.auto}) {
    // 00h00min30s
    if (enLettre) {
      switch (format) {
        case FormatTimeEnum.hhmmss:
          return "${twoDigits(time.hour)}h${twoDigits(time.minute)}min${twoDigits(time.second)}";
        case FormatTimeEnum.hhmm:
          return "${twoDigits(time.hour)}h${twoDigits(time.minute)}";
        case FormatTimeEnum.mmss:
          if (time.hour > 0) {
            return "${twoDigits(time.hour)}h${twoDigits(time.minute)}min${twoDigits(time.second)}";
          }
          return "${twoDigits(time.minute)}min${twoDigits(time.second)}";
        case FormatTimeEnum.auto:
        default:
          if (time.hour <= 0) {
            if (time.minute <= 0) {
              return "${twoDigits(time.second)}s";
            }
            return "${twoDigits(time.minute)}min${twoDigits(time.second)}";
          }
          return "${twoDigits(time.hour)}h${twoDigits(time.minute)}min${twoDigits(time.second)}";
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
        return "${twoDigits(time.minute)}:${twoDigits(time.second)}";
      case FormatTimeEnum.auto:
      default:
        if (time.hour <= 0) {
          if (time.minute <= 0) {
            return twoDigits(time.second);
          }
          return "${twoDigits(time.minute)}:${twoDigits(time.second)}";
        }
        return "${twoDigits(time.hour)}:${twoDigits(time.minute)}:${twoDigits(time.second)}";
    }
  }
}
