import 'package:audioplayers/audioplayers.dart';

class MusicPlayer {
  final audioPlayer = AudioPlayer();
  static final instance = MusicPlayer._();
  MusicPlayer._();
  void playSound() async {
    await audioPlayer.play(AssetSource('sounds/next.mp3'));
  }
}
