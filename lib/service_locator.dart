import 'package:flappy_dash/audio_helper.dart'; // Importa la clase AudioHelper desde el paquete flappy_dash, que probablemente contiene funcionalidades relacionadas con el manejo de audio.
import 'package:get_it/get_it.dart'; // Importa la biblioteca GetIt, que es un contenedor de inyección de dependencias para gestionar servicios y objetos compartidos.

final getIt = GetIt
    .instance; // Crea una instancia singleton de GetIt, que se usará para registrar y acceder a servicios en toda la aplicación.

Future<void> setupServiceLocator() async {
  // Define una función asíncrona que configura el servicio de localización de dependencias.
  getIt.registerLazySingleton<AudioHelper>(() =>
      AudioHelper()); // Registra AudioHelper como un singleton perezoso, lo que significa que se creará solo cuando se necesite por primera vez.
}
