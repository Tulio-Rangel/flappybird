import 'package:equatable/equatable.dart';
import 'package:flappy_dash/audio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'game_state.dart'; // Importa la definición del estado del juego desde 'game_state.dart'.

/// Clase `GameCubit` que extiende `Cubit` para manejar el estado del juego.
/// Utiliza el patrón Bloc para gestionar los estados de manera reactiva.
class GameCubit extends Cubit<GameState> {
  /// Constructor de `GameCubit`.
  /// Inicializa el estado del juego con un estado predeterminado.
  GameCubit(this._audioHelper) : super(const GameState());

  final AudioHelper
      _audioHelper; // Instancia de AudioHelper para manejar el audio.

  /// Método para iniciar el juego.
  /// Cambia el estado del juego a `PlayingState.playing` y reinicia la puntuación a 0.
  void startPlaying() {
    _audioHelper.playBackgroundAudio(); // Reproduce el audio de fondo.
    emit(state.copyWith(
      currentPlayingState:
          PlayingState.playing, // Cambia el estado a "jugando".
      currentScore: 0, // Reinicia la puntuación.
    ));
  }

  /// Método para incrementar la puntuación del juego.
  /// Aumenta la puntuación actual en 1.
  void increaseScore() {
    _audioHelper.playScoreCollectSound(); // Reproduce el sonido de puntuación.
    emit(state.copyWith(
      currentScore: state.currentScore + 1, // Incrementa la puntuación.
    ));
  }

  /// Método para finalizar el juego.
  /// Cambia el estado del juego a `PlayingState.gameOver`.
  void gameOver() {
    _audioHelper.stopBackgroundAudio(); // Detiene el audio de fondo.
    emit(state.copyWith(
      currentPlayingState:
          PlayingState.gameOver, // Cambia el estado a "juego terminado".
    ));
  }

  /// Método para reiniciar el juego.
  /// Cambia el estado del juego a `PlayingState.none` y reinicia la puntuación a 0.
  void restartGame() {
    emit(state.copyWith(
      currentPlayingState: PlayingState.none, // Cambia el estado a "sin jugar".
      currentScore: 0, // Reinicia la puntuación.
    ));
  }
}
