// Test de la vraie source de hasard : avec une graine fixe, les tirages restent dans les bornes.
import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:projet_fil_rouge/features/jets/data/source_de_hasard_aleatoire.dart';

void main() {
  test('1 000 tirages d’un d20 restent entre 1 et 20 et atteignent les deux bornes', () {
    final hasard = SourceDeHasardAleatoire(Random(42));

    final tirages = [for (var i = 0; i < 1000; i++) hasard.entre(1, 20)];

    expect(tirages, everyElement(inInclusiveRange(1, 20)));
    expect(tirages, containsAll([1, 20]));
  });
}
