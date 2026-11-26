// États de l'écran des jets : ce que la page doit afficher à chaque instant.
import 'package:equatable/equatable.dart';

import '../domain/entities/jet.dart';

sealed class JetsState extends Equatable {
  const JetsState();

  @override
  List<Object?> get props => [];
}

/// L'historique est en cours de lecture.
final class JetsChargement extends JetsState {
  const JetsChargement();
}

/// L'écran est prêt : historique, dernier jet et éventuel message d'alerte.
final class JetsPret extends JetsState {
  const JetsPret({required this.historique, this.dernierJet, this.alerte});

  final List<Jet> historique;
  final Jet? dernierJet;
  final String? alerte;

  @override
  List<Object?> get props => [historique, dernierJet, alerte];
}

/// Une erreur inattendue empêche d'afficher l'écran.
final class JetsErreur extends JetsState {
  const JetsErreur(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
