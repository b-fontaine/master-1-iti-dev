// Test d'intégrité de la base sur une base SQLite en mémoire : schéma, clés étrangères, contraintes.
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:projet_fil_rouge/core/data/base_de_donnees.dart';

void main() {
  late BaseDeDonnees base;

  setUp(() => base = BaseDeDonnees(NativeDatabase.memory()));
  tearDown(() => base.close());

  test('chaque table déclarée existe dans la base créée', () async {
    final lignes = await base
        .customSelect(
          "SELECT name FROM sqlite_master WHERE type = 'table' "
          "AND name NOT LIKE 'sqlite_%'",
        )
        .get();

    expect(
      lignes.map((l) => l.read<String>('name')),
      unorderedEquals(base.allTables.map((t) => t.actualTableName)),
    );
  });

  test('les clés étrangères sont activées', () async {
    final ligne = await base.customSelect('PRAGMA foreign_keys').getSingle();
    expect(ligne.read<int>('foreign_keys'), 1);
  });

  test('SQLite ne signale aucun défaut d’intégrité', () async {
    final integrite = await base
        .customSelect('PRAGMA integrity_check')
        .getSingle();
    final cles = await base.customSelect('PRAGMA foreign_key_check').get();

    expect(integrite.read<String>('integrity_check'), 'ok');
    expect(cles, isEmpty);
  });

  test('la table jets a les colonnes attendues, en ASCII snake_case', () async {
    final colonnes = await base.customSelect('PRAGMA table_info(jets)').get();

    expect(colonnes.map((c) => c.read<String>('name')), [
      'id',
      'valeur',
      'dd',
      'reussi',
      'lance_le',
    ]);
  });

  test('la base refuse un jet de valeur 0', () async {
    final insertion = base
        .into(base.jets)
        .insert(
          JetsCompanion.insert(
            valeur: 0,
            dd: 10,
            reussi: false,
            lanceLe: DateTime.utc(2026, 12, 2),
          ),
        );

    await expectLater(insertion, throwsA(isA<SqliteException>()));
  });
}
