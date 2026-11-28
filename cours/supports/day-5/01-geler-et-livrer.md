# Chapitre 1 · Geler et livrer : de `v1.0-rc` à `v1.0`

*Séance 5 « Retouches et soutenance » · Master ITI, Nantes Université, 2026-2027. Chapitre à lire avant ou après la séance ; les sections 2 à 6 concernent la fin du sprint et se lisent avant le dépôt de `v1.0-rc`. Les commandes git ont été exécutées le 27 novembre 2026 sous Linux (git 2.53.0, Flutter 3.50.1, Dart 3.14.0), sur une copie du dépôt-modèle placée hors du dépôt du cours, avec un dépôt distant local : rien n'a été écrit sur GitHub ; quelques commandes `gh` ont été essayées en lecture seule sur le dépôt du cours.*

Ce chapitre accompagne la fin du sprint et les blocs 1, 2 et 3 de la séance : le briefing, les retouches bloquantes, le gel du code. Il répond au premier objectif de la séance : geler un périmètre et livrer une version stable, en assumant ce qui est laissé de côté. Vous n'y apprenez presque aucun geste nouveau : poser un tag, ouvrir une PR, tester un `README` à froid, vous l'avez déjà fait. Ce qui est nouveau, c'est l'ordre, les échéances, et le fait que quelqu'un d'autre lira votre dépôt sans vous. L'exemple suivi est le dépôt `equipe_04`, du thème B, comme en séance 4.

## Ce que vous allez retenir

- Deux tags, deux moments : `v1.0-rc` avec le dossier de rendu, l'avant-veille de la séance à 18h ; `v1.0` en début de séance, avant le premier passage.
- Deux gels : le **gel des fonctionnalités**, au plus tard une semaine avant la séance (ensuite : correctifs, documentation, préparation de la démonstration), et le **gel du code**, en séance (« à partir de là, on ne pousse plus »).
- Le dossier de rendu compte sept pièces, toutes dans le dépôt ou sur sa page GitHub. Chacune se prouve par un écran, une commande ou un fichier qui existe, sans lire de code.
- Un tag se pose sur le dernier commit de `main`, après `git pull`, quand sa pastille de CI est verte. La CI ne tourne pas « sur un tag » : elle se lit sur le **commit tagué**.
- git refuse par défaut de déplacer un tag déjà poussé, et on ne force jamais. On vérifie donc **avant** de pousser, on prouve après.
- En séance, seuls des correctifs bloquants sont autorisés, et chacun passe par une PR relue, contrôles verts, comme tout le reste. Aucune nouvelle fonctionnalité.
- Le programme demande de décider explicitement ce qu'on abandonne et de l'assumer ; il ne dit pas comment une story abandonnée est comptée.

---

## 1. Pourquoi ce chapitre

Le programme pose le principe du rendu en deux phrases, citées mot pour mot : « Le **tag `v1.0-rc` et le dossier de rendu sont déposés l'avant-veille de S5 à 18h**, pour que l'enseignant lise les dépôts avant la séance. Au début de S5, seuls des correctifs bloquants sont autorisés avant le tag final `v1.0`. » Le premier objectif de la séance dit ce que l'on attend de vous : l'étudiant « gèle un périmètre et livre une version stable (`v1.0`), en assumant ce qui est laissé de côté ».

Les gestes ont déjà été enseignés. On ne les redit pas, on y renvoie :

| Geste | Où il a été vu |
|---|---|
| Ce qu'est un tag, ce que veut dire `-rc` (*release candidate*, candidat à la version finale) | Chapitre 8 de la séance 1, section 8.1 |
| Poser et pousser un tag (`s2-fin`) | Chapitre 3 de la séance 2, section 11.2 |
| Tag et release `v0.1`, la CI lue sur le commit tagué | Chapitre 2 de la séance 4, section 10 |
| La protection de `main` | Chapitre 3 de la séance 2, section 10.3 |
| La CI obligatoire, constatée ; lire un contrôle rouge sans lire le code | Chapitre 2 de la séance 4, sections 4.3 et 7 |
| Le test du `README` à froid | Chapitre 3 de la séance 4, section 7.1 |
| La décision du RSSI, ses conditions, la rubrique 13, le calendrier de la fiche | Chapitre 4 de la séance 4, sections 9 et 10 |
| L'« État courant » de `JOURNAL.md` ; le modèle de PR et ses lignes de suivi | Chapitre 3 de la séance 2, sections 11.1, 9.2 et 9.3 |

Ce que ce chapitre ajoute : le calendrier des derniers jours (section 2), la façon d'assumer un périmètre réduit (section 3), le dossier de rendu pièce par pièce (section 4), les deux tags (sections 5 et 9), la vérification « comme un évaluateur » (section 6) et les trois premiers blocs de la séance (sections 7 à 9). Les gestes condensés sont dans les fiches W (avant la séance) et X (en séance) du chapitre 4. Une différence avec la séance 4 : le programme ne demande pas de release GitHub pour `v1.0` : le tag suffit.

> **À retenir.** Vous savez déjà faire chaque geste. La difficulté est de les faire dans l'ordre, à l'heure, sur le bon commit.

---

## 2. Le calendrier de la fin du sprint

Le programme donne le calendrier du sprint en une phrase (section 5). Sa fin, mot pour mot : « **au plus tard une semaine avant S5**, réponse du RSSI et **gel des fonctionnalités au soir** (ensuite : correctifs, documentation, préparation de la démonstration) ; **l'avant-veille de S5 à 18h**, tag `v1.0-rc` et dossier de rendu ; **la veille de S5**, lecture des dépôts par l'enseignant et communication des PR tirées au sort avant 9h. »

La séance 5 a lieu le vendredi 29 janvier 2027 après-midi (de 13h45 à 17h45). Les trois échéances qui la précèdent se déduisent de cette date :

| Quand (formule du programme, puis date) | Ce qui se passe | Ce qui est encore permis ensuite |
|---|---|---|
| Au plus tard une semaine avant la séance 5, soit le **vendredi 22 janvier 2027** | Réponse du RSSI ; **gel des fonctionnalités au soir** | « correctifs, documentation, préparation de la démonstration » |
| L'avant-veille de la séance 5 à 18h, soit le **mercredi 27 janvier 2027 à 18h** | Tag `v1.0-rc` et dossier de rendu déposés | Voir la remarque sous le tableau |
| La veille de la séance 5 avant 9h, soit le **jeudi 28 janvier 2027 avant 9h** | PR tirées au sort communiquées aux étudiants ; ce jour-là, lecture des dépôts par l'enseignant | Préparer sa PR (chapitre 3, sections 3 et 4) |
| **Vendredi 29 janvier 2027**, début de séance | Briefing (bloc 1), retouches bloquantes (bloc 2) | Correctifs bloquants, documentation, mise à jour de la fiche, finition ; aucune nouvelle fonctionnalité |
| Vendredi 29 janvier 2027, avant le premier passage | Gel du code, tag `v1.0` (bloc 3) | Rien : « à partir de là, on ne pousse plus » |

**Entre `v1.0-rc` et le début de la séance**, le programme ne dit pas ce qui est permis ; proposition des supports : appliquer déjà la règle du bloc 2. L'enseignant lit votre dépôt le jeudi : ce que vous fusionnez après le tag, il ne l'a peut-être pas lu.

Avant la séance, le programme demande aussi une **répétition de la démonstration** : « une fois, en équipe, avec chronomètre » (chapitre 2, section 10). Il ne donne pas d'horaire aux blocs de la séance : ce sont des blocs pondérés, pas un minutage. Les blocs 1 et 2 sont **Importants**, le bloc 3 est **Indispensable**.

> **À retenir.** Le gel des fonctionnalités a lieu une semaine avant la séance, pas la veille. Les derniers jours servent à corriger, documenter et répéter.

---

## 3. Geler les fonctionnalités et assumer ce qu'on laisse de côté

### 3.1 Ce que dit le programme

