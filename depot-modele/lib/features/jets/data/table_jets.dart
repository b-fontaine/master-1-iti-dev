// Définition drift de la table `jets` : noms de table et de colonnes en ASCII snake_case.
// Une contrainte CHECK cite sa propre colonne : c'est l'écriture prévue par drift.
// ignore_for_file: recursive_getters
import 'package:drift/drift.dart';

/// Une ligne de la table `jets` (nom distinct de l'entité `Jet` du domaine).
@DataClassName('JetLigne')
class Jets extends Table {
  @override
  String get tableName => 'jets';

  IntColumn get id => integer().autoIncrement()();

  /// Valeur du dé, colonne `valeur`, au moins 1.
  IntColumn get valeur => integer().check(valeur.isBiggerOrEqualValue(1))();

  /// Degré de difficulté, colonne `dd`, au moins 1.
  IntColumn get dd => integer().check(dd.isBiggerOrEqualValue(1))();

  /// Résultat de la règle, colonne `reussi`.
  BoolColumn get reussi => boolean()();

  /// Instant du jet, colonne `lance_le`, stocké en UTC.
  DateTimeColumn get lanceLe => dateTime()();
}
