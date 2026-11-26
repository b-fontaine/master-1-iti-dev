// Étape « le dé va donner {n} » : repart d'une base vide en mémoire et fixe le résultat du dé.
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:projet_fil_rouge/core/data/base_de_donnees.dart';
import 'package:projet_fil_rouge/core/di/injection.dart';

import '../helpers/fausses_pieces.dart';

/// Usage: le dé va donner {10}
Future<void> leDeVaDonner(WidgetTester tester, num valeur) async {
  await sl.reset();
  configurerDependances(
    base: BaseDeDonnees(NativeDatabase.memory()),
    hasard: FausseSourceDeHasard(valeur.toInt()),
  );
  addTearDown(sl.reset);
}
