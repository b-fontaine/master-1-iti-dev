// Vraie source de hasard de l'application ; les tests la remplacent par une fausse.
import 'dart:math';

import '../domain/services/source_de_hasard.dart';

class SourceDeHasardAleatoire implements SourceDeHasard {
  SourceDeHasardAleatoire([Random? random]) : _random = random ?? Random();

  final Random _random;

  @override
  int entre(int min, int max) => min + _random.nextInt(max - min + 1);
}
