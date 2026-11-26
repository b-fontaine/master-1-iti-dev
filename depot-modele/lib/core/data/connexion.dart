// Ouverture de la base persistante, sur le web (fichiers de web/) comme sur le bureau.
import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

QueryExecutor ouvrirConnexion() {
  return driftDatabase(
    name: 'projet_fil_rouge',
    web: DriftWebOptions(
      sqlite3Wasm: Uri.parse('sqlite3.wasm'),
      driftWorker: Uri.parse('drift_worker.dart.js'),
    ),
  );
}
