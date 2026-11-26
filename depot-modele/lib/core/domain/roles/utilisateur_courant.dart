// Utilisateur courant simulé : aucun compte ni mot de passe, le rôle se choisit à l'écran.
// Ce n'est pas une sécurité réelle : l'application web est publique.
import 'role.dart';

abstract interface class UtilisateurCourant {
  /// Pseudonyme fictif qui identifie l'utilisateur (« sa propre fiche »).
  /// Jamais un nom de personne ni une adresse électronique.
  String get identifiant;

  Role get role;
}

/// Implémentation de démonstration : le rôle est modifiable à tout moment.
class UtilisateurCourantSimule implements UtilisateurCourant {
  UtilisateurCourantSimule({
    this.identifiant = 'pseudo-demo-1',
    this.role = Role.joueur,
  });

  @override
  final String identifiant;

  @override
  Role role;
}
