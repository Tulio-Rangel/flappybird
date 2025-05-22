import 'package:flutter_soloud/flutter_soloud.dart';

class AudioHelper {
  late SoLoud _soLoud;
  late AudioSource _backgroundSource;
  SoundHandle? _playingBackgroundHandle;

  late AudioSource _scoreSource;

  Future<void> initialize() async {
    _soLoud = SoLoud.instance;
    if (_soLoud.isInitialized) {
      return;
    }
    await _soLoud.init();
    _backgroundSource = await _soLoud.loadAsset('assets/audio/background.mp3');
    _scoreSource = await _soLoud.loadAsset('assets/audio/score.mp3');
  }

  void playBackgroundAudio() async {
    _playingBackgroundHandle = await _soLoud.play(_backgroundSource);
    _soLoud.setProtectVoice(_playingBackgroundHandle!, true);
  }

  void stopBackgroundAudio() {
    if (_playingBackgroundHandle == null) {
      return;
    }

    _soLoud.fadeVolume(
        _playingBackgroundHandle!, 0.0, const Duration(milliseconds: 500));
  }

  void playScoreCollectSound() async {
    await _soLoud.play(_scoreSource);
  }
}
