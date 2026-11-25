# Livre Quarto « support de cours » · Conception

*25 novembre 2026. Statut : en attente de validation par l'enseignant.*

## 1. Intention

Réunir tout ce qui est rédigé pour l'enseignement « Master ITI · Ingénierie logicielle à l'ère de l'IA agentique » dans un **livre** autonome, compilé en **PDF** (à imprimer et relier) et en **EPUB** (liseuse), qui grandit au fil des séances.

Trois publics, un seul livre :

| Public | Ce qu'il y cherche |
|---|---|
| Étudiants de la formation | Un guide pour suivre le cours, puis une référence pour leur vie professionnelle |
| Responsables pédagogiques | Comprendre le programme : objectifs, déroulé, évaluation, moyens, conformité |
| Lecteurs autonomes (n'ont pas suivi le cours) | Un livre-guide sur le sujet, et le programme de formation s'ils veulent suivre le parcours à l'université |

Règle de travail pour la suite (demande explicite) : chaque nouveau support (`cours/supports/`) et chaque nouveau diaporama (`cours/presentations/`) est aussi décliné en **contenu adapté** dans le livre.

## 2. Objectifs, non-objectifs, anti-objectifs

**Objectifs**

- Un projet Quarto de type `book` dans `support-de-cours/`, qui produit sans erreur un PDF et un EPUB.
- Tout le contenu existant repris et adapté : programme (`README.md`), programme détaillé, thèmes du projet, module RGPD et AI Act, 9 chapitres de la séance 1, 4 chapitres de la séance 2, et le contenu des trois diaporamas (séance 1, séance 2, thèmes).
- Une lecture intemporelle : le livre se lit hors séance, des années après.
- Une règle de maintenance écrite dans un `CLAUDE.md` à la racine du dépôt, que toute session future applique.

**Non-objectifs**

- Ne pas modifier les supports de `cours/` (ils restent la version « séance »).
- Pas de site web publié (le format HTML de Quarto peut servir à la prévisualisation locale, il n'est pas un livrable).
- Pas de conversion des sources en bibliographie BibTeX : les sources restent en fin de chapitre, au format `[S1]` actuel.
- Pas de rédaction des séances 3 à 5, qui n'existent pas encore.

**Anti-objectifs** (ce qui ferait échouer le livre même s'il compile)

- Un livre qui ressemble à une concaténation de notes de séance (« pendant l'atelier », « avant le 27 novembre », « aujourd'hui »).
- Un contenu interne diffusé : la checklist enseignant (`programme-detaille.md`, section 13, « interne, ne pas diffuser aux étudiants »), les chemins locaux du poste de rédaction (`/tmp/claude-…`), toute donnée personnelle.
- Perdre l'honnêteté des supports : les « points non vérifiés » et les dates d'état des outils doivent rester visibles.
- Un PDF illisible à l'impression : tableaux qui débordent, blocs de code coupés, liens seulement cliquables.

## 3. Contraintes constatées

- Quarto 1.8.26 et TinyTeX (`~/.TinyTeX`) sont installés sur le poste ; le PDF passe par LaTeX.
- Les supports sont en Markdown, avec beaucoup de tableaux, de blocs de code (dont des blocs `markdown` contenant des titres `##`) et des sources numérotées.
- Les diaporamas sont des pages HTML maison (`cours/presentations/<deck>/index.html` + `notes.html`), sans Markdown réutilisable : leur contenu est à réécrire.
- Chaque chapitre de support compte de 6 à 21 tournures liées à la séance ou datées.
- Licence du dépôt : propriétaire, tous droits réservés (Benoît Fontaine). Le livre porte la même mention.

## 4. Approches envisagées

| Approche | Avantage | Inconvénient |
|---|---|---|
| **Copie adaptée** (retenue) | Meilleure lecture : ton intemporel, renvois croisés Quarto, encadrés | Deux versions à tenir à jour ; risque de divergence |
| Inclusion directe (`{{< include >}}`) | Une seule source, aucune divergence | Ton de séance conservé, renvois approximatifs |
| Source unique balisée et filtrée | Pas de divergence, bonne lecture | Retouche de tous les supports existants et discipline d'écriture lourde pour les suivants |

**Choix de l'enseignant : copie adaptée.** Le risque de divergence est traité par la règle du `CLAUDE.md` (section 8) : toute modification d'un support entraîne celle du chapitre du livre dans la même PR.

## 5. Structure du livre

```
support-de-cours/
├── _quarto.yml            configuration du livre, formats pdf et epub
├── index.qmd              Avant-propos
├── partie-1-formation/    Partie I · La formation
├── partie-2-seance-1/     Partie II · Séance 1 · Comprendre et s'équiper
├── partie-3-seance-2/     Partie III · Séance 2 · Git, configurer son assistant, lancer le projet
├── partie-4-projet/       Partie IV · Le projet fil rouge et la conformité
├── partie-5-a-venir/      Parties des séances 3 à 5 (pages d'annonce)
├── annexes/               Fiches pratiques, glossaire
├── images/                Images copiées depuis cours/
├── styles/                epub.css, préambule LaTeX
└── README.md              Comment compiler, comment ajouter un chapitre
```

Contenu, dans l'ordre de lecture :

1. **Avant-propos** (`index.qmd`, nouveau) : à qui s'adresse le livre ; trois parcours de lecture (étudiant, responsable pédagogique, lecteur autonome) ; réserves (rédaction assistée, points non vérifiés, outils datés) ; édition et date de version.
2. **Partie I · La formation** : programme (depuis `README.md`, sans les champs « [à compléter] ») ; programme détaillé adapté (`programme-detaille.md`, sections 1 à 12, **sans la section 13**) ; un court chapitre nouveau « Suivre le parcours en autonome » (comment refaire le projet seul ou à deux, ce qui change sans encadrant ni RSSI, et comment rejoindre la formation à l'université).
3. **Partie II · Séance 1** : un chapitre d'ouverture « La séance en bref » adapté du diaporama `day-1` et de ses notes (objectifs, déroulé, idées clés), puis les 9 chapitres de `cours/supports/day-1/`.
4. **Partie III · Séance 2** : chapitre d'ouverture adapté du diaporama `day-2`, puis les chapitres 1 à 3 de `cours/supports/day-2/`. Les fiches (chapitre 4) vont en annexe.
5. **Partie IV · Le projet fil rouge et la conformité** : les trois thèmes (`cours/projets/themes.md`, enrichi du diaporama `themes`), puis le module RGPD et AI Act (`cours/conformite-ai-act-rgpd.md`).
6. **Séances 3, 4 et 5** : une page de partie par séance, avec objectifs et déroulé tirés du programme détaillé, et la mention « chapitres à paraître dans une prochaine édition ». Elles disparaissent au profit des vrais chapitres quand ceux-ci sont rédigés.
7. **Annexes** : les fiches pratiques de la séance 2 (`04-fiches-de-seance.md`) ; un glossaire général (termes du `README.md` complétés par les entrées des glossaires de chapitre, dédoublonnées).

Les glossaires, sources et points non vérifiés de chaque chapitre restent en fin de chapitre.

## 6. Règles d'adaptation d'un support en chapitre de livre

1. **Ton intemporel.** « Pendant l'atelier » devient « en formation » ou « en pratique » ; « avant le 27 novembre » disparaît ou devient « avant la séance 2 » ; les consignes adressées à la promotion 2026-2027 deviennent des conseils au lecteur.
2. **Dates conservées quand elles datent un fait.** « État des outils au 19 novembre 2026 » reste, dans un encadré en tête de chapitre.
3. **Renvois croisés Quarto.** « Chapitre 4 de la séance 1 » devient `@sec-guide-flutter` ; chaque chapitre a un identifiant `#sec-…` stable.
4. **Encadrés Quarto.** « À retenir » → `callout-tip` ; avertissements → `callout-warning` ; points non vérifiés → `callout-note` titré.
5. **Liens imprimables.** Les URL des sources restent écrites en clair (le PDF imprimé n'a pas de lien cliquable).
6. **Nettoyage.** Pas de chemin local, pas de section interne, pas de donnée personnelle ; liens relatifs vers `cours/` remplacés par des renvois internes.
7. **Fidélité.** Pas d'ajout de contenu factuel non sourcé ; on adapte la forme, pas le fond. Un fait du support qui paraît faux est signalé à l'enseignant, pas corrigé en silence.
8. **Diaporama → prose.** Le contenu d'un diaporama et de ses notes devient un chapitre « La séance en bref » : objectifs, déroulé (tableau), idées clés en encadrés, schémas utiles redessinés ou capturés. Les consignes de régie (chronomètre, transitions) ne sont pas reprises.

Chaque chapitre du livre commence par un commentaire HTML qui indique sa source et la date de synchronisation :

```html
<!-- source: cours/supports/day-2/01-git-pas-a-pas.md · synchro: 2026-11-25 -->
```

## 7. Rendu

- **PDF** : classe `scrbook` (KOMA-Script), A4, recto verso (`twoside`, marge intérieure élargie pour la reliure), table des matières, numérotation des sections, polices libres avec accents et glyphes de code (moteur `lualatex` ou `xelatex`), tableaux larges en petite police plutôt que débordants, blocs de code avec retour à la ligne.
- **EPUB** : couverture (image générée), feuille de style légère, table des matières, renvois fonctionnels.
- **Métadonnées** : titre « Ingénierie logicielle à l'ère de l'IA agentique », sous-titre « Créer avec l'IA, dialoguer avec les développeurs », auteur Benoît Fontaine, Master ITI, Nantes Université, édition 2026-2027, `lang: fr`, mention de licence.
- **Sorties** : `support-de-cours/_book/` (ignoré par git).
- **Commandes** : `quarto render support-de-cours` ; tâches `task book`, `task book:pdf`, `task book:epub` dans `Taskfile.yml`.

## 8. Règle de maintenance (`CLAUDE.md` à la racine)

Le dépôt n'a pas de `CLAUDE.md`. On en crée un, court, qui fixe :

- **Où écrire** : nouveaux supports dans `cours/supports/day-N/`, nouveaux diaporamas dans `cours/presentations/<deck>/`.
- **La règle** : tout support ou diaporama créé ou modifié l'est aussi dans `support-de-cours/` dans la même PR, selon les règles d'adaptation de la section 6 (reprises dans `support-de-cours/README.md`).
- **La table de correspondance** source → chapitre (tenue dans `support-de-cours/README.md`).
- **La vérification** : `quarto render support-de-cours` sans erreur avant de conclure.

## 9. Vérification

- `quarto render support-de-cours --to pdf` et `--to epub` sans erreur ni avertissement de renvoi non résolu.
- Recherche des tournures interdites dans `support-de-cours/**/*.qmd` (« pendant la séance », « aujourd'hui », « avant le », `/tmp/`, « Checklist enseignant ») : chaque occurrence restante est justifiée.
- Contrôle visuel de pages du PDF (couverture, table des matières, un tableau large, un bloc de code long, un encadré) et ouverture de l'EPUB.
- Relecture indépendante, par un agent séparé, d'un échantillon de chapitres comparés à leur source (fidélité du fond).

## 10. Décisions prises après relecture

| Question | Décision | Par |
|---|---|---|
| Champs vides du programme (responsable, rattachement et ECTS, lieu) | Omis du livre ; la séance 5 est datée « janvier 2027 ». Ils reviendront quand le `README.md` sera complété | Enseignant |
| Découpage du travail | Une branche, une PR ; un commit par jalon (squelette qui compile, partie I, partie II, partie III, partie IV et annexes, `CLAUDE.md`). Le livre doit compiler à chaque jalon | Mon choix |
| Contenu nouveau (avant-propos, « La séance en bref », « Suivre le parcours en autonome ») | Rédigé uniquement à partir du dépôt (programme, diaporamas et leurs notes, supports), sans fait extérieur ; signalé à l'enseignant pour relecture dans le compte rendu final, sans bloquer le travail | Mon choix |
| Mention de licence | Reprise du texte de `LICENSE` (« Tous droits réservés », Benoît Fontaine) en page de copyright et dans les métadonnées | Mon choix |
| Images tierces de `cours/sources/` (dont `craft-ai/`) | Non reprises : ce sont des sources de travail, aucun support ne les affiche. Seules les images créées pour le cours (`cours/images/`) peuvent l'être | Mon choix |
| Schémas des diaporamas | Traduits en prose ou en tableaux ; un schéma Mermaid seulement s'il apporte une structure que la prose ne porte pas (Chrome est installé pour le rendu PDF) | Mon choix |
| Avertissements LaTeX | Les erreurs et renvois non résolus sont bloquants ; les `overfull hbox` sont tolérés tant que rien ne déborde visiblement de la page lors du contrôle visuel | Mon choix |

## 11. Laissé au constructeur

- Le choix exact des polices et du moteur LaTeX, du moment qu'accents, code et symboles passent.
- La génération de la couverture EPUB.
- Le découpage en fichiers et les identifiants `#sec-…`.
- La sélection des images reprises de `cours/images/` et `cours/sources/craft-ai/`.
- Le traitement des blocs Gherkin, Dart et Markdown (coloration disponible ou non).
