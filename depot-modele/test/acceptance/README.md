# Cas d'acceptation

Ce dossier est réservé aux scénarios d'acceptation (fichiers `.feature`) de la séance 4.

- Il est modifié **par des humains uniquement**, dans une PR relue. La règle `Edit(/test/acceptance/**)` de `.claude/settings.json` bloque les outils d'écriture de fichiers de l'agent (et les redirections du terminal qu'il reconnaît) ; elle n'arrête pas toute commande du terminal (`mv`, `rm`, un script). Le vrai garde-fou reste la relecture de la PR : toute modification de ce dossier doit y être repérée et justifiée.
- Les étapes de ces scénarios vont dans `test/steps/`, comme celles des autres scénarios.
- Les tests `*_test.dart` générés ici par `build_runner` ne sont pas versionnés.
