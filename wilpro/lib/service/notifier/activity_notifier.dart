import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';
import 'package:wilpro/model/activity.dart';
import 'package:wilpro/model/my_database.dart';
import 'package:wilpro/model/quantity.dart';
import 'package:wilpro/model/structure/my_time.dart';
import 'package:wilpro/model/task.dart';
import 'package:wilpro/service/notifier/task_notifier.dart';
import 'package:wilpro/service/tools.dart';

class ActivityNotifier with ChangeNotifier {
  List<Activity> _activities = [];
  final taskNotifier = TaskNotifier.instance;
  final database = MyDatabase.instance;

  static final instance = ActivityNotifier._();
  ActivityNotifier._();

  Future<List<Activity>> init() async {
    taskNotifier.init();
    return await database.getActivities();
  }

  List<Activity> get activities => _activities;

  set activities(List<Activity> value) {
    _activities = value;
    notifyListeners();
  }

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
    final activity =
        Activity(id: const Uuid().v1(), title: title.trim(), tasks: tasks);
    _activities.add(activity);
    notifyListeners();
    database.insertActivity(activity);
  }

  // modifier une activiter
  void editActivity(
      {required String id,
      required String title,
      required List<Quantity> tasks}) async {
    final activity = getById(id);
    activity.title = title;
    activity.tasks = tasks;
    notifyListeners();
    await database.updateActivity(activity);
  }

  void deleteActivityById(String id) async {
    _activities.removeWhere((test) => test.id == id);
    notifyListeners();
    await database.deleteActivity(id);
  }

  // verifi si l'activité existe avec l'id
  bool isExistById(String id) => getById(id).id != "-1" ? true : false;

  // verifi si l'activité existe avec l'le titre
  bool isExistByTitle(String title, {String? original}) {
    final activity = _activities.firstWhere(
      (element) => element.title == title,
      orElse: () => Activity(id: "-1", title: "", tasks: []),
    );

    return activity.id != "-1" && title != original ? true : false;
  }

  // recupere toutes les taches de l'activité via l'id
  List<Task> getListTaskById(String id) {
    List<Task> resultat = [];
    if (isExistById(id)) {
      final listQuantity = getById(id).tasks;
      resultat = taskNotifier
          .getByListId(listQuantity.map((element) => element.idTask).toList());
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

  void clearActivities(){
    database.clearActivity();
    notifyListeners();
  }
}
