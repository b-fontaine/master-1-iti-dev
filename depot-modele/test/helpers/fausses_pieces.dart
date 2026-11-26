// Fausses pièces partagées par les tests : elles remplacent le hasard, l'heure et le repository.
import 'package:mocktail/mocktail.dart';
import 'package:projet_fil_rouge/core/domain/services/horloge.dart';
import 'package:projet_fil_rouge/features/jets/domain/repositories/jets_repository.dart';
import 'package:projet_fil_rouge/features/jets/domain/services/source_de_hasard.dart';

/// Source de hasard qui renvoie toujours la même valeur.
class FausseSourceDeHasard implements SourceDeHasard {
  FausseSourceDeHasard(this.valeur);

  int valeur;

  @override
  int entre(int min, int max) => valeur;
}

/// Horloge arrêtée sur un instant fixe.
class FausseHorloge implements Horloge {
  FausseHorloge(this.instant);

  DateTime instant;

  @override
  DateTime maintenant() => instant;
}

/// Repository simulé avec mocktail : on lui dicte ses réponses dans chaque test.
class MockJetsRepository extends Mock implements JetsRepository {}