Le sprint a un objectif (programme, section 5) : « terminer le périmètre décidé en S4 (clou niveau 1 avec son test d'acceptation vert, éléments souhaitables retenus), corriger les constats de l'audit croisé, **finaliser la fiche de conformité et obtenir la réponse du RSSI**, stabiliser. »

Il se pilote avec le backlog à trois colonnes rempli à la fin de la séance 4 (fiche U). Mot pour mot : « **Backlog priorisé** : essentiel, souhaitable, **abandonné**. L'équipe décide explicitement de ce qu'elle abandonne. Chaque thème fournit un « livrable minimum viable ». Si l'équipe est en retard, le CRUD se limite à la création et à la lecture, et le seed complet cède avant l'import CSV. »

Le socle commun (programme, section 8) donne l'ordre dans lequel le souhaitable se sacrifie : « export CSV (avec la neutralisation des formules vue en S4), tableau de bord, clou niveau 2 (bonus plafonné à 1 point) ». Et le sprint a une règle de prudence : « ne pas commencer un gros chantier au dernier moment. »

### 3.2 Le livrable minimum viable de votre thème

Chaque énoncé (`cours/projets/themes.md`) dit ce qu'il reste quand on a tout réduit. Mot pour mot :

| Thème | Livrable minimum viable |
|---|---|
| **A** · Les Marches de Cendrelune | « inscription d'un passeur, jugement d'une traversée avec les règles 1 à 6, fiche avec historique, contrôle d'accès, CI verte, import CSV des passeurs, une page `docs/monde.md`, fiche de conformité déposée et soumise au RSSI. Sans le registre filtrable, l'export ni les vues 3 et 4. » |
| **B** · Ligne 4 (exemple suivi) | « quart, déclaration, arrêts, TRS avec les règles 1 à 6 sur le cas nominal et les cas dégénérés, vue 1, CI verte, fiche de conformité déposée et soumise au RSSI. L'import CSV des déclarations fait partie du socle obligatoire ; sans Pareto et sans test du changement d'heure si l'équipe est en retard (mais le cas 8 reste écrit). » |
| **C** · Vœux de projet | « création des sujets, import des étudiants et de leurs vœux, répartition avec les règles 1 à 5, affichage des affectations et des motifs, explication par étudiant, rôles de base, statut `brouillon` / `publie`, CI verte, fiche de conformité déposée et soumise au RSSI. Sans statut de sujet, sans vue de satisfaction ni export. » |

Proposition, au-delà du programme, pour le soir du gel des fonctionnalités : tranchez en équipe une seule question. Ce qui n'est pas encore fusionné dans `main` est-il un **correctif** (il continue) ou une **fonctionnalité** (elle s'arrête là, et passe dans la colonne « abandonné ») ?

### 3.3 Écrire ce qu'on abandonne

« L'équipe décide explicitement » : une décision explicite s'écrit. Votre dépôt a déjà deux endroits prévus pour cela.

- **`PROJET.md`**, rubrique « Décisions de l'équipe » : « Une ligne par décision : date, ce qui est décidé, qui a décidé, pourquoi. » Le même fichier demande que les stories écartées restent visibles, « barrées, avec la raison dans « Décisions de l'équipe » ».
- **`JOURNAL.md`**, rubrique « Décisions et apprentissages » : « Une entrée par décision ou par apprentissage : date, ce qui a été décidé ou appris, pourquoi. »

Proposition, au-delà du programme : une ligne par élément abandonné dans `PROJET.md`, et l'issue correspondante fermée avec la mention « abandonné » et sa raison (c'est ce que le chapitre 3 de la séance 4, section 9.3, prévoit déjà pour un constat d'audit non corrigé). Exemple pour `equipe_04`, **rédigé pour ce chapitre** :

```markdown
## Décisions de l'équipe

- 22/01/2027 : la vue Pareto des pertes est abandonnée pour la v1.0. Décidé par
  l'équipe, au gel des fonctionnalités. Pourquoi : l'import CSV (socle
  obligatoire) n'était pas terminé ; l'énoncé prévoit ce retrait en cas de retard.
- 22/01/2027 : l'export CSV est abandonné (souhaitable, premier élément à
  sacrifier d'après le programme). Pourquoi : il aurait fallu le test de
  neutralisation des formules, soit un chantier de plus après le gel.
```

Le 22/01/2027 de l'exemple est la date déduite du gel des fonctionnalités (« au plus tard une semaine avant S5 »). Ces lignes passent par une PR, comme tout le reste, avant `v1.0-rc`. Aucun nom complet : « décidé par l'équipe » ou un rôle suffit. Pourquoi dans `PROJET.md` : la grille regarde, pour la fonctionnalité, si « les user stories annoncées sont livrées », avec `PROJET.md` pour support. Ce que `PROJET.md` annonce et ce que la démonstration montre doivent donc concorder. Le programme ne dit pas comment une story abandonnée et déclarée est comptée : voir « Points non vérifiés ».

> **Attention.** Ce qui ne s'abandonne pas : le socle obligatoire (programme, section 8), dont l'import CSV, le clou niveau 1 et ses cas d'acceptation, les mesures de conformité du thème, la fiche et la réponse du RSSI. Un cas d'acceptation resté rouge ne se supprime pas et ne s'assouplit pas : il reste rouge, et vous le dites.

> **À retenir.** Geler, c'est arrêter d'ajouter. Assumer, c'est une ligne datée dans `PROJET.md` qui dit quoi et pourquoi, et la capacité de le redire en soutenance (chapitre 2, section 9).

---

## 4. Le dossier de rendu, pièce par pièce

