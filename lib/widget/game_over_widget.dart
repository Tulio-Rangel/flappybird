import 'dart:ui';

import 'package:flappy_dash/bloc/game/game_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Widget que representa la pantalla de "Game Over".
/// Se muestra cuando el juego termina y permite reiniciarlo.
class GameOverWidget extends StatelessWidget {
  const GameOverWidget({super.key});

  /// Construye el widget de la pantalla de "Game Over".
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameCubit, GameState>(
      builder: (context, state) {
        return BackdropFilter(
            filter: ImageFilter.blur(
                sigmaX: 5, sigmaY: 5), // Aplica un desenfoque al fondo.
            child: Container(
              color: Colors.black54, // Fondo semitransparente negro.
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize
                      .min, // Ajusta el tamaño de la columna al contenido.
                  children: [
                    // Texto principal que indica "GAME OVER!".
                    const Text(
                      'GAME OVER!',
                      style: TextStyle(
                        color: Color(0xFFFFCA00), // Texto en color amarillo.
                        fontWeight: FontWeight.bold, // Texto en negrita.
                        fontSize: 48, // Tamaño de fuente grande.
                      ),
                    ),
                    const SizedBox(
                        height: 18), // Espaciado entre el texto y el botón.
                    Text('Score: ${state.currentScore}',
                        style: const TextStyle(
                          color: Colors.white, // Texto en color blanco.
                          fontWeight: FontWeight.bold, // Texto en negrita.
                          fontSize: 22,
                        )), // Tamaño de fuente),
                    const SizedBox(
                      height: 24,
                    ),
                    // Botón que permite reiniciar el juego.
                    ElevatedButton(
                      onPressed: () => context.read<GameCubit>().restartGame(),
                      // Llama al método `restartGame` del `GameCubit` para reiniciar el juego.
                      child: const Padding(
                        // Padding para el botón.
                        padding: EdgeInsets.all(8.0),
                        child: Text('PLAY AGAIN!',
                            style: TextStyle(
                              fontWeight: FontWeight.bold, // Texto en negrita.
                              fontSize: 22,
                            )),
                      ), // Texto del botón.
                    ),
                  ],
                ),
              ),
            ));
      },
    );
  }
}
