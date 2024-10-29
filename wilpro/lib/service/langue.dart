import 'package:wilpro/model/enum/langage_enum.dart';
import 'package:wilpro/service/notifier/settings_notifier.dart';

class Langue {
  final notifier = SettingsNotifier.instance;

  static final instance = Langue._();

  Langue._();

  String add() {
    switch (notifier.language) {
      case LangageEnum.english:
        return "ADD";
      case LangageEnum.french:
      default:
        return "AJOUTER";
    }
  }

  String tasks() {
    switch (notifier.language) {
      case LangageEnum.english:
        return "Tasks";
      case LangageEnum.french:
      default:
        return "Taches";
    }
  }

  String activities() {
    switch (notifier.language) {
      case LangageEnum.english:
        return "Activities";
      case LangageEnum.french:
      default:
        return "Activités";
    }
  }

  String creation() {
    switch (notifier.language) {
      case LangageEnum.english:
        return "Creation";
      case LangageEnum.french:
      default:
        return "Création";
    }
  }

  String home() {
    switch (notifier.language) {
      case LangageEnum.english:
        return "Home";
      case LangageEnum.french:
      default:
        return "Acceuil";
    }
  }

  String history() {
    switch (notifier.language) {
      case LangageEnum.english:
        return "History";
      case LangageEnum.french:
      default:
        return "Historique";
    }
  }

  String validate() {
    switch (notifier.language) {
      case LangageEnum.english:
        return "VALIDATE";
      case LangageEnum.french:
      default:
        return "VALIDER";
    }
  }

  String withTimer() {
    switch (notifier.language) {
      case LangageEnum.english:
        return "WITH Timer";
      case LangageEnum.french:
      default:
        return "AVEC Chorno";
    }
  }

  String withoutTimer() {
    switch (notifier.language) {
      case LangageEnum.english:
        return "WITHOUT Timer";
      case LangageEnum.french:
      default:
        return "SANS Chorno";
    }
  }

  String start() {
    switch (notifier.language) {
      case LangageEnum.english:
        return "START";
      case LangageEnum.french:
      default:
        return "DEMARRER";
    }
  }

  String empty() {
    switch (notifier.language) {
      case LangageEnum.english:
        return "Empty";
      case LangageEnum.french:
      default:
        return "Vide";
    }
  }

  String title() {
    switch (notifier.language) {
      case LangageEnum.english:
        return "Title";
      case LangageEnum.french:
      default:
        return "Titre";
    }
  }

  String edit() {
    switch (notifier.language) {
      case LangageEnum.english:
        return "EDIT";
      case LangageEnum.french:
      default:
        return "MODIFIER";
    }
  }

  String taskList() {
    switch (notifier.language) {
      case LangageEnum.english:
        return "Task List";
      case LangageEnum.french:
      default:
        return "Liste des taches";
    }
  }

  String yourchoice() {
    switch (notifier.language) {
      case LangageEnum.english:
        return "Your Choice ?";
      case LangageEnum.french:
      default:
        return "Votre choix ?";
    }
  }
}