Le programme le définit en une phrase (section 7), mot pour mot : « **Dossier de rendu** (tag `v1.0-rc` l'avant-veille de S5 à 18h, puis `v1.0` au début de S5) : dépôt à jour, `README` d'installation, `CLAUDE.md`, `docs/ARCHITECTURE.md` (une page : composants, modèle de données, décisions), `docs/fiche_conformite.md` (avec réponse du RSSI), `JOURNAL.md`, et les PR avec leurs sections de suivi. »

Sept pièces : le dépôt lui-même, cinq fichiers qu'il contient, et les PR, qui se lisent sur sa page GitHub. Le programme écrit seulement « déposés » ; lecture de ce chapitre : le dossier est l'état du dépôt à l'endroit du tag. Pour chaque pièce, on donne ce que dit le programme, le critère de la grille sur 20 concerné, et la preuve observable. **La preuve observable est à chaque fois une proposition de ce chapitre**, tirée de la grille et de la definition of done. La grille complète est au chapitre 3, section 8.

### 4.1 Le dépôt à jour

**Ce que dit le programme.** « dépôt à jour », sans plus de détail.

**Le critère.** « Process git et équipe » (2 points) : « Commits petits et lisibles, PR relues, issues, branches courtes, pas de push direct, traçabilité des décisions ». « Qualité, sécurité et livraison » (3 points) : « CI verte sur le tag, audit croisé traité (issues priorisées, constats corrigés ou justifiés) ».

**La preuve observable.** Proposition de lecture : « à jour » veut dire que tout ce que l'équipe veut voir évalué est **fusionné dans `main`**. Un tag désigne un commit de `main` ; ce qui est resté sur une branche ou dans une PR ouverte n'est pas dans le rendu.

- Sur chaque poste, `git status` sur `main` répond « Votre branche est à jour avec 'origin/main'. » et « rien à valider, la copie de travail est propre » (sortie en section 5.2).
- Onglet *Pull requests* : aucune PR ouverte que l'équipe compte faire évaluer. Une PR que l'on abandonne se ferme, avec une phrase qui dit pourquoi.
- Onglet *Issues* : chaque constat de l'audit croisé est fermé par une PR, ou reste ouvert avec sa priorité et, le cas échéant, la mention « abandonné » et sa raison (chapitre 3 de la séance 4, section 9.3).
- Page d'accueil du dépôt : une coche verte à côté du dernier commit de `main`.

### 4.2 Le `README` testé à froid

**Ce que dit le programme.** La definition of done : « le `README` testé à froid (`git clone`, `flutter pub get`, `flutter run -d chrome`) permet de lancer l'application en moins de 10 minutes ».

**Le critère.** « Qualité, sécurité et livraison » : « `README` testé à froid en moins de 10 minutes ».

> **Attention.** La liste entre parenthèses de la definition of done ne cite pas la génération du code. Sur un clone neuf, sans `dart run build_runner build --delete-conflicting-outputs`, `flutter test` échoue à la compilation. C'est vérifié sur le dépôt-modèle : on obtient par exemple `Error: 'JetLigne' isn't a type.`, puis `Some tests failed.` Les fichiers générés ne sont pas versionnés, et le `README` du dépôt-modèle le dit : « relancez `build_runner` après chaque clone ». **Suivez le `README` de votre dépôt**, qui donne cinq commandes après le clone (`flutter pub get`, la génération, `flutter test`, `flutter analyze`, `flutter run -d chrome`), et vérifiez qu'aucune n'en a disparu.

**La preuve observable.** L'application ouverte dans Chrome, sur un clone neuf, en moins de 10 minutes. La méthode est celle du point « Installation à froid » de l'audit croisé (chapitre 3 de la séance 4, section 7.1) : un dossier vide, un chronomètre, les commandes **dans l'ordre où le `README` les donne**, et l'arrêt du chronomètre quand le premier écran s'affiche. La section 6.1 le fait à partir du tag.

« À froid » veut dire sans rien savoir d'avance. Proposition : le test est fait par un membre qui n'a pas écrit le `README`, si possible sur un poste qui n'a pas servi au développement ces derniers jours ; il note le temps mesuré, la date et le système du poste dans `JOURNAL.md`. Dans une équipe de 5, le programme confie le « README testé à froid » au gardien de la démonstration.

Repère de durée : sur le poste de rédaction, le clone et les trois premières commandes ont pris **45 secondes au total** sur le dépôt-modèle nu (`Built with build_runner/aot in 29s; wrote 83 outputs.`, puis `00:02 +32: All tests passed!`). Les bibliothèques étaient déjà en cache : un poste qui les télécharge pour la première fois met plus longtemps, et votre dépôt a plus de tests. `flutter analyze`, rejoué à part, répond `No issues found!` ; `flutter run -d chrome` n'a pas été rejoué pour ce chapitre. À relire dans votre `README` (proposition) : le tableau « Démarrer » du dépôt-modèle annonce l'écran « Jets de dé » ; si votre application ouvre un autre écran, la colonne « Ce que vous devez voir » doit le dire. Ajoutez l'adresse de la version web publiée (chapitre 2 de la séance 4, section 5.3).

### 4.3 `CLAUDE.md`

**Ce que dit le programme.** La règle du jeu n° 9 : « **`CLAUDE.md` est maintenu.** Toute règle apprise y est ajoutée. »

**Le critère.** « Harnais et tests » (2 points) : « `CLAUDE.md` utile et à jour, permissions (dont `test/acceptance/**` protégé), hooks, tests pertinents (unitaires, intégrité, scénarios BDD, acceptation), aucun test supprimé ou assoupli ».

**La preuve observable.** `CLAUDE.md` est un texte en français : il se relit sans lire de code. Trois vérifications.

- **Il a vécu.** Sur GitHub, ouvrez le fichier, puis *History* : vous devez voir les PR qui l'ont modifié depuis la séance 2. En ligne de commande, `git log --oneline -- CLAUDE.md` donne la même liste. Sur la copie du dépôt-modèle, jamais modifiée, la réponse tient en une ligne, `b53f271 Dépôt d'équipe créé depuis le modèle` : si votre dépôt ne répond qu'une ligne lui aussi, `CLAUDE.md` est encore celui du premier jour.
- **Il est juste.** Les commandes de sa rubrique « Commandes » sont celles de votre `README`. La consigne sur `test/acceptance/` y est (chapitre 1 de la séance 4, section 9.2).
- **Il est utile.** Proposition : relisez vos PR étiquetées `erreur-agent` (section 4.7). Pour chacune, une règle a-t-elle été ajoutée à `CLAUDE.md` pour que l'erreur ne se reproduise pas ? C'est le sens de « toute règle apprise y est ajoutée ».

### 4.4 `docs/ARCHITECTURE.md`

**Ce que dit le programme.** « `docs/ARCHITECTURE.md` (une page : composants, modèle de données, décisions) ».

**Le critère.** La grille ne nomme pas ce fichier. Il sert « Harnais et tests » (c'est le contexte que lit l'agent), le point « données » de « Données et conformité » (« modèle cohérent, contraintes, migrations rejouables »), et le passage « sous le capot » de la soutenance, qui présente « une décision sur les données » (chapitre 2, section 6).

**Un écart à connaître.** Le fichier fourni par le dépôt-modèle n'a pas cette forme : il compte neuf sections, répond à « où ranger quoi » (chapitre 3 de la séance 2, section 5.2) et dépasse largement une page. Le programme ne dit pas s'il faut le réécrire, le compléter ou en tirer une page de synthèse. Ce chapitre ne tranche pas : **demandez à l'enseignant** avant le gel des fonctionnalités.

**La preuve observable**, quelle que soit la forme retenue. Un lecteur qui ouvre le fichier doit y trouver, sans chercher dans le code :

- **vos composants** : les fonctionnalités de votre application (les dossiers de `lib/features/`), et plus seulement l'exemple `jets` ;
- **votre modèle de données** : les tables de votre thème et ce qui les relie (la section 7 du fichier fourni, « La base de données (drift) », annonce « les tables du thème, et le retrait de `jets` ») ;
- **vos décisions** : au moins celle que vous présenterez en soutenance, avec sa raison.

Proposition de vérification rapide : cherchez dans le fichier le nom de votre table principale et celui de votre fonctionnalité principale. S'ils n'y figurent pas, le fichier décrit encore le dépôt-modèle, pas votre projet.

### 4.5 La fiche de conformité et la réponse du RSSI

**Ce que dit le programme.** La definition of done : « La fiche de conformité est complète (13 rubriques) et contient la **réponse du RSSI** datée (go, go sous conditions avec actions, ou no-go assumé avec les raisons). »

**Le critère.** « Données et conformité », 2 points de conformité : « fiche de conformité complète et honnête (13 rubriques), justification du niveau de risque AI Act, mesures réellement présentes dans l'application (accès par rôle testé, mesures propres au thème, durée de conservation), le rôle AI Act (fournisseur ou déployeur) et la case de classement justifiés, **réponse du RSSI datée** et suites données aux conditions, limites d'usage écrites ».

**La preuve observable.** Le contenu des rubriques et la lecture de la décision sont au chapitre 4 de la séance 4 (sections 6 et 9). Ici, seulement ce qui se vérifie avant le tag :

| Ce que regarde la grille | Preuve observable |
|---|---|
| 13 rubriques | `docs/fiche_conformite.md` s'ouvre ; les rubriques 1 à 13 ont toutes un texte après les deux-points |
| Réponse du RSSI datée | La rubrique 13 porte une date, une décision (go, go sous conditions, no-go) et, s'il y en a, les conditions ; le RSSI y est désigné par son rôle, jamais par son nom |
| Suites données aux conditions | Chaque condition a son issue, fermée par une PR (chapitre 4 de la séance 4, section 9.2) |
| Mesures réellement présentes | La mesure propre au thème se **voit dans l'application** : en thème B, la consigne « aucun nom » affichée dans le formulaire de commentaire d'arrêt (chapitre 3 de la séance 4, section 7.5) |
| Limites d'usage écrites | La rubrique 12 complète la phrase « n'utilisez pas cet outil pour... » |
| Aucun nom civil, aucun courriel | Courriel : la recherche du chapitre 3 de la séance 4, section 7.5, ne répond rien. Noms civils : relire l'en-tête et les rubriques 3 et 13 (même section) |

**Si la réponse du RSSI n'est pas arrivée.** Le programme est net (section 10) : « absence de réponse = no-go par défaut » ; et, dans ses parades (section 11) : « pas de réponse = no-go par défaut, l'équipe documente l'attente ». On n'écrit donc pas « go » à la place du RSSI. Proposition pour documenter l'attente : dans la rubrique 13, la date de dépôt de la v1 et la mention « sans réponse à ce jour : no-go par défaut », et la même ligne datée dans `JOURNAL.md`. Si la réponse arrive après `v1.0-rc`, le bloc 2 de la séance prévoit la « mise à jour de la fiche de conformité (dont la réponse du RSSI) » (section 8).

Lecture de ce chapitre, à confirmer par l'enseignant : un no-go assumé n'est pas un échec, puisque la definition of done accepte un « no-go assumé avec les raisons » et que la grille note une fiche « complète et honnête » et des « suites données aux conditions », pas l'obtention d'un go (chapitre 2, section 8).

### 4.6 `JOURNAL.md`

**Ce que dit le programme.** La definition of done : « `JOURNAL.md` est à jour ».

**Le critère.** « Process git et équipe » : la « traçabilité des décisions ».

**La preuve observable.** En tête du fichier, la rubrique « État courant » porte une date de la fin du sprint, et ses cinq lignes (où on en est, prochaine étape, commandes clés, décisions, reste à faire) décrivent l'état que vous taguez ; sa forme est celle du chapitre 3 de la séance 2, section 11.1. Plus bas, « Décisions et apprentissages » contient ce que le sprint a décidé : la décision du RSSI et ses conditions, les abandons (section 3.3), le plan B de publication s'il a servi (chapitre 2 de la séance 4, section 9), le temps du test à froid. Le journal passe par une PR, fusionnée **avant** le tag. C'est la dernière PR du sprint : prévoyez un relecteur disponible.

### 4.7 Les PR et leurs sections de suivi

**Ce que dit le programme.** La definition of done : « les PR portent leur section « ce que l'agent a proposé, ce que j'ai refusé » et leurs temps ». La règle de transparence, première des cinq règles d'usage de l'IA, en donne le détail : elle est citée en entier au chapitre 3, section 7.

**Le critère.** « Process git et équipe » : « **deux cas d'erreur d'agent documentés** dans les PR (étiquette `erreur-agent`), contrôlés en soutenance ». « Soutenance » (1 point) : « compilation des mesures (temps estimé, réel, retouches) ».

**La preuve observable.** Cette pièce n'est pas dans le tag : les PR vivent sur GitHub, pas dans les fichiers du dépôt, et un clone ne les contient pas. C'est parmi elles que sont tirées au sort les PR de l'oral (chapitre 3, section 3).

- Onglet *Pull requests*, filtre sur les PR fermées : ouvrez chaque PR fusionnée. Les rubriques « Ce que l'agent a proposé, ce que j'ai refusé » et « Suivi » du modèle sont remplies, avec les trois lignes de suivi (temps estimé, temps réel, retouches).
- Les cas d'erreur d'agent se retrouvent par leur étiquette `erreur-agent` : vous devez en compter **au moins deux**. La commande qui les liste est au chapitre 2, section 7.4.

> **Attention.** Proposition : complétez les sections vides avant `v1.0-rc`, sans rien reconstituer : un temps que personne n'a noté s'écrit « non mesuré ». N'inventez ni un temps, ni un refus, ni un cas d'erreur. Le programme est explicite : « Un usage caché ou des cas d'erreur inventés sont sanctionnés, un usage franc ne l'est jamais. » La compilation de ces mesures pour la soutenance est au chapitre 2, section 7 ; la préparation de la PR tirée au sort, au chapitre 3, section 4.

> **À retenir.** Sept pièces, sept preuves. Si une preuve ne peut pas être montrée à l'écran, la pièce n'est pas prête.

---

## 5. Poser le tag `v1.0-rc`

### 5.1 Les conditions

Le programme fixe l'échéance (l'avant-veille de la séance à 18h) et deux exigences : la CI est verte sur le tag, et le dossier de rendu est déposé avec lui. Liste de vérifications avant de taguer, **proposée par ce chapitre** :

1. Tout ce qui doit être évalué est fusionné dans `main` (section 4.1), journal compris (section 4.6).
2. Le dernier commit de `main` porte une coche verte sur GitHub : les trois contrôles exigés et `publication`.
3. Le test à froid a été fait sur cet état (section 4.2).
4. La fiche a sa rubrique 13, ou l'attente est documentée (section 4.5).

Après le tag, tout ce que vous changez n'est plus dans `v1.0-rc`. Le programme ne dit pas qui pose le tag. Proposition : **un seul membre**, désigné à l'avance (le gardien du harnais et de la CI, par exemple), un coéquipier regardant l'écran. Deux membres qui posent le même tag chacun de leur côté se retrouvent dans la situation de la section 10.

### 5.2 Les commandes

Les mêmes que pour `s2-fin` et `v0.1`, avec deux contrôles avant :

```bash
git switch main
git pull
git status
git log --oneline -1
```

Ce que vous devez voir (sortie obtenue sur la copie du dépôt-modèle ; votre dernier commit aura un autre identifiant et un autre titre, celui de votre dernière PR fusionnée) :

```text
Déjà sur 'main'
Votre branche est à jour avec 'origin/main'.
Déjà à jour.
Sur la branche main
Votre branche est à jour avec 'origin/main'.

rien à valider, la copie de travail est propre
b53f271 Dépôt d'équipe créé depuis le modèle
```

La dernière ligne nomme le commit que vous allez taguer. Comparez-la au dernier commit affiché sur la page d'accueil du dépôt, celui qui porte la coche verte : même identifiant court, même titre. Posez alors le tag sur votre poste, et vérifiez-le **avant** de le pousser :

```bash
git tag v1.0-rc
git fetch
git rev-parse v1.0-rc origin/main
```

`git tag` n'affiche rien quand il réussit, `git fetch` non plus quand le dépôt distant n'a rien de nouveau. La troisième commande répond :

```text
b53f271e61427a519078ddfd31623402b697d2e0
b53f271e61427a519078ddfd31623402b697d2e0
```

**Deux lignes identiques** : le tag est sur le dernier commit de `main`. Le `git fetch` n'est pas facultatif : sans lui, `origin/main` n'est que le souvenir que votre poste garde du dépôt distant, et la comparaison peut être juste en apparence seulement (section 10.2). Poussez ensuite le tag, puis prouvez qu'il est arrivé :

```bash
git push origin v1.0-rc
git ls-remote origin main refs/tags/v1.0-rc
```

```text
To <adresse du dépôt>
 * [new tag]         v1.0-rc -> v1.0-rc
b53f271e61427a519078ddfd31623402b697d2e0	refs/heads/main
b53f271e61427a519078ddfd31623402b697d2e0	refs/tags/v1.0-rc
```

La protection de branche vise `main`, pas les tags : cet envoi n'est pas refusé (chapitre 3 de la séance 2, section 11.2). `git ls-remote` interroge le dépôt distant lui-même, sans rien modifier : le même identifiant sur les deux lignes prouve que `v1.0-rc` y désigne le dernier commit de `main`. Si la ligne `refs/tags/v1.0-rc` manque, le tag n'est que sur votre poste (section 10).

Deux autres endroits où le voir. **Sur GitHub**, la page du dépôt liste les tags (lien « Tags », à côté des branches) : `v1.0-rc` doit y figurer (écran non observé pour ce chapitre). **Sur le poste d'un coéquipier**, un `git pull` rapporte le tag : il affiche `* [nouvelle étiquette] v1.0-rc    -> v1.0-rc`, et `git tag --list 'v1.0*'` répond ensuite `v1.0-rc`.

### 5.3 Un tag sans date à lui

Le tag que vous posez est un tag « léger », comme `s2-fin` et `v0.1` : un simple nom posé sur un commit. Il ne porte pas de date propre. Quand on demande à git la date d'un tag, il répond celle du **commit tagué**. Essai : `git show --no-patch --format='%h %ad %s' --date=iso v1.0-rc` répond `b53f271 2026-11-27 16:01:08 +0100 Dépôt d'équipe créé depuis le modèle`, soit la date du commit, pas celle du moment où `git tag` a été tapé. Le programme fixe l'échéance de 18h mais ne dit pas comment l'heure de dépôt est constatée (voir « Points non vérifiés »). Conséquence pratique, proposition : ne jouez pas avec la limite, posez le tag avec de la marge.

> **À retenir.** `git pull`, `git status`, taguer, `git fetch` et deux lignes identiques, pousser, puis `git ls-remote`. Le tag n'existe pour l'enseignant que s'il apparaît dans cette dernière réponse.

---

## 6. Vérifier le rendu comme le fera un évaluateur

Le programme dit pourquoi le tag est déposé deux jours avant : « pour que l'enseignant lise les dépôts avant la séance ». L'enseignant n'a ni votre poste, ni vos branches locales, ni vos explications. Il a trois choses : le tag, la page GitHub du dépôt (PR, issues, coche du commit), l'adresse publiée. Mettez-vous à sa place, juste après avoir poussé le tag.

### 6.1 Cloner le tag, à froid

Dans un dossier vide, **hors de votre dépôt** :

```bash
git clone --branch v1.0-rc <adresse du dépôt> relecture
cd relecture
git status
git log --oneline -1
```

`<adresse du dépôt>` est l'adresse de clonage affichée par le bouton « Code » de la page GitHub. Ce que vous devez voir (essai sur le dépôt distant local) :

```text
Clonage dans 'relecture'...
fait.
Note : basculement sur 'b53f271e61427a519078ddfd31623402b697d2e0'.

Vous êtes dans l'état « HEAD détachée ». […]
Actuellement sur aucune branche.
rien à valider, la copie de travail est propre
b53f271 Dépôt d'équipe créé depuis le modèle
```

Le long message « HEAD détachée » est normal : vous regardez un état figé, vous n'y travaillez pas. L'identifiant est celui du commit tagué. Lancez alors le chronomètre et suivez votre `README`, dans l'ordre, comme en section 4.2 : c'est le test à froid de la definition of done, fait sur l'état exact qui sera lu. Supprimez ensuite le dossier `relecture` : on ne corrige rien depuis ce clone.

### 6.2 La CI est verte sur le commit tagué

La definition of done demande « la CI est verte sur les deux tags ». Le workflow fourni se déclenche à chaque envoi sur `main` et à chaque PR, **pas à l'envoi d'un tag** : aucun contrôle ne tourne quand vous poussez `v1.0-rc`. La CI verte se lit donc sur le **commit tagué** (chapitre 2 de la séance 4, section 10 ; fiche V).

- **À l'écran** : page d'accueil du dépôt, coche verte à côté du dernier commit de `main`, dont l'identifiant court est celui de la section 5.2. Un clic sur la coche liste les contrôles.
- **En ligne de commande** : `gh run list --commit <identifiant du commit> --limit 5`, avec l'identifiant donné par `git ls-remote --tags origin`. La réponse donne une ligne par exécution de la CI sur ce commit ; vous devez y lire `completed` et `success`. (Essayée en lecture seule sur le dépôt du cours, pas sur un dépôt d'équipe.)

### 6.3 La version web est accessible

La definition of done : « la version web publiée sur GitHub Pages est accessible ». Ouvrez l'adresse publiée, `https://<organisation>.github.io/equipe_04/`, en rechargeant sans le cache : vous devez voir votre application, pas une page blanche ni une erreur 404 (chapitre 2 de la séance 4, sections 5.3 à 5.5).

Le site publié suit `main`, pas les tags : il montre le dernier commit de `main` dont le contrôle `publication` est vert. Juste après `v1.0-rc`, c'est le commit tagué. Si vous venez de fusionner, l'ancienne version peut rester affichée une dizaine de minutes (chapitre 2 de la séance 4, section 5.4) : la preuve est `publication` vert sur le commit tagué. Si la publication n'a jamais fonctionné, la grille accepte « build web publié sur GitHub Pages (ou plan B documenté) » : la ligne qui documente le plan B doit être dans le dépôt avant le tag (chapitre 2 de la séance 4, section 9).

> **À retenir.** Un rendu se vérifie d'un dossier vide, pas de son poste de travail. Ce qui ne marche que chez vous n'est pas livré.

---

## 7. Le briefing (bloc 1)

La séance s'ouvre par un briefing, de poids **Important**. Le programme, mot pour mot :

- *Contenu.* « Ordre de passage, format, critères. »
- *Intention.* « Que chacun sache dans quel ordre il passe et selon quels critères. »

Toutes les équipes passent dans la même salle, l'une après l'autre, devant l'enseignant, seul évaluateur (chapitre 2, section 2). L'ordre de passage est « tiré au sort à l'avance et affiché dans la salle » (programme, format de la soutenance) ; le briefing le rappelle. Ce que votre équipe doit avoir noté en sortant du briefing (proposition) : son rang de passage et le moment prévu pour le gel. Le rang compte pour la suite : l'équipe qui passe en premier a le moins de temps entre le gel et son passage. Le format de la soutenance est détaillé au chapitre 2 (section 2), les critères au chapitre 3 (section 8).

> **À retenir.** Après le briefing, chacun sait dans quel ordre il passe et selon quels critères. Sinon, on demande.

---

## 8. Les retouches bloquantes (bloc 2)

### 8.1 Ce que dit le programme

Bloc de poids **Important**, mot pour mot :

- *Contenu.* « Correctifs de bugs bloquants, documentation, mise à jour de la fiche de conformité (dont la réponse du RSSI), finition. Aucune nouvelle fonctionnalité. Dernier passage de la CI. »
- *Intention.* « Livrer une version stable : seuls les correctifs bloquants sont autorisés. »

Si la séance prend du retard, l'ordre de coupe prévoit : « Le bloc 2 (retouches) : s'en tenir aux seuls correctifs bloquants, et ne pas déborder sur le gel. » Quatre choses sont donc permises (corriger un bug bloquant, documenter, mettre la fiche à jour, finir), une est interdite (ajouter une fonctionnalité), et une est attendue (voir la CI passer une dernière fois).

### 8.2 Ce qui est bloquant, ce qui ne l'est pas

Le programme ne définit pas « bloquant ». La définition qui suit est une **proposition de ce chapitre, à valider par l'enseignant** : est bloquant ce qui empêche une ligne de la definition of done d'être vraie, ou ce qui empêche votre scénario de démonstration de se dérouler.

| Bloquant (proposition) | Pas bloquant (proposition) |
|---|---|
| L'application ne démarre pas en suivant le `README` sur un clone neuf | Une couleur, un alignement, un libellé perfectible |
| La pastille de `main` est rouge | Un écran du « souhaitable » qui manque |
| La version web publiée ne s'ouvre pas | Une amélioration de code qui ne change rien à l'écran |
| Une étape de votre scénario de démonstration échoue | Un cas hors du scénario de démonstration, connu et écrit dans les limites |
| La rubrique 13 de la fiche n'a pas la réponse du RSSI, arrivée entre-temps | Une reformulation de la fiche qui ne change pas le fond |
| Le `README` oublie une commande | Une idée venue pendant la répétition |

Tout ce qui est dans la colonne de droite se note (une issue, une ligne de « Reste à faire » dans le journal) et ne se code pas. Proposition : décidez la liste dans les premières minutes du bloc, à voix haute, et tenez-vous-y.

> **Attention.** Un cas d'acceptation rouge ne se « corrige » pas en modifiant le test. Les règles n'ont pas changé le dernier jour : aucun test supprimé, désactivé ni assoupli, et `test/acceptance/` reste hors de portée de l'agent.

### 8.3 Toujours par une PR

Un correctif du dernier jour suit le même chemin que tout le reste. Le programme (section 8, « Décisions arrêtées ») : « PR relue par un coéquipier dès S2 ; `main` protégée (PR obligatoire avec 1 approbation) ; CI obligatoire à partir de S4. **Merge commit seul**. » Il n'y a pas de raccourci le jour de la soutenance, et il n'y en a pas pour l'enseignant non plus (chapitre 3 de la séance 2, section 10.3).

Sur le poste de l'auteur, après `git switch main` et `git pull` :

```bash
git switch -c correctif/titre-ecran
git add <fichiers corrigés>
git commit -m "fix: corrige le titre de l'écran d'accueil"
git push -u origin correctif/titre-ecran
```

Ce que vous devez voir (pour l'essai, le fichier corrigé était `README.md`) :

```text
Basculement sur la nouvelle branche 'correctif/titre-ecran'
[correctif/titre-ecran 65cc4fd] fix: corrige le titre de l'écran d'accueil
 1 file changed, 2 insertions(+)
To <adresse du dépôt>
 * [new branch]      correctif/titre-ecran -> correctif/titre-ecran
la branche 'correctif/titre-ecran' est paramétrée pour suivre 'origin/correctif/titre-ecran'.
```

Puis, sur GitHub : ouvrir la PR avec le modèle (les lignes de suivi valent aussi pour un correctif de trois lignes), attendre les trois contrôles exigés, obtenir l'approbation d'un coéquipier, fusionner par commit de fusion. Cette partie n'a pas été exécutée pour ce chapitre : la fusion a été simulée en local.

**Le coût d'un correctif** : une branche, une PR, un relecteur disponible, et l'attente des contrôles. Lors de l'essai en ligne de la séance 4, les deux contrôles les plus longs prenaient environ deux minutes chacun sur le dépôt-modèle nu (chapitre 2 de la séance 4, « Points non vérifiés ») ; votre dépôt a plus de tests. Vous n'aurez le temps que de très peu de correctifs : c'est une raison de plus de les trier et de les garder petits. Proposition, reprise de la correction d'un constat d'audit (chapitre 3 de la séance 4, section 9.3) : un correctif de bug commence par le test qui le reproduit, que vous voyez rouge, puis vert.

### 8.4 Le dernier passage de la CI

Après la dernière fusion, chacun remet son poste à jour (`git switch main`, `git pull`), et l'équipe regarde la CI tourner sur le nouveau dernier commit de `main`. Vous devez voir, sur ce commit, les trois contrôles exigés verts, puis `publication` vert. Proposition : ne fusionnez rien dans les dernières minutes du bloc sans rester devant la CI jusqu'au vert.

`git log --oneline v1.0-rc..origin/main` liste ce que `main` a reçu depuis `v1.0-rc` (sortie en section 9.4, où la même liste est lue entre les deux tags). Si la commande ne répond rien, `main` n'a pas bougé. **S'il n'y a rien à corriger**, proposition : le bloc 2 sert à vérifier (les gestes de la section 6) et à passer plus vite à la répétition.

> **À retenir.** Bloquant ou pas : on tranche d'abord, on corrige ensuite, par une PR relue. Le bloc ne déborde pas sur le gel.

---

## 9. Le gel et le tag `v1.0` (bloc 3)

### 9.1 Ce que dit le programme

Bloc de poids **Indispensable**, mot pour mot :

- *Contenu.* « Tag `v1.0`. À partir de là, on ne pousse plus. »
- *Intention.* « Figer ce qui sera évalué ; le tag `v1.0` est posé avant le premier passage. »

C'est l'un des trois éléments de la séance qui « ne se sacrifient jamais » : « le gel et le tag `v1.0`, les soutenances avec leurs deux questions individuelles, les fiches d'évaluation par les pairs ». Le programme situe ce tag de trois façons : « puis `v1.0` au début de S5 » (dossier de rendu), « `v1.0` est taguée avant le premier passage le jour de S5 » (definition of done), et le bloc 3, placé après les retouches. Les trois disent la même chose : le gel a lieu en début de séance, après les retouches et avant les passages. Le programme ne donne pas d'heure.

### 9.2 Les commandes

Les mêmes qu'en section 5.2, avec le nom `v1.0`, dans le même ordre : on vérifie avant de pousser, on prouve après. Un seul membre, sur `main` à jour : `git switch main`, `git pull`, `git status`, puis `git log --oneline -3`. Quand un correctif a été fusionné pendant le bloc 2, `git pull` le rapporte (`Mise à jour b53f271..5d2e30f`, puis `Fast-forward` : l'avance rapide du chapitre 1 de la séance 2, section 2.2), `git status` répond comme en section 5.2, et la dernière commande affiche :

```text
5d2e30f Merge pull request #42 from equipe/correctif/titre-ecran
65cc4fd fix: corrige le titre de l'écran d'accueil
b53f271 Dépôt d'équipe créé depuis le modèle
```

Le premier commit de la liste est celui que vous allez taguer : il doit porter la coche verte sur GitHub (section 8.4). Dans cet essai, la fusion de la PR a été simulée en local ; son titre imite celui que GitHub donne à un commit de fusion, et le numéro 42 est fictif. Posez le tag et vérifiez-le, sans le pousser encore :

```bash
git tag v1.0
git fetch
git rev-parse v1.0 origin/main
```

```text
5d2e30f5b9c5dc85cbce2e97af78ef288f5f632a
5d2e30f5b9c5dc85cbce2e97af78ef288f5f632a
```

### 9.3 Le tag est-il au bon endroit ?

**Deux lignes identiques**, après `git fetch` : le tag est sur le dernier commit de `main`. Deux lignes différentes : ne poussez pas, le tag se corrige encore sans difficulté (section 10.2). Quand les deux lignes sont identiques, poussez, puis demandez la preuve au dépôt distant lui-même :

```bash
git push origin v1.0
git ls-remote origin main refs/tags/v1.0
```

```text
To <adresse du dépôt>
 * [new tag]         v1.0 -> v1.0
5d2e30f5b9c5dc85cbce2e97af78ef288f5f632a	refs/heads/main
5d2e30f5b9c5dc85cbce2e97af78ef288f5f632a	refs/tags/v1.0
```

Le même identifiant sur les deux lignes : sur le dépôt distant, `v1.0` désigne le dernier commit de `main`. C'est la preuve du gel. `git ls-remote --tags origin` liste alors les deux tags, chacun sur son commit (`5d2e30f…` pour `v1.0`, `b53f271…` pour `v1.0-rc`).

### 9.4 Ce qui sépare `v1.0-rc` de `v1.0`

L'enseignant a lu `v1.0-rc`. La question qu'il peut poser : « qu'avez-vous changé depuis ? » Trois commandes y répondent, du plus court au plus détaillé :

```bash
git diff --name-only v1.0-rc v1.0
git diff --stat v1.0-rc v1.0
git log --oneline v1.0-rc..v1.0
```

```text
README.md
 README.md | 2 ++
 1 file changed, 2 insertions(+)
5d2e30f Merge pull request #42 from equipe/correctif/titre-ecran
65cc4fd fix: corrige le titre de l'écran d'accueil
```

La première donne la liste des fichiers modifiés, la deuxième le nombre de lignes par fichier, la troisième les commits : deux lignes pour un correctif, son commit et le commit de fusion de sa PR. Proposition : un membre garde cette réponse sous la main pour la soutenance. Une liste courte, faite de correctifs, est exactement ce que le bloc 2 autorise ; un fichier de fonctionnalité dans cette liste se remarquerait.

**Si rien n'a été corrigé**, `v1.0` se pose sur le même commit que `v1.0-rc`. Ce n'est pas une anomalie : un commit peut porter deux tags, et les trois commandes ci-dessus ne répondent rien. (Vérifié avec un tag d'essai posé sur le commit de `v1.0-rc` : `git rev-parse` donne alors deux lignes identiques pour les deux tags.)

### 9.5 « À partir de là, on ne pousse plus »

Le programme ne précise pas la portée de la formule ; lecture de ce chapitre, au sens large. Une fois `v1.0` poussé et prouvé : plus aucune fusion dans `main`, plus aucune PR ouverte « pour plus tard » pendant la séance. Ce qui est évalué, c'est l'état de `v1.0` ; une amélioration poussée après le gel n'est pas dans le rendu, et elle brouille la lecture du dépôt. L'idée qui vient pendant la répétition se note dans une issue ou sur papier. Le site publié montre alors la version de `v1.0`, quand `publication` est vert sur ce commit et que le cache a expiré (section 6.3). Sur quoi tourne la démonstration, et que faire si le site n'est pas à jour au moment de passer : chapitre 2, sections 4 et 5.

> **À retenir.** `v1.0` est le dernier geste technique de la formation. Il se vérifie avant d'être poussé, se prouve après, puis on ne pousse plus.

---

## 10. Quand ça coince

Premier réflexe, toujours : `git status`, puis `git ls-remote --tags origin`, et lire ce qu'ils répondent. Tous les messages ci-dessous ont été obtenus sur la copie du dépôt-modèle.

| Ce que vous voyez | Ce qui se passe | Ce qu'il faut faire |
|---|---|---|
| `fatal: l'étiquette 'v1.0' existe déjà` | Le tag existe déjà sur votre poste : un coéquipier l'a posé et vous l'avez reçu par `git pull`, ou vous l'avez posé plus tôt | Ne rien forcer. `git ls-remote origin main refs/tags/v1.0` : le même identifiant sur les deux lignes, et c'est fait |
| `git ls-remote --tags origin` ne liste pas votre tag | Le tag est posé sur votre poste, pas poussé | Le vérifier (section 9.2), puis `git push origin v1.0-rc` (ou `v1.0`) |
| `git push origin v1.0-rc` répond `Everything up-to-date` | Le tag est déjà sur le dépôt distant, au même endroit | Rien : c'est fait |
| `! [rejected] v1.0 -> v1.0 (already exists)` | Vous tentez de déplacer un tag déjà poussé | Ne pas forcer (section 10.1) |
| Après `git fetch`, `git rev-parse v1.0 origin/main` donne deux lignes différentes | Le tag est sur un commit ancien de `main` (`git pull` oublié), ou `main` a reçu une fusion depuis | Section 10.2 |
| La réponse de `git branch -r --contains v1.0` ne cite pas `origin/main` (elle est vide, ou ne cite qu'une branche de travail) | Le tag est sur un commit qui n'est pas dans `main` | Section 10.2 |
| La pastille de `main` est rouge à l'heure du gel | Le dernier commit de `main` ne passe pas les contrôles | Section 10.3 |

### 10.1 Un tag poussé ne se déplace pas

git refuse par défaut de déplacer un tag déjà poussé ; forcer reste techniquement possible, et c'est interdit : on ne force jamais. Essai fait pour ce chapitre, à ne pas reproduire : un tag `v1.0` déjà poussé a été déplacé sur le poste, puis renvoyé. Réponse de `git push origin v1.0` :

```text
To <adresse du dépôt>
 ! [rejected]        v1.0 -> v1.0 (already exists)
error: impossible de pousser des références vers '<adresse du dépôt>'
hint: Les mises à jour ont été rejetées car l'étiquette existe déjà dans la branche distante.
```

Le poste et le dépôt distant ne sont alors plus d'accord sur ce que désigne `v1.0`. Un tag sert à retrouver un état à coup sûr, et c'est à partir de lui que votre dépôt est lu : un tag qui a bougé ne prouve plus rien. Ne confiez pas non plus ce geste à un agent. Pour réaligner un tag déplacé par erreur sur votre poste, une commande suffit :

```bash
git fetch --tags --force
```

```text
Depuis <adresse du dépôt>
 t [mise à jour de l'étiquette] v1.0       -> v1.0
```

Le tag local reprend la place qu'il a sur le dépôt distant. Si c'est votre `main` local qui s'est écarté de celui du dépôt distant, le geste est celui de la fiche C de la séance 2 (étape 4).

### 10.2 Un tag posé au mauvais endroit

Deux cas, que l'on ne voit qu'après `git fetch`.

**`git pull` oublié.** Un coéquipier a fusionné, votre poste ne le sait pas encore. Sans `git fetch`, `git rev-parse v1.0 origin/main` donne deux lignes identiques, et c'est trompeur : `origin/main` date de votre dernier échange avec le dépôt distant. Après `git fetch` (essai avec un tag nommé `essai-gel`), la même commande répond :

```text
b53f271e61427a519078ddfd31623402b697d2e0
5d2e30f5b9c5dc85cbce2e97af78ef288f5f632a
```

Deux lignes différentes : le tag est en retard sur `main`.

**Tag posé sur une branche de travail.** `git branch -r --contains v1.0` liste les branches du dépôt distant qui contiennent le commit tagué. La bonne réponse cite `origin/main`. Si elle est vide, ou ne cite qu'une branche de travail (essai : `origin/correctif/essai`), le tag n'est pas dans `main`.

**Tant que le tag n'est pas poussé**, le remède est le même dans les deux cas : `git tag -d v1.0`, `git switch main`, `git pull`, `git tag v1.0`, puis la vérification de la section 9.2. Dans l'essai, git répond `Étiquette 'essai-gel' supprimée (elle était sur b53f271)`, et la vérification donne ensuite deux lignes identiques. La suppression ne concerne que votre poste.

**Si le tag a déjà été poussé**, ne le déplacez pas vous-même (section 10.1). Le programme ne prévoit pas ce cas. Proposition : prévenez l'enseignant tout de suite, avec la réponse de `git ls-remote origin main refs/tags/v1.0`. C'est lui qui lit le dépôt à partir de ce tag.

### 10.3 La CI est rouge à l'heure du gel

Le programme pose deux exigences qui peuvent se contredire ce jour-là : le gel et le tag `v1.0` « ne se sacrifient jamais », et « la CI est verte sur les deux tags ». Il ne dit pas quoi faire si le dernier commit de `main` est rouge au moment de geler : la décision revient à l'enseignant. Prévenez-le **avant** l'heure du gel, avec deux informations :

1. **le contrôle rouge** (chapitre 2 de la séance 4, section 7) : lequel des contrôles, quelle étape, quelle dernière ligne ;
2. **ce qui a été fusionné depuis `v1.0-rc`**, qui était vert : la réponse de `git log --oneline v1.0-rc..origin/main`, après `git pull`.

Une seule chose est certaine, parce que la règle d'intégrité ne change pas ce jour-là : on ne rend pas un contrôle vert en désactivant un test.

> **À retenir.** Un tag se vérifie avant d'être poussé. Après, on ne force rien : on constate, et on prévient l'enseignant.

---

## 11. Avez-vous fini ?

La part de ce chapitre dans le livrable et la definition of done de la séance 5 (programme, mot pour mot). Le livrable de fin de séance : « Tag `v1.0`, dossier de rendu à jour (section 7) et soutenance passée. »

- [ ] `v1.0-rc` est déposé l'avant-veille de S5 à 18h ; `v1.0` est taguée avant le premier passage le jour de S5 ; la CI est verte sur les deux tags ; le `README` testé à froid (`git clone`, `flutter pub get`, `flutter run -d chrome`) permet de lancer l'application en moins de 10 minutes, et la version web publiée sur GitHub Pages est accessible.
- [ ] La fiche de conformité est complète (13 rubriques) et contient la **réponse du RSSI** datée (go, go sous conditions avec actions, ou no-go assumé avec les raisons).
- [ ] `JOURNAL.md` est à jour et les PR portent leur section « ce que l'agent a proposé, ce que j'ai refusé » et leurs temps.

La troisième ligne de la definition of done (les deux questions individuelles) est au chapitre 3, section 13. Et, pour que ces cases aient un sens, ce que ce chapitre ajoute :

- [ ] `git ls-remote --tags origin` liste `v1.0-rc` et `v1.0`, et `git ls-remote origin main refs/tags/v1.0` donne le même identifiant sur ses deux lignes.
- [ ] Le commit de chaque tag porte une coche verte sur GitHub.
- [ ] Le test à froid a été fait depuis un clone du tag, avec les **cinq** commandes du `README`, génération comprise, et son temps est noté.
- [ ] Ce que l'équipe a abandonné est écrit dans `PROJET.md`, daté, avec sa raison.
- [ ] `git log --oneline v1.0-rc..v1.0` ne montre que des correctifs, et depuis `v1.0` personne n'a rien poussé.

---

## Glossaire

- **Candidat à la version finale** (*release candidate*, `-rc`) : version que l'on pense pouvoir livrer telle quelle, déposée pour être vérifiée avant la version finale ; ici, le tag `v1.0-rc`.
- **Commit tagué** : le commit que désigne un tag. C'est sur lui que se lit la pastille de CI, puisque la CI ne tourne pas à l'envoi d'un tag.
- **Correctif bloquant** : correction sans laquelle la version ne peut pas être livrée ou montrée. Le programme n'en donne pas de définition ; celle de ce chapitre est une proposition (section 8.2).
- **Dossier de rendu** : les sept pièces évaluées : dépôt à jour, `README` d'installation, `CLAUDE.md`, `docs/ARCHITECTURE.md`, `docs/fiche_conformite.md`, `JOURNAL.md`, et les PR avec leurs sections de suivi.
- **Gel des fonctionnalités** : moment, au plus tard une semaine avant la séance 5, après lequel on n'ajoute plus rien : seulement des correctifs, de la documentation et la préparation de la démonstration.
- **Gel du code** : moment de la séance 5 où le tag `v1.0` est posé ; « à partir de là, on ne pousse plus ».
- **HEAD détachée** : état d'un dépôt local placé sur un commit précis (par exemple un tag) et non sur une branche. Normal pour relire, à éviter pour travailler.
- **Livrable minimum viable** : ce que l'énoncé de chaque thème demande au minimum quand l'équipe a tout réduit.
- **Rubrique 13** : dernière rubrique de la fiche de conformité, la validation du RSSI : sa date, sa décision (go, go sous conditions, no-go) et ses conditions.
- **Tag léger** : tag qui n'est qu'un nom posé sur un commit, sans date ni auteur propres ; c'est celui que crée `git tag <nom>`.
- **Test à froid** : installation rejouée depuis un clone neuf, dans un dossier vide, en ne suivant que le `README`.

Les autres termes (tag, release, contrôle exigé, plan B de publication, PR, commit de fusion, avance rapide) sont définis dans les glossaires des séances 1, 2 et 4.

---

## Pour aller plus loin

- Chapitre 2 de cette séance : section 2 (une salle, ordre de passage, format), sections 4 et 5 (la démonstration, où elle tourne, le plan de secours), section 6 (« sous le capot » : la décision sur les données, l'historique git), section 7 (compiler les mesures des PR), section 8 (présenter la fiche et l'avis du RSSI), section 9 (le regard critique, dont ce qui a été laissé de côté), section 10 (la répétition).
- Chapitre 3 de cette séance : sections 3 et 4 (la PR tirée au sort et sa préparation), section 7 (les cinq règles d'usage de l'IA), section 8 (la grille sur 20, critère par critère).
- Chapitre 4 de cette séance : fiche W (avant la séance : `v1.0-rc` et dossier de rendu) et fiche X (retouches bloquantes, gel et `v1.0`).
- Chapitre 8 de la séance 1, section 8 : versions, tags et releases. Chapitre 3 de la séance 2 : sections 9 (la PR et son suivi), 10 (la protection de `main`), 11 (`JOURNAL.md` et le tag `s2-fin`) ; chapitre 4 de la séance 2, fiche C (étape 4), si votre `main` local s'est écarté du dépôt distant.
- Séance 4 : chapitre 2, sections 4.3, 5, 7, 9 et 10 (CI obligatoire, publication, contrôle rouge, plan B, `v0.1`) ; chapitre 3, sections 7 et 9 (checklist d'audit, des constats aux issues) ; chapitre 4, sections 9 et 10 (décision du RSSI, calendrier de la fiche) ; chapitre 5, fiche U (backlog et calendrier du sprint).
- Dans votre dépôt : `README.md` (« Démarrer », « Vérifier avant une PR »), `PROJET.md` (« Décisions de l'équipe »), `JOURNAL.md`.

---

## Points non vérifiés (à signaler honnêtement)

- **Rien n'a été écrit sur GitHub.** Les commandes git ont été jouées sur une copie du dépôt-modèle, avec un dépôt distant local. N'ont donc pas été observés : la page « Tags » d'un dépôt d'équipe, la coche sur un commit tagué, une PR de correctif fusionnée sous la protection de `main`, l'adresse de clonage d'un dépôt GitHub dans `git clone --branch`, le filtre des PR par étiquette, le site GitHub Pages après un correctif. Le refus de déplacer un tag (section 10.1) est le refus par défaut de git, observé sur un dépôt distant local, où un envoi forcé passe (constaté à la relecture) ; GitHub n'a pas été essayé.
- **La fusion du correctif est simulée.** Le commit `Merge pull request #42 from equipe/correctif/titre-ecran` a été créé en local pour imiter une fusion de PR ; le numéro et le nom sont fictifs. Les séquences de gel (sections 5.2, 9.2, 9.3 et 10.2) ont été rejouées sur une copie séparée, où ce commit a été poussé sur `main` ; la sortie de `git push -u origin correctif/titre-ecran` vient d'un autre essai.
- **Les trois dates.** Vendredi 22 janvier 2027, mercredi 27 janvier 2027 à 18h et jeudi 28 janvier 2027 avant 9h sont déduites de la date de la séance (vendredi 29 janvier 2027) et des formules du programme (« une semaine avant », « l'avant-veille », « la veille »). Le programme fait foi ; si la date de la séance change, elles changent avec elle.
- **L'heure de dépôt de `v1.0-rc`.** Le programme fixe l'échéance (l'avant-veille à 18h) sans dire comment elle est constatée. Un tag léger ne porte pas de date propre : git affiche celle du commit tagué (section 5.3). Ce chapitre n'invente pas de règle ; la question est à poser à l'enseignant.
- **Entre `v1.0-rc` et le début de la séance.** Le programme dit ce qui est permis après le gel des fonctionnalités et pendant le bloc 2, pas ce qui l'est le jeudi et le vendredi matin, alors que l'enseignant lit les dépôts la veille. Il ne dit pas non plus si la description d'une PR peut encore être complétée après `v1.0-rc`. Les deux prudences proposées (sections 2 et 4.7) ne sont pas des règles du programme.
- **Quel tag sert à l'évaluation du dépôt.** L'enseignant lit `v1.0-rc` la veille, mais le bloc 3 veut « Figer ce qui sera évalué » avec `v1.0` ; la grille dit « CI verte sur le tag », au singulier, la definition of done « sur les deux tags ». Le programme ne dit pas lequel des deux états sert aux critères lus dans le dépôt.
- **Le test à froid de la definition of done.** Elle cite « (`git clone`, `flutter pub get`, `flutter run -d chrome`) », sans la génération du code. Sans `dart run build_runner build --delete-conflicting-outputs`, `flutter test` ne compile pas sur un clone neuf (vérifié sur le dépôt-modèle) ; la checklist d'audit de la séance 4 et le `README` du dépôt-modèle citent bien la commande. Ce chapitre suit le `README`. L'échec de `flutter run -d chrome` sans génération n'a pas été rejoué.
- **« Au début de S5 » et « avant le premier passage ».** Le dossier de rendu, la definition of done et le bloc 3 situent `v1.0` par trois formules. Ce chapitre les lit comme compatibles (gel en début de séance, après les retouches, avant les passages) ; le programme ne donne pas d'heure.
- **Definition of done et étudiant absent.** « Chaque étudiant a répondu à **deux questions individuelles** » ne peut pas être vrai le jour même si un absent est interrogé « dans les 15 jours ».
- **`docs/ARCHITECTURE.md`, « une page ».** Le programme décrit ce fichier comme « une page : composants, modèle de données, décisions ». Le fichier fourni par le dépôt-modèle est bien plus long et organisé autrement (où ranger quoi, conventions, migrations, rôles). Le programme ne dit pas si l'équipe doit le réécrire, le compléter ou le résumer. À trancher par l'enseignant.
- **Stories abandonnées et critère « Fonctionnalité ».** La grille regarde si « les user stories annoncées sont livrées ». Le programme ne dit pas comment est comptée une story que l'équipe a abandonnée et déclarée comme telle dans `PROJET.md`, ni ce qui distingue, le soir du gel, un correctif d'une fonctionnalité.
- **No-go assumé.** Que la grille ne sanctionne pas un no-go en tant que tel est une lecture de ce chapitre (section 4.5), à confirmer par l'enseignant.
- **CI rouge à l'heure du gel, tag mal placé déjà poussé.** Le programme exige à la fois le tag `v1.0` (jamais sacrifié) et une CI verte sur les deux tags, sans dire quoi faire si les deux s'opposent ; il ne prévoit pas non plus le cas d'un tag poussé au mauvais endroit. Les sections 10.2 et 10.3 renvoient à l'enseignant.
- **« On ne pousse plus ».** Le programme ne précise pas si la formule vise seulement `main` ou tout envoi (branches, issues, descriptions de PR). La section 9.5 la lit au sens large.
- **Commande `gh`.** `gh run list --commit <identifiant> --limit 5` a été essayée en lecture seule sur le dépôt du cours, pas sur un dépôt d'équipe.
- **Durées.** Les 45 secondes de l'installation à froid sont celles du poste de rédaction, bibliothèques en cache, sur le dépôt-modèle nu (32 tests) : elles couvrent le clone et les trois premières commandes, ni `flutter analyze` (rejoué à part), ni `flutter run -d chrome` (non rejoué). Les durées de la CI viennent de l'essai en ligne de la séance 4, sur le dépôt-modèle nu.
- **Plateformes et langue.** Vérifications sous Linux seulement, avec un git dont les messages sont en français. Sur un poste où git répond en anglais, les messages diffèrent ; ils n'ont pas été relevés.
- **Textes proposés, à valider par l'enseignant.** La prudence entre `v1.0-rc` et la séance (section 2) ; la question « correctif ou fonctionnalité » du soir du gel (section 3.2) ; la façon d'écrire un abandon et l'exemple de « Décisions de l'équipe » (section 3.3) ; la lecture « le dossier est l'état du dépôt à l'endroit du tag » et **toutes les preuves observables de la section 4**, dont le sens donné à « dépôt à jour » et la fermeture d'une PR abandonnée (4.1), qui fait le test à froid, où noter son temps, ce qu'il faut relire dans le `README` (4.2), les trois vérifications de `CLAUDE.md` et le lien avec `erreur-agent` (4.3), la vérification rapide d'`ARCHITECTURE.md` (4.4), le tableau des preuves de la fiche et la façon de documenter l'attente du RSSI (4.5), le contenu attendu du journal (4.6), compléter les sections vides avant `v1.0-rc` sans rien reconstituer (4.7) ; la liste des conditions avant de taguer et le choix d'un seul membre pour poser le tag (section 5.1) ; poser le tag avec de la marge (section 5.3) ; ce qu'il faut noter au briefing (section 7) ; la définition de « bloquant », son tableau et la liste décidée en début de bloc (section 8.2) ; le test d'abord pour un correctif (section 8.3) ; rester devant la CI jusqu'au vert, et l'usage du bloc 2 quand il n'y a rien à corriger (section 8.4) ; garder sous la main ce qui sépare les deux tags (section 9.4) ; la lecture large de « on ne pousse plus » (section 9.5) ; prévenir l'enseignant pour un tag mal placé déjà poussé (section 10.2) ; les cases ajoutées à la definition of done (section 11).

---

## Sources

Documents du cours :

- `cours/programme-detaille.md` : section 2 (vue d'ensemble, lignes « Sprint » et « S5 ») ; section 4 (rôles d'équipe ; séance 5 : principe du rendu, objectifs, matériel, blocs 1 à 3, ordre de coupe, « ne se sacrifient jamais », livrable, definition of done) ; section 5 (le sprint final) ; section 7 (grille sur 20, repères pour la notation, dossier de rendu, règles d'usage de l'IA) ; section 8 (décisions arrêtées, socle commun, règles du jeu) ; section 10 (fiche de conformité, absence de réponse du RSSI) ; section 11 (parade « RSSI indisponible ou en retard »).
- `cours/projets/themes.md` : « livrable minimum viable » des thèmes A, B et C. `cours/conformite-ai-act-rgpd.md` : section 6.2 (processus de validation, trace, no-go par défaut). `README.md` à la racine du dépôt du cours : horaires de la séance 5.
- Supports de la séance 1 : chapitre 8 (section 8). Supports de la séance 2 : chapitre 1 (section 2.2), chapitre 3 (sections 5.2, 9, 10 et 11), chapitre 4 (fiche C). Supports de la séance 4 : chapitre 1 (section 9.2), chapitre 2 (sections 4.3, 5.3 à 5.5, 7, 9 et 10), chapitre 3 (sections 7.1, 7.5 et 9.3), chapitre 4 (sections 6, 9 et 10), chapitre 5 (fiches U et V).

Dépôt-modèle (`depot-modele/`, relu le 27 novembre 2026) : `README.md` (« Démarrer », « Vérifier avant une PR », « Bon à savoir »), `CLAUDE.md`, `docs/ARCHITECTURE.md` (plan des sections), `docs/fiche_conformite.md`, `JOURNAL.md`, `themes/PROJET-B.md` (« Décisions de l'équipe »), `.github/pull_request_template.md`, `docs/seance-4/ci.yml` (déclencheurs).

Vérifications locales (27 novembre 2026, Linux, git 2.53.0, gh 2.100.0, Flutter 3.50.1, Dart 3.14.0), sur des copies du dépôt-modèle placées hors du dépôt du cours, avec des dépôts distants locaux :

- installation à froid : clone, `flutter pub get`, `dart run build_runner build --delete-conflicting-outputs` (83 sorties), `flutter test` (32 tests verts), 45 secondes au total ; `flutter analyze` rejoué à part ; sans génération, échec de compilation de `flutter test` ;
- tag `v1.0-rc` : `git switch main`, `git pull`, `git status`, `git log --oneline -1`, `git tag`, `git fetch`, `git rev-parse v1.0-rc origin/main`, `git push origin v1.0-rc`, `git ls-remote origin main refs/tags/v1.0-rc`, réception par `git pull` sur un second poste, `git show --no-patch --format='%h %ad %s' --date=iso` ;
- correctif et tag `v1.0` : branche, commit, envoi de la branche, fusion simulée en local, `git log --oneline -3`, `git tag v1.0`, `git fetch`, `git rev-parse v1.0 origin/main`, `git push origin v1.0`, `git ls-remote origin main refs/tags/v1.0`, `git ls-remote --tags origin`, `git log --oneline v1.0-rc..v1.0`, `git log --oneline v1.0-rc..origin/main`, `git diff --stat`, `git diff --name-only`, deux tags sur un même commit ;
- erreurs : tag déjà existant, tag non poussé, `Everything up-to-date`, `git pull` oublié (tag d'essai, avec et sans `git fetch`), `git tag -d`, déplacement d'un tag poussé refusé, `git fetch --tags --force`, `git branch -r --contains` (tag dans `main`, tag sur une branche de travail poussée, tag sur une branche jamais poussée) ;
- relecture : `git clone --branch v1.0-rc`, `git status`, `git log --oneline -1` ; `git log --oneline -- CLAUDE.md`.

Commande `gh` essayée en lecture seule sur le dépôt du cours (27 novembre 2026, gh 2.100.0) : `gh run list --commit <identifiant> --limit 5`.
