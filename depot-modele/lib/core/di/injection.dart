// Annuaire get_it : seul endroit où l'on enregistre les pièces de l'application.
import 'package:get_it/get_it.dart';

import '../../features/jets/data/jets_repository_drift.dart';
import '../../features/jets/data/source_de_hasard_aleatoire.dart';
import '../../features/jets/domain/repositories/jets_repository.dart';
import '../../features/jets/domain/services/source_de_hasard.dart';
import '../../features/jets/domain/usecases/lancer_un_de.dart';
import '../../features/jets/domain/usecases/lire_historique.dart';
import '../../features/jets/domain/usecases/vider_historique.dart';
import '../../features/jets/presentation/jets_cubit.dart';
import '../data/base_de_donnees.dart';
import '../data/horloge_systeme.dart';
import '../domain/roles/utilisateur_courant.dart';
import '../domain/services/horloge.dart';
import '../presentation/role_cubit.dart';

final sl = GetIt.instance;

/// Enregistre toutes les pièces. Les tests peuvent fournir leur base et leur hasard.
void configurerDependances({BaseDeDonnees? base, SourceDeHasard? hasard}) {
  // Commun : base de données, horloge et utilisateur courant simulé.
  sl.registerLazySingleton<BaseDeDonnees>(
    () => base ?? BaseDeDonnees(),
    dispose: (b) => b.close(),
  );
  sl.registerLazySingleton<Horloge>(HorlogeSysteme.new);
  sl.registerLazySingleton<UtilisateurCourantSimule>(
    UtilisateurCourantSimule.new,
  );
  // Le même objet, vu sous son contrat : le domaine ne connaît que UtilisateurCourant.
  sl.registerLazySingleton<UtilisateurCourant>(
    sl.get<UtilisateurCourantSimule>,
  );
  sl.registerFactory<RoleCubit>(() => RoleCubit(sl()));

  // Feature jets : data, puis domain, puis presentation.
  sl.registerLazySingleton<SourceDeHasard>(
    () => hasard ?? SourceDeHasardAleatoire(),
  );
  sl.registerLazySingleton<JetsRepository>(() => JetsRepositoryDrift(sl()));
  sl.registerFactory<LancerUnDe>(() => LancerUnDe(sl(), sl(), sl()));
  sl.registerFactory<LireHistorique>(() => LireHistorique(sl()));
  sl.registerFactory<ViderHistorique>(() => ViderHistorique(sl(), sl()));
  sl.registerFactory<JetsCubit>(
    () => JetsCubit(
      lancerUnDe: sl(),
      lireHistorique: sl(),
      viderHistorique: sl(),
    ),
  );
}
