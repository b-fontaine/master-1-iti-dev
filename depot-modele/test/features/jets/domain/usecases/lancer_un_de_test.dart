// Test du cas d'usage LancerUnDe : hasard fixé par une fausse pièce, repository simulé par mocktail.
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:projet_fil_rouge/features/jets/domain/entities/jet.dart';
import 'package:projet_fil_rouge/features/jets/domain/usecases/lancer_un_de.dart';

import '../../../../helpers/fausses_pieces.dart';

void main() {
  final instant = DateTime.utc(2026, 12, 2, 9);
  late MockJetsRepository repository;

  setUpAll(() {
    registerFallbackValue(
      Jet(valeur: 1, dd: 1, reussi: true, lanceLe: instant),
    );
  });

  setUp(() {
    repository = MockJetsRepository();
    when(() => repository.enregistrer(any())).thenAnswer(
      (invocation) async => invocation.positionalArguments.single as Jet,
    );
  });

  test('un 12 contre DD 10 est enregistré comme une réussite', () async {
    final lancer = LancerUnDe(
      repository,
      FausseSourceDeHasard(12),
      FausseHorloge(instant),
    );

    final jet = await lancer(dd: 10);

    final attendu = Jet(valeur: 12, dd: 10, reussi: true, lanceLe: instant);
    expect(jet, attendu);
    verify(() => repository.enregistrer(attendu)).called(1);
  });

  test('un 9 contre DD 10 est enregistré comme un échec', () async {
    final lancer = LancerUnDe(
      repository,
      FausseSourceDeHasard(9),
      FausseHorloge(instant),
    );

    final jet = await lancer(dd: 10);

    expect(jet.reussi, isFalse);
  });
}
