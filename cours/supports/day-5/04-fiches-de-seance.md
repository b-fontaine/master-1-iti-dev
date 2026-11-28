# Chapitre 4 · Les fiches de la séance : à imprimer ou à suivre à l'écran

*Séance 5 « Retouches et soutenance » · Master ITI, Nantes Université, 2026-2027. Fiches à utiliser pendant la fin du sprint et pendant la séance. Condensées des chapitres 1 à 3. Les commandes git ont été exécutées le 27 novembre 2026 sous Linux (git 2.53.0, Flutter 3.50.1, Dart 3.14.0), sur une copie du dépôt-modèle placée hors du dépôt du cours, avec un dépôt distant local : rien n'a été écrit sur GitHub ; quelques commandes `gh` ont été essayées en lecture seule sur le dépôt du cours.*

Ce chapitre ne contient presque pas d'explications : il rassemble ce que vous gardez sous les yeux avant et pendant la séance. Chaque fiche annonce en tête son « Fini quand », se termine par un tableau « Si ça coince » et renvoie à la section du chapitre qui explique le pourquoi. Les lettres continuent celles des séances 2 (fiches 0 et A à F), 3 (fiches G à N) et 4 (fiches O à V) : W, X, Y et Z sont les dernières. L'exemple suivi est celui de l'équipe `equipe_04`, du thème B.

