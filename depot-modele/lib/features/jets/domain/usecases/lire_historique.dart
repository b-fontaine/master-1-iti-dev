// Cas d'usage : lire l'historique des jets, du plus récent au plus ancien.
import '../entities/jet.dart';
import '../repositories/jets_repository.dart';

class LireHistorique {
  LireHistorique(this._repository);

  final JetsRepository _repository;

  Future<List<Jet>> call() => _repository.historique();
}
