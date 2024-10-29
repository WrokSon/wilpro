import 'package:flutter/material.dart';
import 'package:restart_app/restart_app.dart';
import 'package:wilpro/model/enum/langage_enum.dart';
import 'package:wilpro/service/notifier/activity_notifier.dart';
import 'package:wilpro/service/notifier/history_notifier.dart';
import 'package:wilpro/service/notifier/task_notifier.dart';
import 'package:wilpro/ui/composants/my_colors.dart';

class SettingsNotifier with ChangeNotifier {
  static final instance = SettingsNotifier._();
  final _historyNotifier = HistoryNotifier.instance;
  final _activityNotifier = ActivityNotifier.instance;
  final _taskNotifier = TaskNotifier.instance;
  bool _autoSaveHistory = true;
  bool _playSound = true;
  bool _darkMode = false;
  LangageEnum _langue = LangageEnum.french;

  SettingsNotifier._();
  void init() {}

  bool get playSound => _playSound;

  set playSound(bool value) {
    _playSound = value;
    notifyListeners();
  }

  bool get darkMode => _darkMode;

  set darkMode(bool value) {
    // ici faire le changement de la couleur
    _darkMode = value;
    if (value) {
      MyColors.background = Colors.black;
      MyColors.black = Colors.white;
    } else {
      MyColors.background = const Color.fromARGB(255, 248, 248, 248);
      MyColors.black = Colors.black;
    }
    notifyListeners();
  }

  bool get autoSaveHistory => _autoSaveHistory;

  set autoSaveHistory(bool value) {
    _autoSaveHistory = value;
    notifyListeners();
  }

  LangageEnum get language => _langue;

  set language(LangageEnum value) {
    _langue = value;
    notifyListeners();
  }

  void clearHistory() {
    _historyNotifier.clearHistory();
  }

  void restartApp() {
    _historyNotifier.clearHistory();
    _activityNotifier.clearActivities();
    _taskNotifier.clearTasks();
    Restart.restartApp(
      notificationTitle: 'Restarting App',
      notificationBody: 'Please tap here to open the app again.',
    );
  }
}
