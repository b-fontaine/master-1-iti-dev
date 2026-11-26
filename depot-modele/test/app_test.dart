// Test de la racine de l'application : les libellés internes de Material sont en français.
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:projet_fil_rouge/features/jets/presentation/jets_page.dart';

import 'helpers/ouvrir_application.dart';

void main() {
  testWidgets('les libellés internes de Material sont en français', (
    tester,
  ) async {
    await ouvrirApplication(tester);
    final contexte = tester.element(find.byType(JetsPage));

    expect(Localizations.localeOf(contexte), const Locale('fr', 'FR'));
    expect(MaterialLocalizations.of(contexte).cancelButtonLabel, 'Annuler');
    expect(MaterialLocalizations.of(contexte).backButtonTooltip, 'Retour');
  });
}
