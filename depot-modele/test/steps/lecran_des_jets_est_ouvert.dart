// Étape « l'écran des jets est ouvert » : affiche l'application et attend la fin du chargement.
import 'package:flutter_test/flutter_test.dart';
import 'package:projet_fil_rouge/app.dart';

/// Usage: l'écran des jets est ouvert
Future<void> lecranDesJetsEstOuvert(WidgetTester tester) async {
  await tester.pumpWidget(const App());
  await tester.pumpAndSettle();
}
