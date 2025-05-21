import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

/// Clase que representa una moneda oculta en el juego.
/// Extiende `PositionComponent` para manejar su posición y tamaño.
class HiddenCoin extends PositionComponent {
  /// Constructor de la clase `HiddenCoin`.
  /// - [position]: Posición inicial de la moneda.
  HiddenCoin({
    required super.position,
  }) : super(
          size: Vector2(60, 60), // Tamaño de la moneda (24x24 píxeles).
          anchor:
              Anchor.center, // Punto de anclaje en el centro del componente.
        );

  /// Método que se ejecuta al cargar el componente.
  @override
  void onLoad() {
    super.onLoad();
    // Agrega un hitbox circular para detectar colisiones.
    debugMode = true; // Activa el modo de depuración para ver el hitbox.
    add(CircleHitbox(
      collisionType: CollisionType.passive,
      // Define el tipo de colisión como pasiva (no afecta a otros objetos).
    ));
  }
}
