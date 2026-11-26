// Tests de la garde RequireRole, dont le test de refus exigé pour chaque action protégée.
import 'package:flutter_test/flutter_test.dart';
import 'package:projet_fil_rouge/core/domain/roles/require_role.dart';
import 'package:projet_fil_rouge/core/domain/roles/role.dart';
import 'package:projet_fil_rouge/core/domain/roles/utilisateur_courant.dart';

void main() {
  const reserveAuMeneur = RequireRole({Role.meneur});

  test('refuse l’accès à un joueur', () {
    final joueur = UtilisateurCourantSimule(role: Role.joueur);

    expect(reserveAuMeneur.autorise(joueur), isFalse);
    expect(
      () => reserveAuMeneur.verifier(joueur),
      throwsA(
        isA<AccesRefuse>().having((e) => e.role, 'rôle refusé', Role.joueur),
      ),
    );
  });

  test('autorise l’accès au meneur', () {
    final meneur = UtilisateurCourantSimule(role: Role.meneur);

    expect(reserveAuMeneur.autorise(meneur), isTrue);
    expect(() => reserveAuMeneur.verifier(meneur), returnsNormally);
  });
}
