# Livre Quarto « support de cours » · Plan de réalisation

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal :** créer dans `support-de-cours/` un livre Quarto, compilé en PDF et en EPUB, qui reprend et adapte tout le contenu de `cours/`, et poser la règle de maintenance dans un `CLAUDE.md`.

**Architecture :** un projet Quarto de type `book`, organisé en parties (un dossier par partie). Chaque chapitre est une copie adaptée d'un support ou d'un diaporama, et porte un commentaire qui donne sa source. Un script de vérification fait office de test : il contrôle les interdits (contenu interne, chemins locaux, champs vides) et compile les deux formats.

**Tech Stack :** Quarto 1.8.26, TinyTeX (LuaLaTeX, KOMA-Script `scrbook`), Pandoc intégré à Quarto, Bash, Task (Taskfile v3).

**Spec :** `docs/superpowers/specs/2026-11-25-support-de-cours-quarto-design.md` (les règles d'adaptation de la section 6 s'appliquent à chaque chapitre).

## Global Constraints

- Ne rien modifier dans `cours/` ; ne jamais indexer `.omc/` (`git add` par chemins explicites uniquement).
- Langue : français, accents et typographie française (espaces insécables gérés par `lang: fr`).
- Chaque `.qmd` de chapitre commence, juste après son en-tête YAML ou son titre, par `<!-- source: <chemin(s)> · synchro: 2026-11-25 -->` (`source: nouveau` pour un texte original).
- Identifiants de chapitre : `{#sec-<slug>}` sur le titre `#`, stables et uniques.
- Interdits absolus dans `support-de-cours/` : `/tmp/`, `Checklist enseignant`, `à compléter`, `ne pas diffuser`, les adresses électroniques.
- Les dates qui datent un fait (état des outils, consultation des sources) sont conservées ; les consignes datées adressées à la promotion ne le sont pas.
- Métadonnées : titre « Ingénierie logicielle à l'ère de l'IA agentique », sous-titre « Créer avec l'IA, dialoguer avec les développeurs », auteur Benoît Fontaine, « Master ITI · Nantes Université · édition 2026-2027 », mention « Tous droits réservés » reprise de `LICENSE`.
- Séance 5 datée « janvier 2027 » ; les champs vides du programme (responsable, rattachement et ECTS, lieu) sont omis.

## Review Focus

- **Un tableau large du programme détaillé** (8 colonnes et plus) : il doit tenir dans la page A4 sans déborder. Contrôle visuel dans la tâche 6.
- **Les blocs de code `markdown` contenant des titres `##`** (chapitres de la séance 2, fiches) : ils doivent rester du code, sans créer de faux chapitres dans la table des matières. Contrôle dans la tâche 4 (`grep` de la TOC EPUB).
- **Les renvois entre chapitres** : aucun « chapitre N de la séance M » ne doit subsister sans `@sec-…`. Le script signale les motifs `chapitre [0-9]+ de la séance`.
- **Les longues lignes de code et les URL des sources** : retour à la ligne dans le PDF, sans couper la marge. Contrôle visuel dans la tâche 6.
- **Les caractères spéciaux** (émojis, flèches, `≥`, guillemets, symboles des diaporamas) : LuaLaTeX ne doit signaler aucun « Missing character ». Le script cherche ce motif dans le journal.

---

### Task 1 : squelette du livre qui compile, avec le script de vérification

**Files :**
- Create : `support-de-cours/_quarto.yml`, `support-de-cours/index.qmd`, `support-de-cours/styles/preambule.tex`, `support-de-cours/styles/epub.css`, `support-de-cours/images/couverture.png`, `support-de-cours/scripts/verifier.sh`, `support-de-cours/README.md`, `support-de-cours/.gitignore`
- Create : une page de partie minimale par dossier (`partie-1-formation/index.qmd`, …) pour que la structure compile
- Modify : `Taskfile.yml` (tâches `book`, `book:pdf`, `book:epub`, `book:check`)

**Interfaces :**
- Produces : `support-de-cours/scripts/verifier.sh [--no-render]`. Il quitte avec un code non nul sur un interdit absolu, sur un chapitre sans commentaire `source:`, ou sur une erreur de rendu. Il affiche en avertissement les tournures de séance (« pendant la séance », « pendant l'atelier », « aujourd'hui », « avant le [0-9] », `chapitre [0-9]+ de la séance`). Il cherche dans le journal de rendu « Unable to resolve crossref », « WARNING » et « Missing character ».
- Produces : la liste `book.chapters` de `_quarto.yml`, que les tâches 2 à 5 complètent, une partie par entrée `part:`.

- [ ] **Step 1 : écrire `verifier.sh` puis le lancer sur un dossier vide.** Run : `bash support-de-cours/scripts/verifier.sh`. Expected : échec, `_quarto.yml` introuvable.
- [ ] **Step 2 : écrire `_quarto.yml`.**
  - `project.type: book`, `output-dir: _book`, `lang: fr`.
  - Format `pdf` : `documentclass: scrbook`, `classoption: [twoside, BCOR=12mm, DIV=11]`, `papersize: a4`, `pdf-engine: lualatex`, `toc`, `number-sections`, `include-in-header: styles/preambule.tex` (polices libres, `fvextra` avec `breaklines`, `\small` sur les longs tableaux, URL coupables).
  - Format `epub` : `cover-image: images/couverture.png`, `css: styles/epub.css`.
  - Ajouter `index.qmd` (avant-propos : publics, trois parcours de lecture, réserves, licence) et une page par partie.
