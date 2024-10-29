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

  String loading() {
    switch (notifier.language) {
      case LangageEnum.english:
        return "Loading";
      case LangageEnum.french:
      default:
        return "Chargement";
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

  String launch() {
    switch (notifier.language) {
      case LangageEnum.english:
        return "LAUNCH";
      case LangageEnum.french:
      default:
        return "LANCER";
    }
  }

  String finish() {
    switch (notifier.language) {
      case LangageEnum.english:
        return "FINISH";
      case LangageEnum.french:
      default:
        return "TERMINER";
    }
  }

  String done() {
    switch (notifier.language) {
      case LangageEnum.english:
        return "DONE";
      case LangageEnum.french:
      default:
        return "FINI";
    }
  }

  String skip() {
    switch (notifier.language) {
      case LangageEnum.english:
        return "SKIP";
      case LangageEnum.french:
      default:
        return "PASSER";
    }
  }

  String pause() {
    switch (notifier.language) {
      case LangageEnum.english:
        return "PAUSE";
      case LangageEnum.french:
      default:
        return "PAUSE";
    }
  }

  String play() {
    switch (notifier.language) {
      case LangageEnum.english:
        return "PLAY";
      case LangageEnum.french:
      default:
        return "REPRENDRE";
    }
  }

  String stop() {
    switch (notifier.language) {
      case LangageEnum.english:
        return "STOP";
      case LangageEnum.french:
      default:
        return "ARRETER";
    }
  }

  String modeLang() => notifier.language.value;

  String settings() {
    switch (notifier.language) {
      case LangageEnum.english:
        return "SETTINGS";
      case LangageEnum.french:
      default:
        return "PARAMETTRES";
    }
  }

  String aboutUs() {
    switch (notifier.language) {
      case LangageEnum.english:
        return "about us";
      case LangageEnum.french:
      default:
        return "A propos de nous";
    }
  }

  String dark() {
    switch (notifier.language) {
      case LangageEnum.english:
        return "dark";
      case LangageEnum.french:
      default:
        return "Sombre";
    }
  }

  String autoSave() {
    switch (notifier.language) {
      case LangageEnum.english:
        return "auto save";
      case LangageEnum.french:
      default:
        return "Sauvegarde auto";
    }
  }

  String clean() {
    switch (notifier.language) {
      case LangageEnum.english:
        return "CLEAN";
      case LangageEnum.french:
      default:
        return "VIDER";
    }
  }

  String others() {
    switch (notifier.language) {
      case LangageEnum.english:
        return "OTHERS";
      case LangageEnum.french:
      default:
        return "AUTRES";
    }
  }

  String reset() {
    switch (notifier.language) {
      case LangageEnum.english:
        return "RESET";
      case LangageEnum.french:
      default:
        return "REINITILISER";
    }
  }

  String music() {
    switch (notifier.language) {
      case LangageEnum.english:
        return "Music";
      case LangageEnum.french:
      default:
        return "Musique";
    }
  }

  String sound() {
    switch (notifier.language) {
      case LangageEnum.english:
        return "sound";
      case LangageEnum.french:
      default:
        return "son";
    }
  }

  String textAboutUs() {
    switch (notifier.language) {
      case LangageEnum.english:
        return "I am a second year Master student in Orleans. I code free applications in order to meet a need or requests. I work alone so if there are improvements that you want to see on this application let me know and I will look into this improvement during my free time.";
      case LangageEnum.french:
      default:
        return "Je suis un étudiant en deuxième année de Master à Orleans. Je code des applications gratuites afin de répondre à un besoin ou des demandes. Je travaille tout seul donc s'il y a des améliorations que vous voulez voir sur cette application faite le moi savoir et je me pencherai sur cette amélioration durant mes temps libres.";
    }
  }

}
