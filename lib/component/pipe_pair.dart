import 'package:flame/components.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flappy_dash/bloc/game/game_cubit.dart';
import 'package:flappy_dash/component/pipe.dart';

import 'hidden_coin.dart';

/// Clase que representa un par de tubos en el juego.
/// Los tubos se mueven horizontalmente y tienen un espacio entre ellos.
/// También incluye una moneda oculta entre los tubos.
class PipePair extends PositionComponent
    with FlameBlocReader<GameCubit, GameState> {
  /// Constructor de la clase `PipePair`.
  /// - [position]: Posición inicial del par de tubos.
  /// - [gap]: Tamaño del espacio entre los tubos (por defecto 200.0).
  /// - [speed]: Velocidad de movimiento horizontal de los tubos (por defecto 200.0).
  PipePair({
    required super.position,
    this.gap = 200.0,
    this.speed = 200.0,
  });

  final double gap; // Tamaño del espacio entre los tubos.
  final double speed; // Velocidad de movimiento horizontal de los tubos.

  /// Método que se ejecuta al cargar el componente.
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    // Agrega los componentes que forman el par de tubos y la moneda oculta.
    addAll([
      // Tubo inferior (no volteado).
      Pipe(
        isFlipped: false,
        position: Vector2(0, gap / 2), // Posición relativa al centro del par.
      ),
      // Tubo superior (volteado).
      Pipe(
        isFlipped: true,
        position:
            Vector2(0, -(gap / 2)), // Posición relativa al centro del par.
      ),
      // Moneda oculta entre los tubos.
      HiddenCoin(
        position: Vector2(30, 0), // Posición relativa al centro del par.
      ),
    ]);
  }

  /// Método que actualiza el estado del par de tubos en cada frame.
  /// - [dt]: Tiempo transcurrido desde el último frame.
  @override
  void update(double dt) {
    // Verifica el estado actual del juego para determinar si los tubos deben moverse.
    switch (bloc.state.currentPlayingState) {
      case PlayingState.paused:
      case PlayingState.gameOver:
      case PlayingState.none:
        // Si el juego está pausado, terminado o no iniciado, los tubos no se mueven.
        break;
      case PlayingState.playing:
        // Si el juego está en progreso, mueve los tubos hacia la izquierda.
        position.x -= speed * dt;
        break;
    }
    super.update(dt); // Llama al método de actualización de la clase base.
  }
}
