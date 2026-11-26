// Étape « je vois le texte {'…'} » : vérifie qu'un texte exact est affiché une fois.
import 'package:flutter_test/flutter_test.dart';

/// Usage: je vois le texte {'Dernier jet : 10 · Réussite'}
Future<void> jeVoisLeTexte(WidgetTester tester, String texte) async {
  expect(find.text(texte), findsOneWidget);
}
