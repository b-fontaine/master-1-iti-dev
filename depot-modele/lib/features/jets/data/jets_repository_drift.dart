// Implémentation du contrat JetsRepository avec la base drift.
import 'package:drift/drift.dart';

import '../../../core/data/base_de_donnees.dart';
import '../domain/entities/jet.dart';
import '../domain/repositories/jets_repository.dart';

class JetsRepositoryDrift implements JetsRepository {
  JetsRepositoryDrift(this._base);

  final BaseDeDonnees _base;

  @override
  Future<Jet> enregistrer(Jet jet) async {
    final ligne = await _base
        .into(_base.jets)
        .insertReturning(
          JetsCompanion.insert(
            valeur: jet.valeur,
            dd: jet.dd,
            reussi: jet.reussi,
            lanceLe: jet.lanceLe.toUtc(),
          ),
        );
    return _versEntite(ligne);
  }

  @override
  Future<List<Jet>> historique() async {
    final requete = _base.select(_base.jets)
      ..orderBy([(t) => OrderingTerm.desc(t.id)]);
    final lignes = await requete.get();
    return lignes.map(_versEntite).toList();
  }

  @override
  Future<void> vider() => _base.delete(_base.jets).go();

  Jet _versEntite(JetLigne ligne) => Jet(
    id: ligne.id,
    valeur: ligne.valeur,
    dd: ligne.dd,
    reussi: ligne.reussi,
    lanceLe: ligne.lanceLe.toUtc(),
  );
}
