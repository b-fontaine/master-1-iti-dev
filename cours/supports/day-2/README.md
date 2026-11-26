# Supports de cours · Séance 2 · Git, configurer son agent, lancer le projet

Quatre chapitres pour la séance du mercredi 2 décembre 2026, huit semaines après la séance 1. La séance s'ouvre sur la remise en route des postes, la présentation des trois thèmes (diaporama `cours/presentations/themes/`) et la constitution des équipes ; c'est ensuite une séance de pratique : les diapositives (`cours/presentations/day-2/`) cadrent les ateliers, ces chapitres expliquent chaque geste et le chapitre 4 rassemble les fiches à garder sous les yeux. Chaque chapitre contient un résumé, un glossaire, des sources et une liste des points non vérifiés.

| # | Chapitre | Contenu | Blocs de la séance |
|---|---|---|---|
| 1 | [Git pas à pas](01-git-pas-a-pas.md) | Modèle mental, commandes, branches, pull request, résolution de conflit dans VS Code, erreurs fréquentes | 4 et 5 |
| 2 | [Configurer Claude Code](02-configurer-claude-code.md) | `CLAUDE.md`, permissions testées, mode plan, hooks, skills, sous-agents, plugins, MCP, aperçu spec-kit ; pourquoi la configuration prime sur la consigne | 6 et 7 |
| 3 | [Démarrer le projet d'équipe](03-demarrer-le-projet-d-equipe.md) | Constitution des équipes, thèmes et rôles, création des dépôts pendant la séance, pile et couches, contexte fourni, `PROJET.md`, première PR relue, protection de `main`, `JOURNAL.md`, la suite du calendrier | 3 et 8 à 10 |
| 4 | [Les fiches de la séance](04-fiches-de-seance.md) | Fiche de remise en route du poste (reprise après huit semaines), fiche git guidée, fiche de configuration, fiche d'initialisation, checklist de PR en cinq lignes, modèle de PR, dépannage | 1, 5, 7 et 9 |

Ces chapitres ne redisent pas ceux de la séance 1 (`cours/supports/day-1/`) : ils y renvoient pour l'histoire de git (chapitre 1), Flutter (chapitre 4), le dojo et le TDD (chapitre 5), les outils agentiques, le contexte et les jetons (chapitre 6), la CI/CD et les protections de branche (chapitre 8), les patrons d'architecture (chapitre 9).

## Lecture conseillée

- Avant le vendredi 27 novembre : chapitre 4, fiche 0 (la reprise du poste en dix minutes, après huit semaines sans séance).
- Avant la séance : chapitre 1, sections 1 à 3 (le modèle mental et l'identité), et le chapitre 6 de la séance 1 si vous ne l'avez pas lu.
- Pendant la séance : le chapitre 4, fiche après fiche. C'est le seul à imprimer.
- Quand un geste coince : chapitre 1, section 9, et la fiche F.
- Après la séance : chapitre 2 (pour comprendre ce que vous avez configuré) et chapitre 3 (pour le projet).

## Ce que la séance vise

| Objectif du programme | Où le travailler |
|---|---|
| 1. Retrouver un poste opérationnel après huit semaines et savoir énoncer la règle d'or | Chapitre 4, fiche 0 |
| 2. Connaître les trois thèmes, faire partie d'une équipe constituée en séance, avec un thème, un numéro et un rôle | Diaporama des thèmes ; chapitre 3, section 2 |
| 3. Réaliser un cycle git complet et résoudre un conflit simple | Chapitre 1 ; fiche A |
| 4. Configurer Claude Code ; savoir ce que sont un plugin, un serveur MCP et un cadre de type spec-kit (en ressource) | Chapitre 2 ; fiche B |
| 5. Expliquer pourquoi une consigne ne suffit pas, alors qu'une permission configurée suffit | Chapitre 2, sections 1, 2 et 5 |
| 6. Dépôt d'équipe cloné et fonctionnel, contribution à `PROJET.md` et à une première PR relue et fusionnée | Chapitre 3, sections 7 à 10 ; fiches C, D et E |
| 7. Situer où ranger quoi dans le projet | Chapitre 3, sections 3 à 6 |

## Réserves

Rédigés et relus avec l'aide d'un assistant, les chapitres sont sourcés, mais **chaque chapitre signale ses points non vérifiés** en fin de document. Cinq réserves valent pour l'ensemble.

- **Les outils changent vite.** L'état décrit est celui du 19 novembre 2026 (git 2.53, gh 2.100, Claude Code 2.1.325 à 2.1.328). Les commandes git locales, les sept règles de refus et le skill ont été essayés sur le poste de rédaction (hors session interactive) ; le reste est repris de la documentation : voir les points non vérifiés de chaque chapitre. Réessayez les extraits sur la version installée avant de vous y fier.
- **Rien n'a été exécuté sur GitHub.** Aucun dépôt n'a été créé en ligne pour écrire ces chapitres : les étapes qui passent par GitHub (clone d'un dépôt d'équipe, PR, relecture, protection de `main`, CI) sont décrites d'après la documentation et le programme.
- **Le dépôt-modèle est vérifié sous Linux seulement.** Écrit après les chapitres, il a été relu et ses commandes exécutées le 26 novembre 2026 avec Flutter 3.50.1 (32 tests verts, `flutter analyze` sans remarque, build web ouvert dans Chrome) ; les chapitres 3 et 4 ont été alignés sur lui le même jour (Flutter 3.50 ou plus récent, `flutter upgrade` en remise en route, import `material_ui`, Gherkin français avec `# language: fr`, vraie structure de `PROJET.md`, modèle de PR en quatre rubriques). Il n'a été essayé ni sous Windows ni sous macOS, il n'est pas encore publié dans l'organisation, et sa CI n'a jamais tourné en ligne.
- **Les dates.** Le programme date la séance du mercredi 2 décembre 2026 (le calendrier a glissé : la séance était d'abord prévue le 9 octobre) ; ces chapitres ont été rédigés et vérifiés le 19 novembre 2026, puis mis à jour pour le nouveau calendrier, et enfin, le 26 novembre, pour le dépôt-modèle. Les dates citées sont celles du programme, qui fait foi : 27 novembre, 4, 16 et 18 décembre, soutenance le vendredi 29 janvier 2027 après-midi.
- **Un écart avec la documentation a été constaté** : la règle de refus `Read(./.env)` n'a pas, à elle seule, empêché la lecture du fichier par une commande du terminal (chapitre 2, section 5.4). Les fiches en tiennent compte.
