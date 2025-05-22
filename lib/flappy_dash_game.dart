import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flappy_dash/audio_helper.dart';
import 'package:flappy_dash/bloc/game/game_cubit.dart';
import 'package:flappy_dash/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'component/flappy_dash_root_component.dart';

/// Clase principal del juego FlappyDash, que extiende `FlameGame`
/// y configura el mundo y la cámara del juego.
class FlappyDashGame extends FlameGame<FlappyDashWorld>
    with KeyboardEvents, HasCollisionDetection {
  /// Constructor que inicializa el juego con un `GameCubit` para manejar el estado.
  FlappyDashGame(this.gameCubit)
      : super(
            world: FlappyDashWorld(), // Define el mundo del juego.
            camera: CameraComponent.withFixedResolution(
                width: 600, // Ancho fijo de la cámara.
                height: 1000 // Alto fijo de la cámara.
                )
            //..viewfinder.zoom = _calculateZoom(), // Calcula el zoom inicial.
            );

  final GameCubit gameCubit; // Cubit para manejar el estado del juego.

  /// Maneja eventos de teclado, como presionar la barra espaciadora.
  @override
  KeyEventResult onKeyEvent(
    KeyEvent event,
    Set<LogicalKeyboardKey> keysPressed,
  ) {
    final isKeyDown =
        event is KeyDownEvent; // Verifica si la tecla fue presionada.
    final isSpace = keysPressed
        .contains(LogicalKeyboardKey.space); // Verifica si la tecla es espacio.

    if (isSpace && isKeyDown) {
      world.onSpaceDown(); // Llama a la acción correspondiente en el mundo.
      return KeyEventResult.handled; // Indica que el evento fue manejado.
    }
    return KeyEventResult.ignored; // Ignora otros eventos.
  }

  /// Calcula el factor de zoom para mantener las proporciones originales.
  // static double _calculateZoom() {
  //   final screenWidth = window.physicalSize.width / window.devicePixelRatio;
  //   final screenHeight = window.physicalSize.height / window.devicePixelRatio;

  //   // Calcula el factor de escala basado en la resolución original.
  //   final scaleX = screenWidth / 600;
  //   final scaleY = screenHeight / 1000;

  //   // Devuelve el menor factor de escala para evitar distorsión.
  //   return scaleX < scaleY ? scaleX : scaleY;
  // }
}

/// Clase que representa el mundo del juego FlappyDash.
/// Contiene los componentes principales y maneja eventos de entrada.
class FlappyDashWorld extends World
    with TapCallbacks, HasGameRef<FlappyDashGame> {
  late FlappyDashRootComponent _rootComponent; // Componente raíz del mundo.

  /// Método que se ejecuta al cargar el mundo.
  @override
  Future<void> onLoad() async {
    super.onLoad();
    await getIt
        .get<AudioHelper>()
        .initialize(); // Inicializa el helper de audio.
    add(
      FlameBlocProvider<GameCubit, GameState>(
        create: () => game.gameCubit, // Proporciona el cubit del juego.
        children: [
          _rootComponent =
              FlappyDashRootComponent(), // Agrega el componente raíz.
        ],
      ),
    );
  }

  /// Método que se llama cuando se presiona la barra espaciadora.
  void onSpaceDown() => _rootComponent.onSpaceDown();

  /// Maneja eventos de toque en la pantalla.
  @override
  void onTapDown(TapDownEvent event) {
    super.onTapDown(event); // Llama al comportamiento base.
    _rootComponent.onTapDown(event); // Propaga el evento al componente raíz.
  }
}
