# Supports de cours · Séance 2 · Git, configurer son agent, lancer le projet

Quatre chapitres pour la séance du 9 octobre 2026. La séance est une séance de pratique : les diapositives (`cours/presentations/day-2/`) cadrent les ateliers, ces chapitres expliquent chaque geste et le chapitre 4 rassemble les fiches à garder sous les yeux. Chaque chapitre contient un résumé, un glossaire, des sources et une liste des points non vérifiés.

| # | Chapitre | Contenu | Blocs de la séance |
|---|---|---|---|
| 1 | [Git pas à pas](01-git-pas-a-pas.md) | Modèle mental, commandes, branches, pull request, résolution de conflit dans VS Code, erreurs fréquentes | 2 et 3 |
| 2 | [Configurer Claude Code](02-configurer-claude-code.md) | `CLAUDE.md`, permissions testées, mode plan, hooks, skills, sous-agents, plugins, MCP, aperçu spec-kit ; pourquoi la configuration prime sur la consigne | 4 et 5 |
| 3 | [Démarrer le projet d'équipe](03-demarrer-le-projet-d-equipe.md) | Équipes et rôles, pile et couches, contexte fourni, `PROJET.md`, première PR relue, protection de `main`, `JOURNAL.md`, les huit semaines | 6 à 9 |
| 4 | [Les fiches de la séance](04-fiches-de-seance.md) | Fiche git guidée, fiche de configuration, fiche d'initialisation, checklist de PR en cinq lignes, modèle de PR, dépannage | 1, 3, 5 et 8 |

Ces chapitres ne redisent pas ceux de la séance 1 (`cours/supports/day-1/`) : ils y renvoient pour l'histoire de git (chapitre 1), Flutter (chapitre 4), le dojo et le TDD (chapitre 5), les outils agentiques, le contexte et les jetons (chapitre 6), la CI/CD et les protections de branche (chapitre 8), les patrons d'architecture (chapitre 9).

## Lecture conseillée

- Avant la séance : chapitre 1, sections 1 à 3 (le modèle mental et l'identité), et le chapitre 6 de la séance 1 si vous ne l'avez pas lu.
- Pendant la séance : le chapitre 4, fiche après fiche. C'est le seul à imprimer.
- Quand un geste coince : chapitre 1, section 9, et la fiche F.
- Après la séance : chapitre 2 (pour comprendre ce que vous avez configuré) et chapitre 3 (pour le projet).
- Avant le vendredi 27 novembre : chapitre 3, section 12 (la reprise en dix minutes).

## Ce que la séance vise

| Objectif du programme | Où le travailler |
|---|---|
| 1. Réaliser un cycle git complet et résoudre un conflit simple | Chapitre 1 ; fiche A |
| 2. Configurer Claude Code et savoir citer un cadre de type spec-kit | Chapitre 2 ; fiche B |
| 3. Expliquer pourquoi une consigne ne suffit pas, alors qu'une permission configurée suffit | Chapitre 2, sections 1, 2 et 5 |
| 4. Équipe validée, thème confirmé, dépôt cloné et fonctionnel | Chapitre 3, sections 2 et 7 ; fiche C |
| 5. Contribuer à `PROJET.md` et à une première PR relue et fusionnée | Chapitre 3, sections 8 à 10 ; fiches C, D et E |
| 6. Situer où ranger quoi dans le projet | Chapitre 3, sections 3 à 6 |

## Réserves

Rédigés et relus avec l'aide d'un assistant, les chapitres sont sourcés, mais **chaque chapitre signale ses points non vérifiés** en fin de document. Quatre réserves valent pour l'ensemble.

- **Les outils changent vite.** L'état décrit est celui du 19 novembre 2026 (git 2.53, gh 2.100, Claude Code 2.1.325 à 2.1.328). Les commandes git locales, les sept règles de refus et le skill ont été essayés sur le poste de rédaction (hors session interactive) ; le reste est repris de la documentation : voir les points non vérifiés de chaque chapitre. Réessayez les extraits sur la version installée avant de vous y fier.
- **Rien n'a été exécuté sur GitHub ni sur le dépôt du projet.** Aucun dépôt n'a été créé en ligne pour écrire ces chapitres, et le dépôt-modèle du projet n'existait pas encore : les étapes qui passent par GitHub et par le squelette Flutter sont décrites d'après la documentation et le programme.
- **Les dates.** Le programme date la séance du 9 octobre 2026 ; ces chapitres ont été rédigés et vérifiés le 19 novembre 2026, et le dépôt-modèle du projet restait à produire. Si le calendrier a changé, les dates citées (27 novembre, 2 décembre) sont à reprendre du programme.
- **Un écart avec la documentation a été constaté** : la règle de refus `Read(./.env)` n'a pas, à elle seule, empêché la lecture du fichier par une commande du terminal (chapitre 2, section 5.4). Les fiches en tiennent compte.
