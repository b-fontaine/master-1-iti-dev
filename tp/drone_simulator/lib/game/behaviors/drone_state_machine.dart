enum DroneState { idle, patrol, alert, returnToBase }

class DroneStateMachine {
  DroneState _currentState = DroneState.idle;

  void update(double dt, dynamic sensors) {
    // Simple state transition logic
    switch (_currentState) {
      case DroneState.idle:
        // Transition to Patrol if battery > 50%
        _currentState = DroneState.patrol;
        break;
      case DroneState.patrol:
        // If obstacle detected -> Alert
        // If battery < 20% -> ReturnToBase
        break;
      case DroneState.alert:
        // Stop and wait or turn
        break;
      case DroneState.returnToBase:
        // Move towards 0,0
        break;
    }
  }
}
