import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';

/// Clase que representa un tubo en el juego.
/// Extiende `PositionComponent` para manejar la posición y el tamaño del tubo.
class Pipe extends PositionComponent {
  late Sprite _pipeSprite; // Sprite que representa la imagen del tubo.

  final bool isFlipped; // Indica si el tubo está volteado verticalmente.

  /// Constructor de la clase `Pipe`.
  /// - [isFlipped]: Define si el tubo debe estar volteado.
  /// - [position]: Posición inicial del tubo.
  Pipe({
    required this.isFlipped,
    required super.position,
  }) : super(
            priority: 2); // Prioridad del componente en la capa de renderizado.

  /// Método que se ejecuta al cargar el componente.
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    // Carga el sprite del tubo desde un archivo de imagen.
    _pipeSprite = await Sprite.load('pipe.png');
    anchor =
        Anchor.topCenter; // Define el punto de anclaje en el centro superior.

    // Calcula la relación de aspecto del sprite para mantener proporciones.
    final ratio = _pipeSprite.srcSize.y / _pipeSprite.srcSize.x;
    const width = 82.0; // Ancho fijo del tubo.
    size = Vector2(width, width * ratio); // Calcula el tamaño del tubo.

    // Si el tubo debe estar volteado, lo voltea verticalmente.
    if (isFlipped) {
      flipVertically();
    }

    // Agrega un hitbox rectangular para detectar colisiones.
    add(RectangleHitbox());
  }

  /// Método que renderiza el tubo en el lienzo.
  @override
  void render(Canvas canvas) {
    super.render(canvas);
    // Dibuja el sprite del tubo en el lienzo con el tamaño y posición definidos.
    _pipeSprite.render(
      canvas,
      position: Vector2.zero(), // Posición relativa al componente.
      size: size, // Tamaño del sprite.
    );
  }
}
