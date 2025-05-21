import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flappy_dash/bloc/game/game_cubit.dart';
import 'package:flappy_dash/flappy_dash_game.dart';

import 'dash.dart';
import 'dash_parallax_background.dart';
import 'pipe_pair.dart';

class FlappyDashRootComponent extends Component
    with HasGameRef<FlappyDashGame>, FlameBlocReader<GameCubit, GameState> {
  // Declaración de variables privadas para el personaje principal (_dash) y el último par de tubos (_lastPipe).
  late Dash _dash;
  late PipePair _lastPipe;
  static const _pipesDistance =
      400.0; // Distancia constante entre los pares de tubos.

  @override
  Future<void> onLoad() async {
    // Método que se ejecuta al cargar el componente.
    await super.onLoad();
    add(DashParallaxBackground()); // Agrega el fondo parallax al juego.
    add(_dash = Dash()); // Agrega el personaje principal (Dash) al juego.
    _generatePipes(
      fromX: 350, // Genera los primeros tubos a partir de la posición X = 350.
    );
  }

  void _generatePipes({
    int count = 5, // Número de pares de tubos a generar.
    double fromX = 0.0, // Posición inicial en el eje X para generar los tubos.
  }) {
    // Genera una cantidad específica de pares de tubos con posiciones aleatorias en el eje Y.
    for (int i = 0; i < count; i++) {
      const area = 600; // Rango de altura para los tubos.
      final y = (Random().nextDouble() * area) -
          (area / 2); // Calcula una posición aleatoria en Y.
      add(_lastPipe = PipePair(
        position:
            Vector2(fromX + (i * _pipesDistance), y), // Posición del tubo.
      ));
    }
  }

  void _removeLastPipes() {
    // Elimina los tubos más antiguos para mantener un máximo de 5 pares en pantalla.
    final pipes =
        children.whereType<PipePair>(); // Obtiene todos los pares de tubos.
    final shouldBeRemoved =
        max(pipes.length - 5, 0); // Calcula cuántos tubos deben eliminarse.
    pipes.take(shouldBeRemoved).forEach((pipe) {
      pipe.removeFromParent(); // Elimina cada tubo de su padre (el juego).
    });
  }

  void onSpaceDown() {
    // Método que se ejecuta cuando el jugador presiona la barra espaciadora.
    _checkToStart(); // Verifica si el juego debe comenzar.
    _dash.jump(); // Hace que el personaje principal salte.
  }

  void onTapDown(TapDownEvent event) {
    // Método que se ejecuta cuando el jugador toca la pantalla.
    _checkToStart(); // Verifica si el juego debe comenzar.
    _dash.jump(); // Hace que el personaje principal salte.
  }

  void _checkToStart() {
    // Verifica si el estado actual del juego es "no iniciado" y lo inicia si es necesario.
    if (bloc.state.currentPlayingState.isNone) {
      bloc.startPlaying(); // Cambia el estado del juego a "jugando".
    }
  }

  @override
  void update(double dt) {
    // Método que se ejecuta en cada frame del juego.
    super.update(dt);

    // Verifica si Dash está fuera de los límites verticales
    if (_dash.y < -1000 || _dash.y > 1000) bloc.gameOver();

    if (_dash.x >= _lastPipe.x) {
      // Si el personaje principal ha pasado el último tubo, genera más tubos.
      _generatePipes(
        fromX:
            _pipesDistance, // Genera nuevos tubos a partir de una distancia fija.
      );
      _removeLastPipes(); // Elimina los tubos más antiguos.
    }
    game.camera.viewfinder.zoom = 1.0; // Ajusta el zoom de la cámara.
  }
}
