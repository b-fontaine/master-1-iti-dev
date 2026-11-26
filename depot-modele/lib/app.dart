// Racine de l'interface : thème, cubits partagés et page d'accueil.
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';

import 'core/di/injection.dart';
import 'core/presentation/role_cubit.dart';
import 'features/jets/presentation/jets_cubit.dart';
import 'features/jets/presentation/jets_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<RoleCubit>()),
        BlocProvider(create: (_) => sl<JetsCubit>()..charger()),
      ],
      child: MaterialApp(
        title: 'Projet fil rouge',
        theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.indigo)),
        // Libellés internes de Material (boutons, infobulles, dates) en français.
        locale: const Locale('fr', 'FR'),
        supportedLocales: const [Locale('fr', 'FR')],
        localizationsDelegates: GlobalMaterialLocalizations.delegates,
        home: const JetsPage(),
      ),
    );
  }
}
