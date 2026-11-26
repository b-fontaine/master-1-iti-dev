// Base SQLite de l'application (drift) : liste des tables, version du schéma et migrations.
import 'package:drift/drift.dart';

import '../../features/jets/data/table_jets.dart';
import 'connexion.dart';

part 'base_de_donnees.g.dart';

@DriftDatabase(tables: [Jets])
class BaseDeDonnees extends _$BaseDeDonnees {
  /// Ouvre la base persistante de l'application, ou celle fournie (base en mémoire des tests).
  BaseDeDonnees([QueryExecutor? executor])
    : super(executor ?? ouvrirConnexion());

  /// À augmenter de 1 à chaque changement du schéma (voir docs/ARCHITECTURE.md, section 7).
  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) => m.createAll(),
    onUpgrade: (m, from, to) async {
      // Version 1 : première version, aucune étape à jouer.
      // Pour passer en version 2, suivre docs/ARCHITECTURE.md, section 7 :
      // `dart run drift_dev make-migrations` crée base_de_donnees.steps.dart,
      // puis cette fonction est remplacée par les étapes, une par version :
      //
      // onUpgrade: stepByStep(
      //   from1To2: (m, schema) async {
      //     await m.deleteTable('jets');
      //     await m.createTable(schema.fiches);
      //   },
      // ),
    },
    beforeOpen: (details) async {
      // SQLite n'applique les clés étrangères que si on le lui demande, à chaque ouverture.
      await customStatement('PRAGMA foreign_keys = ON');
    },
  );
}
