import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';
import 'package:wilpro/model/history.dart';
import 'package:wilpro/model/my_database.dart';
import 'package:wilpro/model/structure/my_date.dart';
import 'package:wilpro/model/structure/my_time.dart';
import 'package:wilpro/service/notifier/activity_notifier.dart';

class HistoryNotifier with ChangeNotifier {
  static final instance = HistoryNotifier._();
  final activityNotifier = ActivityNotifier.instance;
  final database = MyDatabase.instance;
  List<History> _historical = [];
  HistoryNotifier._();

  List<History> get getHistorical {
    final List<History> resultat = [];
    for (History history in _historical) {
      activityNotifier.isExistById(history.idActivity)
          ? resultat.add(history)
          : removeById(history.id);
    }
    return resultat;
  }

  Future<List<History>> init() async {
    activityNotifier.activities = await activityNotifier.init();
    _historical = await database.getHistories();
    return _historical;
  }

  void addHistory(
      {required String idActivity,
      required MyTime duration,
      required DateTime begin}) async {
    final title = "Activité de ${activityNotifier.getById(idActivity).title}";
    final history = History(
      id: const Uuid().v1(),
      title: title,
      idActivity: idActivity,
      time: MyTime(hour: begin.hour, minute: begin.minute),
      date: MyDate(day: begin.day, month: begin.month, year: begin.year),
      duration: duration,
    );
    _historical.add(history);
    notifyListeners();
    await database.insertHistory(history);
  }

  void removeById(String id) async {
    _historical.removeWhere((test) => test.id == id);
    await database.deleteHistory(id);
    notifyListeners();
  }
}
