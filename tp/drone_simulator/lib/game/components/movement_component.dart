import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import '../entities/rover.dart';

class MovementComponent extends Component with ParentIsA<Rover> {
  final double maxSpeed = 10.0; // Maximum units per second
  final double acceleration = 8.0; // Units per second squared (acceleration rate)
  final double deceleration = 6.0; // Units per second squared (deceleration rate)
  final double turnSpeed = 3.0; // Radians per second for rotation

  Vector2 _targetDirection = Vector2.zero(); // Target direction from input
  double _currentVelocity = 0.0; // Current velocity magnitude
  double _turnDirection = 0.0;

  /// Returns the current actual speed
  double get currentSpeed => _currentVelocity.abs();

  /// Returns the current velocity vector in world space
  Vector2 get currentVelocityVector {
    if (_currentVelocity == 0) return Vector2.zero();
    final body = parent.body;
    final forward = body.worldVector(Vector2(0, -1));
    return forward * _currentVelocity;
  }

  void move(Vector2 direction) {
    _targetDirection = direction;
  }

  void turn(double direction) {
    _turnDirection = direction;
  }

  @override
  void update(double dt) {
    super.update(dt);

    final body = parent.body;

    // Calculate target velocity based on input direction
    final targetVelocity = _targetDirection.y * maxSpeed;

    // Smoothly interpolate current velocity towards target velocity
    if (targetVelocity.abs() > _currentVelocity.abs() ||
        (targetVelocity > 0 && _currentVelocity < 0) ||
        (targetVelocity < 0 && _currentVelocity > 0)) {
      // Accelerating or changing direction
      if (targetVelocity > _currentVelocity) {
        _currentVelocity += acceleration * dt;
        if (_currentVelocity > targetVelocity) _currentVelocity = targetVelocity;
      } else {
        _currentVelocity -= acceleration * dt;
        if (_currentVelocity < targetVelocity) _currentVelocity = targetVelocity;
      }
    } else {
      // Decelerating
      if (_currentVelocity > targetVelocity) {
        _currentVelocity -= deceleration * dt;
        if (_currentVelocity < targetVelocity) _currentVelocity = targetVelocity;
      } else if (_currentVelocity < targetVelocity) {
        _currentVelocity += deceleration * dt;
        if (_currentVelocity > targetVelocity) _currentVelocity = targetVelocity;
      }
    }

    // Apply movement if there's velocity
    if (_currentVelocity.abs() > 0.01) {
      final forward = body.worldVector(Vector2(0, -1));
      final displacement = forward * _currentVelocity * dt;
      final newPosition = body.position + displacement;
      body.setTransform(newPosition, body.angle);
    } else {
      _currentVelocity = 0; // Snap to zero when very small
    }

    // Direct rotation update
    if (_turnDirection != 0) {
      final newAngle = body.angle + _turnDirection * turnSpeed * dt;
      body.setTransform(body.position, newAngle);
    }

    // Reset physics velocities to prevent accumulation
    body.linearVelocity = Vector2.zero();
    body.angularVelocity = 0;
  }
}
