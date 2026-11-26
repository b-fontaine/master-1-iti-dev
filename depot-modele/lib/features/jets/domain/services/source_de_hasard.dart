// Contrat de la source de hasard : injectée pour que les tests puissent fixer le résultat du dé.

abstract interface class SourceDeHasard {
  /// Renvoie un entier entre [min] et [max], bornes comprises.
  int entre(int min, int max);
}
