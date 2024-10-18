import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';
import 'package:wilpro/model/task.dart';

class TaskNotifier with ChangeNotifier {
  static final TaskNotifier instance = TaskNotifier._();

  final List<Task> _tasks = [
    Task(id: "run", title: "courrir", withTimer: true),
    Task(id: "pompe", title: "pompe", withTimer: false)
  ];

  // constructeur privée
  TaskNotifier._();

  // renvoie la liste entiere des tache existante
  List<Task> get taks => _tasks;
  // renvoie la tache correspondant a l'id
  Task getById(String id) => _tasks.firstWhere(
        (element) => element.id == id,
        orElse: () => Task(id: "-1", title: "", withTimer: false),
      );

  // verifi si la tache existe avec l'id
  bool isExistById(String id) => getById(id).id != "-1" ? true : false;

  // verifie une tache exite
  bool isExistByTask(String title, bool withTimer) => _tasks
              .firstWhere(
                (element) =>
                    element.title == title && element.withTimer == withTimer,
                orElse: () => Task(id: "-1", title: "", withTimer: false),
              )
              .id ==
          "-1"
      ? false
      : true;

  // renvoie la liste avec les taches correspondant a la liste d'id
  List<Task> getByListId(List<String> listID) {
    final List<Task> liste = [];
    for (String id in listID) {
      if (isExistById(id)) liste.add(getById(id));
    }
    return liste;
  }

  // ajouter une tache
  void addTask({required String title, required bool withTimer}) {
    if (!isExistByTask(title, withTimer)) {
      _tasks
          .add(Task(id: const Uuid().v1(), title: title, withTimer: withTimer));
      notifyListeners();
    }
  }

  void editTask(Task task) {
    if (isExistById(task.id)) {
      final tache = _tasks.firstWhere((test) => test.id == task.id);
      tache.title = task.title;
      tache.withTimer = task.withTimer;
      notifyListeners();
    }
  }

  // supprime l'element de la liste
  void removeTaskById(String id) {
    if (isExistById(id)) {
      _tasks.removeWhere((element) => element.id == id);
      notifyListeners();
    }
  }
}
