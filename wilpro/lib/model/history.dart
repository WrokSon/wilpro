import 'package:wilpro/model/structure/my_date.dart';
import 'package:wilpro/model/structure/my_time.dart';

class History {
  final String id;
  final String idActivity;
  final String title;
  final MyTime time; // heure de la seance
  final MyTime duration; // temps mis
  final MyDate date;

  History(
      {required this.id,
      required this.title,
      required this.idActivity,
      required this.time,
      required this.date,
      required this.duration});
}
