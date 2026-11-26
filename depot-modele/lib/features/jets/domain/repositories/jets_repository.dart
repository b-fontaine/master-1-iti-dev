// Contrat d'accès aux jets : le domaine dit ce dont il a besoin, la couche data dit comment.
import '../entities/jet.dart';

abstract interface class JetsRepository {
  /// Enregistre un jet et le renvoie avec son identifiant.
  Future<Jet> enregistrer(Jet jet);

  /// Renvoie les jets enregistrés, du plus récent au plus ancien.
  Future<List<Jet>> historique();

  /// Supprime tous les jets enregistrés.
  Future<void> vider();
}
