# Séance 3 : supports, diaporama et partie du livre (cadrage)

Date : 26 novembre 2026. Séance visée : vendredi 4 décembre 2026.

## Intention

La séance 3 (« Première user story, données et RGPD ») n'a aujourd'hui que sa description dans `cours/programme-detaille.md` et une page « à paraître » dans le livre. Il faut ce que la séance 2 a déjà : des chapitres à lire, des fiches à suivre en atelier, un diaporama court qui cadre les ateliers, et la partie correspondante du livre.

## Buts, non-buts, anti-buts

- **Buts.** Cinq chapitres dans `cours/supports/day-3/`, un `README.md` de dossier, un diaporama `cours/presentations/day-3/` (`index.html`, `notes.html`, `deck.css`), la partie « Séance 3 » du livre, la synchronisation exigée par `CLAUDE.md`.
- **Non-buts.** Modifier le déroulé, le livrable ou la definition of done de la séance (le programme fait foi). Modifier le dépôt-modèle. Écrire les séances 4 et 5.
- **Anti-buts.** Redire ce qui existe déjà (conflit git de la séance 2, dojo TDD et BDD de la séance 1, module de conformité) au lieu d'y renvoyer. Donner un extrait de code ou une commande qui n'a pas été exécuté sans le signaler dans « Points non vérifiés ». Inventer un fait juridique ou technique absent des sources du dépôt.

## Approches considérées

1. **Calquer la séance 2** (retenue, validée par l'enseignant le 26 novembre) : quatre chapitres d'explication et un chapitre de fiches, diaporama court. Le lecteur retrouve la même forme ; le livre se remplit selon la procédure déjà écrite dans `support-de-cours/README.md`.
2. **Version légère** : deux ou trois chapitres courts. Plus rapide, mais la séance compte quatre ateliers Indispensables sans fiche, et le public n'est pas développeur.
3. **Un seul chapitre « guide de séance »**. Écartée : mélange les gestes à suivre au clavier et les explications à lire au calme.

## Découpage

| Fichier `cours/supports/day-3/` | Contenu | Blocs |
|---|---|---|
| `01-travailler-a-plusieurs.md` | Contrôle d'ouverture, petites PR et branches courtes, relire une PR (quoi regarder, comment commenter), le conflit réel dans le dépôt d'équipe, la revue croisée entre équipes (paires à 8 et à 7 équipes, qui approuve) | 1, 2, 10 |
| `02-premiere-user-story.md` | De la story de `PROJET.md` au scénario `.feature` en français, aux tests unitaires, au code : plan critiqué, rouge-vert-nettoyage, repository fake en mémoire, Cubit testé, repérer un test « triché », PR | 3 |
| `03-rgpd-applique-au-projet.md` | Les notions utiles (renvoi au module), le prompt comme transfert à un tiers, les droits, le test en 4 questions, la qualification des données des thèmes A, B, C, les rubriques 1 à 5 de la fiche | 4 à 7 |
| `04-les-donnees.md` | Entités, relations, clés, contraintes ; drift en une phrase puis en pratique ; migration versionnée ; test d'intégrité sur base en mémoire ; les deux pièges ; la règle « une migration à la fois » | 8, 9 |
| `05-fiches-de-seance.md` | Fiches à suivre : contrôle d'ouverture, première user story, checklist de revue de PR, test en 4 questions et fiche de conformité, données, revue croisée, bilan et livrable, dépannage | 1, 3, 6, 7, 9, 10, 11 |

## Forme des chapitres (celle de `cours/supports/day-2/`)

- Titre `# Chapitre N · …`, ligne en italique (séance, année, état des outils et date de vérification), paragraphe d'introduction, `## Ce que vous allez retenir`, sections numérotées `## 1.`, encadrés `> **À retenir.**`, puis `## Glossaire`, `## Pour aller plus loin`, `## Points non vérifiés (à signaler honnêtement)`, `## Sources`.
- Public : non-développeurs. Chaque mot technique est défini à sa première apparition.
- Les exemples suivis s'appuient sur le thème B (comme la séance 2) ; les thèmes A et C sont cités là où le programme les distingue.
- Les lettres des fiches continuent celles de la séance 2 (0, A à F), donc G et suivantes, pour que l'annexe A du livre garde des lettres uniques.

## Sources qui font foi

`cours/programme-detaille.md` (séance 3, sections 5 et 8), `cours/projets/themes.md`, `cours/conformite-ai-act-rgpd.md`, `depot-modele/` (code, `CLAUDE.md`, `docs/ARCHITECTURE.md`, `docs/fiche_conformite.md`, `themes/PROJET-*.md`), chapitres des séances 1 et 2.

## Vérification

- Tout extrait Dart, Gherkin ou commande est exécuté sur une copie du dépôt-modèle (hors dépôt, dans le dossier temporaire de la session) avec Flutter 3.50.1 ; ce qui n'a pas pu l'être est listé en « Points non vérifiés ».
- Relecture par un agent indépendant : fidélité au programme et aux sources, cohérence entre chapitres, fiches et diaporama.
- `task book:check` vert, résultat collé.

## Livre

Procédure « Remplacer la page à paraître d'une séance K » de `support-de-cours/README.md`, suivie point par point : dossier `partie-5-seance-3/` (`index.qmd`, `00-seance-en-bref.qmd` portant `#sec-s3`, quatre chapitres), fiches ajoutées à `annexes/a-fiches-pratiques.qmd`, glossaire fusionné, `_quarto.yml`, table de correspondance, avant-propos, parcours autonome. Le dossier `partie-5-a-venir/` garde son nom et les pages des séances 4 et 5.

## Laissé au rédacteur

Le détail des sections, le choix des exemples, la longueur de chaque chapitre (ordre de grandeur : 400 à 800 lignes, moins pour le chapitre 3 qui renvoie au module de conformité).
