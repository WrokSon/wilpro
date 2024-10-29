import 'package:shared_preferences/shared_preferences.dart';

class SharedPreference {
  static const theme = "theme";
  static const autoSaveHistory = "autosavehistory";
  static const music = "music";
  static const langue = "lang";

  // GETTERS

  Future<bool> getThemeIsDark() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(theme) ?? false;
  }

  Future<bool> getAutoSaveHistory() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(autoSaveHistory) ?? true;
  }

  Future<bool> getIsMusic() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(music) ?? true;
  }

  Future<String> getlangue() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(langue) ?? "fr";
  }

  // SETTERS

  Future<void> setThemeIsDark(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(theme, value);
  }

  Future<void> setAutoSaveHistory(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(autoSaveHistory, value);
  }

  Future<void> setIsMusic(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(music, value);
  }

  Future<void> setlangue(String value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(langue, value);
  }
}
