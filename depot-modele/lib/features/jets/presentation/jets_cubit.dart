// Cubit de l'écran des jets : reçoit les actions de l'utilisateur et produit les états.
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/domain/roles/require_role.dart';
import '../domain/usecases/lancer_un_de.dart';
import '../domain/usecases/lire_historique.dart';
import '../domain/usecases/vider_historique.dart';
import 'jets_state.dart';

class JetsCubit extends Cubit<JetsState> {
  JetsCubit({
    required this._lancerUnDe,
    required this._lireHistorique,
    required this._viderHistorique,
  }) : super(const JetsChargement());

  /// Degré de difficulté de la démonstration.
  static const ddDemonstration = 10;

  final LancerUnDe _lancerUnDe;
  final LireHistorique _lireHistorique;
  final ViderHistorique _viderHistorique;

  Future<void> charger() async {
    emit(const JetsChargement());
    try {
      emit(JetsPret(historique: await _lireHistorique()));
    } on Exception catch (e) {
      emit(JetsErreur('Lecture de l’historique impossible : $e'));
    }
  }

  Future<void> lancer() async {
    try {
      final jet = await _lancerUnDe(dd: ddDemonstration);
      emit(JetsPret(historique: await _lireHistorique(), dernierJet: jet));
    } on Exception catch (e) {
      emit(JetsErreur('Lancer impossible : $e'));
    }
  }

  Future<void> vider() async {
    try {
      await _viderHistorique();
      emit(const JetsPret(historique: []));
    } on AccesRefuse catch (refus) {
      final actuel = state;
      final sansAlerte = JetsPret(
        historique: actuel is JetsPret ? actuel.historique : const [],
        dernierJet: actuel is JetsPret ? actuel.dernierJet : null,
      );
      // Un état égal au précédent est ignoré : on efface d'abord l'alerte
      // pour qu'un second refus identique l'affiche de nouveau.
      emit(sansAlerte);
      emit(
        JetsPret(
          historique: sansAlerte.historique,
          dernierJet: sansAlerte.dernierJet,
          alerte: refus.toString(),
        ),
      );
    } on Exception catch (e) {
      emit(JetsErreur('Effacement impossible : $e'));
    }
  }
}
