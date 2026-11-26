// Point d'entrée : configure l'injection de dépendances, puis lance l'interface.
import 'package:material_ui/material_ui.dart';

import 'app.dart';
import 'core/di/injection.dart';

void main() {
  configurerDependances();
  runApp(const App());
}
