// Cas d'usage protégé : seul le meneur peut vider l'historique des jets.
import '../../../../core/domain/roles/require_role.dart';
import '../../../../core/domain/roles/role.dart';
import '../../../../core/domain/roles/utilisateur_courant.dart';
import '../repositories/jets_repository.dart';

class ViderHistorique {
  ViderHistorique(this._repository, this._utilisateur);

  static const garde = RequireRole({Role.meneur});

  final JetsRepository _repository;
  final UtilisateurCourant _utilisateur;

  /// Vide l'historique, ou lève [AccesRefuse] si le rôle courant n'est pas autorisé.
  Future<void> call() async {
    garde.verifier(_utilisateur);
    await _repository.vider();
  }
}
