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

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'idActivity': idActivity,
      'time': time.getValue(),
      'duration': duration.getValue(),
      'date': date.getValue(),
    };
  }

  static History fromJson(Map<String, dynamic> json) {
    return History(
      id: json['id'],
      title: json['title'],
      idActivity: json['idActivity'],
      time: MyTime.fromValue(json['time']),
      duration: MyTime.fromValue(json['duration']),
      date: MyDate.fromValue(json['date']),
    );
  }
}
