import 'package:flame/game.dart';
import 'package:flappy_dash/bloc/game/game_cubit.dart';
import 'package:flappy_dash/flappy_dash_game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widget/game_over_widget.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() =>
      _MainPageState(); // Crea el estado asociado a este widget.
}

class _MainPageState extends State<MainPage> {
  late FlappyDashGame _flappyDashGame; // Instancia del juego FlappyDashGame.
  late GameCubit
      gameCubit; // Instancia del cubit para manejar el estado del juego.
  PlayingState?
      _latestState; // Variable para almacenar el último estado del juego.

  @override
  void initState() {
    // Método que se ejecuta al inicializar el widget.
    gameCubit = BlocProvider.of<GameCubit>(
        context); // Obtiene el GameCubit del contexto.
    _flappyDashGame =
        FlappyDashGame(gameCubit); // Inicializa el juego con el cubit.
    super.initState(); // Llama al método initState de la clase padre.
  }

  @override
  Widget build(BuildContext context) {
    // Construye la interfaz de usuario.
    return BlocConsumer<GameCubit, GameState>(
      // Escucha y construye la interfaz en función del estado del GameCubit.
      listener: (context, state) {
        // Escucha los cambios en el estado.
        if (state.currentPlayingState == PlayingState.none &&
            _latestState == PlayingState.gameOver) {
          // Si el estado actual es "none" y el último estado fue "gameOver":
          setState(() {
            _flappyDashGame = FlappyDashGame(gameCubit); // Reinicia el juego.
          });
        }

        _latestState = state.currentPlayingState; // Actualiza el último estado.
      },
      builder: (context, state) {
        // Construye la interfaz en función del estado actual.
        return Scaffold(
          body: Stack(
            // Apila widgets uno encima de otro.
            children: [
              GameWidget(game: _flappyDashGame), // Muestra el widget del juego.
              if (state.currentPlayingState == PlayingState.gameOver)
                const GameOverWidget(), // Muestra el widget de "Game Over" si el estado es "gameOver".
              if (state.currentPlayingState == PlayingState.none)
                const Align(
                  // Muestra un texto centrado si el estado es "none".
                  alignment: Alignment(0, 0.2),
                  child: Text(
                    'PRESS TO START', // Texto que indica al usuario que presione para comenzar.
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
