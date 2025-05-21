import 'package:flappy_dash/bloc/game/game_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Define un widget llamado TopScoreWidget que muestra la puntuación actual del juego.
class TopScoreWidget extends StatelessWidget {
  const TopScoreWidget(
      {super.key}); // Constructor del widget, permite asignar una clave opcional.

  @override
  Widget build(BuildContext context) {
    // Construye el widget utilizando el estado del GameCubit.
    return BlocBuilder<GameCubit, GameState>(
      // Escucha los cambios en el estado del GameCubit para actualizar el widget.
      builder: (context, state) {
        return Align(
          // Alinea el contenido en la parte superior central de la pantalla.
          alignment: Alignment.topCenter,
          child: Padding(
            // Agrega un espacio superior de 24 píxeles alrededor del texto.
            padding: const EdgeInsets.only(top: 24.0),
            child: Text(
              state.currentScore
                  .toString(), // Muestra la puntuación actual como texto.
              style: const TextStyle(
                color: Colors.white, // Define el color del texto como blanco.
                fontSize: 38, // Establece el tamaño de la fuente en 38.
              ),
            ),
          ),
        );
      },
    );
  }
}
