// Tests de l'écran des jets : message de refus à chaque tentative, puis règles d'accessibilité.
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/ouvrir_application.dart';

void main() {
  const messageDeRefus = 'Accès refusé : action réservée au rôle Meneur.';

  testWidgets('le joueur voit le refus à chaque tentative de vider', (
    tester,
  ) async {
    await ouvrirApplication(tester);

    await tester.tap(find.text('Vider l’historique'));
    await tester.pumpAndSettle();
    expect(find.text(messageDeRefus), findsOneWidget);

    // On laisse le message disparaître, puis on recommence.
    await tester.pump(const Duration(seconds: 5));
    await tester.pumpAndSettle();
    expect(find.text(messageDeRefus), findsNothing);

    await tester.tap(find.text('Vider l’historique'));
    await tester.pumpAndSettle();
    expect(find.text(messageDeRefus), findsOneWidget);
  });

  Future<void> verifierLesReglesDAccessibilite(WidgetTester tester) async {
    await expectLater(tester, meetsGuideline(androidTapTargetGuideline));
    await expectLater(tester, meetsGuideline(iOSTapTargetGuideline));
    await expectLater(tester, meetsGuideline(labeledTapTargetGuideline));
    await expectLater(tester, meetsGuideline(textContrastGuideline));
  }

  // testWidgets active déjà l'arbre de sémantique (semanticsEnabled vaut true
  // par défaut dans flutter_test) : pas besoin d'appeler ensureSemantics().
  testWidgets('l’écran des jets respecte les règles d’accessibilité', (
    tester,
  ) async {
    await ouvrirApplication(tester, valeurDuDe: 12);

    await verifierLesReglesDAccessibilite(tester);

    await tester.tap(find.text('Lancer le dé'));
    await tester.pumpAndSettle();
    expect(find.text('Dernier jet : 12 · Réussite'), findsOneWidget);
    await verifierLesReglesDAccessibilite(tester);
  });
}
