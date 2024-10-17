import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';
import 'package:wilpro/model/quantity.dart';

class ManagerActivityNotifier with ChangeNotifier {
  final List<Quantity> _editActivityList = [
    Quantity(id: "1", value: 20, idTask: "pompe"),
    Quantity(
        id: "2",
        value: DateTime(0, 0, 0, 12, 5, 15).microsecondsSinceEpoch,
        idTask: "jouer"),
  ];
  static final instance = ManagerActivityNotifier._();
  ManagerActivityNotifier._();

  /// ADD/EDITION

  List<Quantity> get editList => _editActivityList;

  void deleteToeditActivityList(String id) {
    _editActivityList.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  void editToeditActivityList({required String id, required int value}) {
    _editActivityList.firstWhere((element) => element.id == id).value = value;
    notifyListeners();
  }

  void addToeditActivityList({required int value, required String idTask}) {
    _editActivityList
        .add(Quantity(id: const Uuid().v1(), value: value, idTask: idTask));
    notifyListeners();
  }
}