| Fiche | Pour quel moment | Explications |
|---|---|---|
| [W · Avant la séance : `v1.0-rc` et dossier de rendu](#fiche-w--avant-la-séance--v10-rc-et-dossier-de-rendu) | Fin du sprint, en équipe, jusqu'à l'avant-veille de la séance à 18h (mercredi 27 janvier 2027) | [Chapitre 1](01-geler-et-livrer.md), sections 2 à 6 |
| [X · Retouches bloquantes, gel et `v1.0`](#fiche-x--retouches-bloquantes-gel-et-v10) | Début de séance, en équipe (blocs 1 à 3) | Chapitre 1, sections 7 à 10 |
| [Y · Répétition et soutenance d'équipe](#fiche-y--répétition-et-soutenance-déquipe) | Répétition technique, puis passage de l'équipe (blocs 4 et 5) | [Chapitre 2](02-la-soutenance-d-equipe.md) |
| [Z · Oral individuel, fiche des pairs et livrable](#fiche-z--oral-individuel-fiche-des-pairs-et-livrable) | La veille, chacun pour soi ; puis le passage, les fiches des pairs et la clôture (blocs 5 à 8) | [Chapitre 3](03-l-oral-individuel-et-la-note.md) |

## Ce que vous allez retenir

- Les lignes qui commencent par `$` se tapent dans le terminal, **sans** le `$`. Les mots entre chevrons (`<numéro>`, `<dépôt>`) sont à remplacer, chevrons compris.
- Trois échéances précèdent la séance : au plus tard une semaine avant, soit le **vendredi 22 janvier 2027** (réponse du RSSI, gel des fonctionnalités) ; l'avant-veille à 18h, soit le **mercredi 27 janvier 2027 à 18h** (tag `v1.0-rc` et dossier de rendu) ; la veille avant 9h, soit le **jeudi 28 janvier 2027 avant 9h** (votre PR tirée au sort vous est communiquée).
- Un tag se pose sur le **dernier commit de `main`**, quand sa pastille est verte. On **vérifie avant de pousser** (`git fetch`, puis `git rev-parse`), on **prouve après** (`git ls-remote`). Aucun contrôle ne démarre sur un tag : la CI verte se lit sur le commit tagué.
- Après `v1.0`, **on ne pousse plus**. git refuse par défaut de déplacer un tag déjà poussé ; forcer reste techniquement possible, et c'est interdit : on ne force jamais.
- La démonstration est **en direct**. Le plan de secours (démonstration enregistrée, jeu de données de secours) ne sert qu'en cas de panne.
- Chaque étudiant répond à **deux questions**. « C'est l'agent qui l'a écrit » n'est pas une réponse recevable : votre PR se prépare la veille, par les preuves.
- Ne se sacrifient jamais : le gel et le tag `v1.0`, les soutenances avec leurs deux questions individuelles, les fiches d'évaluation par les pairs.

---

## Fiche W · Avant la séance : `v1.0-rc` et dossier de rendu

**En équipe, pendant la fin du sprint. Répartition proposée par les supports : un seul membre pose le tag, un coéquipier le vérifie depuis un autre poste ; le test à froid revient au gardien de la démonstration quand l'équipe en a un. Fini quand :** chaque pièce du dossier de rendu est cochée ; le `README` a été testé à froid en moins de 10 minutes ; la démonstration a été répétée une fois, en équipe, avec chronomètre ; `v1.0-rc` est sur GitHub, posé sur le dernier commit de `main`, pastille verte, avant l'avant-veille de la séance à 18h, soit le mercredi 27 janvier 2027 à 18h ; la version web publiée s'ouvre.

**Étape 1 · Le calendrier de la fin du sprint.** Les formules sont celles du programme (« S5 » est la séance 5), suivies de la date.

| Formule du programme | Date | Ce qui est attendu |
|---|---|---|
| « au plus tard une semaine avant S5 » | **Vendredi 22 janvier 2027** | Réponse du RSSI et **gel des fonctionnalités au soir** (« ensuite : correctifs, documentation, préparation de la démonstration ») |
| « l'avant-veille de S5 à 18h » | **Mercredi 27 janvier 2027 à 18h** | Tag `v1.0-rc` et dossier de rendu |
| « la veille de S5 », « avant 9h » | **Jeudi 28 janvier 2027 avant 9h** | Lecture des dépôts par l'enseignant ; communication des PR tirées au sort |
| | **Vendredi 29 janvier 2027, après-midi** | Séance 5 : retouches bloquantes, `v1.0`, soutenance |

Règle de prudence du programme : **« ne pas commencer un gros chantier au dernier moment »**. Proposition, au-delà du programme : après le gel des fonctionnalités, ce qui n'est pas fini va dans la colonne « abandonné » du backlog, et l'équipe l'assume (objectif 1 de la séance).

Entre `v1.0-rc` et le début de la séance, le programme ne dit pas ce qui est permis ; proposition des supports : appliquer déjà la règle du bloc 2 (chapitre 1, section 2).

**Étape 2 · Le dossier de rendu, pièce par pièce.** Le texte en gras est celui du programme, mot pour mot ; la preuve écrite en face est une proposition des supports, tirée de la grille et de la definition of done.

- [ ] **dépôt à jour** : les PR à livrer sont fusionnées dans `main` ; la pastille du dernier commit de `main` est verte.
- [ ] **`README` d'installation** : testé à froid (étape 3), l'application démarre en moins de 10 minutes.
- [ ] **`CLAUDE.md`** : à jour ; il décrit le projet tel qu'il est aujourd'hui, pas celui du 2 décembre.
- [ ] **`docs/ARCHITECTURE.md` (une page : composants, modèle de données, décisions)** : on y trouve vos composants, votre modèle de données et vos décisions (forme à confirmer : chapitre 1, section 4.4).
- [ ] **`docs/fiche_conformite.md` (avec réponse du RSSI)** : les 13 rubriques sont remplies ; la rubrique 13 porte la réponse datée (go, go sous conditions avec actions, ou no-go assumé avec les raisons) ; aucun nom civil, aucun courriel.
- [ ] **`JOURNAL.md`** : l'« État courant » est réécrit à la date du rendu.
- [ ] **les PR avec leurs sections de suivi** : chaque PR fusionnée porte sa section « Ce que l'agent a proposé, ce que j'ai refusé » et ses trois lignes de suivi (temps estimé, temps réel, retouches) ; deux PR portent l'étiquette `erreur-agent`.

Une pièce qui manque se corrige par une PR relue, comme le reste : `main` est protégée.

**Étape 3 · Le test à froid, selon le `README` de votre dépôt.** Chronomètre lancé, dans un dossier vide (pas dans votre dépôt). Proposition des supports : le test est fait par un membre qui n'a pas écrit le `README`.

```bash
$ gh repo clone <organisation>/<dépôt>
$ cd <dépôt>
$ flutter pub get
$ dart run build_runner build --delete-conflicting-outputs
$ flutter test
$ flutter analyze
$ flutter run -d chrome
```

Ce sont les cinq commandes que le `README` du dépôt-modèle donne après le clone : tapez-les **dans l'ordre où votre `README` les donne**. À voir : `Got dependencies!`, `Built with build_runner … wrote … outputs.`, `All tests passed!`, `No issues found!`, puis le premier écran de votre application dans Chrome. Arrêtez le chronomètre au premier écran : **moins de 10 minutes**.

Sur le dépôt-modèle nu, le clone et les trois premières commandes (`flutter pub get`, `build_runner`, `flutter test`) ont pris 45 secondes au total, sur un poste dont les bibliothèques étaient déjà téléchargées (un poste qui les télécharge pour la première fois met plus longtemps) :

```text
Built with build_runner/aot in 29s; wrote 83 outputs.
00:02 +32: All tests passed!
```

`flutter analyze` y a répondu `No issues found! (ran in 1.1s)`. Votre dépôt a d'autres tests et d'autres durées.

> **Attention.** La definition of done écrit le test à froid ainsi : « (`git clone`, `flutter pub get`, `flutter run -d chrome`) ». Sans `dart run build_runner build --delete-conflicting-outputs`, `flutter test` ne compile pas (vérifié : voir « Si ça coince ») ; l'échec de `flutter run -d chrome` sans génération n'a pas été rejoué. Suivez le `README` de votre dépôt, qui cite cette commande. Si votre `README` l'a perdue, c'est lui qu'il faut corriger.

**Étape 4 · La répétition chronométrée.** Programme : **« Répétition de la démonstration avant S5 : une fois, en équipe, avec chronomètre. »** Proposition, au-delà du programme (chapitre 2, section 10.1) : répétez sur l'état que vous allez taguer `v1.0-rc`, donc **avant** l'étape 5. Ce que la répétition doit vous apprendre :

- si la partie commune tient dans ce qui reste une fois les questions comptées (avec la transition, de l'ordre de 8 minutes pour une équipe de 4, 5 pour une équipe de 5 : fiche Y, étape 2) : notez la durée de chacun de ses trois temps (fiche Y, étape 3) ;
- si le scénario passe du début à la fin, sur la machine et par la voie prévues ;
- si vous savez repartir de zéro avec le jeu de données de secours (fiche Y, étape 4) ;
- qui parle, et qui tient le clavier.

**Étape 5 · Poser `v1.0-rc`.** Quatre vérifications avant de taguer (liste proposée par le chapitre 1, section 5.1) :

1. Tout ce qui doit être évalué est fusionné dans `main`, `JOURNAL.md` compris.
2. Le dernier commit de `main` porte une coche verte sur GitHub : les trois contrôles exigés et `publication`.
3. Le test à froid a été fait sur cet état (étape 3).
4. La fiche a sa rubrique 13, ou l'attente est documentée.

Depuis **un seul** poste :

```bash
$ git switch main
$ git pull
$ git status
$ git log --oneline -1
```

À voir, pour `git status` :

```text
Sur la branche main
Votre branche est à jour avec 'origin/main'.

rien à valider, la copie de travail est propre
```

Puis une ligne : le dernier commit de `main`, celui dont GitHub montre la coche verte. Les messages de git sont cités en français, tels qu'ils ont été obtenus ; un git réglé en anglais répond `nothing to commit, working tree clean`. Si `git status` dit autre chose, ne taguez pas (« Si ça coince »).

**On vérifie avant de pousser :**

```bash
$ git tag v1.0-rc
$ git fetch
$ git rev-parse v1.0-rc origin/main
```

`git tag v1.0-rc` n'affiche rien quand il réussit ; `git fetch` n'affiche rien quand il n'y a rien de nouveau. À voir : **deux lignes identiques**, le tag est sur le dernier commit de `main`.

```text
b53f271e61427a519078ddfd31623402b697d2e0
b53f271e61427a519078ddfd31623402b697d2e0
```

Deux lignes différentes : ne poussez pas (« Si ça coince »). Sans `git fetch`, cette vérification est trompeuse : elle compare le tag à ce que votre poste savait de `main`, pas à ce que contient GitHub.

**On prouve après :**

```bash
$ git push origin v1.0-rc
$ git ls-remote origin main refs/tags/v1.0-rc
```

```text
To <adresse du dépôt>
 * [new tag]         v1.0-rc -> v1.0-rc
```

```text
b53f271e61427a519078ddfd31623402b697d2e0	refs/heads/main
b53f271e61427a519078ddfd31623402b697d2e0	refs/tags/v1.0-rc
```

`git ls-remote` interroge le dépôt distant lui-même : le même identifiant sur les deux lignes prouve que le tag reçu par GitHub est sur le dernier commit de `main`. Les sept premiers caractères de cet identifiant sont ceux qu'affiche `git log --oneline -1`.

**Étape 6 · Vérifier le rendu comme le fera un évaluateur.**

1. **Depuis un autre poste.** Le tag arrive avec `git pull` :

   ```bash
   $ git pull
   $ git tag --list 'v1.0*'
   ```

   ```text
   Depuis <adresse du dépôt>
    * [nouvelle étiquette] v1.0-rc    -> v1.0-rc
   Déjà à jour.
   ```

   ```text
   v1.0-rc
   ```

2. **Sur GitHub.** La page `https://github.com/<organisation>/<dépôt>/tags` liste `v1.0-rc`. Ouvrez le commit tagué : une coche verte figure à côté. Le workflow ne se déclenche pas sur un tag : aucun contrôle ne démarre après le push du tag, et c'est normal. En complément, avec l'identifiant relevé à l'étape 5 :

   ```bash
   $ gh run list --commit <identifiant du commit> --limit 5
   ```

   À voir : une ligne par exécution de la CI sur ce commit, du type `completed success … main push …`.

3. **Depuis le tag, à froid.** Dans un dossier vide, **hors de votre dépôt** (sinon `git status` y signale le dossier `relecture/` comme « Fichiers non suivis ») :

   ```bash
   $ git clone --branch v1.0-rc <adresse du dépôt> relecture
   $ cd relecture
   $ git status
   $ git log --oneline -1
   ```

   L'adresse du dépôt est celle que donne le bouton « Code » de sa page GitHub. À voir :

   ```text
   Clonage dans 'relecture'...
   fait.
   Note : basculement sur 'b53f271e61427a519078ddfd31623402b697d2e0'.

   Vous êtes dans l'état « HEAD détachée ». […]
   ```

   ```text
   Actuellement sur aucune branche.
   rien à valider, la copie de travail est propre
   ```

   Le long message « HEAD détachée » est normal : vous regardez un état figé, vous n'y travaillez pas. Rejouez dans ce dossier les commandes de l'étape 3, à partir de `flutter pub get`.

4. **La version web.** `https://<organisation>.github.io/<dépôt>/` montre votre application (fiche Q de la séance 4, étape 6). Rechargez sans le cache avant de conclure.

Le programme fixe l'échéance (l'avant-veille à 18h) sans dire comment l'heure de dépôt est constatée, et un tag de ce type n'a pas de date propre : git affiche celle du commit tagué. En cas de doute, posez la question à l'enseignant **avant** l'échéance.

**Si ça coince.** Les gestes qui ne citent pas le programme sont des propositions des supports.

| Ce que vous voyez | Ce qui se passe | Ce qu'il faut faire |
|---|---|---|
| Sur le clone à froid, `flutter test` s'arrête sur une erreur du type `Error: 'JetLigne' isn't a type.` (chez vous, un autre nom), puis `Some tests failed.` | `build_runner` n'a pas été lancé : les fichiers générés ne sont pas versionnés | `dart run build_runner build --delete-conflicting-outputs`, puis `flutter test`. Si le `README` ne cite pas la commande : le corriger par une PR |
| `git status` ne dit pas « la copie de travail est propre », ou annonce un retard sur `origin/main` | Des modifications ne sont pas commitées, ou `main` a avancé | Ne pas taguer. Finir la PR en cours, ou `git pull` ; fiche F de la séance 2 |
| `fatal: l'étiquette 'v1.0-rc' existe déjà` | Le tag est déjà sur ce poste : posé par vous, ou reçu par `git pull` | Ne pas le refaire. `git ls-remote origin main refs/tags/v1.0-rc` : s'il y figure, c'est terminé |
| Après `git fetch`, `git rev-parse v1.0-rc origin/main` donne deux lignes différentes | Le tag est sur un commit ancien de `main` (`git pull` oublié), ou `main` a reçu une fusion depuis | Tag **pas encore poussé** : `git tag -d v1.0-rc`, `git pull`, `git tag v1.0-rc`, puis revérifier. Déjà poussé : dernière ligne du tableau |
| `git ls-remote origin main refs/tags/v1.0-rc` ne donne qu'une ligne, celle de `main` | Le tag a été posé, pas poussé | `git push origin v1.0-rc` |
| Un coéquipier ne voit pas le tag sur son poste | Il n'a pas encore reçu le tag | `git pull`, puis `git tag --list 'v1.0*'` |
| La pastille du dernier commit de `main` est rouge avant l'échéance | Un contrôle échoue sur `main` | Lire le contrôle rouge (chapitre 2 de la séance 4, section 7), corriger par une PR, taguer ensuite |
| Aucun contrôle ne démarre après `git push origin v1.0-rc` | Le workflow ne tourne pas sur un tag | Rien : la CI verte se lit sur le commit tagué |
| Le tag a été poussé au mauvais endroit | git refuse par défaut de déplacer un tag déjà poussé ; forcer reste techniquement possible, et c'est interdit | Ne jamais forcer ; prévenir l'enseignant (fiche X, « Si ça coince ») |

*Explications : chapitre 1, sections 2 (calendrier), 3 (gel des fonctionnalités), 4 (dossier de rendu), 5 (poser `v1.0-rc`), 6 (vérifier le rendu) et 10 (quand ça coince) ; chapitre 2, section 10 (répétition chronométrée).*

---

## Fiche X · Retouches bloquantes, gel et `v1.0`

**Toute l'équipe, en début de séance ; un seul membre pose le tag, un coéquipier le vérifie (proposition des supports). Fini quand :** chacun connaît son ordre de passage, le format et les critères ; les correctifs bloquants sont fusionnés par PR et le dernier commit de `main` a sa coche verte ; `v1.0` est posé sur ce commit, poussé, visible sur GitHub, **avant le premier passage** ; plus personne ne pousse.

**Étape 1 · Le briefing** (bloc 1). Le programme y met : **« Ordre de passage, format, critères. »** Notez :

| Ce qu'on vous annonce | Où le retrouver ensuite |
|---|---|
| Votre ordre de passage, tiré au sort à l'avance | L'affichage dans la salle ; fiche Y, étape 1 |
| Le format (partie commune, questions individuelles, transition) | Fiche Y, étapes 2 et 3 |
| Les critères (grille sur 20, échelle de 0 à 4) | Fiche Z, étape 3 ; chapitre 3, section 8 |

**Étape 2 · Les retouches bloquantes** (bloc 2). Programme, mot pour mot : **« Correctifs de bugs bloquants, documentation, mise à jour de la fiche de conformité (dont la réponse du RSSI), finition. Aucune nouvelle fonctionnalité. Dernier passage de la CI. »** Si la séance prend du retard : « s'en tenir aux seuls correctifs bloquants, et ne pas déborder sur le gel ».

Le programme ne définit pas « bloquant ». Proposition du chapitre 1 (section 8.2), à valider par l'enseignant : est bloquant ce qui empêche une ligne de la definition of done d'être vraie (fiche Z), ou ce qui empêche votre scénario de démonstration de se dérouler. Le reste se note et attend.

Un correctif passe **toujours par une PR** : `main` est protégée. L'exemple est celui d'un titre d'écran à corriger.

```bash
$ git switch main
$ git pull
$ git switch -c correctif/titre-ecran
```

```text
Basculement sur la nouvelle branche 'correctif/titre-ecran'
```

Le correctif fait (proposition du chapitre 1, section 8.3 : d'abord le test qui reproduit le bug, vu rouge, puis vert) :

```bash
$ git add <fichiers corrigés>
$ git commit -m "fix: corrige le titre de l'écran d'accueil"
$ git push -u origin correctif/titre-ecran
$ gh pr create --web
```

À voir, pour le commit puis pour le push (pour l'essai, la modification portait sur `README.md`) :

```text
[correctif/titre-ecran 65cc4fd] fix: corrige le titre de l'écran d'accueil
 1 file changed, 2 insertions(+)
```

```text
To <adresse du dépôt>
 * [new branch]      correctif/titre-ecran -> correctif/titre-ecran
la branche 'correctif/titre-ecran' est paramétrée pour suivre 'origin/correctif/titre-ecran'.
```

Puis, sur la page de la PR : la description remplie (elle aussi a ses sections de suivi), la relecture d'un coéquipier, les trois contrôles exigés verts (`analyse-et-tests`, `securite`, `site-web`), la fusion par commit de fusion.

**Le dernier passage de la CI.** Après la dernière fusion, attendez la coche verte sur le dernier commit de `main` (page d'accueil du dépôt). C'est ce commit qui sera tagué.

**Étape 3 · Le gel et `v1.0`** (bloc 3). Programme : **« Tag `v1.0`. À partir de là, on ne pousse plus. »** Intention : « Figer ce qui sera évalué ; le tag `v1.0` est posé avant le premier passage. » Depuis un seul poste :

```bash
$ git switch main
$ git pull
$ git status
$ git log --oneline -3
```

À voir, sur l'exemple : `git pull` apporte le correctif (le fichier `README.md` de l'essai), `git status` répond « la copie de travail est propre », et le dernier commit est la fusion de la PR.

```text
Depuis <adresse du dépôt>
   b53f271..5d2e30f  main       -> origin/main
Mise à jour b53f271..5d2e30f
Fast-forward
 README.md | 2 ++
 1 file changed, 2 insertions(+)
```

```text
5d2e30f Merge pull request #42 from equipe/correctif/titre-ecran
65cc4fd fix: corrige le titre de l'écran d'accueil
b53f271 Dépôt d'équipe créé depuis le modèle
```

**On vérifie avant de pousser** (comme pour `v1.0-rc` : fiche W, étape 5) :

```bash
$ git tag v1.0
$ git fetch
$ git rev-parse v1.0 origin/main
```

À voir : deux lignes identiques. Deux lignes différentes : ne poussez pas (« Si ça coince »).

```text
5d2e30f5b9c5dc85cbce2e97af78ef288f5f632a
5d2e30f5b9c5dc85cbce2e97af78ef288f5f632a
```

**On prouve après :**

```bash
$ git push origin v1.0
$ git ls-remote origin main refs/tags/v1.0
```

```text
To <adresse du dépôt>
 * [new tag]         v1.0 -> v1.0
```

```text
5d2e30f5b9c5dc85cbce2e97af78ef288f5f632a	refs/heads/main
5d2e30f5b9c5dc85cbce2e97af78ef288f5f632a	refs/tags/v1.0
```

Le même identifiant sur les deux lignes : le tag reçu par le dépôt distant est sur le dernier commit de `main`.

**Étape 4 · Constater.**

1. **Ce qui sépare `v1.0-rc` de `v1.0`** : ce que l'enseignant n'a pas lu la veille.

   ```bash
   $ git log --oneline v1.0-rc..v1.0
   $ git diff --stat v1.0-rc v1.0
   ```

   ```text
   5d2e30f Merge pull request #42 from equipe/correctif/titre-ecran
   65cc4fd fix: corrige le titre de l'écran d'accueil
   ```

   ```text
    README.md | 2 ++
    1 file changed, 2 insertions(+)
   ```

   Sans aucune retouche depuis `v1.0-rc`, les deux tags sont sur le même commit et ces deux commandes n'affichent rien.

2. **Sur GitHub** : la page `https://github.com/<organisation>/<dépôt>/tags` liste `v1.0` et `v1.0-rc` ; le commit tagué a sa coche verte.
3. **Sur les autres postes** : `git pull`, puis `git tag --list 'v1.0*'` répond `v1.0` et `v1.0-rc`.

**À partir de là, on ne pousse plus.** Lecture des supports (chapitre 1, section 9.5) : ni commit, ni fusion, ni tag. Ce qui est découvert ensuite se contourne (fiche Y) ou se dit en soutenance ; cela ne se corrige plus dans le dépôt.

Le programme dit « `v1.0` au début de S5 » (dossier de rendu) et « `v1.0` est taguée avant le premier passage » (definition of done) : le gel a lieu en début de séance, après les retouches, avant les passages.

**Si ça coince.** Les gestes qui ne citent pas le programme sont des propositions des supports.

| Ce que vous voyez | Ce qui se passe | Ce qu'il faut faire |
|---|---|---|
| `fatal: l'étiquette 'v1.0' existe déjà` | Le tag est déjà sur ce poste | Ne pas le refaire. `git ls-remote origin main refs/tags/v1.0` : s'il y figure, passer à l'étape 4 |
| Après `git fetch`, `git rev-parse v1.0 origin/main` donne deux lignes différentes | Le tag est sur un commit ancien de `main` (`git pull` oublié), ou `main` a reçu une fusion depuis | Tag **pas encore poussé** : `git tag -d v1.0`, `git pull`, `git tag v1.0`, puis revérifier. Déjà poussé : arrêter les fusions, prévenir l'enseignant, ne pas déplacer le tag |
| `git ls-remote origin main refs/tags/v1.0` ne donne qu'une ligne, celle de `main` | Le tag a été posé, pas poussé | `git push origin v1.0` |
| Un tag d'essai, **jamais poussé**, traîne sur votre poste | Il n'existe que chez vous | `git tag -d essai-local` ; à voir : `Étiquette 'essai-local' supprimée (elle était sur 5d2e30f)` |
| ` ! [rejected]        v1.0 -> v1.0 (already exists)` en réponse à `git push origin v1.0` | Un `v1.0` existe déjà sur le dépôt distant, ailleurs que le vôtre. git refuse par défaut de déplacer un tag déjà poussé ; forcer reste techniquement possible, et c'est interdit | Ne jamais forcer. Réaligner votre tag local sur celui du dépôt distant (ci-dessous), prévenir l'enseignant |
| La réponse de `git branch -r --contains v1.0` ne cite pas `origin/main` (elle est vide, ou ne cite qu'une branche de travail, par exemple `  origin/correctif/essai`) | Le tag est posé sur une branche de travail, pas sur `main` | Pas encore poussé : `git tag -d v1.0`, `git switch main`, `git pull`, reprendre l'étape 3. Déjà poussé : prévenir l'enseignant |
| La pastille de `main` est rouge à l'heure du gel | La dernière fusion casse un contrôle | Le programme ne dit rien de ce cas : prévenir l'enseignant tout de suite (chapitre 1, section 10.3) |
| Aucun contrôle ne démarre après `git push origin v1.0` | Le workflow ne tourne pas sur un tag | Rien : la CI verte se lit sur le commit tagué |

Le remède « `git tag -d`, `git pull`, `git tag` » a été essayé avec un tag d'essai, pas avec `v1.0`. Réponse de `git branch -r --contains v1.0` pour un tag bien placé (d'autres branches peuvent s'y ajouter) :

```text
  origin/HEAD -> origin/main
  origin/main
```

**Le refus de déplacer un tag.** Essai fait pour ces fiches, à ne pas reproduire : un tag `v1.0` déplacé sur un poste, puis poussé, est refusé ainsi.

```text
To <adresse du dépôt>
 ! [rejected]        v1.0 -> v1.0 (already exists)
error: impossible de pousser des références vers '<adresse du dépôt>'
hint: Les mises à jour ont été rejetées car l'étiquette existe déjà dans la branche distante.
```

Pour réaligner un tag local déplacé par erreur sur celui du dépôt distant, une commande suffit :

```bash
$ git fetch --tags --force
```

```text
Depuis <adresse du dépôt>
 t [mise à jour de l'étiquette] v1.0       -> v1.0
```

Si votre `main` local a lui aussi divergé : fiche C de la séance 2, étape 4.

*Explications : chapitre 1, sections 7 (briefing), 8 (retouches bloquantes), 9 (gel et `v1.0`) et 10 (quand ça coince).*

---

## Fiche Y · Répétition et soutenance d'équipe

**Toute l'équipe, dans la salle. Fini quand :** la démonstration a été vérifiée sur l'affichage de la salle, avec le jeu de données de secours et la démonstration enregistrée ; l'équipe est passée (partie commune en trois temps, puis questions individuelles) ; chacun a tenu sa place dans le public pendant les autres passages.

**Étape 1 · Une salle, votre rang de passage.** Toutes les équipes passent dans la même salle, l'une après l'autre, devant l'enseignant, seul évaluateur, sans observateur. L'ordre de passage est « tiré au sort à l'avance et affiché dans la salle » ; s'il change, l'annonce de l'enseignant fait foi. La salle a un vidéoprojecteur, un chronomètre visible de tous et une machine de secours. L'enseignant chronomètre lui-même et note les écarts ; il peut confier le chronomètre et la fiche d'observation, facultative, à un étudiant volontaire d'une équipe qui ne passe pas.

**Étape 2 · Le budget indicatif.** Programme, mot pour mot : de l'ordre de **« 20 minutes par équipe »**, **« transition comprise : une partie commune brève, puis trois minutes de questions par étudiant »**. Ces chiffres sont des **« ordres de grandeur à ajuster »** selon les équipes. Même budget à 7 équipes : « Une équipe de 5 a quinze minutes de questions : sa partie commune est d'autant plus brève. »

| Moment du passage | Ordre de grandeur |
|---|---|
| Questions individuelles, deux par étudiant (question 1 brève, question 2 très brève) | Trois minutes par étudiant (programme) : 12 minutes pour une équipe de 4, 15 pour une équipe de 5 |
| Partie commune, toute l'équipe, puis transition avec l'équipe suivante | Ce qui reste (calcul des fiches) : de l'ordre de 8 minutes pour une équipe de 4, 5 pour une équipe de 5 |

Le programme ne découpe ni la partie commune ni la transition : c'est votre répétition chronométrée (fiche W, étape 4) qui fixe la durée de chacun de ses trois temps.

**Étape 3 · La partie commune, en trois temps.** La colonne du milieu est le texte du programme ; la colonne de droite reprend les preuves que propose le chapitre 2 (sections 4, 6 et 8). Aucune ne demande d'ouvrir du code.

| Temps | Ce que le programme y met | Ce que vous montrez (proposition) |
|---|---|---|
| 1. Démonstration en direct | « sur un scénario choisi par l'équipe » | L'application lancée par la voie choisie (version publiée, ou poste de l'équipe), avec des données fictives |
| 2. « Sous le capot » | « harnais, une décision sur les données, un moment de l'historique git, mesures temps estimé et réel » | **Harnais** : une règle de `CLAUDE.md` ajoutée en cours de projet et la PR qui l'a ajoutée ; le refus de l'agent d'écrire dans `test/acceptance/`. **Décision** : ce qui a été décidé, ce qui a été écarté, pourquoi, et la preuve (la liste des tables dans `docs/ARCHITECTURE.md`, la rubrique 2 de la fiche, la ligne datée de `PROJET.md`). **Historique** : une PR et ses commits. **Mesures** : les lignes « Suivi » des PR, compilées |
| 3. Point de conformité | « fiche, avis du RSSI, limites d'usage » | Les rubriques 9, 12 et 13 de `docs/fiche_conformite.md` ; les tests de refus verts ; la mesure propre à votre thème, à l'écran |

Les tests de refus se lancent avec `flutter test --plain-name "refuse"` (fiche O de la séance 4) ; à voir, en dernière ligne : `All tests passed!`.

Deux éléments de la grille se montrent pendant ce passage :

- **La compilation des mesures** (critère « Soutenance » : « temps estimé, réel, retouches »). Chacun relève les trois lignes « Suivi » de ses PR fusionnées ; la liste de ses PR :

  ```bash
  $ gh pr list --state merged --author "@me"
  ```

  À voir : une ligne par PR (numéro, titre, branche, état, date).
- **Les deux cas `erreur-agent`** (critère « Process git et équipe » : « contrôlés en soutenance »). Onglet *Pull requests*, filtre sur l'étiquette, ou :

  ```bash
  $ gh pr list --state all --label erreur-agent
  ```

  À voir : une ligne par PR étiquetée (chapitre 2, section 7.4 : sur le dépôt du cours, qui n'a pas cette étiquette, la liste était vide).

Proposition des supports : ouvrez ces pages dans des onglets **avant** de passer. Pendant le passage, on montre, on ne cherche pas.

**Étape 4 · Le plan de secours.** Programme, mot pour mot : **« Démonstration en direct, avec plan de secours (démonstration enregistrée et jeu de données de secours, à utiliser seulement en cas de panne). Une démonstration enregistrée sans plan B live est pénalisée. »** Le « plan B enregistré » du bloc 4 désigne la démonstration enregistrée ; il n'a rien à voir avec le plan B de publication de la séance 4.

- [ ] La démonstration enregistrée existe, et elle se lit sur le poste de la démonstration.
- [ ] Le jeu de données de secours existe, il est fictif de bout en bout, et vous savez **repartir de zéro** avec lui : base vide, seed, import, écran attendu.
- [ ] Vous savez où est la machine de secours de la salle.

Proposition, au-delà du programme (chapitre 2, section 5.2) : le jeu de données de secours est ce que votre scénario consomme (le seed à graine fixe et le fichier CSV fictif que vous importez) ; l'enregistrement se garde hors du dépôt, à un endroit qui ne dépend pas du réseau.

**Étape 5 · La répétition technique** (bloc 4). Programme : **« Répétition technique par les équipes, chacune vérifiant sa démonstration (affichage, jeu de données de secours, plan B enregistré) ; le branchement au vidéoprojecteur se vérifie à tour de rôle. »** Pendant ce temps, l'enseignant relit l'échelle sur ses deux exemples de réponses. Les trois vérifications sont celles du programme ; la colonne de droite est une proposition des supports.

| Vérification | Geste | Ce que vous devez voir |
|---|---|---|
| Affichage | À votre tour, brancher le poste de la démonstration sur le vidéoprojecteur, lancer l'application | Le premier écran, lisible depuis le fond de la salle |
| Jeu de données de secours | Repartir de zéro une fois | L'application montre l'état de départ du scénario |
| Plan B enregistré | Ouvrir l'enregistrement sur le poste | Il se lit sur le poste de démonstration, sans dépendre du réseau |

Lecture des supports : `v1.0` est posé, donc la répétition ne corrige plus rien dans le dépôt. Un défaut découvert ici se contourne dans le scénario, ou se dit.

Si la séance prend du retard, la répétition technique est « faite en équipe avant la séance ou pendant le passage de l'équipe précédente ».

**Étape 6 · Le passage** (bloc 5). Programme : **« démonstration en direct, « sous le capot », conformité, puis questions individuelles. Une pause au milieu des passages, au moment le moins gênant. »**

1. Pendant la transition : brancher le poste, ouvrir l'application et les onglets préparés.
2. La partie commune, dans l'ordre de l'étape 3.
3. Les questions individuelles, étudiant par étudiant (fiche Z).

Le programme ne dit pas qui parle : décidez-le à la répétition (chapitre 2, section 10).

**Étape 7 · Pendant que les autres passent.** Programme : **« Tous les étudiants sont dans la salle : ils forment le public et remplissent les fiches d'évaluation par les pairs. »** Vous restez dans la salle pendant les passages des autres équipes. La fiche des pairs porte sur les membres de **votre** équipe (fiche Z, étape 5) ; le programme les place à la fois pendant les passages et au bloc 6 : l'enseignant dit quand les remplir (chapitre 3, section 12).

**Si ça coince.** Les quatre premières lignes sont une proposition, au-delà du programme (chapitre 2, section 5.3) : décidez à l'avance ce qui prend le relais, et qui prononce « on bascule ».

| Ce que vous voyez | Ce qui se passe | Ce qu'il faut faire |
|---|---|---|
| Les données sont abîmées en cours de démonstration | Une manipulation a changé l'état de départ | Le jeu de données de secours : repartir de l'état connu |
| La voie choisie ne répond plus (réseau, ou application locale) | Panne de la voie de démonstration | L'autre voie, préparée à l'avance (chapitre 2, section 4.4) |
| Le poste de l'équipe est en panne, ou ne s'affiche pas | Panne de matériel | La machine de secours de la salle, avec la version publiée et le jeu de données de secours |
| Plus rien ne permet de montrer l'application en direct | Panne générale | La démonstration enregistrée, commentée à voix haute |
| La répétition technique n'a pas eu lieu | La séance a pris du retard | La faire « pendant le passage de l'équipe précédente » |
| À la répétition, la partie commune et la transition dépassent nettement ce qui reste une fois les questions comptées (fiche Y, étape 2) | Scénario trop long | Proposition des supports : retirer du contenu, garder les trois temps |
| Un défaut apparaît à la répétition | `v1.0` est posé, on ne pousse plus | Proposition des supports : le contourner dans le scénario, ou le nommer comme une limite |
| Un membre de l'équipe est absent | | « l'équipe passe normalement » ; l'absent est interrogé dans les 15 jours (fiche Z) |

*Explications : chapitre 2, sections 2 (dispositif à une salle, budget, variante à 7 équipes, public), 3 à 5 (partie commune, démonstration, plan de secours), 6 à 9 (« sous le capot », mesures, conformité, regard critique), 10 (répéter) et 11 (le passage).*

---

## Fiche Z · Oral individuel, fiche des pairs et livrable

**Chacun pour soi la veille et pendant le passage, puis en équipe pour le livrable. Fini quand :** vous avez préparé votre PR tirée au sort ; vous avez répondu à vos deux questions ; votre fiche d'évaluation par les pairs est remplie et rendue ; chaque ligne de la definition of done ci-dessous est vraie.

**Étape 1 · Les deux questions.** Programme, mot pour mot : **« chaque étudiant reçoit deux questions, avec la même trame pour tous. Question 1 (la plus longue) : une PR tirée au sort parmi celles qu'il a ouvertes ou approuvées, dont la taille atteint le seuil de 20 lignes modifiées hors fichiers générés (à défaut, sa plus grosse PR), communiquée 24 h avant (la veille de S5 avant 9h). Question 2 (brève) : une question de compréhension, par exemple nommer un patron d'architecture présent dans le code de l'équipe et dire quel problème il résout. »**

| | Question 1 | Question 2 |
|---|---|---|
| Sur quoi | Une PR que vous avez ouverte **ou approuvée** | La compréhension du projet ; elle « peut porter sur une règle du thème, un cas d'erreur d'agent, la fiche de conformité ou les droits d'une personne concernée » |
| Quand vous la connaissez | La veille de la séance avant 9h, soit le **jeudi 28 janvier 2027 avant 9h** | Sur le vif |
| Comment s'y préparer | Étape 2 | Proposition des supports : relire `PROJET.md` (les règles du thème), les deux PR `erreur-agent`, la fiche de conformité, le chapitre 3 de la séance 3, section 5 (les droits des personnes), et un patron d'architecture (chapitre 9 de la séance 1, sections 6 et 8 ; `docs/ARCHITECTURE.md`) |

**Étape 2 · La veille : préparer sa PR par les preuves** (proposition des supports, au-delà du programme). Vous n'avez pas à lire le code ligne à ligne : vous rassemblez ce qui s'observe.

1. **Retrouver la PR.** Onglet *Pull requests* du dépôt, PR fermées, le numéro communiqué. En complément, vos PR ouvertes, puis celles que vous avez relues (relues, pas seulement approuvées) :

   ```bash
   $ gh pr list --state merged --author "@me"
   $ gh pr list --state all --search "reviewed-by:@me"
   ```

   À voir : une ligne par PR (numéro, titre, branche, état, date).
2. **Relire sa description** : le résumé, la section « Ce que l'agent a proposé, ce que j'ai refusé », les trois lignes de suivi.
3. **Lire la liste des fichiers** : onglet « Files changed » de la PR, ou :

   ```bash
   $ gh pr diff <numéro> --name-only
   $ gh pr view <numéro> --json number,title,additions,deletions,changedFiles
   ```

   La première donne un fichier par ligne ; la seconde, la taille de la PR, sous cette forme (essai sur un autre dépôt) : `{"additions":88,"changedFiles":8,"deletions":47,"number":11,"title":"…"}`. Repérez les dossiers : `lib/` (l'application), `test/` (les tests), `docs/`.
4. **Dire ce que les tests vérifient.** Pour chaque fichier de `test/` de la PR, lisez le titre des tests ou les phrases du `.feature` : dans le dépôt-modèle, ils sont écrits en français. Sur `main` à jour, après `build_runner`, `flutter test` se termine par `All tests passed!`.
5. **Lancer l'application** (`flutter run -d chrome`) et retrouver à l'écran ce que la PR a changé, si elle change quelque chose de visible.
6. **Préparer quatre phrases, en langage clair** : ce que fait la PR et pourquoi ; ce qui changerait si on la modifiait (quel test rougirait, quel écran changerait) ; un risque ; un test que vous ajouteriez ou une autre façon de faire, le lien avec une règle du thème, les données ou la conformité, et une limite. La trame complète, en sept lignes, est au chapitre 3, section 4.7.

**Étape 3 · L'échelle de compréhension, de 0 à 4** (programme, mot pour mot). « Chaque question est notée de 0 à 4, la note est la moyenne des deux questions arrondie au demi-point. La question 1, préparée à l'avance sur une PR communiquée 24 h avant, porte l'essentiel de la note ; la question 2 vérifie la compréhension sur le vif ».

| Niveau | Ce que l'enseignant entend |
|---|---|
| **0** | ne reconnaît pas la PR ou le projet, aucune explication. |
| **1** | lit à voix haute sans dire pourquoi. |
| **2** | explique ce que fait la PR et pourquoi, mais ne sait pas prévoir les conséquences d'un changement. |
| **3** | explique, prévoit les conséquences d'une modification (« que se passe-t-il si je supprime cette ligne ? ») et repère un risque. |
| **4** | en plus, propose un test ou une alternative argumentée, relie le travail aux règles du thème, aux données ou à la conformité, et nomme une limite. L'explication est faite **en langage clair**, comme à un chef de projet. |

Règle « Responsabilité » du programme : **« L'étudiant qui ouvre ou approuve une PR en est responsable et doit pouvoir l'expliquer. « C'est l'agent qui l'a écrit » n'est pas une réponse recevable. »**

**Étape 4 · Le passage.** Les questions individuelles suivent la partie commune de votre équipe (fiche Y, étape 6). L'enseignant, seul évaluateur, a devant lui une fiche de notation pré-remplie à votre nom, avec votre PR tirée au sort et l'échelle de 0 à 4 pour les deux questions. Ordre de grandeur : trois minutes par étudiant pour les deux questions (question 1 brève, question 2 très brève).

**Étape 5 · La fiche d'évaluation par les pairs** (**Indispensable** : 1 point de la note). Programme, mot pour mot : **« chaque étudiant note les autres membres de son équipe de 0 à 2 sur trois questions fixes. Pour chaque étudiant noté, on calcule la somme des trois notes donnée par chaque évaluateur (0 à 6), puis la médiane de ces sommes sur les évaluateurs, convertie ainsi : 0 point si la médiane vaut 0 à 2, 0,5 point si elle vaut 3 à 4, 1 point si elle vaut 5 à 6. Les fiches restent confidentielles. »** Dans cette phrase, « évaluateur » désigne le coéquipier qui note, pas l'enseignant.

| Médiane des sommes | Point obtenu |
|---|---|
| 0 à 2 | 0 |
| 3 à 4 | 0,5 |
| 5 à 6 | 1 |

Les trois questions figurent sur la fiche distribuée en séance. Vous notez chacun des autres membres de votre équipe, pas vous-même. Proposition des supports : remplissez la vôtre seul. Le programme place ces fiches à la fois pendant les passages et au bloc 6 : l'enseignant dit quand les remplir (chapitre 3, section 12).

**Étape 6 · Retour d'expérience écrit et clôture** (blocs 7 et 8). Pas de plénière : un questionnaire en ligne, rempli en fin de séance s'il reste du temps, sinon après : « Ce qui a marché, ce qui a échoué, ce que je ferais autrement ; l'IA, les limites, la conformité ; ce que je dirais à une équipe de développement. » Puis les consignes pour la suite : questionnaire de fin de formation en ligne, notes.

**Le livrable de fin de séance** (programme, mot pour mot). Tag `v1.0`, dossier de rendu à jour (section 7) et soutenance passée. « Section 7 » est celle du programme : la liste du dossier de rendu est dans la fiche W, étape 2.

**La definition of done** (programme, mot pour mot), à cocher ensemble :

- [ ] `v1.0-rc` est déposé l'avant-veille de S5 à 18h ; `v1.0` est taguée avant le premier passage le jour de S5 ; la CI est verte sur les deux tags ; le `README` testé à froid (`git clone`, `flutter pub get`, `flutter run -d chrome`) permet de lancer l'application en moins de 10 minutes, et la version web publiée sur GitHub Pages est accessible.
- [ ] La fiche de conformité est complète (13 rubriques) et contient la **réponse du RSSI** datée (go, go sous conditions avec actions, ou no-go assumé avec les raisons).
- [ ] Chaque étudiant a répondu à **deux questions individuelles** : une sur une PR tirée au sort communiquée la veille de S5, une de compréhension.
- [ ] `JOURNAL.md` est à jour et les PR portent leur section « ce que l'agent a proposé, ce que j'ai refusé » et leurs temps.

Les preuves de chaque ligne : fiches W (étapes 2, 3, 5 et 6) et X (étapes 3 et 4) pour la première, fiche W (étape 2) pour la deuxième et la quatrième, cette fiche pour la troisième. Le test à froid suit le `README` de votre dépôt, `build_runner` compris (fiche W, étape 3).

**Ne se sacrifient jamais** (programme) : le gel et le tag `v1.0`, les soutenances avec leurs deux questions individuelles, les fiches d'évaluation par les pairs. Si les passages prennent du retard, on renvoie le questionnaire après la séance et on réduit la clôture avant de toucher à un passage.

**Peut glisser** (programme) : le retour d'expérience collectif (par questionnaire en ligne) et la communication des notes après la séance.

**Si la séance prend du retard**, l'ordre de coupe du programme est : le retour d'expérience écrit (rempli après la séance) ; le bloc des retouches (réduit aux seuls correctifs bloquants) ; la répétition technique (faite avant la séance ou pendant le passage de l'équipe précédente) ; la clôture (réduite aux consignes essentielles).

**L'absent** (programme) : « l'équipe passe normalement ; l'étudiant absent le jour de la soutenance est interrogé dans les 15 jours avec la même trame. »

**Si ça coince.** Les gestes qui ne citent pas le programme sont des propositions des supports.

| Ce que vous voyez | Ce qui se passe | Ce qu'il faut faire |
|---|---|---|
| La veille de la séance à 9h (jeudi 28 janvier 2027), vous n'avez pas reçu votre PR | La communication ne vous est pas parvenue | Prévenir l'enseignant sans attendre |
| La PR tirée au sort est une PR que vous avez approuvée, pas ouverte | Le tirage porte sur les PR « ouvertes ou approuvées » | La préparer de la même façon : en l'approuvant, vous en êtes devenu responsable |
| Votre PR fait moins de 20 lignes | Aucune de vos PR n'atteint le seuil | Normal : « à défaut, sa plus grosse PR » |
| Vous ne retrouvez pas la PR | Elle est fermée, donc absente de la liste par défaut | Onglet *Pull requests*, PR fermées ; ou les deux commandes de l'étape 2 |
| La PR ne change rien de visible à l'écran | Elle porte sur les données, les tests ou la CI | S'appuyer sur la liste des fichiers et sur ce que vérifient les tests |
| On vous demande « que se passe-t-il si je supprime cette ligne ? » | C'est le niveau 3 de l'échelle | Répondre par ce qui s'observerait : le test qui rougirait, l'écran qui changerait. Dire ce que vous ne savez pas plutôt que l'inventer |
| Vous êtes absent le jour de la séance | | Votre équipe passe ; vous êtes interrogé dans les 15 jours, avec la même trame |

*Explications : chapitre 3, sections 2 à 4 (les deux questions, la PR tirée au sort, la préparer), 5 et 6 (l'échelle, la question 2), 7 (les règles d'usage de l'IA), 9 (contribution vérifiée, évaluation par les pairs), 11 (absent, un seul évaluateur) et 12 (après les passages) ; definition of done : chapitre 1, section 11 ; chapitre 2, section 12 ; chapitre 3, section 13.*

---

## Glossaire

- **Candidat à la version finale** (*release candidate*, `-rc`) : version que l'on pense pouvoir livrer telle quelle, déposée pour être vérifiée avant la version finale ; ici, le tag `v1.0-rc`, que l'enseignant lit la veille de la séance.
- **Correctif bloquant** : correction sans laquelle la version ne peut pas être livrée ou montrée. Le programme n'en donne pas de définition ; celle-ci est une proposition (chapitre 1, section 8.2). Avec la documentation, la mise à jour de la fiche de conformité et la finition, c'est tout ce que le bloc 2 autorise en séance avant `v1.0`. Entre `v1.0-rc` et le début de la séance, le programme ne dit pas ce qui est permis (chapitre 1, section 2).
- **Dossier de rendu** : les pièces que l'équipe livre avec le tag : dépôt à jour, `README`, `CLAUDE.md`, `docs/ARCHITECTURE.md`, fiche de conformité avec la réponse du RSSI, `JOURNAL.md`, PR avec leurs sections de suivi.
- **`erreur-agent`** : étiquette GitHub posée sur une PR qui documente une erreur de l'agent repérée par l'équipe ; elle sert à retrouver ces cas (chapitre 3 de la séance 2, section 9.3).
- **Fiche d'évaluation par les pairs** : fiche confidentielle sur laquelle chaque étudiant note les autres membres de son équipe ; elle compte pour 1 point.
- **Gel du code** : moment de la séance 5 où le tag `v1.0` est posé ; « à partir de là, on ne pousse plus ». À distinguer du gel des fonctionnalités, au plus tard une semaine avant la séance, après lequel on ne fait plus que des correctifs, de la documentation et la préparation de la démonstration.
- **HEAD détachée** : état d'un dépôt local placé sur un commit précis (par exemple un tag) et non sur une branche. Normal pour relire, à éviter pour travailler.
- **Médiane** : valeur du milieu d'une série de nombres rangés par ordre croissant.
- **Partie commune** : les trois temps que l'équipe présente ensemble : démonstration en direct, « sous le capot », point de conformité.
- **Pastille** : la coche verte ou la croix rouge que GitHub affiche à côté d'un commit ; elle résume l'état des contrôles de la CI sur ce commit.
- **Plan B de publication (séance 4)** : build web local et démonstration avec `flutter run -d chrome` quand GitHub Pages ou Actions posent problème. Ce n'est pas le plan de secours de la démonstration.
- **Plan de secours de la démonstration** : démonstration enregistrée (le « plan B enregistré » du bloc 4) et jeu de données de secours, à utiliser seulement en cas de panne.
- **Test à froid** : installation rejouée depuis un clone neuf, dans un dossier vide, en ne suivant que le `README`.

Les autres termes (tag, PR, commit de fusion, contrôle exigé, CI, harnais, grille go/no-go…) sont définis dans les glossaires des séances 1 à 4 et des chapitres 1 à 3.

---

## Pour aller plus loin

- Chapitres 1 à 3 de cette séance : le pourquoi de chaque geste, fiche par fiche (voir la ligne « Explications » en fin de fiche).
- Supports de la séance 4 : chapitre 2, section 10 (un tag, une release, la CI et les tags) et section 7 (lire un contrôle rouge sans lire le code) ; chapitre 5, fiches O (tests de refus), Q (publication, adresse du site) et V (dépannage).
- Supports de la séance 3, chapitre 5 : fiche I (checklist de revue de PR).
- Supports de la séance 2 : chapitre 3, section 11.2 (poser un tag) ; chapitre 4, fiches C (étape 4), E (modèle de PR) et F (dépannage git).
- Dans votre dépôt : `README.md` (« Démarrer : les commandes après le clone »), `.github/pull_request_template.md`, `docs/fiche_conformite.md`.

---

## Points non vérifiés (à signaler honnêtement)

- **Les fiches n'ont pas été rejouées en tant que telles.** Elles reprennent des commandes git exécutées le 27 novembre 2026 sous Linux seulement (git 2.53.0, messages en français), sur une copie du dépôt-modèle et un dépôt distant local. Ni Windows ni macOS. Le message anglais `nothing to commit, working tree clean` est cité sans avoir été obtenu.
- **Rien n'a été écrit sur GitHub.** N'ont pas été observés : la page des tags d'un dépôt d'équipe, la coche verte sur un commit tagué, une PR de correctif sous la protection de `main`, `gh pr create --web`, `gh repo clone`, le clone d'un tag depuis une adresse GitHub, le site GitHub Pages. La fusion de la PR de l'exemple a été simulée par une fusion locale, et son message (« Merge pull request #42 … ») écrit pour l'essai.
- **Séquences de tag.** Les deux suites « `git tag`, `git fetch`, `git rev-parse`, `git push`, `git ls-remote` » ont été rejouées de bout en bout contre un dépôt distant local. Le remède « `git tag -d`, `git pull`, `git tag` » et le cas des deux lignes différentes ont été essayés avec un tag d'essai, pas avec `v1.0` ni `v1.0-rc`. La réponse `origin/correctif/essai` de `git branch -r --contains` vient d'un essai sur une branche de travail poussée.
- **Commandes `gh`** : essayées en lecture seule sur le dépôt du cours. `gh pr list --state all --search "reviewed-by:@me"` et `gh pr list --state all --label erreur-agent` y ont rendu une liste vide ; leur résultat sur un dépôt d'équipe n'a pas été observé.
- **Test à froid** : mesuré sur le dépôt-modèle nu (32 tests ; 45 secondes pour le clone et les trois premières commandes, bibliothèques déjà en cache), pas sur un dépôt d'équipe ; `flutter run -d chrome` n'a pas été rejoué pour cette séance.
- **Le test à froid de la definition of done oublie `build_runner`.** Elle écrit « (`git clone`, `flutter pub get`, `flutter run -d chrome`) » ; sans `dart run build_runner build --delete-conflicting-outputs`, `flutter test` ne compile pas (vérifié) ; l'échec de `flutter run -d chrome` sans génération n'a pas été rejoué. Les fiches suivent le `README` du dépôt ; le programme n'a pas été corrigé.
- **Les trois dates** (vendredi 22, mercredi 27 à 18h et jeudi 28 janvier 2027 avant 9h) sont déduites de la date de la séance, le vendredi 29 janvier 2027 : les formules du programme font foi. La PR est dite « communiquée 24 h avant » ; la séance ayant lieu l'après-midi, le délai réel est un peu plus long.
- **L'heure de dépôt de `v1.0-rc`** : le programme ne dit pas comment elle est constatée, et un tag léger ne porte pas de date propre.
- **Entre `v1.0-rc` et la séance** : le programme ne dit pas ce qui est permis ; appliquer déjà la règle du bloc 2 est une proposition.
- **« `v1.0` au début de S5 » et « avant le premier passage »** : les fiches lisent ces deux formules comme compatibles (gel en début de séance, après les retouches, avant les passages), sans horaire.
- **La CI rouge à l'heure du gel** : le programme ne dit pas quoi faire ; la fiche X renvoie à l'enseignant.
- **L'échelle de 0 à 4 suppose une lecture ligne à ligne** (« lit à voix haute », « si je supprime cette ligne »), alors que les étudiants ne sont pas développeurs. Elle est citée mot pour mot ; la préparation proposée passe par les preuves.
- **Fiches d'évaluation par les pairs.** Le programme parle de « trois questions fixes » sans les écrire : elles figurent sur la fiche distribuée en séance. Il place le remplissage à la fois pendant les passages et au bloc 6. Il ne dit pas comment convertir une médiane qui tombe entre deux tranches (2,5 ou 4,5, possible quand un étudiant est noté par un nombre pair de coéquipiers, dans une équipe de 5 ou de 3).
- **Autres points du programme, détaillés dans les chapitres** : quel tag sert aux critères lus dans le dépôt, et la definition of done quand un étudiant est absent (chapitre 1) ; le temps qui reste pour la partie commune d'une équipe de 5, la phrase « sans plan B live » (chapitre 2) ; une PR à l'oral et trois PR pour la contribution vérifiée, la « moyenne des deux questions », les fichiers « générés » du seuil de 20 lignes, l'échelle appliquée à la question 2, les sujets de la question 2, moins de trois PR, le plafonnement, le bonus, le caractère nominatif de la fiche des pairs (chapitre 3).
- **Soutenance** : rien du déroulement réel n'a été observé, et aucune soutenance n'a été jouée dans le format retenu (une salle, un seul évaluateur) ; le temps qui reste pour la partie commune et la transition (de l'ordre de 8 minutes pour une équipe de 4, 5 pour une équipe de 5) est un calcul des fiches ; aucun enregistrement de démonstration n'a été essayé, et aucun outil n'est recommandé pour le faire.
- **Textes proposés, à valider par l'enseignant** : un seul membre pose le tag, un autre vérifie ; le test à froid confié au gardien de la démonstration, et fait par un membre qui n'a pas écrit le `README` ; le sort de ce qui n'est pas fini au gel des fonctionnalités (colonne « abandonné ») ; la règle du bloc 2 appliquée dès `v1.0-rc` ; les preuves écrites en face de chaque pièce du dossier de rendu ; répéter avant de taguer, et la liste de ce que la répétition doit apprendre ; les quatre vérifications avant de taguer ; la définition de « bloquant » et le test d'abord pour un correctif ; « ni commit, ni fusion, ni tag » après `v1.0` ; la colonne « Ce que vous montrez » de la partie commune ; les onglets ouverts avant de passer ; la composition du jeu de données de secours, « repartir de zéro » et l'enregistrement gardé hors du dépôt ; la colonne « Ce que vous devez voir » de la répétition technique, et « la répétition ne corrige plus rien » ; les quatre relais en cas de panne ; la façon de se préparer à la question 2 ; les six gestes de préparation de la PR et les quatre phrases ; « remplissez la vôtre seul » ; le calcul du temps qui reste pour la partie commune et la transition (fiche Y, étape 2) ; les gestes des tableaux « Si ça coince » qui ne citent pas le programme.

---

## Sources

- Chapitres 1 à 3 de ce support, qui portent le détail des explications et des vérifications.
- `cours/programme-detaille.md` : séance 5 (principe du rendu, objectifs, matériel, format de la soutenance, blocs 1 à 8, ordre de coupe, « ne se sacrifient jamais », « peut glisser », livrable, definition of done) ; section 5 (le sprint final) ; section 7 (grille sur 20, échelle de 0 à 4, repères, format de la soutenance, dossier de rendu, règles d'usage de l'IA) ; rôles d'équipe.
- Essais du 27 novembre 2026, sous Linux (git 2.53.0, gh 2.100.0, Flutter 3.50.1, Dart 3.14.0) : copie du dépôt-modèle, dépôts distants locaux, postes clonés, clones de relecture.
- Dépôt-modèle (`depot-modele/`) : `README.md`, `.github/pull_request_template.md`, `docs/fiche_conformite.md`, `docs/seance-4/ci.yml`.
- Supports de la séance 4, chapitre 2 (section 10) et chapitre 5 (fiches O, Q et V) ; supports de la séance 2, chapitre 4 (fiches C et F).
