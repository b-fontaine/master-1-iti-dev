// Tests du JetsCubit avec blocTest : pour chaque action, la suite d'états attendue.
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:projet_fil_rouge/core/domain/roles/role.dart';
import 'package:projet_fil_rouge/core/domain/roles/utilisateur_courant.dart';
import 'package:projet_fil_rouge/features/jets/domain/entities/jet.dart';
import 'package:projet_fil_rouge/features/jets/domain/usecases/lancer_un_de.dart';
import 'package:projet_fil_rouge/features/jets/domain/usecases/lire_historique.dart';
import 'package:projet_fil_rouge/features/jets/domain/usecases/vider_historique.dart';
import 'package:projet_fil_rouge/features/jets/presentation/jets_cubit.dart';
import 'package:projet_fil_rouge/features/jets/presentation/jets_state.dart';

import '../../../helpers/fausses_pieces.dart';

void main() {
  final instant = DateTime.utc(2026, 12, 2, 9);
  final jetReussi = Jet(
    id: 1,
    valeur: 14,
    dd: 10,
    reussi: true,
    lanceLe: instant,
  );
  late MockJetsRepository repository;

  setUpAll(() => registerFallbackValue(jetReussi));

  setUp(() {
    repository = MockJetsRepository();
    when(() => repository.historique()).thenAnswer((_) async => [jetReussi]);
    when(() => repository.enregistrer(any()))
        .thenAnswer((_) async => jetReussi);
    when(() => repository.vider()).thenAnswer((_) async {});
  });

  JetsCubit construire(Role role) => JetsCubit(
    lancerUnDe: LancerUnDe(
      repository,
      FausseSourceDeHasard(14),
      FausseHorloge(instant),
    ),
    lireHistorique: LireHistorique(repository),
    viderHistorique: ViderHistorique(
      repository,
      UtilisateurCourantSimule(role: role),
    ),
  );

  blocTest<JetsCubit, JetsState>(
    'charger affiche le chargement, puis l’historique',
    build: () => construire(Role.joueur),
    act: (cubit) => cubit.charger(),
    expect: () => [
      const JetsChargement(),
      JetsPret(historique: [jetReussi]),
    ],
  );

  blocTest<JetsCubit, JetsState>(
    'lancer affiche le jet obtenu et l’historique à jour',
    build: () => construire(Role.joueur),
    act: (cubit) => cubit.lancer(),
    expect: () => [
      JetsPret(historique: [jetReussi], dernierJet: jetReussi),
    ],
  );

  blocTest<JetsCubit, JetsState>(
    'vider est refusé au joueur : l’historique reste, une alerte s’affiche',
    build: () => construire(Role.joueur),
    seed: () => JetsPret(historique: [jetReussi]),
    act: (cubit) => cubit.vider(),
    expect: () => [
      isA<JetsPret>()
          .having((s) => s.historique, 'historique', [jetReussi])
          .having((s) => s.alerte, 'alerte', contains('Accès refusé')),
    ],
    verify: (_) => verifyNever(() => repository.vider()),
  );

  blocTest<JetsCubit, JetsState>(
    'vider est permis au meneur : l’historique devient vide',
    build: () => construire(Role.meneur),
    seed: () => JetsPret(historique: [jetReussi]),
    act: (cubit) => cubit.vider(),
    expect: () => [const JetsPret(historique: [])],
  );

  blocTest<JetsCubit, JetsState>(
    'un second refus identique affiche de nouveau l’alerte',
    build: () => construire(Role.joueur),
    seed: () => JetsPret(historique: [jetReussi]),
    act: (cubit) async {
      await cubit.vider();
      await cubit.vider();
    },
    expect: () => [
      isA<JetsPret>().having((s) => s.alerte, 'alerte', isNotNull),
      JetsPret(historique: [jetReussi]),
      isA<JetsPret>().having((s) => s.alerte, 'alerte', isNotNull),
    ],
  );

  blocTest<JetsCubit, JetsState>(
    'vider affiche une erreur si l’effacement échoue',
    setUp: () =>
        when(() => repository.vider())
            .thenThrow(Exception('base indisponible')),
    build: () => construire(Role.meneur),
    seed: () => JetsPret(historique: [jetReussi]),
    act: (cubit) => cubit.vider(),
    expect: () => [isA<JetsErreur>()],
  );
}
