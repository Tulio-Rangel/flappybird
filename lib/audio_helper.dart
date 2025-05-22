import 'package:flutter_soloud/flutter_soloud.dart'; // Importa la biblioteca flutter_soloud, que proporciona funcionalidades para manejar audio.

class AudioHelper {
  late SoLoud _soLoud; // Instancia de SoLoud para manejar el motor de audio.
  late AudioSource
      _backgroundSource; // Fuente de audio para el sonido de fondo.
  SoundHandle?
      _playingBackgroundHandle; // Identificador del sonido de fondo actualmente en reproducción.

  late AudioSource
      _scoreSource; // Fuente de audio para el sonido de puntuación.

  // Inicializa el motor de audio y carga los archivos de audio necesarios.
  Future<void> initialize() async {
    _soLoud = SoLoud.instance; // Obtiene la instancia singleton de SoLoud.
    if (_soLoud.isInitialized) {
      // Verifica si el motor de audio ya está inicializado.
      return; // Si ya está inicializado, no hace nada.
    }
    await _soLoud.init(); // Inicializa el motor de audio.
    _backgroundSource = await _soLoud.loadAsset(
        'assets/audio/background.mp3'); // Carga el archivo de audio de fondo.
    _scoreSource = await _soLoud.loadAsset(
        'assets/audio/score.mp3'); // Carga el archivo de audio de puntuación.
  }

  // Reproduce el audio de fondo en bucle.
  void playBackgroundAudio() async {
    _playingBackgroundHandle = await _soLoud.play(
        _backgroundSource); // Reproduce el audio de fondo y guarda el identificador.
    _soLoud.setProtectVoice(_playingBackgroundHandle!,
        true); // Protege el audio de fondo para evitar que sea interrumpido.
  }

  // Detiene el audio de fondo con un efecto de desvanecimiento.
  void stopBackgroundAudio() {
    if (_playingBackgroundHandle == null) {
      // Verifica si hay un audio de fondo en reproducción.
      return; // Si no hay audio en reproducción, no hace nada.
    }

    _soLoud.fadeVolume(
        _playingBackgroundHandle!,
        0.0,
        const Duration(
            milliseconds:
                500)); // Reduce el volumen del audio de fondo a 0 en 500 ms.
  }

  // Reproduce el sonido de puntuación.
  void playScoreCollectSound() async {
    await _soLoud.play(_scoreSource); // Reproduce el sonido de puntuación.
  }
}