- [ ] **Step 3 : générer `images/couverture.png`** (1600×2560). Partir d'un HTML simple, capturé avec Chrome sans interface (`google-chrome --headless --screenshot`), titre et sous-titre seulement.
- [ ] **Step 4 : lancer la vérification.** Run : `bash support-de-cours/scripts/verifier.sh`. Expected : succès, puis `ls support-de-cours/_book/*.pdf support-de-cours/_book/*.epub` affiche les deux fichiers.
- [ ] **Step 5 : écrire `support-de-cours/README.md`.** Il donne les commandes, la table de correspondance source → chapitre (vide pour l'instant) et les huit règles d'adaptation recopiées de la section 6 du spec. Ajouter aussi les tâches au `Taskfile.yml`. Run : `task book:check`. Expected : succès.
- [ ] **Step 6 : commit.** `git add support-de-cours Taskfile.yml docs/superpowers` puis `git commit -m "feat(livre): squelette Quarto du support de cours (PDF et EPUB)"`.

### Task 2 : Partie I · La formation

**Files :** `support-de-cours/partie-1-formation/{index,01-programme,02-programme-detaille,03-parcours-autonome}.qmd`

**Interfaces :**
- Consumes : `verifier.sh` et `_quarto.yml` (tâche 1).
- Produces : `@sec-programme`, `@sec-programme-detaille`, `@sec-parcours-autonome`.

- [ ] **Step 1 : `01-programme.qmd`** depuis `README.md`. Retirer les trois lignes « [à compléter] », dater la séance 5 « janvier 2027 », remplacer les liens d'annexes par des renvois `@sec-…` vers les chapitres des tâches 2 et 5.
- [ ] **Step 2 : `02-programme-detaille.qmd`** depuis `cours/programme-detaille.md`, sections 1 à 12 seulement. Garder la logistique, qui intéresse les responsables. Retirer les décisions internes datées (pre-flight, quotas, état des formulaires) ou les reformuler au futur générique.
- [ ] **Step 3 : `03-parcours-autonome.qmd`** (nouveau, à partir du dépôt uniquement). Il couvre l'ordre de lecture, le projet mené seul ou à deux sur l'un des trois thèmes, ce qui remplace le RSSI et le relecteur (relecture par un pair, fiche de conformité auto-évaluée) et la façon de suivre la formation à l'université (renvoi vers @sec-programme).
- [ ] **Step 4 : lancer la vérification.** Run : `bash support-de-cours/scripts/verifier.sh`. Expected : succès, aucun interdit.
- [ ] **Step 5 : commit.** `git commit -m "feat(livre): partie I, la formation"`.

### Task 3 : Partie II · Séance 1

**Files :**
- `support-de-cours/partie-2-seance-1/index.qmd`
- `support-de-cours/partie-2-seance-1/00-seance-en-bref.qmd`
- `support-de-cours/partie-2-seance-1/01-histoire-du-craft.qmd` … `09-design-patterns.qmd`, un fichier par chapitre de `cours/supports/day-1/`

**Interfaces :**
- Produces :
  - `@sec-histoire-craft`, `@sec-histoire-ia`, `@sec-craft-ia`, `@sec-guide-flutter`, `@sec-pratique-craft-flutter`, `@sec-outils-agentiques`, `@sec-edge-ai`, `@sec-ci-cd`, `@sec-design-patterns`, `@sec-s1-en-bref` ;
  - pour les renvois internes, les sections numérotées gardent leur numéro de titre ; les sous-sections citées ailleurs reçoivent `{#sec-<chapitre>-<n>}`.

- [ ] **Step 1 : `00-seance-en-bref.qmd`** depuis `cours/presentations/day-1/index.html` et `notes.html`, selon la règle 8 du spec : objectifs, déroulé en tableau, idées clés en encadrés, sans régie ni chronomètre.
- [ ] **Step 2 : adapter les 9 chapitres.** Ils sont indépendants : ils peuvent être confiés en parallèle, un sous-agent par lot de 2 ou 3, chacun avec le spec et la liste des `@sec-…` ci-dessus. Pour chacun, appliquer les règles 1 à 7 :
  - « Ce que vous allez retenir » devient un encadré `callout-tip` ;
  - « Points non vérifiés » devient un encadré `callout-note` ;
  - les chemins `/tmp/…` sont retirés des sources.
- [ ] **Step 3 : lancer la vérification.** Run : `bash support-de-cours/scripts/verifier.sh`. Expected : succès. Chaque avertissement de tournure qui reste est relu et soit corrigé, soit gardé parce qu'il décrit le programme.
- [ ] **Step 4 : commit.** `git commit -m "feat(livre): partie II, séance 1"`.

### Task 4 : Partie III · Séance 2, et annexe des fiches

**Files :**
- `support-de-cours/partie-3-seance-2/{index,00-seance-en-bref,01-git-pas-a-pas,02-configurer-claude-code,03-demarrer-le-projet}.qmd`
- `support-de-cours/annexes/a-fiches-pratiques.qmd`

**Interfaces :**
- Consumes : les `@sec-…` de la tâche 3, pour remplacer « chapitre N de la séance 1 ».
- Produces : `@sec-git`, `@sec-configurer-claude-code`, `@sec-demarrer-projet`, `@sec-s2-en-bref`, `@sec-fiches`.

- [ ] **Step 1 : chapitre « La séance en bref »** depuis le diaporama `day-2`.
- [ ] **Step 2 : adapter les chapitres 1 à 3** de `cours/supports/day-2/`, ainsi que `04-fiches-de-seance.md`, qui devient l'annexe A.
- [ ] **Step 3 : vérifier que les titres dans les blocs de code ne fuient pas.** Run : `bash support-de-cours/scripts/verifier.sh && unzip -p support-de-cours/_book/*.epub '*nav.xhtml' | grep -c -E 'Vision|Résumé|Interdits'`. Expected : succès, puis `0`.
- [ ] **Step 4 : commit.** `git commit -m "feat(livre): partie III, séance 2, et fiches pratiques"`.

### Task 5 : Partie IV, séances à venir et glossaire

**Files :**
- `support-de-cours/partie-4-projet/{index,01-themes,02-conformite}.qmd`
- `support-de-cours/partie-5-a-venir/{seance-3,seance-4,seance-5}.qmd`, une partie par séance dans `_quarto.yml`
- `support-de-cours/annexes/b-glossaire.qmd`

**Interfaces :**
- Produces : `@sec-themes`, `@sec-conformite`, `@sec-glossaire`.

- [ ] **Step 1 : `01-themes.qmd`.** Partir de `cours/projets/themes.md`, enrichi de ce que le diaporama `themes` apporte en plus (accroches, exemples) ; dédoublonner les blocs « Trame des séances » répétés pour chaque thème.
- [ ] **Step 2 : `02-conformite.qmd`.** Partir de `cours/conformite-ai-act-rgpd.md` ; la section 0 « Vérification du calendrier » devient un encadré daté.
- [ ] **Step 3 : pages des séances 3 à 5.** Reprendre objectifs et déroulé de la section 4 du programme détaillé, puis ajouter l'encadré « Chapitres à paraître dans une prochaine édition ».
- [ ] **Step 4 : `b-glossaire.qmd`.** Partir des termes de `README.md`, ajouter les entrées des glossaires de chapitre, dédoublonnées et triées par ordre alphabétique, chacune avec un renvoi `@sec-…` vers le chapitre qui la développe.
- [ ] **Step 5 : lancer la vérification.** Run : `bash support-de-cours/scripts/verifier.sh`. Expected : succès.
- [ ] **Step 6 : commit.** `git commit -m "feat(livre): partie IV, séances à venir et glossaire"`.

### Task 6 : règle de maintenance et vérification finale

**Files :**
- Create : `CLAUDE.md` (racine)
- Modify : `support-de-cours/README.md` (table de correspondance complète), `README.md` (une ligne qui présente le livre)

- [ ] **Step 1 : écrire `CLAUDE.md`, en 40 lignes au plus.** Il dit où écrire (`cours/supports/day-N/`, `cours/presentations/<deck>/`) et pose la règle : tout support ou diaporama créé ou modifié est décliné dans `support-de-cours/` dans la même PR. Il renvoie aux règles et à la table de `support-de-cours/README.md`, met à jour la date `synchro:`, et rend `task book:check` vert avant de conclure.
- [ ] **Step 2 : compléter la table de correspondance** : chaque fichier source de `cours/` doit y apparaître. Run : `for f in cours/supports/day-*/0*.md cours/projets/themes.md cours/conformite-ai-act-rgpd.md cours/programme-detaille.md; do grep -q "$f" support-de-cours/README.md || echo "MANQUE $f"; done`. Expected : aucune sortie.
- [ ] **Step 3 : rendu complet.** Run : `task book:check`. Expected : succès. Le PDF et l'EPUB sont présents ; noter le nombre de pages avec `pdfinfo` ou `python -c` (pypdf).
- [ ] **Step 4 : contrôle visuel.** Convertir en images les pages suivantes, puis les regarder : couverture, table des matières, tableau large du programme détaillé, bloc de code long, encadré, page de sources. Commande : `pdftoppm -png -r 60 -f N -l N`, ou capture Chrome du PDF. Corriger tout débordement.
- [ ] **Step 5 : relecture de fidélité.** Un agent indépendant compare trois chapitres tirés au sort à leur source (fond inchangé, tournures de séance retirées, rien d'interne). Corriger ce qu'il relève.
- [ ] **Step 6 : commit.** `git commit -m "docs: règle de maintenance du livre (CLAUDE.md) et correspondance des sources"`.
