// Les deux rôles de démonstration. Chaque équipe les remplace par ceux de son thème.

enum Role {
  meneur('Meneur'),
  joueur('Joueur');

  const Role(this.libelle);

  /// Nom affiché à l'écran.
  final String libelle;
}
