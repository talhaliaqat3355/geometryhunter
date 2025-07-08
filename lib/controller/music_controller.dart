import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';

class MusicController extends GetxController {
  final AudioPlayer _player = AudioPlayer();
  final isPlaying = false.obs;

  @override
  void onInit() {
    super.onInit();
    _player.setReleaseMode(ReleaseMode.loop);
    playMusic();
  }

  void playMusic() async {
    await _player.play(AssetSource('audio/background_music.mp3'));
    isPlaying.value = true;
  }

  void stopMusic() async {
    await _player.pause();
    isPlaying.value = false;
  }

  void toggleMusic() {
    isPlaying.value ? stopMusic() : playMusic();
  }
}
