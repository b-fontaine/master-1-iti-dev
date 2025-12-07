import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flame/events.dart';

import 'entities/rover.dart';
import 'components/movement_component.dart';
import 'components/scrolling_background.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class SimulationGame extends Forge2DGame
    with PanDetector, HasKeyboardHandlerComponents {
  final WidgetRef ref;
  late Rover rover;
  late ScrollingBackground scrollingBackground;

  SimulationGame(this.ref) : super(gravity: Vector2.zero(), zoom: 10);

  @override
  void onPanUpdate(DragUpdateInfo info) {
    // If the user drags, we stop following the rover so they can pan freely.
    camera.stop();
    camera.viewfinder.position -= info.delta.global / camera.viewfinder.zoom;
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();
    // Disable debug mode to show sprites properly
    debugMode = false;

    final boundaryParams = createBoundaries(this);
    boundaryParams.forEach(world.add);

    // Create scrolling background that moves based on rover velocity
    scrollingBackground = ScrollingBackground();
    camera.backdrop.add(scrollingBackground);

    rover = Rover(ref, position: Vector2.zero());
    await world.add(rover);

    // Follow the rover (after it's fully loaded and body is initialized)
    camera.follow(rover);
  }

  @override
  void update(double dt) {
    super.update(dt);

    // Update background scroll based on rover's velocity
    if (rover.isMounted) {
      final movementComp = rover.firstChild<MovementComponent>();
      if (movementComp != null) {
        scrollingBackground.updateVelocity(movementComp.currentVelocityVector);
      }
    }
  }

  List<BodyComponent> createBoundaries(Forge2DGame game) {
    final topLeft = Vector2(-20, -20);
    final bottomRight = Vector2(20, 20);
    final topRight = Vector2(20, -20);
    final bottomLeft = Vector2(-20, 20);

    final top = Wall(topLeft, topRight);
    final right = Wall(topRight, bottomRight);
    final bottom = Wall(bottomRight, bottomLeft);
    final left = Wall(bottomLeft, topLeft);

    return [top, right, bottom, left];
  }
}

class Wall extends BodyComponent {
  final Vector2 start;
  final Vector2 end;

  Wall(this.start, this.end) : super(renderBody: false);

  @override
  Body createBody() {
    final shape = EdgeShape()..set(start, end);
    final fixtureDef = FixtureDef(shape)..friction = 0.3;
    final bodyDef = BodyDef()..position = Vector2.zero();

    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }
}
