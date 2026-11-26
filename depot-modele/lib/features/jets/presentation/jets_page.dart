// Écran des jets : lancer un dé, voir réussite ou échec, consulter et vider l'historique.
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';

import '../../../core/presentation/selecteur_de_role.dart';
import '../domain/entities/jet.dart';
import 'jets_cubit.dart';
import 'jets_state.dart';

class JetsPage extends StatelessWidget {
  const JetsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jets de dé'),
        actions: const [
          Padding(padding: .symmetric(horizontal: 8), child: SelecteurDeRole()),
        ],
      ),
      body: BlocConsumer<JetsCubit, JetsState>(
        // Effet ponctuel : listenWhen choisit les états à écouter (ceux qui portent une
        // alerte) ; le motif du listener refait le test pour lire le message sans « ! ».
        listenWhen: (avant, apres) => apres is JetsPret && apres.alerte != null,
        listener: (context, state) {
          if (state case JetsPret(alerte: final message?)) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(message)));
          }
        },
        builder: (context, state) => switch (state) {
          JetsChargement() => const Center(child: CircularProgressIndicator()),
          JetsErreur(:final message) => Center(child: Text(message)),
          JetsPret() => _Contenu(state),
        },
      ),
    );
  }
}

class _Contenu extends StatelessWidget {
  const _Contenu(this.state);

  final JetsPret state;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<JetsCubit>();
    final dernier = state.dernierJet;
    return Padding(
      padding: const .all(16),
      child: Column(
        crossAxisAlignment: .start,
        children: [
          const Text('Degré de difficulté : ${JetsCubit.ddDemonstration}'),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: [
              FilledButton(
                onPressed: cubit.lancer,
                child: const Text('Lancer le dé'),
              ),
              OutlinedButton(
                onPressed: cubit.vider,
                child: const Text('Vider l’historique'),
              ),
            ],
          ),
          const SizedBox(height: 16),
          if (dernier != null)
            Text(
              'Dernier jet : ${dernier.valeur} · ${_verdict(dernier)}',
              key: const Key('dernier_jet'),
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          const SizedBox(height: 16),
          Text('Historique', style: Theme.of(context).textTheme.titleMedium),
          Expanded(
            child: state.historique.isEmpty
                ? const Text('Aucun jet enregistré.')
                : ListView(
                    children: [
                      for (final jet in state.historique)
                        ListTile(
                          title: Text('${jet.valeur} contre ${jet.dd}'),
                          trailing: Text(_verdict(jet)),
                        ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }

  String _verdict(Jet jet) => jet.reussi ? 'Réussite' : 'Échec';
}
