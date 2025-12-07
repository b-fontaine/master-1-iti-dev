import 'dart:math';
import 'dart:ui';
import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import '../entities/rover.dart';

class LidarComponent extends Component with ParentIsA<Rover> {
  final int numRays = 16;
  final double reach = 10.0;
  final List<RaycastResult?> results = [];
  final Paint _rayPaint = Paint()
    ..color = const Color(0xFFFF0000)
    ..strokeWidth = 0.1;

  List<double> get lastDistances {
    return results
        .where((r) => r != null)
        .map((r) => r!.fraction * reach)
        .toList();
  }

  @override
  void update(double dt) {
    super.update(dt);
    results.clear();
    final body = parent.body;
    final center = body.position;
    final angle = body.angle;

    for (int i = 0; i < numRays; i++) {
      final rayAngle = angle + (i / numRays) * 2 * pi;
      final direction = Vector2(cos(rayAngle), sin(rayAngle));
      final end = center + direction * reach;

      final callback = _LidarRayCastCallback(body);

      parent.game.world.raycast(callback, center, end);

      if (callback.closestResult != null) {
        results.add(callback.closestResult);
      } else {
        results.add(null);
      }
    }
  }

  @override
  void render(Canvas canvas) {
    // LIDAR ray visualization temporarily disabled
    // To re-enable, uncomment the code below:
    // final body = parent.body;
    // final center = body.position;
    // for (final result in results) {
    //   if (result != null) {
    //     canvas.drawLine(center.toOffset(), result.point.toOffset(), _rayPaint);
    //   }
    // }
  }
}

class RaycastResult {
  final Vector2 point;
  final Vector2 normal;
  final double fraction;

  RaycastResult({
    required this.point,
    required this.normal,
    required this.fraction,
  });
}

class _LidarRayCastCallback extends RayCastCallback {
  final Body originBody;
  RaycastResult? closestResult;

  _LidarRayCastCallback(this.originBody);

  @override
  double reportFixture(
    Fixture fixture,
    Vector2 point,
    Vector2 normal,
    double fraction,
  ) {
    if (fixture.body == originBody) return -1.0;

    closestResult = RaycastResult(
      point: point.clone(),
      normal: normal.clone(),
      fraction: fraction,
    );
    return fraction;
  }
}
