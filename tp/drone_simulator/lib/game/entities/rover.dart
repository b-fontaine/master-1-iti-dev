import 'dart:ui';
import 'package:flame/components.dart';
import 'package:flutter/services.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import '../components/movement_component.dart';
import '../components/fuel_component.dart';
import '../components/lidar_component.dart';
import '../components/rover_visual_component.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../state/rover_state.dart';

class Rover extends BodyComponent with KeyboardHandler {
  final WidgetRef ref;

  Rover(this.ref, {Vector2? position}) : super(priority: 1, renderBody: false) {
    // renderBody: false prevents drawing the physics body outline
    initialPosition = position ?? Vector2.zero();
  }

  late Vector2 initialPosition;

  @override
  bool onKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    final movement = firstChild<MovementComponent>();
    if (movement == null) return false;

    // Movement
    final isMovingForward =
        keysPressed.contains(LogicalKeyboardKey.keyW) ||
        keysPressed.contains(LogicalKeyboardKey.keyZ);
    final isMovingBackward = keysPressed.contains(LogicalKeyboardKey.keyS);

    if (isMovingForward && !isMovingBackward) {
      movement.move(Vector2(0, 1)); // 1 means forward in our simple logic
    } else if (isMovingBackward && !isMovingForward) {
      movement.move(Vector2(0, -1)); // -1 means backward
    } else {
      movement.move(Vector2.zero());
    }

    // Turning
    final isTurningLeft =
        keysPressed.contains(LogicalKeyboardKey.keyA) ||
        keysPressed.contains(LogicalKeyboardKey.keyQ);
    final isTurningRight = keysPressed.contains(LogicalKeyboardKey.keyD);

    if (isTurningLeft && !isTurningRight) {
      movement.turn(-1);
    } else if (isTurningRight && !isTurningLeft) {
      movement.turn(1);
    } else {
      movement.turn(0);
    }

    return true;
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (isMounted) {
      final movementComp = firstChild<MovementComponent>();
      final fuelComp = firstChild<FuelComponent>();
      final lidarComp = firstChild<LidarComponent>();

      // Get speed from movement component (direct movement speed)
      final speed = movementComp?.currentSpeed ?? 0.0;

      // Schedule the update for the end of the frame or next event loop
      // to avoid "modifying provider during build" error.
      Future(() {
        if (!isMounted) return;
        ref
            .read(roverProvider.notifier)
            .updateData(
              speed: speed,
              fuel: fuelComp?.fuel ?? 0.0,
              lidarDistances: lidarComp?.lastDistances ?? [],
            );
      });
    }
  }

  @override
  void render(Canvas canvas) {
    // Invoke super render to draw children (SpriteComponent)
    super.render(canvas);

    // Debug: Draw direction if needed, but sprite should handle it.
    // final dirPaint = Paint()..color = const Color(0xFF000000)..strokeWidth = 0.2;
    // canvas.drawLine(Offset.zero, const Offset(0, -2.0), dirPaint);
  }

  @override
  Body createBody() {
    final shape = PolygonShape()..setAsBoxXY(2, 2);
    final fixtureDef = FixtureDef(shape)
      ..density = 1.0
      ..friction = 0.5
      ..restitution = 0.1;

    final bodyDef = BodyDef()
      ..type = BodyType.dynamic
      ..position = initialPosition
      ..linearDamping = 1.0
      ..angularDamping = 1.0;

    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    // Add Visual Component (Handles Sprites, Direction, Animation)
    add(RoverVisualComponent());

    add(MovementComponent());
    add(FuelComponent());
    // LIDAR component added but rendering disabled for now
    add(LidarComponent());
  }
}
