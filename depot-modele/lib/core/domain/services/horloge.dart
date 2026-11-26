// Contrat de l'horloge, commun à toutes les fonctionnalités : injecté pour que les tests fixent l'heure.

abstract interface class Horloge {
  /// L'instant présent, en UTC.
  DateTime maintenant();
}
