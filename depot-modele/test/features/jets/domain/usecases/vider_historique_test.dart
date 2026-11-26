// Test du cas d'usage protégé ViderHistorique : refus pour le joueur, accord pour le meneur.
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:projet_fil_rouge/core/domain/roles/require_role.dart';
import 'package:projet_fil_rouge/core/domain/roles/role.dart';
import 'package:projet_fil_rouge/core/domain/roles/utilisateur_courant.dart';
import 'package:projet_fil_rouge/features/jets/domain/usecases/vider_historique.dart';

import '../../../../helpers/fausses_pieces.dart';

void main() {
  late MockJetsRepository repository;

  setUp(() {
    repository = MockJetsRepository();
    when(() => repository.vider()).thenAnswer((_) async {});
  });

  test('refuse au joueur de vider l’historique, sans rien effacer', () async {
    final vider = ViderHistorique(
      repository,
      UtilisateurCourantSimule(role: Role.joueur),
    );

    await expectLater(vider(), throwsA(isA<AccesRefuse>()));
    verifyNever(() => repository.vider());
  });

  test('permet au meneur de vider l’historique', () async {
    final vider = ViderHistorique(
      repository,
      UtilisateurCourantSimule(role: Role.meneur),
    );

    await vider();

    verify(() => repository.vider()).called(1);
  });
}
