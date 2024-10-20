import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';
import 'package:wilpro/model/quantity.dart';

class ManagerActivityNotifier with ChangeNotifier {
  List<Quantity> _editActivityList = [];
  static final instance = ManagerActivityNotifier._();
  ManagerActivityNotifier._();

  /// ADD/EDITION

  List<Quantity> get editList => _editActivityList;
  set editList(List<Quantity> value) {
    _editActivityList = value;
    notifyListeners();
  }

  void clearEditList() => _editActivityList.clear();

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
