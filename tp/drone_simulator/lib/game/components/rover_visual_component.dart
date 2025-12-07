import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'dart:math';
import '../entities/rover.dart';

enum RoverDirection { n, ne, e, se, s, sw, w, nw }

class RoverVisualComponent extends SpriteAnimationGroupComponent<RoverDirection>
    with ParentIsA<Rover>, HasGameReference<Forge2DGame> {
  // Sprite sheet details
  static const int rows = 8;
  static const int columns = 1; // Vibration frames
  static const double stepTime = 0.1; // Vibration speed

  RoverVisualComponent()
    : super(
        anchor: Anchor.center,
        size: Vector2(8, 8), // Matching the previous size
      );

  @override
  Future<void> onLoad() async {
    final image = await game.images.load('frame_rover_sprite_sheet_2.png');
    final frameWidth = image.width / columns;
    final frameHeight = image.height / rows;
    final frameSize = Vector2(frameWidth, frameHeight);

    // Create animations for each direction
    // Assuming row order: N, NE, E, SE, S, SW, W, NW
    final directions = [
      RoverDirection.n,
      RoverDirection.ne,
      RoverDirection.e,
      RoverDirection.se,
      RoverDirection.s,
      RoverDirection.sw,
      RoverDirection.w,
      RoverDirection.nw,
    ];

    final animations = <RoverDirection, SpriteAnimation>{};

    for (int i = 0; i < directions.length; i++) {
      final y = i * frameHeight;
      final frames = List.generate(columns, (j) {
        return Sprite(
          image,
          srcPosition: Vector2(j * frameWidth, y),
          srcSize: frameSize,
        );
      });

      animations[directions[i]] = SpriteAnimation.spriteList(
        frames,
        stepTime: stepTime,
        loop: true,
      );
    }

    this.animations = animations;
    current = RoverDirection.n;

    // Set a good size for the visual relative to the body
    // The sprite might be non-square (512x128), so we need to adjust rendering size to look square
    // or respect aspect ratio.
    // 512 / 128 = 4.0 aspect ratio.
    // If height is 8 (world units), width would be 32. That's too wide.
    // Let's force it to be square-ish 8x8 for now, effectively squashing it if the sprite is wide.
    // Or maybe the generator made square frames?
    // 1024x1024 image. 2 cols = 512 width. 8 rows = 128 height.
    // If the actual drawing is in the center, we might need to conform or clip.
    // For now, let's just map it to 8x8 and see how it looks.
    size = Vector2(8, 8);
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (parent.body.bodyType == BodyType.dynamic) {
      // 1. Counter-rotate to stay upright relative to screen
      angle = -parent.body.angle;

      // 2. Determine direction based on body angle
      // Angle is in radians, 0 is East. Positive is clockwise.
      double heading = parent.body.angle;

      // Normalize angle to 0..2PI
      final normalizedAngle = (heading % (2 * pi));
      final positiveAngle = normalizedAngle < 0
          ? normalizedAngle + 2 * pi
          : normalizedAngle;

      // 0 radians (East) is sector 0.
      // 8 slices. Slice size PI/4.
      // Shift by PI/8 so 0 is in the middle of East sector.
      final sector = ((positiveAngle + pi / 8) / (pi / 4)).floor() % 8;

      switch (sector) {
        case 0:
          current = RoverDirection.n;
          break;
        case 1:
          current = RoverDirection.ne;
          break;
        case 2:
          current = RoverDirection.e;
          break;
        case 3:
          current = RoverDirection.se;
          break;
        case 4:
          current = RoverDirection.s;
          break;
        case 5:
          current = RoverDirection.sw;
          break;
        case 6:
          current = RoverDirection.w;
          break;
        case 7:
          current = RoverDirection.nw;
          break;
      }
    }
  }
}
