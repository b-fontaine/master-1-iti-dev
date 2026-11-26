// Entité métier : un jet de dé enregistré, indépendant de l'écran et de la base.
import 'package:equatable/equatable.dart';

class Jet extends Equatable {
  const Jet({
    this.id,
    required this.valeur,
    required this.dd,
    required this.reussi,
    required this.lanceLe,
  });

  /// Identifiant attribué par la base ; nul tant que le jet n'est pas enregistré.
  final int? id;

  /// Valeur obtenue sur le dé.
  final int valeur;

  /// Degré de difficulté à atteindre.
  final int dd;

  /// Résultat de la règle `estReussite`.
  final bool reussi;

  /// Instant du jet, en UTC.
  final DateTime lanceLe;

  @override
  List<Object?> get props => [id, valeur, dd, reussi, lanceLe];
}
