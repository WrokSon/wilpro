import 'package:flutter/foundation.dart';
import 'package:wilpro/model/activity.dart';
import 'package:wilpro/model/quantity.dart';
import 'package:wilpro/model/task.dart';
import 'package:wilpro/service/notifier/task_notifier.dart';
import 'package:wilpro/service/tools.dart';

class ActivityNotifier with ChangeNotifier {
  final List<Activity> _activities = [
    Activity(id: "id", title: "Ma routine", tasks: [
      Quantity(id: "id5", value: 10, idTask: "pompe"),
      Quantity(
          id: "id2",
          value: DateTime(0, 0, 0, 0, 30, 0).microsecondsSinceEpoch,
          idTask: "repo"),
      Quantity(id: "id3", value: 10, idTask: "marche"),
      Quantity(
          id: "id6",
          value: DateTime(0, 0, 0, 0, 15, 0).microsecondsSinceEpoch,
          idTask: "mange"),
    ]),
    Activity(id: "id2", title: "Sport", tasks: [
      Quantity(id: "id7", value: 30, idTask: "pompe"),
      Quantity(
          id: "id8",
          value: DateTime(0, 0, 0, 0, 1, 0).microsecondsSinceEpoch,
          idTask: "repo"),
      Quantity(id: "id9", value: 30, idTask: "pompe"),
      Quantity(
          id: "id10",
          value: DateTime(0, 0, 0, 0, 1, 0).microsecondsSinceEpoch,
          idTask: "repo"),
      Quantity(id: "id11", value: 30, idTask: "pompe"),
      Quantity(
          id: "id12",
          value: DateTime(0, 0, 0, 0, 1, 0).microsecondsSinceEpoch,
          idTask: "repo"),
      Quantity(id: "id13", value: 30, idTask: "pompe"),
      Quantity(
          id: "id14",
          value: DateTime(0, 0, 0, 0, 1, 0).microsecondsSinceEpoch,
          idTask: "repo"),
      Quantity(id: "id15", value: 30, idTask: "pompe"),
      Quantity(
          id: "id16",
          value: DateTime(0, 0, 0, 0, 1, 0).microsecondsSinceEpoch,
          idTask: "repo"),
    ]),
    Activity(id: "id3", title: "Session", tasks: [
      Quantity(
          id: "id18",
          value: DateTime(0, 0, 0, 0, 30, 0).microsecondsSinceEpoch,
          idTask: "jouer"),
      Quantity(
          id: "id19",
          value: DateTime(0, 0, 0, 0, 15, 0).microsecondsSinceEpoch,
          idTask: "mange"),
      Quantity(
          id: "id20",
          value: DateTime(0, 0, 0, 5, 0, 0).microsecondsSinceEpoch,
          idTask: "dodo"),
    ]),
    Activity(id: "id4", title: "Etudier", tasks: [
      Quantity(
          id: "id22",
          value: DateTime(0, 0, 0, 0, 30, 0).microsecondsSinceEpoch,
          idTask: "etude"),
      Quantity(
          id: "id23",
          value: DateTime(0, 0, 0, 0, 30, 0).microsecondsSinceEpoch,
          idTask: "musique"),
      Quantity(
          id: "id25",
          value: DateTime(0, 0, 0, 0, 30, 0).microsecondsSinceEpoch,
          idTask: "etude"),
      Quantity(
          id: "id32",
          value: DateTime(0, 0, 0, 0, 30, 0).microsecondsSinceEpoch,
          idTask: "musique"),
      Quantity(
          id: "id36",
          value: DateTime(0, 0, 0, 0, 30, 0).microsecondsSinceEpoch,
          idTask: "etude"),
    ]),
  ];
  final taskNotifier = TaskNotifier.instance;

  static final instance = ActivityNotifier._();
  ActivityNotifier._();

  List<Activity> get activities => _activities;

  // renvoie l'activité
  Activity getById(String id) => _activities.firstWhere(
        (element) => element.id == id,
        orElse: () => Activity(id: "-1", title: "", tasks: []),
      );

  // verifi si l'activité existe avec l'id
  bool isExistById(String id) => getById(id).id != "-1" ? true : false;

  // verifi si l'activité existe avec l'le titre
  bool isExistByTitle(String title) => _activities
              .firstWhere(
                (element) => element.title == title,
                orElse: () => Activity(id: "-1", title: "", tasks: []),
              )
              .id ==
          "-1"
      ? true
      : false;

  // recupere toutes les taches de l'activité via l'id
  List<Task> getListTaskById(String id) {
    final List<Task> resultat = [];
    if (isExistById(id)) {
      return taskNotifier.getByListId(
          getById(id).tasks.map((element) => element.idTask).toList());
    }
    return resultat;
  }

  // renvoi la liste des les phrase pour les taches a afficher
  List<String> getListTaskStringById(String id) {
    final List<String> resultat = [];
    if (isExistById(id)) {
      for (final quantity in getById(id).tasks) {
        if (taskNotifier.isExistById(quantity.idTask)) {
          final task = taskNotifier.getById(quantity.idTask);
          if (task.withTimer) {
            resultat.add(
                "${Tools.timeString(DateTime.fromMicrosecondsSinceEpoch(quantity.value), enLettre: true)} : ${task.title}");
          } else {
            resultat.add(
                quantity.value < 900000000000 && quantity.value > -900000000000
                    ? "${quantity.value} : ${task.title}"
                    : "Impossible");
          }
        }
      }
    }

    return resultat;
  }
}
