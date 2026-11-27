# Supports de cours · Séance 3 · Première user story, données et RGPD

Cinq chapitres pour la séance du vendredi 4 décembre 2026, deux jours après la séance 2. Rien n'est demandé entre les deux séances : l'état courant de `JOURNAL.md` et le tag `s2-fin` suffisent à reprendre, et la séance s'ouvre sur un bref contrôle, pas sur une remise en route. C'est ensuite une séance de pratique : les diapositives (`cours/presentations/day-3/`) cadrent les ateliers, les chapitres 1 à 4 expliquent chaque geste et le chapitre 5 rassemble les fiches à garder sous les yeux. Chaque chapitre contient un résumé, un glossaire, des sources et une liste des points non vérifiés.

| # | Chapitre | Contenu | Blocs de la séance |
|---|---|---|---|
| 1 | [Travailler à plusieurs](01-travailler-a-plusieurs.md) | Contrôle d'ouverture, petites PR et branches courtes, relire une PR (quoi regarder, comment commenter), checklist de revue, le conflit dans un dépôt dont `main` est protégée, la revue croisée entre équipes (paires à 8 et à 7 équipes, qui approuve) | 1, 2 et 10 |
| 2 | [La première user story](02-premiere-user-story.md) | De la story de `PROJET.md` au scénario `.feature` en français, plan de l'agent critiqué, tests unitaires d'abord, repository en mémoire, Cubit testé, étapes sans écran, repérer un test « triché », PR et clone frais | 3 |
| 3 | [Le RGPD appliqué au projet](03-rgpd-applique-au-projet.md) | Les notions utiles, le prompt comme transfert vers un tiers, vos droits, le test en quatre questions, la qualification des données des thèmes A, B et C, les rubriques 1 à 5 de la fiche de conformité | 4 à 7 |
| 4 | [Les données](04-les-donnees.md) | Entités, relations, clés et contraintes ; le modèle sur papier ; drift ; migrations versionnées ; test d'intégrité sur base en mémoire ; deux pièges ; la règle « une migration à la fois » | 8 et 9 |
| 5 | [Les fiches de la séance](05-fiches-de-seance.md) | Contrôle d'ouverture, première user story, checklist de revue de PR, test en quatre questions et fiche de conformité, données, revue croisée, bilan et livrable, dépannage (fiches G à N) | 1, 3, 6, 7, 9, 10 et 11 |

Ces chapitres ne redisent pas ce qui existe déjà : ils y renvoient. Supports de la séance 1 (`cours/supports/day-1/`) : le dojo, le TDD et le BDD (chapitre 5), Flutter (chapitre 4), le patron *repository* (chapitre 9). Supports de la séance 2 (`cours/supports/day-2/`) : les gestes git et le conflit pas à pas (chapitre 1), la configuration de l'agent, les permissions et le mode plan (chapitre 2), les couches, le modèle de PR et la protection de `main` (chapitre 3), les fiches 0 et A à F (chapitre 4). Le droit est dans le module de conformité (`cours/conformite-ai-act-rgpd.md`), qui fait foi ; les énoncés des thèmes dans `cours/projets/themes.md`.

## Lecture conseillée

