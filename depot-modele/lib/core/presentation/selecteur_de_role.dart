// Sélecteur de rôle affiché dans la barre de titre (démonstration, pas une connexion).
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';

import '../domain/roles/role.dart';
import 'role_cubit.dart';

class SelecteurDeRole extends StatelessWidget {
  const SelecteurDeRole({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RoleCubit, Role>(
      builder: (context, role) => SegmentedButton<Role>(
        segments: [
          for (final r in Role.values)
            ButtonSegment(value: r, label: Text(r.libelle)),
        ],
        selected: {role},
        onSelectionChanged: (choix) =>
            context.read<RoleCubit>().choisir(choix.single),
      ),
    );
  }
}
