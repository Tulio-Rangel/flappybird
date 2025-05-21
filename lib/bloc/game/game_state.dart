part of 'game_cubit.dart'; // Indica que este archivo es parte del archivo principal 'game_cubit.dart'.

/// Clase que representa el estado del juego.
/// Utiliza `EquatableMixin` para facilitar la comparación de instancias.
class GameState with EquatableMixin {
  /// Constructor de la clase `GameState`.
  /// - [currentScore]: Puntuación actual del juego (por defecto 0).
  /// - [currentPlayingState]: Estado actual del juego (por defecto `PlayingState.none`).
  const GameState({
    this.currentScore = 0,
    this.currentPlayingState = PlayingState.none,
  });

  final int currentScore; // Puntuación actual del juego.
  final PlayingState currentPlayingState; // Estado actual del juego.

  /// Método que crea una copia del estado actual con valores opcionalmente modificados.
  /// - [currentScore]: Nueva puntuación (si se proporciona).
  /// - [currentPlayingState]: Nuevo estado del juego (si se proporciona).
  GameState copyWith({
    int? currentScore,
    PlayingState? currentPlayingState,
  }) =>
      GameState(
        currentScore: currentScore ??
            this.currentScore, // Mantiene la puntuación actual si no se proporciona una nueva.
        currentPlayingState: currentPlayingState ??
            this.currentPlayingState, // Mantiene el estado actual si no se proporciona uno nuevo.
      );

  /// Define las propiedades que se utilizarán para comparar instancias de `GameState`.
  @override
  List<Object> get props => [
        currentScore, // Incluye la puntuación actual.
        currentPlayingState, // Incluye el estado actual del juego.
      ];
}

/// Enumeración que define los posibles estados del juego.
enum PlayingState {
  none, // El juego no ha comenzado.
  playing, // El juego está en progreso.
  paused, // El juego está pausado.
  gameOver; // El juego ha terminado.

  bool get isGameOver =>
      this ==
      PlayingState.gameOver; // Método para verificar si el juego ha terminado.
  bool get isPlaying =>
      this ==
      PlayingState
          .playing; // Método para verificar si el juego está en progreso.
  bool get isPaused =>
      this ==
      PlayingState.paused; // Método para verificar si el juego está pausado.
  bool get isNone =>
      this ==
      PlayingState.none; // Método para verificar si el juego no ha comenzado.
}
