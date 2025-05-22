import 'package:flappy_dash/audio_helper.dart';
import 'package:flappy_dash/bloc/game/game_cubit.dart';
import 'package:flappy_dash/main_page.dart';
import 'package:flappy_dash/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Función principal que inicia la aplicación
void main() async {
  await setupServiceLocator(); // Configura el localizador de servicios
  runApp(const MyApp()); // Ejecuta la aplicación con el widget MyApp como raíz
}

// Clase principal de la aplicación
class MyApp extends StatelessWidget {
  const MyApp({super.key}); // Constructor de la clase MyApp

  @override
  Widget build(BuildContext context) {
    // Construye el árbol de widgets de la aplicación
    return BlocProvider(
      // Proporciona el GameCubit a los widgets hijos
      create: (BuildContext context) => GameCubit(
        getIt.get<
            AudioHelper>(), // Obtiene la instancia de AudioHelper del localizador de servicios
      ), // Crea una instancia de GameCubit
      child: MaterialApp(
        // Define la configuración principal de la aplicación
        title: 'Flappy Dash', // Título de la
        theme: ThemeData(
            fontFamily: 'Chewy'), // Establece la fuente de la aplicación,
        home: const MainPage(), // Página principal de la aplicación
      ),
    );
  }
}
