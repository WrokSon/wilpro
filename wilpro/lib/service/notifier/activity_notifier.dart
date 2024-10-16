import 'package:flutter/foundation.dart';
import 'package:wilpro/model/activity.dart';
import 'package:wilpro/model/task.dart';
import 'package:wilpro/service/notifier/task_notifier.dart';

class ActivityNotifier with ChangeNotifier {
  final List<Activity> _activities = [
    Activity(id: "id", title: "title", tasks: [])
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
}
