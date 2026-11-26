// Garde d'accès : autorise une action seulement pour certains rôles.
import 'role.dart';
import 'utilisateur_courant.dart';

/// Erreur levée quand le rôle courant n'est pas autorisé.
class AccesRefuse implements Exception {
  const AccesRefuse(this.role, this.rolesAutorises);

  final Role role;
  final Set<Role> rolesAutorises;

  @override
  String toString() =>
      'Accès refusé : action réservée au rôle '
      '${rolesAutorises.map((r) => r.libelle).join(' ou ')}.';
}

class RequireRole {
  const RequireRole(this.rolesAutorises);

  final Set<Role> rolesAutorises;

  /// Vrai si [utilisateur] a l'un des rôles autorisés.
  bool autorise(UtilisateurCourant utilisateur) =>
      rolesAutorises.contains(utilisateur.role);

  /// Ne fait rien si l'accès est autorisé, lève [AccesRefuse] sinon.
  void verifier(UtilisateurCourant utilisateur) {
    if (!autorise(utilisateur)) {
      throw AccesRefuse(utilisateur.role, rolesAutorises);
    }
  }
}
