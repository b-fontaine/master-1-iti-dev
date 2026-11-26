// Test du repository drift sur une base en mémoire : enregistrer, relire, vider.
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:projet_fil_rouge/core/data/base_de_donnees.dart';
import 'package:projet_fil_rouge/features/jets/data/jets_repository_drift.dart';
import 'package:projet_fil_rouge/features/jets/domain/entities/jet.dart';

void main() {
  late BaseDeDonnees base;
  late JetsRepositoryDrift repository;
  final instant = DateTime.utc(2026, 12, 2, 9);

  setUp(() {
    base = BaseDeDonnees(NativeDatabase.memory());
    repository = JetsRepositoryDrift(base);
  });
  tearDown(() => base.close());

  test('relit les jets enregistrés, du plus récent au plus ancien', () async {
    await repository.enregistrer(
      Jet(valeur: 4, dd: 10, reussi: false, lanceLe: instant),
    );
    await repository.enregistrer(
      Jet(valeur: 15, dd: 10, reussi: true, lanceLe: instant),
    );

    final historique = await repository.historique();

    expect(historique, [
      Jet(id: 2, valeur: 15, dd: 10, reussi: true, lanceLe: instant),
      Jet(id: 1, valeur: 4, dd: 10, reussi: false, lanceLe: instant),
    ]);
  });

  test('vider supprime tous les jets', () async {
    await repository.enregistrer(
      Jet(valeur: 4, dd: 10, reussi: false, lanceLe: instant),
    );

    await repository.vider();

    expect(await repository.historique(), isEmpty);
  });
}
