import 'package:path/path.dart';
import 'package:sqflite_common/sqflite.dart';
import 'package:wilpro/model/activity.dart';
import 'package:wilpro/model/history.dart';
import 'package:wilpro/model/quantity.dart';
import 'package:wilpro/model/task.dart';

class MyDatabase {
  static const _nameTableActivity = "activities";
  static const _nameTableTask = "taks";
  static const _nameTableHistory = "history";
  static const _nameTableQuantity = "quantity";
  static Database? _database;
  static final instance = MyDatabase._();

  MyDatabase._();

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await initDB();
    return _database;
  }

  Future<Database?> initDB() async {
    return await openDatabase(
      join(await getDatabasesPath(), "wilpro_database.db"),
      onCreate: (Database db, int version) async {
        await Future.wait([
          db.execute(
            "CREATE TABLE IF NOT EXISTS $_nameTableActivity (id TEXT PRIMARY KEY, title TEXT)",
          ),
          db.execute(
            "CREATE TABLE IF NOT EXISTS $_nameTableTask (id TEXT PRIMARY KEY, title TEXT, withTimer INTEGER)",
          ),
          db.execute(
            "CREATE TABLE IF NOT EXISTS $_nameTableQuantity (id TEXT PRIMARY KEY, value INTEGER, idActivity TEXT, idTask  TEXT, FOREIGN KEY(idActivity) REFERENCES $_nameTableActivity(id) ON DELETE CASCADE, FOREIGN KEY(idTask) REFERENCES $_nameTableTask(id) ON DELETE CASCADE)",
          ),
          db.execute(
            "CREATE TABLE IF NOT EXISTS $_nameTableHistory (id TEXT PRIMARY KEY, title TEXT, idActivity TEXT, time INTEGER, duration INTEGER, date TEXT, FOREIGN KEY(idActivity) REFERENCES $_nameTableActivity(id) ON DELETE CASCADE)",
          ),
        ]);
      },
      version: 1,
    );
  }

  // Activity
  // CRUD pour Activity

  // C - Créer
  Future<void> insertActivity(Activity activity) async {
    final db = await database;
    await db!.insert(
      _nameTableActivity,
      activity.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    // Insérer les quantités associées
    for (var quantity in activity.tasks) {
      await insertQuantity(quantity, activity.id);
    }
  }

  // R - Lire
  Future<List<Activity>> getActivities() async {
    final db = await database;
    final activityMaps = await db!.query(_nameTableActivity);

    List<Activity> activities = [];
    for (var activityMap in activityMaps) {
      final quantities =
          await getQuantitiesForActivity(activityMap['id'] as String);
      activities.add(Activity(
        id: activityMap['id'] as String,
        title: activityMap['title'] as String,
        tasks: quantities,
      ));
    }
    return activities.toList();
  }

  // U - Mettre à jour
  Future<void> updateActivity(Activity activity) async {
    final db = await database;
    await db!.update(
      _nameTableActivity,
      activity.toJson(),
      where: "id = ?",
      whereArgs: [activity.id],
    );

    // Mettre à jour les quantités associées
    for (var quantity in activity.tasks) {
      await updateQuantity(quantity, activity.id);
    }
  }

  // D - Supprimer
  Future<void> deleteActivity(String id) async {
    final db = await database;
    await db!.delete(
      _nameTableActivity,
      where: "id = ?",
      whereArgs: [id],
    );
  }

  // CRUD pour Quantity

  // C - Créer
  Future<void> insertQuantity(Quantity quantity, String idActivity) async {
    final db = await database;
    await db!.insert(
      _nameTableQuantity,
      {
        'id': quantity.id,
        'value': quantity.value,
        'idTask': quantity.idTask,
        'idActivity': idActivity,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // R - Lire (quantités pour une activité)
  Future<List<Quantity>> getQuantitiesForActivity(String activityId) async {
    final db = await database;
    final quantityMaps = await db!.query(
      _nameTableQuantity,
      where: "idActivity = ?",
      whereArgs: [activityId],
    );
    return quantityMaps.map((map) => Quantity.fromJson(map)).toList();
  }

  // U - Mettre à jour une quantité
  Future<void> updateQuantity(Quantity quantity, String idActivity) async {
    final db = await database;
    try {
      insertQuantity(quantity, idActivity);
    } catch (e) {
      await db!.update(
        _nameTableQuantity,
        {
          'id': quantity.id,
          'value': quantity.value,
          'idTask': quantity.idTask,
          'idActivity': idActivity,
        },
        where: "id = ?",
        whereArgs: [quantity.id],
      );
    }
  }

  // D - Supprimer une quantité
  Future<void> deleteQuantity(String id) async {
    final db = await database;
    await db!.delete(
      _nameTableQuantity,
      where: "id = ?",
      whereArgs: [id],
    );
  }

  // CRUD pour Task

  // C - Créer
  Future<void> insertTask(Task task) async {
    final db = await database;
    await db!.insert(
      _nameTableTask,
      task.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // R - Lire
  Future<List<Task>> getTasks() async {
    final db = await database;
    final taskMaps = await db!.query(_nameTableTask);
    return taskMaps.map((map) => Task.fromJson(map)).toList();
  }

  // U - Mettre à jour
  Future<void> updateTask(Task task) async {
    final db = await database;
    await db!.update(
      _nameTableTask,
      task.toJson(),
      where: "id = ?",
      whereArgs: [task.id],
    );
  }

  // D - Supprimer
  Future<void> deleteTask(String id) async {
    final db = await database;
    await db!.delete(
      _nameTableTask,
      where: "id = ?",
      whereArgs: [id],
    );
  }

  // CRUD pour History

  // C - Créer
  Future<void> insertHistory(History history) async {
    final db = await database;
    await db!.insert(
      _nameTableHistory,
      history.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // R - Lire
  Future<List<History>> getHistories() async {
    final db = await database;
    final historyMaps = await db!.query(_nameTableHistory);
    return historyMaps.map((map) => History.fromJson(map)).toList();
  }

  // D - Supprimer
  Future<void> deleteHistory(String id) async {
    final db = await database;
    await db!.delete(
      _nameTableHistory,
      where: "id = ?",
      whereArgs: [id],
    );
  }
}
