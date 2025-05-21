import 'package:flappy_dash/bloc/game/game_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TapToPlayWidget extends StatelessWidget {
  const TapToPlayWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameCubit, GameState>(
      builder: (context, state) {
        return Align(
          // Muestra un texto centrado si el estado es "none".
          alignment: const Alignment(0, 0.2),
          child: IgnorePointer(
            // Ignora los toques en este widget.
            child: const Text(
              'TAP TO PLAY', // Texto que indica al usuario que presione para comenzar.
              style: TextStyle(
                  color: Color(0xFF2387FC),
                  fontWeight: FontWeight.bold,
                  fontSize: 38,
                  letterSpacing: 4),
            )
                .animate(
                  onPlay: (controller) => controller.repeat(
                      reverse: true), // Anima el texto para que parpadee.
                )
                .scale(
                  // Aplica un efecto de escalado al texto.
                  begin: const Offset(1.0, 1.0), // Escala inicial del texto.
                  end: const Offset(1.2, 1.2), // Escala final del texto.
                  duration: const Duration(
                      milliseconds: 500), // Duración de la animación.
                ),
          ),
        );
      },
    );
  }
}
