import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'game/simulation_game.dart';
import 'ui/dashboard.dart';
import 'ui/guide_overlay.dart';

void main() {
  runApp(const ProviderScope(child: DroneSimulatorApp()));
}

class DroneSimulatorApp extends StatelessWidget {
  const DroneSimulatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Drone Simulator',
      theme: ThemeData(brightness: Brightness.dark, primarySwatch: Colors.blue),
      home: const SimulationScreen(),
    );
  }
}

class SimulationScreen extends ConsumerWidget {
  const SimulationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Stack(
        children: [
          GameWidget(
            game: SimulationGame(ref),
            overlayBuilderMap: {
              'dashboard': (context, game) => const Dashboard(),
              'guide': (context, game) => const GuideOverlay(),
            },
            initialActiveOverlays: const ['dashboard', 'guide'],
          ),
          // TODO: Add actual UI overlays here
        ],
      ),
    );
  }
}
