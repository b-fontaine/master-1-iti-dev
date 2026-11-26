// Cubit du sélecteur de rôle : change le rôle de l'utilisateur courant simulé.
import 'package:flutter_bloc/flutter_bloc.dart';

import '../domain/roles/role.dart';
import '../domain/roles/utilisateur_courant.dart';

class RoleCubit extends Cubit<Role> {
  RoleCubit(this._utilisateur) : super(_utilisateur.role);

  final UtilisateurCourantSimule _utilisateur;

  void choisir(Role role) {
    _utilisateur.role = role;
    emit(role);
  }
}
