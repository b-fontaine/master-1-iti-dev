import 'dart:ui';
import 'package:flame/components.dart';

/// A scrolling background component that creates an infinite tiling effect
/// based on the rover's velocity, giving the impression of movement.
class ScrollingBackground extends PositionComponent with HasGameReference {
  late Sprite _backgroundSprite;
  Vector2 _offset = Vector2.zero();
  Vector2 _velocity = Vector2.zero();

  // Scroll speed multiplier to make the background movement more visible
  final double scrollMultiplier = 15.0;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    _backgroundSprite = await game.loadSprite('mars_surface.png');
    // Set priority to render behind everything
    priority = -10;
  }

  /// Update the velocity used for scrolling the background
  void updateVelocity(Vector2 velocity) {
    _velocity = velocity;
  }

  @override
  void update(double dt) {
    super.update(dt);

    // Update offset based on velocity (inverted to create parallax effect)
    // When rover moves forward, background should scroll backward
    _offset += _velocity * scrollMultiplier * dt;

    // Get the sprite's original size for proper tiling
    if (_backgroundSprite.image.width > 0) {
      final spriteWidth = _backgroundSprite.image.width.toDouble();
      final spriteHeight = _backgroundSprite.image.height.toDouble();

      // Wrap offset to prevent floating point overflow
      _offset.x = _offset.x % spriteWidth;
      _offset.y = _offset.y % spriteHeight;
    }
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    final screenSize = game.size;
    final spriteWidth = _backgroundSprite.image.width.toDouble();
    final spriteHeight = _backgroundSprite.image.height.toDouble();

    if (spriteWidth <= 0 || spriteHeight <= 0) return;

    // Calculate how many tiles we need to cover the screen plus buffer
    final tilesX = (screenSize.x / spriteWidth).ceil() + 2;
    final tilesY = (screenSize.y / spriteHeight).ceil() + 2;

    // Calculate starting position for tiling
    final startX = -spriteWidth + (_offset.x % spriteWidth);
    final startY = -spriteHeight + (_offset.y % spriteHeight);

    // Draw tiled background
    for (int x = 0; x < tilesX; x++) {
      for (int y = 0; y < tilesY; y++) {
        _backgroundSprite.render(
          canvas,
          position: Vector2(startX + x * spriteWidth, startY + y * spriteHeight),
          size: Vector2(spriteWidth, spriteHeight),
        );
      }
    }
  }
}
