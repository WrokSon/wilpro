import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';
import 'package:wilpro/model/activity.dart';
import 'package:wilpro/model/quantity.dart';
import 'package:wilpro/model/structure/my_time.dart';
import 'package:wilpro/model/task.dart';
import 'package:wilpro/service/notifier/task_notifier.dart';
import 'package:wilpro/service/tools.dart';

class ActivityNotifier with ChangeNotifier {
  final List<Activity> _activities = [
    Activity(id: "id", title: "mon title", tasks: [
      Quantity(id: "id", value: 20, idTask: "pompe"),
      Quantity(id: "2", value: MyTime(minute: 5).getValue(), idTask: "run")
    ])
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

  bool isTitleExist(String title) => _activities
              .firstWhere((test) => test.title.trim() == title.trim(),
                  orElse: () => Activity(id: "-1", title: "", tasks: []))
              .id ==
          "-1"
      ? false
      : true;

  // ajouter une activiter
  void addActivity({required String title, required List<Quantity> tasks}) {
    _activities.add(
        Activity(id: const Uuid().v1(), title: title.trim(), tasks: tasks));
    notifyListeners();
  }

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
    List<Task> resultat = [];
    if (isExistById(id)) {
      final listQuantity = getById(id).tasks;
      resultat = taskNotifier.getByListId(
          listQuantity.map((element) => element.idTask).toList());
      // if(resultat.length != listQuantity.length) // revision
    }
    return resultat;
  }

  // renvoi la liste des les phrase pour les taches a afficher
  List<String> getListTaskStringById(String id) {
    final List<String> resultat = [];
    if (isExistById(id)) {
      final activity = getById(id);
      for (final quantity in activity.tasks) {
        if (taskNotifier.isExistById(quantity.idTask)) {
          final task = taskNotifier.getById(quantity.idTask);
          if (task.withTimer) {
            resultat.add(
                "${Tools.timeString(MyTime.fromValue(quantity.value), enLettre: true)} : ${task.title}");
          } else {
            resultat.add(
                quantity.value < 900000000000 && quantity.value > -900000000000
                    ? "${quantity.value} : ${task.title}"
                    : "Impossible");
          }
        } else {
          // mettre a jour
          // n'a pas trouvé la tache avec l'id
          activity.tasks.removeWhere((test) => quantity.id == quantity.id);
        }
      }
    }

    return resultat;
  }
}
