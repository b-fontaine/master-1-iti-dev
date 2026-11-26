// Vraie horloge de l'application : lit l'heure du système ; les tests la remplacent par une fausse.
import '../domain/services/horloge.dart';

class HorlogeSysteme implements Horloge {
  const HorlogeSysteme();

  @override
  DateTime maintenant() => DateTime.now().toUtc();
}
