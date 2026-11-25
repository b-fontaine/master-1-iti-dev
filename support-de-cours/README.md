# Support de cours (livre Quarto)

Livre en français « Ingénierie logicielle à l'ère de l'IA agentique », compilé en PDF (LuaLaTeX) et en EPUB à partir des supports de `cours/`.

## Commandes

```bash
quarto render support-de-cours          # PDF et EPUB dans support-de-cours/_book/
task book                               # idem
task book:pdf                           # PDF seul
task book:epub                          # EPUB seul
task book:check                         # vérification complète (interdits, sources, rendu)
bash support-de-cours/scripts/verifier.sh --no-render   # contrôles sans rendu
```

Prérequis : Quarto (1.8 ou plus) et une distribution TeX avec LuaLaTeX (TinyTeX convient). Le PDF utilise TeX Gyre Pagella, TeX Gyre Heros et DejaVu Sans Mono. Un caractère absent des polices fait échouer la compilation.

Un rendu limité à un seul format vide `_book/` : lancer `task book` pour obtenir les deux fichiers.

## Ajouter un chapitre

1. Créer le fichier `.qmd` dans le dossier de la partie, avec en première ligne `<!-- source: <chemin(s)> · synchro: AAAA-MM-JJ -->` (`source: nouveau` pour un texte original).
2. Donner au titre `#` un identifiant stable : `# Titre {#sec-slug}`.
3. Déclarer le fichier dans `book.chapters` de `_quarto.yml`, sous la bonne entrée `part:`.
4. Ajouter la ligne correspondante à la table ci-dessous.
5. Lancer `task book:check`.

Quand une séance à venir (`partie-5-a-venir/`) reçoit ses vrais chapitres, supprimer sa page d'annonce et son entrée `part:` de `_quarto.yml`.

## Table de correspondance source → chapitre

Tout fichier de `cours/` qui nourrit le livre figure ici. Le chemin source est celui du dépôt ; le chapitre est dans `support-de-cours/`.

| Source | Chapitre (fichier · identifiant) |
|---|---|
| `README.md` (racine) | `partie-1-formation/01-programme.qmd` · `#sec-programme` ; glossaire repris dans `annexes/b-glossaire.qmd` · `#sec-glossaire` |
| `cours/programme-detaille.md` | `partie-1-formation/02-programme-detaille.qmd` · `#sec-programme-detaille` ; séances à venir : `partie-5-a-venir/seance-3.qmd` · `#sec-s3`, `seance-4.qmd` · `#sec-s4`, `seance-5.qmd` · `#sec-s5` |
| `cours/presentations/day-1/index.html`, `cours/presentations/day-1/notes.html` | `partie-2-seance-1/00-seance-en-bref.qmd` · `#sec-s1-en-bref` |
| `cours/supports/day-1/01-histoire-detaillee-du-craft.md` | `partie-2-seance-1/01-histoire-du-craft.qmd` · `#sec-histoire-craft` |
| `cours/supports/day-1/02-histoire-de-l-ia.md` | `partie-2-seance-1/02-histoire-de-l-ia.qmd` · `#sec-histoire-ia` |
| `cours/supports/day-1/03-craft-depuis-l-ia.md` | `partie-2-seance-1/03-craft-depuis-l-ia.qmd` · `#sec-craft-ia` |
| `cours/supports/day-1/04-guide-flutter.md` | `partie-2-seance-1/04-guide-flutter.qmd` · `#sec-guide-flutter` |
| `cours/supports/day-1/05-pratique-craft-flutter.md` | `partie-2-seance-1/05-pratique-craft-flutter.qmd` · `#sec-pratique-craft-flutter` |
| `cours/supports/day-1/06-outils-developpement-agentique.md` | `partie-2-seance-1/06-outils-agentiques.qmd` · `#sec-outils-agentiques` |
| `cours/supports/day-1/07-edge-ai-flutter.md` | `partie-2-seance-1/07-edge-ai-flutter.qmd` · `#sec-edge-ai` |
| `cours/supports/day-1/08-ci-cd-devops.md` | `partie-2-seance-1/08-ci-cd-devops.qmd` · `#sec-ci-cd` |
| `cours/supports/day-1/09-design-patterns.md` | `partie-2-seance-1/09-design-patterns.qmd` · `#sec-design-patterns` |
| `cours/presentations/day-2/index.html`, `cours/presentations/day-2/notes.html` | `partie-3-seance-2/00-seance-en-bref.qmd` · `#sec-s2-en-bref` |
| `cours/supports/day-2/01-git-pas-a-pas.md` | `partie-3-seance-2/01-git-pas-a-pas.qmd` · `#sec-git` |
| `cours/supports/day-2/02-configurer-claude-code.md` | `partie-3-seance-2/02-configurer-claude-code.qmd` · `#sec-configurer-claude-code` |
| `cours/supports/day-2/03-demarrer-le-projet-d-equipe.md` | `partie-3-seance-2/03-demarrer-le-projet.qmd` · `#sec-demarrer-projet` |
| `cours/supports/day-2/04-fiches-de-seance.md` | `annexes/a-fiches-pratiques.qmd` · `#sec-fiches` |
| `cours/projets/themes.md`, `cours/presentations/themes/index.html`, `cours/presentations/themes/notes.html` | `partie-4-projet/01-themes.qmd` · `#sec-themes` |
| `cours/conformite-ai-act-rgpd.md` | `partie-4-projet/02-conformite.qmd` · `#sec-conformite` |
| _(texte original, sans source)_ | `index.qmd` (avant-propos), `partie-1-formation/03-parcours-autonome.qmd` · `#sec-parcours-autonome`, pages d'ouverture de partie |

Les `README.md` de `cours/supports/` et de `cours/presentations/` sont des notes de travail : ils ne nourrissent pas le livre.

## Interdits absolus dans les `.qmd`

Chemins temporaires du poste de rédaction, mentions internes de préparation enseignant, formules de brouillon et adresses électroniques (sauf le domaine `users.noreply.github.com`, utilisé dans des exemples). La liste exacte, qui fait foi, est dans `scripts/verifier.sh`.
