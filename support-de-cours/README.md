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

Portabilité :

- Avec TinyTeX, installer à la main les paquets absents : `tlmgr install fvextra xurl`, plus `tex-gyre` si les polices TeX Gyre manquent. Si TinyTeX est en TeX Live 2025 alors que le dépôt courant est plus récent, pointer d'abord `tlmgr` vers le dépôt historique de TeX Live 2025 (`tlmgr option repository` suivi de l'adresse de l'archive historique).
- DejaVu Sans Mono est une police du système, pas un paquet TeX : l'installer avec le gestionnaire de paquets du poste (par exemple `fonts-dejavu`).
- `scripts/verifier.sh` suppose GNU grep (option `-P`) et bash 4 ou plus (`mapfile`) : sur macOS, installer `grep` et `bash` GNU (Homebrew) et les placer en tête du `PATH`.

Un rendu limité à un seul format vide `_book/` : lancer `task book` pour obtenir les deux fichiers.

## Versions et publication

Le workflow `.github/workflows/livre.yml` compile le livre sur GitHub Actions :

| Événement | Version imprimée | Résultat |
|---|---|---|
| Pull request touchant `support-de-cours/` | `X.Y.Z-pr.N` (version qu'aurait la fusion) | Vérification complète ; PDF et EPUB téléchargeables dans les artefacts du run (30 jours) |
| Fusion dans `main` touchant `support-de-cours/` | `X.Y.Z` | Tag `livre-vX.Y.Z` et release GitHub « Livre vX.Y.Z » avec le PDF et l'EPUB |

La version suit le versionnage sémantique et se calcule à partir des messages des commits qui touchent `support-de-cours/` depuis le dernier tag `livre-v*` (`scripts/version-suivante.sh`) :

- aucun tag : `1.0.0` ;
- un commit `type(portée)!: …` ou un corps contenant `BREAKING CHANGE` : version majeure (refonte de la structure, identifiants `#sec-` renommés) ;
- un commit `feat(…): …` : version mineure (nouveau chapitre, nouvelle séance) ;
- tout autre commit (`fix`, `docs`, fusion…) : correctif.

Le numéro et la date sont imprimés au verso du titre (PDF), sur la page de titre et dans l'avant-propos. Ils viennent de `_version.yml` et `styles/version.tex`, générés par `scripts/ecrire-version.sh <version> [AAAA-MM-JJ]` : les fichiers versionnés portent la version « de travail », la CI les réécrit avant de compiler. Ne pas les modifier à la main ni commiter une version réécrite.

```bash
task book:test                                   # tests du calcul de version
bash support-de-cours/scripts/version-suivante.sh          # version de la prochaine publication
bash support-de-cours/scripts/version-suivante.sh --notes  # commits qui la composent
```

## Ajouter un chapitre

1. Créer le fichier `.qmd` dans le dossier de la partie, avec en première ligne `<!-- source: <chemin(s)> · synchro: AAAA-MM-JJ -->` (`source: nouveau` pour un texte original).
2. Donner au titre `#` un identifiant stable : `# Titre {#sec-slug}`.
3. Déclarer le fichier dans `book.chapters` de `_quarto.yml`, sous la bonne entrée `part:`.
4. Ajouter la ligne correspondante à la table ci-dessous.
5. Lancer `task book:check`.

### Ajouter la partie d'une séance

Les cinq séances ont leur partie (`partie-2-seance-1/` à `partie-7-seance-5/`) : il n'y a plus de page « à paraître ». Pour une séance K supplémentaire, ou pour refondre une partie :

1. Créer `partie-N-seance-K/` en suivant `partie-7-seance-5/` : `index.qmd` (page de la partie), `00-seance-en-bref.qmd` (tiré du diaporama, titre `# La séance K en bref {#sec-sK}` : le numéro dans le titre distingue les entrées de la table des matières de l'EPUB, qui n'a pas de pages de partie) et les chapitres numérotés. Des chapitres existants renvoient à `@sec-s3`, `@sec-s4` et `@sec-s5` : ces identifiants restent sur le chapitre « La séance K en bref » (vérifier avec `grep -rn "sec-sK" support-de-cours/*/*.qmd`).
2. Donner à chaque section numérotée du support l'identifiant `sec-<préfixe>-N` et à chaque sous-section `sec-<préfixe>-N-M`, avec les numéros du support : les renvois entre chapitres s'écrivent alors sans chercher.
3. Dans `_quarto.yml`, ajouter l'entrée `part: partie-N-seance-K/index.qmd` listant les nouveaux chapitres, dans l'ordre des séances.
4. Ajouter les lignes à la table de correspondance.
5. Dans `index.qmd`, mettre à jour les « Réserves » si elles citent la séance.
6. Dans `partie-1-formation/03-parcours-autonome.qmd`, mettre à jour la ligne de la séance dans le tableau du parcours.
7. Fusionner les nouvelles entrées dans `annexes/b-glossaire.qmd` et ajouter les nouvelles fiches dans `annexes/a-fiches-pratiques.qmd`.
8. Lancer `task book:check`.

## Table de correspondance source → chapitre

Tout fichier de `cours/` qui nourrit le livre figure ici. Le chemin source est celui du dépôt ; le chapitre est dans `support-de-cours/`.

| Source | Chapitre (fichier · identifiant) |
|---|---|
| `README.md` (racine) | `partie-1-formation/01-programme.qmd` · `#sec-programme` ; glossaire repris dans `annexes/b-glossaire.qmd` · `#sec-glossaire` |
| `cours/programme-detaille.md` | `partie-1-formation/02-programme-detaille.qmd` · `#sec-programme-detaille` |
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
| `cours/presentations/day-3/index.html`, `cours/presentations/day-3/notes.html` | `partie-5-seance-3/00-seance-en-bref.qmd` · `#sec-s3` |
| `cours/supports/day-3/01-travailler-a-plusieurs.md` | `partie-5-seance-3/01-travailler-a-plusieurs.qmd` · `#sec-travailler-a-plusieurs` |
| `cours/supports/day-3/02-premiere-user-story.md` | `partie-5-seance-3/02-premiere-user-story.qmd` · `#sec-premiere-user-story` |
| `cours/supports/day-3/03-rgpd-applique-au-projet.md` | `partie-5-seance-3/03-rgpd-applique-au-projet.qmd` · `#sec-rgpd-projet` |
| `cours/supports/day-3/04-les-donnees.md` | `partie-5-seance-3/04-les-donnees.qmd` · `#sec-donnees` |
| `cours/supports/day-3/05-fiches-de-seance.md` | `annexes/a-fiches-pratiques.qmd` · `#sec-fiches` (fiches G à N) |
| `cours/presentations/day-4/index.html`, `cours/presentations/day-4/notes.html` | `partie-6-seance-4/00-seance-en-bref.qmd` · `#sec-s4` |
| `cours/supports/day-4/01-test-d-acceptation.md` | `partie-6-seance-4/01-test-d-acceptation.qmd` · `#sec-test-acceptation` |
| `cours/supports/day-4/02-ci-cd-et-publication.md` | `partie-6-seance-4/02-ci-cd-et-publication.qmd` · `#sec-ci-publication` |
| `cours/supports/day-4/03-securite-et-audit-croise.md` | `partie-6-seance-4/03-securite-et-audit-croise.qmd` · `#sec-securite-audit` |
| `cours/supports/day-4/04-ai-act-et-rssi.md` | `partie-6-seance-4/04-ai-act-et-rssi.qmd` · `#sec-ai-act-rssi` |
| `cours/supports/day-4/05-fiches-de-seance.md` | `annexes/a-fiches-pratiques.qmd` · `#sec-fiches` (fiches O à V) |
| `cours/presentations/day-5/index.html`, `cours/presentations/day-5/notes.html` | `partie-7-seance-5/00-seance-en-bref.qmd` · `#sec-s5` |
| `cours/supports/day-5/01-geler-et-livrer.md` | `partie-7-seance-5/01-geler-et-livrer.qmd` · `#sec-geler-livrer` |
| `cours/supports/day-5/02-la-soutenance-d-equipe.md` | `partie-7-seance-5/02-la-soutenance-d-equipe.qmd` · `#sec-soutenance-equipe` |
| `cours/supports/day-5/03-l-oral-individuel-et-la-note.md` | `partie-7-seance-5/03-l-oral-individuel-et-la-note.qmd` · `#sec-oral-individuel` |
| `cours/supports/day-5/04-fiches-de-seance.md` | `annexes/a-fiches-pratiques.qmd` · `#sec-fiches` (fiches W à Z) |
| `cours/projets/themes.md`, `cours/presentations/themes/index.html`, `cours/presentations/themes/notes.html` | `partie-4-projet/01-themes.qmd` · `#sec-themes` |
| `cours/conformite-ai-act-rgpd.md` | `partie-4-projet/02-conformite.qmd` · `#sec-conformite` |
| _(texte original, sans source)_ | `index.qmd` (avant-propos), `partie-1-formation/03-parcours-autonome.qmd` · `#sec-parcours-autonome`, pages d'ouverture de partie |

Les `README.md` de `cours/supports/` et de `cours/presentations/` sont des notes de travail : ils ne nourrissent pas le livre.

## Règles d'adaptation d'un support en chapitre

1. **Ton intemporel.** « Pendant l'atelier » devient « en formation » ou « en pratique » ; « avant le 27 novembre » disparaît ou devient « avant la séance 2 » ; les consignes adressées à la promotion 2026-2027 deviennent des conseils au lecteur ; une consigne purement logistique disparaît.
2. **Dates conservées quand elles datent un fait.** « État des outils au 19 novembre 2026 » reste, regroupé dans un encadré en tête de chapitre.
3. **Renvois croisés Quarto.** « Chapitre 4 de la séance 1 » devient `@sec-guide-flutter` ; chaque chapitre a un identifiant `#sec-…` stable (minuscules ASCII, tirets, jamais en double). Quarto ajoute lui-même « Chapitre » ou « Section » devant la référence : ne jamais écrire le nom juste avant `@sec-…` (le préfixe serait doublé à l'impression). Écrire « voir @sec-x », ou, après le nom, `[-@sec-x]` pour le seul numéro. Le vérificateur refuse ce motif, ainsi que toute préposition ou article collé à `@sec-` : après « dans », « de », « du », « en », « à », « au », « sur » ou « par », écrire le nom avec son article et le numéro seul, selon le type de la cible (titre `#` : chapitre ; `##` ou plus : section ; dans `annexes/` : annexe), par exemple « dans le chapitre [-@sec-x] », « de la section [-@sec-x] », « de l'annexe [-@sec-x] », « au chapitre [-@sec-x] ». Pour viser une section, lui ajouter `{#sec-<chapitre>-<mot>}`.
4. **Encadrés Quarto, toujours titrés.** Un encadré sans `title=` s'affiche sous son type (« Astuce »). Titres standard : `callout-tip` « Ce que vous allez retenir » (en tête de chapitre) et « À retenir » ; `callout-note` « État des connaissances » (date de l'état des outils) et « Points non vérifiés » ; `callout-warning` pour les avertissements, avec un titre explicite. Pas de « À retenir » en gras dans le texte de l'encadré.
5. **Liens imprimables.** Les URL des sources restent écrites en clair (le PDF imprimé n'a pas de lien cliquable).
6. **Nettoyage.** Pas de chemin local, pas de section interne, pas de donnée personnelle ; les liens relatifs vers `cours/` sont remplacés par des renvois internes.
7. **Fidélité.** Pas d'ajout de contenu factuel non sourcé ; on adapte la forme, pas le fond. Un fait du support qui paraît faux est signalé à l'enseignant, pas corrigé en silence.
8. **Schémas.** Un schéma devient prose ou tableau ; seul un diagramme qui porte une structure absente de la prose s'écrit en bloc ` ```{mermaid} ` (et non ` ```mermaid `, qui n'est pas rendu).
9. **Méthode : copier puis retoucher.** Partir de la copie du fichier source et faire des retouches ciblées (ton, renvois, encadrés, nettoyage) ; ne pas réécrire de mémoire. Les numéros manuels des titres sont retirés (Quarto numérote) et les renvois qui les citaient sont mis à jour.
10. **Diaporama vers prose.** Le contenu d'un diaporama et de ses notes devient un chapitre « La séance K en bref » (K = numéro de la séance) : objectifs, déroulé (tableau), idées clés en encadrés. Aucune indication de régie (chronomètre, transitions, « cliquez »).

### Pièges Quarto et LaTeX

- Un bloc de code qui contient lui-même des titres `##` ou des clôtures doit rester un bloc fermé : vérifier l'appariement des clôtures.
- Un tableau très large reste un tableau à barres ; s'il déborde, le scinder ou passer en liste.
- Un bloc ` ```{mermaid} ` s'insère dans le PDF à sa taille naturelle : un schéma large déborde ou est coupé à droite de la page. Fixer sa largeur par une ligne `%%| fig-width: 5.6` juste sous ` ```{mermaid} ` (en pouces ; la colonne de texte en fait 5,67). Choisir une valeur plus petite pour un schéma étroit, car `fig-width` agrandit aussi un schéma moins large que la colonne, puis contrôler la page dans le PDF. Si le texte devient trop petit (un `flowchart LR` de plus de cinq boîtes) ou si le schéma ressort rogné, passer en `flowchart TD`, couper les libellés par des `<br/>`, ou revenir à une liste ou un tableau (règle 8).
- Un caractère absent des polices fait échouer la compilation du PDF (voir Prérequis). Les flèches, ≥ et ✓ ont un repli ; un émoji en couleur ne passe pas : le remplacer par un mot ou un symbole simple.

## Interdits absolus dans les `.qmd`

Chemins temporaires du poste de rédaction, mentions internes de préparation enseignant, formules de brouillon et adresses électroniques (sauf le domaine `users.noreply.github.com`, utilisé dans des exemples). La liste exacte, qui fait foi, est dans `scripts/verifier.sh`.
