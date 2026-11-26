// Ouvre l'application complète sur une base en mémoire, avec un dé truqué, pour les tests d'écran.
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:projet_fil_rouge/app.dart';
import 'package:projet_fil_rouge/core/data/base_de_donnees.dart';
import 'package:projet_fil_rouge/core/di/injection.dart';

import 'fausses_pieces.dart';

Future<void> ouvrirApplication(
  WidgetTester tester, {
  int valeurDuDe = 10,
}) async {
  await sl.reset();
  configurerDependances(
    base: BaseDeDonnees(NativeDatabase.memory()),
    hasard: FausseSourceDeHasard(valeurDuDe),
  );
  addTearDown(sl.reset);
  await tester.pumpWidget(const App());
  await tester.pumpAndSettle();
}
