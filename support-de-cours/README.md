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

### Remplacer la page « à paraître » d'une séance K (3, 4 ou 5)

Des chapitres existants (par exemple `@sec-s3`, `@sec-s4`, `@sec-s5`) renvoient à ces pages : on garde donc l'identifiant `#sec-sK` sur le chapitre « La séance en bref » de la nouvelle partie, et les renvois continuent de fonctionner (vérifier d'abord avec `grep -rn "sec-sK" support-de-cours/*/*.qmd`).

1. Créer `partie-N-seance-K/` en suivant `partie-3-seance-2/` : `index.qmd` (page de la partie), `00-seance-en-bref.qmd` (tiré du diaporama, titre `# La séance en bref {#sec-sK}`) et les chapitres numérotés.
2. Dans `_quarto.yml`, remplacer l'entrée `part: "Séance K · …"` (qui liste l'unique chapitre `partie-5-a-venir/seance-K.qmd`) par `part: partie-N-seance-K/index.qmd` listant les nouveaux chapitres, dans l'ordre des séances, avant les parties d'annonce restantes.
3. Supprimer `partie-5-a-venir/seance-K.qmd`.
4. Ajouter les lignes à la table de correspondance et retirer l'ancienne mention de la page d'annonce.
5. Lancer `task book:check`.

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

## Règles d'adaptation d'un support en chapitre

1. **Ton intemporel.** « Pendant l'atelier » devient « en formation » ou « en pratique » ; « avant le 27 novembre » disparaît ou devient « avant la séance 2 » ; les consignes adressées à la promotion 2026-2027 deviennent des conseils au lecteur ; une consigne purement logistique disparaît.
2. **Dates conservées quand elles datent un fait.** « État des outils au 19 novembre 2026 » reste, regroupé dans un encadré en tête de chapitre.
3. **Renvois croisés Quarto.** « Chapitre 4 de la séance 1 » devient `@sec-guide-flutter` ; chaque chapitre a un identifiant `#sec-…` stable (minuscules ASCII, tirets, jamais en double). Quarto ajoute lui-même « Chapitre » ou « Section » devant la référence : ne jamais écrire le nom juste avant `@sec-…` (le préfixe serait doublé à l'impression). Écrire « voir @sec-x », ou, après le nom, `[-@sec-x]` pour le seul numéro. Le vérificateur refuse ce motif. Pour viser une section, lui ajouter `{#sec-<chapitre>-<mot>}`.
4. **Encadrés Quarto, toujours titrés.** Un encadré sans `title=` s'affiche sous son type (« Astuce »). Titres standard : `callout-tip` « Ce que vous allez retenir » (en tête de chapitre) et « À retenir » ; `callout-note` « État des connaissances » (date de l'état des outils) et « Points non vérifiés » ; `callout-warning` pour les avertissements, avec un titre explicite. Pas de « À retenir » en gras dans le texte de l'encadré.
5. **Liens imprimables.** Les URL des sources restent écrites en clair (le PDF imprimé n'a pas de lien cliquable).
6. **Nettoyage.** Pas de chemin local, pas de section interne, pas de donnée personnelle ; les liens relatifs vers `cours/` sont remplacés par des renvois internes.
7. **Fidélité.** Pas d'ajout de contenu factuel non sourcé ; on adapte la forme, pas le fond. Un fait du support qui paraît faux est signalé à l'enseignant, pas corrigé en silence.
8. **Schémas.** Un schéma devient prose ou tableau ; seul un diagramme qui porte une structure absente de la prose s'écrit en bloc ` ```{mermaid} ` (et non ` ```mermaid `, qui n'est pas rendu).
9. **Méthode : copier puis retoucher.** Partir de la copie du fichier source et faire des retouches ciblées (ton, renvois, encadrés, nettoyage) ; ne pas réécrire de mémoire. Les numéros manuels des titres sont retirés (Quarto numérote) et les renvois qui les citaient sont mis à jour.
10. **Diaporama vers prose.** Le contenu d'un diaporama et de ses notes devient un chapitre « La séance en bref » : objectifs, déroulé (tableau), idées clés en encadrés. Aucune indication de régie (chronomètre, transitions, « cliquez »).

### Pièges Quarto et LaTeX

- Un bloc de code qui contient lui-même des titres `##` ou des clôtures doit rester un bloc fermé : vérifier l'appariement des clôtures.
- Un tableau très large reste un tableau à barres ; s'il déborde, le scinder ou passer en liste.
- Un caractère absent des polices fait échouer la compilation du PDF (voir Prérequis). Les flèches, ≥ et ✓ ont un repli ; un émoji en couleur ne passe pas : le remplacer par un mot ou un symbole simple.

## Interdits absolus dans les `.qmd`

Chemins temporaires du poste de rédaction, mentions internes de préparation enseignant, formules de brouillon et adresses électroniques (sauf le domaine `users.noreply.github.com`, utilisé dans des exemples). La liste exacte, qui fait foi, est dans `scripts/verifier.sh`.
