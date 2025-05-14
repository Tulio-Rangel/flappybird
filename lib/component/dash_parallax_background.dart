import 'package:flame/components.dart';
import 'package:flame/parallax.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flappy_dash/bloc/game/game_cubit.dart';
import 'package:flappy_dash/flappy_dash_game.dart';

/// Clase que representa el fondo parallax del juego Flappy Dash.
/// Extiende `ParallaxComponent` para manejar múltiples capas de fondo
/// que se mueven a diferentes velocidades, creando un efecto de profundidad.
class DashParallaxBackground extends ParallaxComponent<FlappyDashGame>
    with FlameBlocReader<GameCubit, GameState> {
  /// Método que se ejecuta al cargar el componente.
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    anchor = Anchor
        .center; // Define el punto de anclaje en el centro del componente.

    // Carga las capas del fondo parallax desde los archivos de imagen.
    parallax = await game.loadParallax(
      [
        ParallaxImageData('background/layer1-sky.png'), // Capa del cielo.
        ParallaxImageData('background/layer2-clouds.png'), // Capa de nubes.
        ParallaxImageData(
            'background/layer3-clouds.png'), // Capa de nubes adicionales.
        ParallaxImageData('background/layer4-clouds.png'), // Más nubes.
        ParallaxImageData(
            'background/layer5-huge-clouds.png'), // Nubes grandes.
        ParallaxImageData('background/layer6-bushes.png'), // Capa de arbustos.
        ParallaxImageData('background/layer7-bushes.png'), // Más arbustos.
      ],
      baseVelocity: Vector2(1, 0), // Velocidad base de movimiento horizontal.
      velocityMultiplierDelta: Vector2(1.7,
          0), // Incremento de velocidad entre capas para el efecto de profundidad.
    );
  }

  /// Método que actualiza el estado del fondo en cada frame.
  /// - [dt]: Tiempo transcurrido desde el último frame.
  @override
  void update(double dt) {
    // Controla el comportamiento del fondo según el estado actual del juego.
    switch (bloc.state.currentPlayingState) {
      case PlayingState.none:
      case PlayingState.playing:
        super.update(
            dt); // Actualiza el fondo si el juego está en progreso o no ha comenzado.
        break;
      case PlayingState.paused:
      case PlayingState.gameOver:
        // No actualiza el fondo si el juego está pausado o terminado.
        break;
    }
  }
}