- Avant la séance : rien n'est demandé. Si vous en avez le temps, le chapitre 1, section 2 (le contrôle d'ouverture), et le chapitre 2, sections 3 et 4 (le plan demandé à l'agent, puis de la story au scénario).
- Pendant la séance : le chapitre 5, fiche après fiche. C'est le seul à imprimer.
- Quand un geste coince : la fiche N, puis la section du chapitre à laquelle elle renvoie.
- Après la séance : le chapitre 3, section 5 (vos droits, pour vous-même) ; le chapitre 4 en entier si votre équipe termine le seed ou les rôles pendant la tâche facultative ; le chapitre 1, section 4, avant votre prochaine relecture.

## Ce que la séance vise

| Objectif du programme | Où le travailler |
|---|---|
| 1. Reprendre le projet de l'avant-veille par un bref contrôle (`git pull`, `flutter pub get`, `build_runner`, `flutter test`) | Chapitre 1, section 2 ; fiche G |
| 2. Livrer une première user story en TDD et en BDD avec son agent, et la faire relire | Chapitre 2 ; fiches H et I |
| 3. Relire la PR d'une autre équipe avec une checklist, et résoudre un conflit réel | Chapitre 1, sections 4 à 7 ; fiches I, L et N |
| 4. Modéliser un domaine en entités et relations, écrire une migration drift, et vérifier l'intégrité des données sur une base en mémoire | Chapitre 4 ; fiche K |
| 5. Distinguer donnée personnelle, base légale, durée de conservation, sous-traitant ; connaître ses droits ; remplir les premières rubriques de la fiche de conformité | Chapitre 3 ; fiche J |

Le livrable de fin de séance et la definition of done sont repris mot pour mot dans la fiche M.

## Réserves

Rédigés et relus avec l'aide d'un assistant, les chapitres sont sourcés, mais **chaque chapitre signale ses points non vérifiés** en fin de document. Six réserves valent pour l'ensemble.

- **Vérifié sous Linux seulement.** Les extraits de code, de scénario et de sortie, et les commandes, ont été exécutés le 26 novembre 2026 sous Linux, avec Flutter 3.50.1 (Dart 3.14.0, drift 2.35.4, git 2.53.0, gh 2.100.0), sur une copie du dépôt-modèle placée hors du dépôt du cours. Ils n'ont été essayés ni sous Windows ni sous macOS. Les nombres de tests et les durées affichés valent pour cette copie : ils seront différents dans votre dépôt.
- **Presque rien n'a été exécuté sur GitHub.** Seul l'essai du script de création des dépôts a eu lieu en ligne, le 27 novembre 2026, pour une équipe d'essai à un seul membre (compte administrateur de l'organisation) : il a confirmé la protection de `main` (push direct refusé, fusion sans approbation refusée) et la CI verte. L'affichage d'un conflit sur la page d'une PR, les commentaires, *Approve* et *Request changes*, la relecture par un compte sans droit d'écriture, l'approbation par un coéquipier et la fusion avec suppression de la branche sont décrits d'après la documentation et le programme. Les conflits ont été rejoués dans des dépôts jetables reliés à un dépôt distant local. Les droits de l'équipe jumelée découlent du script de création des dépôts, dont l'essai n'a vérifié ni l'invitation d'un membre ni ce que peut faire un compte extérieur à l'équipe.
- **Le travail avec l'agent n'a pas été rejoué.** Le code de la première user story et des migrations a été écrit pour la vérification en suivant l'ordre décrit, puis exécuté ; les demandes de plan, les critiques et les descriptions de PR sont rédigées pour les chapitres, et les expériences de « triche » ont été jouées à la main, pas produites par un agent. Ce que Claude Code proposerait réellement n'a pas été observé.
- **Les articles du RGPD sont de seconde main.** Articles, délais et définitions du chapitre 3 sont repris du module de conformité du cours (sources consultées le 1er octobre 2026), sans relecture directe du texte du règlement. Le chapitre est une sensibilisation, pas un avis juridique : la validation revient au RSSI et au DPO.
- **Un texte reste une proposition des supports**, à valider par l'enseignant : le commentaire de la fiche de conformité (chapitre 4, section 8). Les autres textes proposés ont été validés par l'enseignant : la checklist de PR à cinq lignes, les lignes 6 à 10 de la checklist de revue, la convention [bloquant], [question], [suggestion], la règle « une migration à la fois » à ajouter à `CLAUDE.md`, l'exemple de fiche de conformité du thème B et la trame de courriel de demande d'accès.
- **Les dates.** Les chapitres ont été rédigés et vérifiés le 26 novembre 2026. Les dates citées sont celles du programme, qui fait foi : séance 3 le vendredi 4 décembre 2026, séance 4 le mercredi 16 décembre, fiche de conformité v1 le vendredi 18 décembre, séance 5 le vendredi 29 janvier 2027 après-midi.
