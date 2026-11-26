// Cas d'usage : lancer un dé, appliquer la règle de réussite et enregistrer le jet.
import '../../../../core/domain/services/horloge.dart';
import '../entities/jet.dart';
import '../regles/est_reussite.dart';
import '../repositories/jets_repository.dart';
import '../services/source_de_hasard.dart';

class LancerUnDe {
  LancerUnDe(this._repository, this._hasard, this._horloge);

  final JetsRepository _repository;
  final SourceDeHasard _hasard;
  final Horloge _horloge;

  /// Lance un dé à [faces] faces contre le degré de difficulté [dd].
  Future<Jet> call({required int dd, int faces = 20}) {
    final valeur = _hasard.entre(1, faces);
    return _repository.enregistrer(
      Jet(
        valeur: valeur,
        dd: dd,
        reussi: estReussite(valeur, dd),
        lanceLe: _horloge.maintenant(),
      ),
    );
  }
}
