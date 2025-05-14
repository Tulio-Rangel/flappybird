import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flappy_dash/bloc/game/game_cubit.dart';
import 'package:flappy_dash/component/hidden_coin.dart';
import 'package:flappy_dash/component/pipe.dart';
import 'package:flappy_dash/flappy_dash_game.dart';

/// Clase que representa al personaje principal "Dash" en el juego.
/// Extiende `PositionComponent` para manejar su posición, tamaño y renderizado.
/// Implementa colisiones y lectura del estado del juego mediante `FlameBlocReader`.
class Dash extends PositionComponent
    with
        CollisionCallbacks, // Manejo de colisiones.
        HasGameRef<FlappyDashGame>, // Referencia al juego principal.
        FlameBlocReader<GameCubit, GameState> {
  // Acceso al estado del juego.

  /// Constructor de la clase `Dash`.
  Dash()
      : super(
          position: Vector2(0, 0), // Posición inicial de Dash.
          size: Vector2.all(80.0), // Tamaño de Dash (80x80 píxeles).
          anchor: Anchor.center, // Punto de anclaje en el centro.
          priority: 10, // Prioridad de renderizado.
        );

  late Sprite _dashSprite; // Sprite que representa la imagen de Dash.

  final Vector2 _gravity =
      Vector2(0, 1400.0); // Fuerza de gravedad que afecta a Dash.
  Vector2 _velocity = Vector2(0, 0); // Velocidad actual de Dash.
  final Vector2 _jumpForce = Vector2(0, -500); // Fuerza aplicada al saltar.

  /// Método que se ejecuta al cargar el componente.
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    // Carga el sprite de Dash desde un archivo de imagen.
    _dashSprite = await Sprite.load('dash.png');
    final radius = size.x / 2; // Radio del hitbox circular.
    final center = size / 2; // Centro del componente.
    // Agrega un hitbox circular para detectar colisiones.
    add(CircleHitbox(
      radius: radius * 0.75, // Tamaño del hitbox.
      position: center * 1.1, // Posición relativa del hitbox.
      anchor: Anchor.center, // Punto de anclaje del hitbox.
    ));
  }

  /// Método que actualiza el estado de Dash en cada frame.
  /// - [dt]: Tiempo transcurrido desde el último frame.
  @override
  void update(double dt) {
    super.update(dt);
    // Si el juego no está en estado "playing", no actualiza la posición.
    if (bloc.state.currentPlayingState != PlayingState.playing) {
      return;
    }
    // Aplica la gravedad a la velocidad.
    _velocity += _gravity * dt;
    // Actualiza la posición de Dash según la velocidad.
    position += _velocity * dt;
  }

  /// Método que permite a Dash saltar.
  void jump() {
    // Solo salta si el juego está en estado "playing".
    if (bloc.state.currentPlayingState != PlayingState.playing) {
      return;
    }
    _velocity = _jumpForce; // Aplica la fuerza de salto.
  }

  /// Método que renderiza a Dash en el lienzo.
  @override
  void render(Canvas canvas) {
    super.render(canvas);
    // Dibuja el sprite de Dash con el tamaño definido.
    _dashSprite.render(
      canvas,
      size: size,
    );
  }

  /// Método que maneja las colisiones de Dash con otros componentes.
  /// - [points]: Puntos de colisión.
  /// - [other]: Componente con el que colisionó.
  @override
  void onCollision(Set<Vector2> points, PositionComponent other) {
    super.onCollision(points, other);
    // Si el juego no está en estado "playing", no procesa colisiones.
    if (bloc.state.currentPlayingState != PlayingState.playing) {
      return;
    }
    // Si colisiona con una moneda oculta, aumenta la puntuación y elimina la moneda.
    if (other is HiddenCoin) {
      bloc.increaseScore();
      other.removeFromParent();
    }
    // Si colisiona con un tubo, termina el juego.
    else if (other is Pipe) {
      bloc.gameOver();
    }
  }
}
