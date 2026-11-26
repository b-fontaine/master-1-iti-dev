// Source du « worker » drift du web : il ouvre la base SQLite dans le navigateur.
// Compilé en web/drift_worker.dart.js par :
//   dart compile js -O4 --no-source-maps -o web/drift_worker.dart.js tool/drift_worker.dart
// À recompiler uniquement si la version de drift change dans pubspec.lock.
import 'package:drift/wasm.dart';

void main() => WasmDatabase.workerMainForOpen();
