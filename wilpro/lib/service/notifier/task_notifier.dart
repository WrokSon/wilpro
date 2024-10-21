import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';
import 'package:wilpro/model/my_database.dart';
import 'package:wilpro/model/task.dart';

class TaskNotifier with ChangeNotifier {
  static final TaskNotifier instance = TaskNotifier._();
  final database = MyDatabase.instance;

  List<Task> _tasks = [];

  // constructeur privée
  TaskNotifier._();
  void init() async {
    _tasks = await database.getTasks();
    notifyListeners();
  }

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
  void addTask({required String title, required bool withTimer}) async {
    if (!isExistByTask(title, withTimer)) {
      final task =
          Task(id: const Uuid().v1(), title: title, withTimer: withTimer);
      _tasks.add(task);
      notifyListeners();
      await database.insertTask(task);
    }
  }

  void editTask(Task task) async {
    if (isExistById(task.id)) {
      final tache = _tasks.firstWhere((test) => test.id == task.id);
      tache.title = task.title;
      tache.withTimer = task.withTimer;
      notifyListeners();
      await database.updateTask(task);
    }
  }

  // supprime l'element de la liste
  void removeTaskById(String id) async {
    if (isExistById(id)) {
      _tasks.removeWhere((element) => element.id == id);
      notifyListeners();
      await database.deleteTask(id);
    }
  }
}
