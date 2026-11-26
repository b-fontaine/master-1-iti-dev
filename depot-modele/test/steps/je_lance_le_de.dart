// Étape « je lance le dé » : appuie sur le bouton et attend la mise à jour de l'écran.
import 'package:flutter_test/flutter_test.dart';

/// Usage: je lance le dé
Future<void> jeLanceLeDe(WidgetTester tester) async {
  await tester.tap(find.text('Lancer le dé'));
  await tester.pumpAndSettle();
}
