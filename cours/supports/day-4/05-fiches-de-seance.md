# Chapitre 5 · Les fiches de la séance : à imprimer ou à suivre à l'écran

*Séance 4 « Qualité, CI/CD, sécurité, AI Act et validation RSSI » · Master ITI, Nantes Université, 2026-2027. Fiches à utiliser pendant la séance. Condensées des chapitres 1 à 4, dont les commandes locales ont été exécutées le 27 novembre 2026 sous Linux (git 2.53.0, gh 2.100.0, Flutter 3.50.1) sur une copie du dépôt-modèle, et dont les sorties GitHub viennent de deux essais en ligne faits le même jour sur un dépôt d'essai créé depuis le dépôt-modèle, le second avec le workflow durci qui est fourni aujourd'hui.*

Ce chapitre ne contient presque pas d'explications : il rassemble ce que vous gardez sous les yeux pendant les ateliers. Chaque fiche se termine par un « Fini quand » (ou l'annonce en tête) et renvoie à la section du chapitre qui explique le pourquoi. Les lettres continuent celles des séances 2 (fiches 0 et A à F) et 3 (fiches G à N).

| Fiche | Pour quel moment | Explications |
|---|---|---|
| [O · Point d'équipe et reprise (rôles, seed)](#fiche-o--point-déquipe-et-reprise-rôles-seed) | Ouverture de séance, chacun puis en équipe (blocs 1 et 2) | [Chapitre 1](01-test-d-acceptation.md), sections 2 et 3 |
| [P · Test d'acceptation du clou](#fiche-p--test-dacceptation-du-clou) | Atelier du clou : gardien produit et second membre (bloc 4) | Chapitre 1, sections 6 à 10 |
| [Q · CI complète, protection de `main` et GitHub Pages](#fiche-q--ci-complète-protection-de-main-et-github-pages) | Atelier CI : gardien du harnais et de la CI, un coéquipier (bloc 6, release du bloc 12) | [Chapitre 2](02-ci-cd-et-publication.md) |
| [R · Atelier de classification (AI Act)](#fiche-r--atelier-de-classification-ai-act) | Atelier en équipe, puis rubrique 9 de la fiche (bloc 9) | [Chapitre 4](04-ai-act-et-rssi.md), sections 2, 3 à 6 |
| [S · Passage devant le RSSI](#fiche-s--passage-devant-le-rssi) | Jeu de rôle, trois tables en parallèle (bloc 10) | Chapitre 4, sections 7 à 9 |
| [T · Audit croisé en 5 points](#fiche-t--audit-croisé-en-5-points) | Atelier d'audit, une équipe en audite une autre (bloc 11) | [Chapitre 3](03-securite-et-audit-croise.md), sections 6 à 9 |
| [U · Bilan, consignes du sprint et livrable](#fiche-u--bilan-consignes-du-sprint-et-livrable) | Fin de séance, en équipe (blocs 12 et 13) | Chapitre 4, section 10 ; chapitre 2, section 10 |
| [V · Dépannage de la séance 4](#fiche-v--dépannage-de-la-séance-4) | Quand ça coince | Chapitres 1 à 3 |

## Ce que vous allez retenir

- Les lignes qui commencent par `$` se tapent dans le terminal, **sans** le `$`. Les mots entre chevrons (`<numéro>`, `<dépôt>`) sont à remplacer, chevrons compris.
- Après douze jours, `dart run build_runner build --delete-conflicting-outputs` **avant** `flutter test` n'est pas facultatif.
- Le test d'acceptation du clou est écrit **avant** le code, par **une autre main** que l'agent, avec des valeurs **recopiées** de l'énoncé ; il est commité **rouge**, dans une PR **en brouillon**. Ce rouge est le livrable.
- Vous ne pouvez ni activer GitHub Pages ni changer la protection de `main` : **l'enseignant le fait, vous le constatez**, avec une commande ou un écran. Trois contrôles sont exigés pour fusionner : `analyse-et-tests`, `securite`, `site-web`.
- **Tout ce qui est dans un build web est public.** Un secret qui fuit se **révoque** ; le supprimer ne suffit pas.
- AI Act : **étape 0 d'abord** (« est-ce un système d'IA ? »), puis l'usage, puis la case et le rôle. *Sensibilisation, pas avis juridique* : la décision revient au RSSI.
- Audit : **ne signaler que ce qui existe dans le dépôt**, une issue par constat, jamais un secret recopié.

---

## Fiche O · Point d'équipe et reprise (rôles, seed)

**Chacun sur son poste, puis en équipe. Fini quand :** `flutter test` est vert sur **chaque** poste ; le tour de table est fait et chaque blocage a un nom en face ; les rôles du thème sont branchés sur la garde `RequireRole`, avec un test de refus par action protégée, vert ; un seed reproductible fictif de taille réduite existe, ou son report au sprint est noté dans `JOURNAL.md`.

**Étape 1 · Le bref contrôle** (bloc 1), dans le dossier de votre dépôt. Les commandes et ce qu'on doit voir sont ceux de la fiche G de la séance 3 :

```bash
$ git status
$ git switch main
$ git pull
$ flutter pub get
$ dart run build_runner build --delete-conflicting-outputs
$ flutter test
```

À voir : `nothing to commit, working tree clean`, puis `Got dependencies!`, `Built with build_runner … wrote … outputs.` et `All tests passed!`. Après douze jours, `git pull` apporte en général beaucoup de choses : `build_runner` est obligatoire avant `flutter test`. Un rouge : fiche N de la séance 3, puis fiche V.

**Étape 2 · Le tour de table** (en équipe, à voix haute, quelques minutes). Chaque question se vérifie sur un écran.

| Question | Où regarder | Ce qu'on doit voir |
|---|---|---|
| Quelles PR sont ouvertes ? | Onglet *Pull requests* du dépôt | Pour chacune : son auteur, son relecteur, ce qui la bloque |
| Qu'est-ce qui bloque ? | Les commentaires `[bloquant]` des PR ouvertes, la ligne « Reste à faire » de `JOURNAL.md` | Un nom en face de chaque blocage |
| La CI est-elle verte sur `main` ? | La pastille à côté du dernier commit de `main` | Une coche verte |
| Où en est la fiche ? | `docs/fiche_conformite.md` sur `main` | Rubriques 1 à 5 remplies, relues par un coéquipier |
| Qu'a terminé la tâche facultative ? | Les PR fusionnées depuis le 4 décembre | Le seed, les rôles, les rubriques 6 et 7, ou rien : on le note |

L'enseignant annonce aussi les **appariements de l'audit croisé** (fiche T) et les **tables du passage devant le RSSI** (fiche S). Notez-les.

**Étape 3 · Brancher les rôles** (bloc 2, **Indispensable** : l'audit de l'après-midi les vérifie). La garde `RequireRole` est déjà dans le dépôt (`lib/core/domain/roles/`), avec son exemple `ViderHistorique`. Commencez par voir les tests de refus existants :

```bash
$ flutter test --plain-name "refuse"
```

Sur le dépôt-modèle :

```text
00:00 +0: test/features/jets/domain/usecases/vider_historique_test.dart: refuse au joueur de vider l’historique, sans rien effacer
00:00 +1: test/core/domain/roles/require_role_test.dart: refuse l’accès à un joueur
00:00 +2: test/core/data/base_de_donnees_test.dart: la base refuse un jet de valeur 0
00:00 +3: All tests passed!
```

La troisième ligne n'est pas un test de rôle (contrainte de la base) : le filtre porte sur le nom.

1. **En équipe, avant de demander quoi que ce soit à l'agent**, dressez la liste des cas d'usage sensibles à partir des droits de `PROJET.md`. Thème B (story S2) :

   | Action | Rôle autorisé | Test de refus attendu |
   |---|---|---|
   | Importer des déclarations (CSV) | `responsable` | un `operateur` est refusé |
   | Exporter les TRS (CSV) | `responsable` | un `operateur` est refusé |
   | Corriger une déclaration ou un arrêt | `responsable` | un `operateur` est refusé |
   | Déclarer sur un quart | `operateur` du poste du quart | un `operateur` d'un autre poste est refusé |

   La garde se branche sur les cas d'usage **qui existent déjà** dans votre dépôt ; les autres la recevront quand ils seront écrits, pendant le sprint (l'import CSV, par exemple). Si aucun cas d'usage sensible n'existe encore chez vous : les rôles du thème remplacent les rôles de démonstration, le tableau est noté dans `PROJET.md`, et c'est tout pour aujourd'hui.
2. **Décidez du sort de `jets`, en équipe, avant de lancer l'agent.** Tant que la fonctionnalité `jets` est dans le dépôt, renommer `meneur` et `joueur` fait échouer à la compilation `ViderHistorique`, son test, le test du Cubit de `jets` et `require_role_test.dart`. Soit retirer `jets` (`docs/ARCHITECTURE.md`, section 7, « Passer en version 2 », étape 1 ; si votre base est déjà en version 2 avec `jets`, c'est une nouvelle migration, coordonnée par le gardien des données) ; soit garder `jets` et, dans la même PR, adapter ces tests d'exemple aux nouveaux rôles, en le disant dans la description (un renommage, aucune attente assouplie).
3. **Confiez le travail à l'agent en mode plan** (chapitre 2 de la séance 2, section 6) : remplacer `meneur` et `joueur` par les rôles du thème dans `role.dart` (et le rôle par défaut de `utilisateur_courant.dart`) ; dans chaque cas d'usage sensible existant, déclarer la garde et l'appeler avant d'agir, comme `ViderHistorique` ; pour chacun, un **test de refus écrit et vu rouge avant la garde** (le rôle non autorisé est refusé, rien n'est modifié).
4. **Constatez.** La commande suivante liste les endroits où la garde est déclarée :

   ```bash
   $ git grep -n "RequireRole(" -- lib
   ```

   Sur le dépôt-modèle, deux lignes : la définition de la garde, puis le seul cas d'usage protégé de l'exemple.

   ```text
   lib/core/domain/roles/require_role.dart:19:  const RequireRole(this.rolesAutorises);
   lib/features/jets/domain/usecases/vider_historique.dart:10:  static const garde = RequireRole({Role.meneur});
   ```

   Chez vous : une ligne par cas d'usage sensible **existant** de votre tableau. Puis `flutter test --plain-name "refuse"` affiche un test de refus par cas d'usage protégé et se termine par `All tests passed!`. Dans l'onglet des commits de la PR, chaque commit de test de refus précède le commit qui ajoute la garde. PR relue par un coéquipier (fiche I de la séance 3).

**Étape 4 · Le seed réduit** (**Important** ; le seed complet peut finir dans le sprint). Un seed **reproductible** (graine fixe, mêmes données à chaque lancement), **fictif** (aucun nom de personne) et **réduit** (quelques postes, quelques quarts). Ce que vous devez voir : un test qui génère le seed deux fois et constate que les deux résultats sont identiques ; l'application lancée (`flutter run -d chrome`) qui montre ces données dans une base vide. Le seed sera publié avec le build web (fiche Q, étape 7) : il doit être fictif de bout en bout.

Le programme laisse une ambiguïté sur le seed **réduit** (l'ordre de coupe le garde « s'il existe », la liste de ce qui ne se sacrifie jamais l'associe aux rôles « s'il a glissé ») : en cas de doute, demandez à l'enseignant s'il peut glisser au sprint.

**Les équipes à jour** avancent : relecture des PR ouvertes, début du CRUD de l'entité principale. Le gardien produit prépare déjà le tableau de la fiche P. Aucune équipe n'est censée avoir terminé le CRUD.

*Explications : chapitre 1, sections 2 et 3 ; chapitre 4 de la séance 3, section 10 (seed et rôles).*

---

## Fiche P · Test d'acceptation du clou

**Le gardien produit écrit, un second membre relit. Fini quand :** le `.feature` est dans `test/acceptance/`, commence par `# language: fr`, reprend **toutes** les lignes du tableau de `themes.md` avec les valeurs recopiées, a été relu ligne à ligne par le second membre ; il est commité **rouge** sur une branche dédiée, dans une **PR en brouillon** dont la description contient la sortie rouge ; la règle `deny` a été essayée, la consigne de `CLAUDE.md` et `.github/CODEOWNERS` sont fusionnés dans `main`.

L'exemple est le thème B, `calculerTrs`, huit cas. Thèmes A (`jugerTraversee`, 7 cas) et C (`repartir`, 7 cas) : votre tableau est dans `cours/projets/themes.md`, rubrique « Cas de test d'acceptation » de votre thème (chapitre 1, section 12).

**Étape 1 · Le gardien produit écrit le `.feature` lui-même**, dans VS Code, **sans** le demander à l'agent (l'agent n'a d'ailleurs pas le droit d'écrire dans ce dossier). Fichier `test/acceptance/calculer_le_trs.feature` :

- **un scénario par ligne du tableau**, nommé « cas N · … » ;
- `# language: fr` en **première ligne**, les valeurs **entre accolades** (`{480}`, `{'pause'}`) ;
- les **phrases de la séance 3 reprises telles quelles** quand elles disent la même chose (« un quart de {480} minutes », « la disponibilité affichée est {'86,7 %'} ») ;
- les **codes de l'énoncé**, pas des libellés (`'changement_serie'`, `'attente_matiere'`) ;
- les heures en ISO 8601 : au cas 8, les heures UTC que donne le tableau, recopiées (`'2026-10-24T20:00:00Z'`) ; au cas 3, « heure de Paris » écrite `'2026-10-06T06:00:00+02:00'`, le décalage `+02:00` étant un ajout ;
- tout ajout au tableau est **signalé dans la PR** (thème B : la catégorie `'pause'` du cas 6 et le décalage du cas 3 ; thème A : la route et le passeur choisis au cas 6 ; thème C : les données non fixées par le tableau aux cas 2 à 7, chaque choix signalé).

Le fichier complet du thème B, tel qu'il a été exécuté, est au chapitre 1, section 6.3. Un scénario y ressemble à ceci :

```gherkin
  Scénario: cas 1 · quart sans arrêt, une déclaration
    Soit un quart de {480} minutes
    Et aucun arrêt
    Et une déclaration avec un cycle de {30} secondes, {900} pièces produites dont {9} rebutées
    Quand je calcule le TRS
    Alors la disponibilité affichée est {'100,0 %'}
    Et la performance affichée est {'93,8 %'}
    Et la qualité affichée est {'99,0 %'}
    Et le TRS affiché est {'92,8 %'}
```

**Étape 2 · Le second membre relit ligne à ligne**, le tableau de `themes.md` d'un côté, le `.feature` de l'autre. Pour **chaque** scénario :

1. le numéro du cas correspond à la même ligne du tableau ;
2. chaque nombre de la colonne « Entrée » se retrouve, **à l'identique**, dans une ligne `Soit` ou `Et`, sauf l'espace des milliers qui disparaît (« 1 200 » devient `{1200}`) ;
3. chaque valeur de la colonne « Sortie attendue » se retrouve dans une ligne `Alors` ou `Et`, **au caractère près** (`'92,8 %'`, pas `'92.8%'`) ;
4. aucune valeur du scénario n'est absente du tableau, sauf les ajouts signalés ;
5. aucune ligne du tableau n'est oubliée (thème B : huit lignes, huit scénarios).

Il coche, ou écrit un commentaire `[bloquant]` sur la ligne fautive. C'est **lui** qui approuvera la PR, pas son auteur.

**Étape 3 · Générer, réparer si besoin, constater le rouge.**

```bash
$ dart run build_runner build --delete-conflicting-outputs
$ flutter test test/acceptance
```

`build_runner` crée le test (non versionné) et, dans `test/steps/`, une étape par phrase nouvelle (dix-neuf sur une copie du dépôt-modèle ; moins chez vous, les phrases de la séance 3 ont déjà leur étape). Avec `bdd_widget_test` 3.1.0, **un squelette peut être généré abîmé** : `flutter test` signale alors `Expected a declaration` ou `Expected a function body or '=>'` dans un fichier de `test/steps/` qui vient d'être créé. Remède : ouvrez le fichier, supprimez tout ce qui suit la première ligne qui ne contient que `}`, enregistrez, relancez (fiche V).

Squelettes réparés, ce que vous devez voir pour chaque cas : `The following UnimplementedError was thrown running a test`, puis, à la fin :

```text
00:00 +0 -8: Some tests failed.
```

Huit cas, huit échecs (`-8`), chacun sur `UnimplementedError` (sept pour A et C). **Ce rouge est le livrable.** Une erreur de compilation dans `test/steps/` n'est pas ce rouge : réparez d'abord.

**Étape 4 · Le commit rouge, sur une branche dédiée.** Des squelettes générés ne passent pas la vérification de mise en forme de la CI (une ligne vide en trop) : `dart format test/steps` les remet en forme, sans rien changer à leur sens.

```bash
$ git switch -c acceptance/trs
$ dart format test/steps
$ git add test/acceptance/calculer_le_trs.feature test/steps/
$ git commit -m "test(acceptance): cas d'acceptation du TRS (rouge)"
$ git show --stat
```

`git show --stat` ne doit lister que le `.feature` et les étapes (sur la copie : `20 files changed, 230 insertions(+)`).

**Étape 5 · La PR en brouillon.**

```bash
$ git push -u origin acceptance/trs
$ gh pr create --draft
```

Jamais `--fill`, qui saute le modèle de PR. La PR **reste en brouillon jusqu'à ce que tous les cas soient verts** (pendant le sprint). Dans sa description : le tableau d'origine (`themes.md`, votre thème), les ajouts signalés, la mention du second membre qui a relu les valeurs (son rôle, pas son nom), la sortie rouge (`+0 -8: Some tests failed.`). La CI de cette PR sera **rouge**, et c'est voulu : le rouge attendu est celui de l'étape « Tester et mesurer la couverture » du contrôle `analyse-et-tests`. Si c'est l'étape « Vérifier la mise en forme » qui échoue, c'est un `dart format test/steps` oublié. On ne « répare » jamais le rouge des tests en touchant au test.

**Étape 6 · Les trois verrous, dans une PR à part**, courte, fusionnée **avant** que la PR du `.feature` ne soit déclarée prête. Vérifiez avant de copier : deux des trois sont déjà dans le dépôt-modèle.

```bash
$ git switch main
$ git pull
$ git switch -c verrous-acceptance
```

1. **La règle `deny`** : ouvrez `.claude/settings.json` ; la liste `deny` doit contenir `"Edit(/test/acceptance/**)",`. Si elle y est, ne la recopiez pas. **Essayez-la une fois** : lancez `claude` à la racine du dépôt et tapez, par exemple :

   ```text
   Avec ton outil d'édition de fichiers, ajoute la ligne « # essai » à la fin
   du fichier .feature de test/acceptance/. N'utilise pas le terminal.
   Rapporte mot pour mot le message obtenu si l'outil refuse.
   ```

   Vous devez voir un refus (sur la copie : `File is in a directory that is denied by your permission settings.`), puis `git status` sans modification. Notez le message dans la description de la PR.
2. **La consigne de `CLAUDE.md`** : rubrique « Interdits », le dépôt-modèle contient déjà « Ne jamais modifier, désactiver ni supprimer un test pour le faire passer. » et « Ne jamais modifier `test/acceptance/`. ». Pour avoir la formulation exacte du programme, ajoutez dessous :

   ```text
   - Un test qui échoue n'est jamais corrigé en modifiant le test.
   ```

3. **Le fichier `CODEOWNERS`** : copiez le modèle fourni, puis, dans la copie `.github/CODEOWNERS`, remplacez les deux identifiants par ceux du gardien produit et du second membre (tableau des rôles de `PROJET.md`) avant de commiter.

   ```bash
   $ cp docs/seance-4/CODEOWNERS.modele .github/CODEOWNERS
   ```

   La dernière ligne doit devenir `/test/acceptance/ @<identifiant-du-gardien-produit> @<identifiant-du-second-membre>`, avec deux vrais identifiants de membres de l'équipe. Un identifiant mal écrit, ou celui d'un compte sans droit d'écriture sur le dépôt, rend la ligne **sans effet**, sans message visible dans la PR. Deux propriétaires, parce que le gardien produit est l'auteur de la PR du `.feature` et ne peut pas l'approuver. Le modèle `docs/seance-4/CODEOWNERS.modele` reste tel quel. C'est l'enseignant qui rend la relecture des propriétaires obligatoire, dans la protection de `main` ; il repère aussi les dépôts dont le `.github/CODEOWNERS` manque ou est sans effet.

Commit, PR (`gh pr create --web`), relecture par un coéquipier, fusion. Ce que vous constatez ensuite : `.github/CODEOWNERS` est sur `main`, les deux identifiants sont exacts, et sur la PR du `.feature`, GitHub affiche les propriétaires parmi les relecteurs demandés.

**Étape 7 · Le geste du relecteur, pour plus tard.** Quand l'agent annoncera « tous les cas sont verts » (sprint), le relecteur vérifie que **le juge n'a pas bougé**, sans lire le code :

```bash
$ git diff --stat <commit rouge> HEAD -- test/acceptance/
$ git log --oneline -- test/acceptance/
```

La première commande ne doit **rien** afficher ; la seconde ne doit montrer, après le commit de départ, que le commit rouge du gardien produit. Puis les valeurs, comparées au tableau (étape 2). Puis la **valeur faussée**, sur votre poste, sur la branche de la PR (`gh pr checkout <numéro>`) : changez une valeur attendue du `.feature` (`'92,8 %'` en `'92,9 %'`), relancez `build_runner` puis `flutter test test/acceptance` ; le cas doit devenir rouge avec `Expected: '92,9 %'` et `Actual: '92,8 %'`. Annuler demande trois commandes, car le test généré, ignoré par git, garde la valeur faussée :

```bash
$ git restore test/
$ dart run build_runner build --delete-conflicting-outputs
$ flutter test test/acceptance
```

Le cas redevient vert. Un cas qui reste vert avec une valeur faussée : son étape ne vérifie rien, commentaire `[bloquant]`.

Les étapes de `test/steps/` ne sont protégées par aucun des trois verrous : seule la relecture les protège.

*Explications : chapitre 1, sections 4 à 10 ; thèmes A et C, section 12.*

---

## Fiche Q · CI complète, protection de `main` et GitHub Pages

**Le gardien du harnais et de la CI ouvre la PR, un coéquipier la relit. Fini quand :** la PR qui active la CI complète est fusionnée (sur elle, trois contrôles verts et `publication` sauté) ; vous avez **constaté** que `analyse-et-tests`, `securite` et `site-web` sont exigés pour fusionner ; `publication` est vert sur `main` et l'adresse publiée montre votre application (ou le plan B est documenté) ; le bundle a été contrôlé et le résultat est noté.

**Qui fait quoi.** Vous avez le droit d'écriture sur le dépôt, pas les droits d'administration.

| Étape | Votre équipe | L'enseignant | Comment vous le constatez |
|---|---|---|---|
| Activer la CI complète | La PR de l'étape 1, relue et fusionnée | Rien | Sur la PR : trois contrôles verts, `publication` sauté |
| Activer GitHub Pages | Prévenir l'enseignant que la PR est fusionnée | Active Pages (source « GitHub Actions ») | Sur `main` : `publication` vert, le site s'ouvre |
| Rendre la CI obligatoire | Prévenir l'enseignant que `main` contient la CI complète | Ajoute `analyse-et-tests`, `securite` et `site-web` aux contrôles exigés de `main` | Étape 4 |
| Contrôler le bundle | Les gestes de l'étape 7 | Rien | Les résultats, notés |

L'ordre compte : l'enseignant ne rend la CI obligatoire que sur un dépôt dont `main` contient **déjà** la CI complète. La PR de l'étape 1 passe donc **en premier**.

**Étape 1 · La PR qui active la CI complète.** Rien n'est à adapter dans le fichier fourni.

```bash
$ git switch main
$ git pull
$ git switch -c ci-complete
$ cp docs/seance-4/ci.yml .github/workflows/ci.yml
$ git status --short
```

Vous devez voir **une seule ligne** : ` M .github/workflows/ci.yml`. Si `cp` ne trouve pas `docs/seance-4/ci.yml` : prévenez l'enseignant (fiche V).

```bash
$ git add .github/workflows/ci.yml
$ git commit -m "ci: activer la CI complète de la séance 4"
$ git push -u origin ci-complete
$ gh pr create --web
```

**Étape 2 · Lire les contrôles de la PR** (un peu plus de deux minutes : les trois premiers contrôles tournent en même temps). Sur la page de la PR, en bas, ou avec `gh pr checks <numéro>` :

| Contrôle | Ce qu'il fait | État attendu sur la PR |
|---|---|---|
| `analyse-et-tests` | Les six commandes de « Vérifier avant une PR », avec `flutter test --coverage`, puis la couverture | vert |
| `securite` | osv-scanner sur `pubspec.lock`, puis gitleaks sur l'historique de `main` (et, sur une PR, les commits de la PR) | vert |
| `site-web` | `flutter build web` avec les options de publication | vert |
| `publication` | Dépôt du site sur GitHub Pages, **depuis `main` seulement**, après les trois autres | sauté (« Skipped ») |

Une fois tout terminé, le résumé de `gh pr checks` est :

```text
Passed: 3, Failed: 0, Skipped/cancelled: 1
```

La couverture s'affiche à la fin de `analyse-et-tests` (sur le dépôt-modèle nu : `Couverture des tests : 58.1 % (251 lignes exécutées sur 432)`) ; **aucun seuil** ne fait échouer la CI.

Le relecteur relit par les preuves : l'onglet « Files changed » ne contient que `.github/workflows/ci.yml`, et les contrôles sont dans l'état du tableau. Il n'a pas à juger le YAML. Approbation par un coéquipier, puis fusion par **commit de fusion**.

**Étape 3 · Prévenir l'enseignant** que `main` contient la CI complète. Il active GitHub Pages et rend `analyse-et-tests`, `securite` et `site-web` obligatoires (`publication` ne l'est pas : une publication bloquée relève du plan B). La protection qu'il pose contient aussi : une approbation obligatoire, la relecture des propriétaires du code (`CODEOWNERS`) exigée, aucune exception pour les administrateurs, la fusion par commit de fusion seulement.

**Étape 4 · Constater que la CI est obligatoire.** Vous ne pouvez pas ouvrir l'écran des réglages de protection ; deux commandes le remplacent.

Sur une PR de votre dépôt ouverte après le réglage, `--required` ne montre que les contrôles exigés pour fusionner :

```bash
$ gh pr checks <numéro> --required
```

Vous devez voir trois lignes, une par contrôle exigé (`analyse-et-tests`, `securite`, `site-web`), chacune avec son état (`pass` quand il est vert) et sa durée. Rien dans la liste : la CI n'est pas encore obligatoire.

Pour lire la même information sur la branche `main` elle-même, y compris celle d'une autre équipe (le geste de l'auditeur, fiche T), cette lecture ne demande aucun droit sur le dépôt :

```bash
$ gh api repos/<organisation>/<dépôt>/branches/main --jq '.protection.required_status_checks.contexts'
```

```text
["analyse-et-tests","securite","site-web"]
```

Une liste vide (`[]`) : la CI n'est pas obligatoire, prévenez l'enseignant. Le constat se voit aussi sur la PR suivante : le bouton de fusion reste indisponible tant que les trois contrôles exigés ne sont pas verts et qu'aucun coéquipier n'a approuvé.

**Une PR ouverte avant la fusion de la CI complète** a tourné avec l'ancien workflow : `securite` et `site-web` n'ont jamais tourné sur elle et y restent « en attente », ce qui bloque la fusion. Mettez sa branche à jour depuis `main` : bouton « Update branch » de la page de la PR, ou dans le terminal :

```bash
$ git switch main
$ git pull
$ git switch <branche-de-la-PR>
$ git merge main
$ git push
```

Le push relance le workflow, cette fois complet.

**Étape 5 · La publication sur `main`.** La fusion déclenche le workflow sur `main` ; les quatre contrôles tournent, `publication` compris. Onglet *Actions*, l'exécution sur `main` : tout doit être vert.

- **`publication` rouge en 5 s** avec `Ensure GitHub Pages has been enabled` : Pages n'était pas encore activé. Prévenez l'enseignant ; une fois Pages activé, onglet *Actions*, l'exécution rouge sur `main`, bouton « Re-run failed jobs ». Inutile de refaire une PR. Si ce bouton ne vous est pas accessible (non vérifié pour un compte étudiant), prévenez l'enseignant ; la prochaine fusion dans `main` republie de toute façon.

**Étape 6 · Vérifier l'adresse publiée** : `https://<organisation>.github.io/<dépôt>/`, affichée aussi sur le contrôle `publication` vert. Ouvrez-la dans Chrome. Vous devez voir votre premier écran (sur le dépôt-modèle, « Jets de dé »), et dans la console des outils de développement (touche `F12`) un message `Using WasmStorageImplementation.sharedIndexedDb …`, normal. Après une publication, le navigateur peut montrer l'ancienne version pendant une dizaine de minutes (cache de 600 s) : rechargez sans le cache avant de conclure. La preuve de publication est le contrôle `publication` vert. Une page blanche ou une erreur 404 : fiche V (chapitre 2, section 5.5).

**Étape 7 · Contrôler le bundle** (gestes proposés par le chapitre 2, à valider par l'enseignant). Sur votre poste, sur `main` à jour, après `build_runner`, construisez la même version que la CI (remplacez `<dépôt>` par le nom de votre dépôt) :

```bash
$ flutter build web --release --base-href "/<dépôt>/" --no-web-resources-cdn --web-content-hash
$ grep -o '<base href="[^"]*">' build/web/index.html
```

À voir : `✓ Built build/web`, puis `<base href="/<dépôt>/">`. Puis :

1. **Le code est lisible** (preuve de la règle, une fois) : sur une branche d'essai jamais poussée (`git switch -c essai-bundle`), faites ajouter par l'agent une constante fictive dans `lib/main.dart`, affichée au démarrage ; reconstruisez ; `grep -rl '<constante>' build/web` la retrouve en clair dans `main.dart.<empreinte>.js`. Annulez tout l'essai, sans rien commiter :

   ```bash
   $ git restore lib/main.dart
   $ git switch main
   $ git branch -D essai-bundle
   $ git status --short
   ```

   La dernière commande ne doit **rien** afficher. Reconstruisez ensuite.
2. **Vos propres valeurs, pas des mots-clés** : `grep -rl '<valeur-connue>' build/web` pour une valeur de votre `.env` local, un nom réel qui ne doit jamais apparaître, un extrait de votre seed. Aucune réponse pour une valeur interdite : conforme. L'extrait du seed, lui, **doit** être retrouvé : le seed est publié. Cherchez une partie **sans accent** (les accents sont encodés, `\xe9`). Chercher `password` ou `api_key` ne prouve rien : Flutter y range des noms de champs.
3. **Aucun `.env` ni fichier de données** :

   ```bash
   $ find build/web -name '.env*'
   $ find build/web/assets -type f
   ```

   La première ne doit rien répondre. La seconde liste les ressources publiées : un `.csv`, `.json` ou `.xlsx` y est public, il doit être fictif.
4. **Où va le navigateur** : sur l'adresse publiée, outils de développement (`F12`), onglet « Network » (Réseau), rechargez. Toutes les requêtes vont vers `<organisation>.github.io/<dépôt>/`, **aucune vers `www.gstatic.com`**. Une requête vers un autre domaine : un tiers à déclarer dans la fiche, ou une erreur.

Notez le résultat des quatre gestes dans une PR ou dans `JOURNAL.md` : c'est la preuve du point « Secrets » de l'audit.

**Plan B** (programme, mot pour mot) : **« Plan B si Pages ou Actions posent problème : build web local et démonstration avec `flutter run -d chrome`, publication terminée dans le sprint. »** La CI obligatoire, elle, ne glisse pas. Documenter, proposition des supports : une ligne datée dans `JOURNAL.md` ou dans « Décisions de l'équipe » de `PROJET.md`, avec le message réel qui a bloqué, ce qui a été fait, et quand la publication reprendra. Faites aussi les gestes de l'étape 7 sur ce build local : il contient tout ce qui est dans `web/`, y compris des fichiers ignorés par git.

**La release `v0.1`** (bloc 12, **Pratique** ; sinon dans le sprint). Condition du programme : `main` est verte, c'est-à-dire une coche verte sur le dernier commit de `main` (attendre aussi `publication` vert, pour donner l'adresse dans les notes, est une proposition des supports). Le workflow ne tourne pas sur un tag : la CI verte se lit sur le **commit tagué**. On tague donc un commit de `main` dont la pastille est verte, celui qu'apporte `git pull` si sa coche est verte sur GitHub.

```bash
$ git switch main
$ git pull
$ git tag v0.1
$ git push origin v0.1
$ gh release create v0.1 --verify-tag --title "v0.1" --generate-notes
```

`--verify-tag` arrête la commande si le tag n'existe pas déjà sur GitHub ; `--generate-notes` produit les notes à partir de l'historique. Notes utiles, proposition : ce que fait l'application à ce stade, l'adresse publiée, ce qui n'est pas encore là (le clou en rouge, l'import CSV).

*Explications : chapitre 2, sections 2 et 3 (qui fait quoi, le workflow), 4 (activation, constat, PR ouverte avant), 5 (publication, page blanche), 6 (bundle), 7 (contrôle rouge), 9 (plan B), 10 (release).*

---

## Fiche R · Atelier de classification (AI Act)

**En équipe, 40 minutes, puis la rubrique 9 pendant le passage devant le RSSI. Fini quand :** les dix cartes ont chacune leurs cinq réponses ; votre feuille est corrigée au crayon d'une autre couleur après la synthèse ; la rubrique 9 de `docs/fiche_conformite.md` contient un rôle, **une seule** case cochée et une justification qui commence par l'étape 0.

*Sensibilisation, pas avis juridique : la décision revient au RSSI, avec le DPO le cas échéant.*

**Étape 1 · Les dix cartes** (module de conformité, section 8.1).

| N° | Carte |
|---|---|
| 1 | Un chatbot qui répond sur la cantine |
| 2 | Un outil qui trie des CV |
| 3 | Un tableau de TRS par poste |
| 4 | Un outil qui note les copies |
| 5 | Un générateur d'images pour un flyer |
| 6 | Une application qui répartit des stagiaires |
| 7 | Une détection d'émotions des opérateurs par caméra |
| 8 | Un script qui résume des comptes rendus de réunion contenant des noms |
| 9 | Un filtre anti-spam |
| 10 | Une application de suivi du temps de pause des salariés |

Les cartes **6 et 10 sont ambiguës** : elles sont réservées à la mise en commun. Ne passez pas vos deux minutes à les trancher.

**Étape 2 · Par équipe, 20 minutes, environ 2 minutes par carte.** Pour chaque carte, cinq réponses, dans cet ordre :

| Question | Ce qu'on note | Exemple, carte 3 |
|---|---|---|
| 1. Est-ce un système d'IA ? (étape 0, art. 3, point 1) | Oui, non, ou « dépend de la façon dont c'est fait » | Non : c'est un calcul |
| 2. Quel usage, sur qui ? | Le domaine (emploi, éducation, information du public…) et les personnes touchées | Équipements d'une ligne ; des opérateurs en arrière-plan |
| 3. Quelle case ? | Hors champ, minimal, obligations de transparence (art. 50), haut risque, interdit | Hors champ |
| 4. Données personnelles en jeu ? | Oui ou non, lesquelles | Oui si des opérateurs sont nommés |
| 5. Ce qui ferait changer la case | Une phrase | S'il servait à évaluer des opérateurs |

**Étape 3 · Mise en commun, 12 minutes**, puis **synthèse de l'enseignant, 8 minutes**. Corrigez votre feuille au crayon d'une autre couleur, **sans effacer** votre première réponse. Le corrigé indicatif du module est au chapitre 4, section 3.4 : à lire **après** l'atelier.

**Étape 4 · Reporter le classement de votre projet dans la rubrique 9.** Chaque équipe le fait **seule**, **pendant l'observation du passage devant le RSSI** (fiche S). Si votre équipe passe la première à sa table, elle n'a pas d'observation avant son tour : rédigez la rubrique 9 pendant la mise en commun de l'atelier, ou présentez-la à l'oral et rédigez-la juste après votre passage. L'ordre de passage est annoncé en séance. Celui qui tient la fiche ouvre `docs/fiche_conformite.md`. Le gabarit (module, section 6.1) :

```text
9. Rôle AI Act : fournisseur ou déployeur ? (justification) :
   Classement AI Act, une case : [ ] hors champ  [ ] minimal  [ ] obligations de transparence (art. 50)  [ ] haut risque  [ ] interdit
   Justification (commencer par : est-ce un système d'IA au sens de l'art. 3, point 1 ?) :
```

La justification suit cet ordre : **étape 0**, **usage**, **case**, **ce qui la ferait changer**, **ce qui reste vrai hors AI Act** (le RGPD). Pour l'étape 0, trois questions tirées des exemples du module : la règle qui produit le résultat est-elle écrite dans l'énoncé ? Les mêmes entrées donnent-elles toujours la même sortie ? L'outil appelle-t-il, à l'exécution, un modèle qui génère, prédit ou recommande ? « Dans l'énoncé », « oui », « non » : **probablement** hors champ (la définition exacte est à vérifier sur les lignes directrices de la Commission).

| | Thème A | Thème B | Thème C |
|---|---|---|---|
| **Étape 0** (provisoire) | Non : règle de jugement fixe | Non : calcul fixe | Non : affectation déterministe ; point à discuter avec le RSSI |
| **Domaine de l'annexe III voisin** | Aucun | Emploi (point 4), si suivi individuel | Éducation (point 3) |
| **Case probable** (module) | Minimal ou hors champ | Hors champ ou minimal | À discuter ; hors champ si l'étape 0 répond « non », avec la démarche « comme si haut risque », pas une qualification juridique |
| **Rôle si c'était un système d'IA** | Fournisseur | Fournisseur | Fournisseur |
| **Ce qui ferait changer la case** | Un texte généré par IA à l'exécution (art. 50) | Une analyse par IA des performances individuelles (haut risque possible) | Un outil qui évalue des étudiants ou pèse fortement sur leur parcours |

- **Rôle** : votre équipe développe l'outil et le publie. Écrivez les deux temps : « fournisseur, si l'outil était un système d'IA » ; « hors champ, aucun rôle AI Act ne s'applique à l'outil, à faire confirmer par le RSSI ».
- **Thème C** : la case est une qualification, la démarche « comme si haut risque » n'en est pas une. Ne cochez pas « haut risque » par précaution. Si l'étape 0 répond « non », cochez **hors champ** et écrivez à côté : « démarche menée comme si haut risque, pas une qualification juridique ». Puis posez la question au RSSI, qui tranche avec le DPO.
- **Erreurs fréquentes** : deux cases cochées ; une justification qui commence par le niveau de risque ; « hors champ, donc rien à faire » (le RGPD reste) ; oublier les réserves « à vérifier » ; parler de l'agent de code au lieu de l'outil livré.

L'exemple du thème B (rubrique 9, version 0.2, puis rubrique 8 pour la v1) est au chapitre 4, section 6.4 ; le squelette de la rubrique 8 du thème C au chapitre 4, section 5.2. Remplacez `[ ]` par `[x]` pour cocher. Aucun nom civil, aucun courriel, aucun `@identifiant` réel dans un exemple.

*Explications : chapitre 4, sections 2 (l'AI Act appliqué au dépôt), 3 (l'atelier et le report en rubrique 9), 4 et 5 (classer pas à pas), 6.2 (rubrique 9).*

---

## Fiche S · Passage devant le RSSI

**Toute l'équipe, à sa table. Fini quand :** votre équipe est passée devant le RSSI, a posé la question « système d'IA ? » avant de classer, a proposé un classement et un rôle, a discuté la rubrique 8 ; la décision provisoire et ses conditions sont notées ; chacun connaît la date de dépôt de la v1, **vendredi 18 décembre 2026 à 18h**.

*Sensibilisation, pas avis juridique. Le RSSI est simulé par l'enseignant (ou un intervenant, ou un étudiant volontaire muni de la grille).*

**Étape 1 · Les tables.** Trois tables en parallèle, un RSSI par table ; les équipes passent à tour de rôle. Si l'attribution réelle des numéros s'en écarte, l'annonce de l'enseignant fait foi.

| 8 équipes (3-3-2) | 7 équipes (3-2-2) |
|---|---|
| Table 1 : 01, 04, 07 | Table 1 : 01, 04, 06 |
| Table 2 : 02, 05, 08 | Table 2 : 02, 05 |
| Table 3 : 03, 06 | Table 3 : 03, 07 |

**Étape 2 · Préparer les écrans**, un ordinateur par équipe, onglets ouverts avant le bloc :

| Critère | Ce que vous montrez | Où le trouver |
|---|---|---|
| Fiche | `docs/fiche_conformite.md`, rubriques 1 à 5 et 9 remplies : la rubrique 9 vient d'être rédigée et n'est pas encore sur `main` (protégée) | L'éditeur, ou la branche de la PR de la fiche (onglet « Pull requests ») |
| Aucun secret | Le contrôle `securite` de la CI, vert | Onglet *Actions* (fiche Q) |
| CI verte | La pastille verte du dernier commit de `main` | Page d'accueil du dépôt |
| Données fictives | Le seed à graine fixe et la liste des tables, sans colonne d'opérateur (B), avec `etu_NNN` (C) | Le seed (fiche O, étape 4) ; les tables de la séance 3 |
| Accès par rôle testé | Le test de refus de la garde `RequireRole`, vert | `flutter test --plain-name "refuse"` (fiche O) |
| Limites d'usage | « Ce que l'outil ne fera pas » de `PROJET.md` | `PROJET.md` |

Les rubriques 6, 7 et 10 à 12 sont pour le sprint, mais **vous devez pouvoir y répondre de vive voix** : deux des trois questions et un critère de no-go (hébergement non identifié) y renvoient.

**Étape 3 · Qui parle** (proposition des supports) : le gardien conformité (ou le gardien produit et conformité) présente la fiche ; un second membre tient l'ordinateur et montre les preuves ; les autres répondent sur leur rôle et **notent** ce que dit le RSSI, mot pour mot si possible.

**Étape 4 · Le passage : 10 à 12 minutes.** Environ **4 minutes** de présentation, **5 minutes** de questions, **2 minutes** de décision (retour des observateurs compris). Trame de présentation proposée par les supports :

1. Ce que fait l'outil, pour qui, combien de temps (rubriques 1 et 5) : 30 s.
2. Les données : fictives ici, ce qu'elles seraient en usage réel, qui elles concerneraient (rubriques 2 à 4) : 1 min.
3. Le classement AI Act : étape 0, case, rôle, ce qui ferait changer la case (rubrique 9) : 1 min.
4. La décision automatisée : qui décide, qui valide, qui conteste (rubrique 8, à discuter) : 1 min.
5. Ce que vous n'avez pas tranché et que vous demandez au RSSI : 30 s.

Les trois questions du RSSI, à préparer en trois phrases chacune (réponses du thème B au chapitre 4, section 7.5 ; du thème C, section 5.2) :

- **« Où partent les prompts ? »**
- **« Qui peut contester ? »** (A : comment un utilisateur fait-il supprimer ses données ? C : la question centrale, voie de contestation après la vue « mon résultat »)
- **« Que se passe-t-il à la fin de vie de l'outil ? »**

Rubrique 8, discutée devant le RSSI et rédigée ensuite pour la v1 : si l'outil prend ou prépare une décision qui touche une personne ; si oui, qui la valide (un **rôle**, jamais un nom), ce que cette personne voit et peut changer, comment la personne concernée conteste. Thème C : l'algorithme propose, le gestionnaire valide avant publication (`brouillon` / `publie`) et peut déroger ; squelette au chapitre 4, section 5.2 ; à faire valider par le DPO si aucun n'est à la table.

**Étape 5 · Observer quand vous ne passez pas.** Au moins un autre passage, avec la **grille go/no-go** (module, section 6.2) ; ou reporter la rubrique 9 (fiche R, étape 4 ; l'équipe qui passe la première la rédige pendant la mise en commun de l'atelier, ou juste après son passage) ; ou avancer l'audit croisé (fiche T).

| Critères go | Critères no-go |
|---|---|
| Données fictives ou justifiées | Données réelles sans cadre |
| Finalité unique | Finalité floue |
| Durée et suppression définies | Secret dans le dépôt |
| Pas de donnée personnelle dans les prompts | Décision automatisée sans humain sur des personnes |
| Rôle AI Act et classement qualifiés et argumentés | Hébergement non identifié |
| Accès par rôle testé | |
| Limites d'usage écrites | |

Pour chaque critère, notez ce que vous avez vu : une preuve montrée, une réponse orale, rien. Regardez aussi si l'équipe commence par l'étape 0, et ce qu'elle montre au lieu de le dire.

**Étape 6 · Noter la décision et en faire des tâches** (façon de faire proposée par les supports).

| Décision | Ce que fait l'équipe |
|---|---|
| **Go** | Finaliser les rubriques restantes pour la v1. Il ne vaut que pour le périmètre pédagogique à données fictives |
| **Go sous conditions** | Une issue par condition, avec la date demandée, attribuée à un membre, rangée en **essentiel** ; chaque issue fermée par une PR qui la cite |
| **No-go** | Dire quoi corriger et sous quel délai, puis corriger avant la v1 |

1. Le jour même, dans `JOURNAL.md` : date, décision, conditions telles que le RSSI les a dites, membre qui les a notées.
2. La rubrique 13 recevra la **réponse écrite** du RSSI sur la v1, au plus tard une semaine avant la séance 5, pas la décision provisoire. Le RSSI s'y désigne par son rôle, jamais par son nom.
3. **Sans réponse, la décision est no-go par défaut.**

*Explications : chapitre 4, sections 6.3 (rubrique 8), 7 (préparer), 8 (le passage), 9 (la décision).*

---

## Fiche T · Audit croisé en 5 points

**Toute l'équipe, sur le dépôt public d'une équipe d'un autre thème. Fini quand :** chacun des cinq points est noté « conforme », « constat » ou « non vérifié » (avec la raison) ; chaque constat est ouvert en issue dans le dépôt audité, sans secret, nom civil ni courriel ; votre équipe a reçu l'audit d'une autre équipe.

**Étape 1 · Qui audite qui** (« X audite Y » ; anneau, jamais deux équipes qui s'auditent mutuellement, jamais le même thème). Si l'attribution réelle des numéros s'en écarte, l'annonce de l'enseignant fait foi.

| 8 équipes | 7 équipes |
|---|---|
| 01→04, 04→07, 07→02, 02→05, 05→08, 08→03, 03→06, 06→01 | 01→04, 04→02, 02→06, 06→03, 03→05, 05→07, 07→01 |

Vous pouvez cloner, lire l'onglet *Actions*, ouvrir le site publié, ouvrir des issues. Vous ne poussez rien, ne fusionnez rien, ne corrigez rien : le constat appartient à l'équipe auditée. Un rapporteur note le résultat de chaque point.

**La règle d'or du programme : ne signaler que ce qui existe dans le dépôt.** Pas d'hypothèse, pas de préférence de style : un fait observé, avec l'endroit où on l'a observé.

**Étape 2 · Les cinq points.** Le texte en gras est celui du programme, mot pour mot.

**1. Installation à froid.** **« `git clone`, `flutter pub get`, `dart run build_runner build --delete-conflicting-outputs`, `flutter test`, `flutter run -d chrome` selon le `README` : l'application démarre en moins de 10 minutes. »**

Chronomètre lancé, dans un dossier vide (pas dans votre propre dépôt) :

```bash
$ gh repo clone <organisation>/<dépôt-audité>
$ cd <dépôt-audité>
```

Puis les commandes **dans l'ordre où le `README` les donne**. Une commande oubliée par le `README` : notez-la (c'est le constat), puis complétez avec la liste ci-dessus. À voir : `Got dependencies!`, `Built with build_runner … wrote … outputs.`, `All tests passed!`, puis l'application dans Chrome. Arrêtez le chronomètre au premier écran.

**2. CI.** **« la pastille est verte sur `main` ; la CI est obligatoire pour fusionner ; l'audit des dépendances pub sans alerte non traitée ; le déploiement sur GitHub Pages fonctionne. »**

- Pastille : page d'accueil du dépôt, coche verte sur le dernier commit de `main`.
- Obligatoire pour fusionner : la lecture qui ne demande aucun droit (fiche Q, étape 4) :

  ```bash
  $ gh api repos/<organisation>/<dépôt-audité>/branches/main --jq '.protection.required_status_checks.contexts'
  ```

  À voir : `["analyse-et-tests","securite","site-web"]`. Une liste vide, ou un nom manquant : constat.
- Audit des dépendances : onglet *Actions*, dernière exécution sur `main`, contrôle `securite`, étape osv-scanner verte ; sinon, une issue ou une décision écrite qui traite l'alerte.
- GitHub Pages : `https://<organisation>.github.io/<dépôt-audité>/` montre l'application, pas une page 404 ni une page blanche. Plan B documenté : ce n'est pas un constat.

**3. Secrets.** **« aucun secret dans le dépôt ni dans l'historique (rapport gitleaks) ni dans le bundle web publié, `.env` ignoré, `.env.example` présent. »**

- Historique : onglet *Actions*, dernière exécution sur `main`, contrôle `securite`, étape gitleaks verte. gitleaks y lit l'historique de `main` : l'audit porte sur `main`, pas sur les autres branches. gitleaks n'est pas à installer : la CI le lance. Une ligne dans `.gitleaksignore` est visible : elle doit avoir sa PR qui dit pourquoi ce n'est pas un secret.
- Bundle, trois gestes : (a) sur l'adresse publiée, l'onglet Réseau (fiche Q, étape 7, geste 4) ; (b) dans la description de la PR de publication ou dans `JOURNAL.md` de l'équipe auditée, la trace de ses propres contrôles du bundle : une absence de trace est un constat ; (c) en option, sur le clone du point 1, le build web de la fiche Q, étape 7, avec **le nom du dépôt audité** dans `--base-href`, puis `find build/web -name '.env*'` (ou l'artefact `github-pages` de la dernière exécution sur `main`, onglet *Actions*).
- `.env` :

  ```bash
  $ git ls-files | grep -i env
  $ git check-ignore -v .env
  ```

  Sur le dépôt-modèle : `.env.example`, puis `.gitignore:2:.env	.env`. Un `.env` dans la première liste, ou aucune réponse à la seconde : constat.
- **Un vrai secret trouvé** : ne le recopiez nulle part, surtout pas dans une issue. Prévenez l'équipe et l'enseignant à l'oral ; l'équipe le révoque ; l'issue, ensuite, décrit le fichier sans la valeur.

**4. Rôles.** **« chaque cas d'usage sensible passe par la garde d'accès `RequireRole` (couche domain) ; un test vérifie le refus. »**

D'abord les actions que le `PROJET.md` de l'équipe auditée réserve à un rôle, **parmi les cas d'usage qui existent déjà** dans le dépôt : une action prévue pour le sprint, pas encore écrite, n'a pas encore de garde, et ce n'est pas un constat. Puis, dans le clone :

```bash
$ git grep -n "RequireRole(" -- lib
$ flutter test --plain-name "refuse"
```

La première donne la définition de la garde, puis une ligne par cas d'usage protégé, dans un dossier `domain/usecases/`  : chaque cas d'usage sensible déjà écrit doit y être. La seconde liste les tests de refus, verts (lisez les titres : le filtre porte sur le nom). Enfin, dans l'application : le rôle non autorisé, l'action tentée, un message de refus, rien de changé.

**5. Fiche.** **« `docs/fiche_conformite.md` existe, sans nom civil ni courriel, cohérente avec ce que fait l'application (durée de conservation et fin de vie, mesures propres au thème : mention d'information et suppression en A, consigne sur les commentaires en B, statut `brouillon` / `publie` en C). »**

```bash
$ git grep -n -E "[A-Za-z0-9._-]+@[A-Za-z0-9.-]+\.[a-z]{2,}" -- docs/fiche_conformite.md
```

Aucune réponse : pas de courriel. Les noms civils se cherchent à l'œil : en-tête, rubriques 3 et 13. Puis la cohérence : la mesure propre au thème de l'équipe auditée se voit-elle dans l'application ? Les mesures propres à chaque thème font partie du sprint : une mesure que la fiche annonce **pour le sprint** n'est pas un constat ; c'en est un seulement si la fiche la dit en place et qu'on ne la trouve pas. La fiche est un brouillon : on vérifie ce qui est écrit, pas ce qui manque. Le fond juridique est l'affaire du RSSI.

**Hors des cinq points, renvoyés au sprint** : entrées et sorties (`customSelect`, `customStatement`, validation), import et export CSV, `pubspec.lock` versionné. N'ouvrez pas d'issue sur l'import CSV, qui n'existe pas encore.

**Étape 3 · Une issue par constat, dans le dépôt audité.** Forme proposée par les supports, à valider par l'enseignant :

```markdown
Titre : [audit] [essentiel] Installation à froid : `flutter test` échoue sur un clone frais

**Point de la checklist** : 1 · Installation à froid
**Ce qui a été fait** : <commandes, dans l'ordre, date et heure>
**Ce qui a été vu** : <dernière ligne d'erreur, copiée du terminal>
**Ce qui était attendu** : <ce que dit le README>
**Priorité proposée** : essentiel ou souhaitable, avec une raison
Audit de l'équipe <numéro>.
```

Dans l'interface : onglet *Issues* du dépôt audité, *New issue*. En ligne de commande, le texte préparé dans un fichier :

```bash
$ gh issue create -R <organisation>/<dépôt-audité> --title "[audit] [essentiel] …" --body-file constat-1.md
```

L'équipe auditée décide de la priorité au bilan (fiche U) et **corrige au moins un constat pendant le sprint, en commençant par un test qui le reproduit** ; sa PR cite l'issue (`Closes #<numéro>`).

*Explications : chapitre 3, sections 6 (anneaux), 7 (les cinq points), 8 (renvoyé au sprint), 9 (issues) et 10 (thèmes) ; chapitre 2, section 6 (bundle).*

---

## Fiche U · Bilan, consignes du sprint et livrable

**En équipe ; le gardien du harnais tient la plume. Fini quand :** chaque ligne de la definition of done ci-dessous est vraie ou son report est écrit ; le backlog du sprint est priorisé (issues de l'audit incluses) ; les rubriques 6, 7 et 10 à 12 de la fiche ont chacune un responsable ; `JOURNAL.md` est à jour dans `main`.

**Le livrable de fin de séance** (programme, mot pour mot). Test d'acceptation du clou (fichiers `.feature`) en rouge dans une PR brouillon ; règle `deny`, consigne `CLAUDE.md` et `CODEOWNERS` fusionnés ; CI complète obligatoire sur `main` protégée ; build web publié sur GitHub Pages par l'équipe ; rôles en place ; brouillon de fiche de conformité (rubriques 1 à 5, classement et rôle AI Act provisoires à la rubrique 9 ; la rubrique 8 (art. 22) est discutée devant le RSSI) présenté au RSSI ; audit reçu (issues) ; release `v0.1` si `main` est verte.

**La definition of done** (programme, mot pour mot), à cocher ensemble :

- [ ] Le workflow CI s'exécute à chaque PR et bloque la fusion en cas d'échec.
- [ ] Aucune PR fusionnée sans relecture par quelqu'un d'autre que l'auteur ; toutes les PR sont fusionnées par merge commit.
- [ ] Un test d'acceptation (fichier `.feature`) a été écrit avant le code qu'il vérifie (valeurs recopiées, relu par un second membre) et `test/acceptance/**` est protégé.
- [ ] Le contrôle de secrets en CI est vert.
- [ ] La version web de l'équipe est publiée sur GitHub Pages (ou le plan B est documenté).
- [ ] Chaque équipe est passée devant le RSSI, a **posé la question « système d'IA ? »**, proposé un classement AI Act et un rôle, et connaît la date de dépôt de la v1 (vendredi 18 décembre 2026).
- [ ] Chaque équipe a audité une équipe et reçu un audit.

Les preuves de chaque ligne : fiches P (`.feature`, verrous), Q (`gh pr checks <numéro> --required`, `publication` vert, adresse), S (décision notée), T (issues ouvertes et reçues).

**Le backlog du sprint** : trois colonnes, **essentiel**, **souhaitable**, **abandonné**. L'équipe décide explicitement de ce qu'elle abandonne. Y entrent : la suite du clou (environ 3 h de travail d'équipe, jusqu'au test d'acceptation vert), l'import CSV (obligatoire), le seed complet et le CRUD s'ils ne sont pas terminés, les mesures de conformité du thème, les issues de l'audit reçu, les conditions du RSSI (en essentiel). En retard : le CRUD se limite à la création et à la lecture, et le seed complet cède avant l'import CSV.

**Ce qui peut glisser dans le sprint** (programme) : Seed complet, publication sur GitHub Pages si elle a bloqué en séance, release `v0.1`, quiz de 8 questions du module (§8.3), suite du clou.

**Ce qui ne se sacrifie jamais** (programme) : le test d'acceptation en rouge, la CI verte et obligatoire sur `main`, le build web construit, les rôles (garde `RequireRole`, avec le seed s'il a glissé), l'atelier de classification, le passage devant le RSSI, l'audit croisé en 5 points.

**Le calendrier du sprint** (programme, section 5). Charge d'équipe : environ 15 à 20 heures, soit 4 à 5 heures par étudiant (équipe de 4), mesures de conformité du thème incluses.

| Quand | Quoi |
|---|---|
| **Vendredi 18 décembre 2026, 18h** | Fiche de conformité v1 déposée en PR « demande de validation RSSI » ; point d'étape asynchrone avant les vacances (issue de 5 lignes : ce qui est fait, ce qui reste, qui fait quoi et quand ; l'enseignant répond) |
| **Du samedi 19 décembre 2026 au dimanche 3 janvier 2027 inclus** | Vacances : aucun travail imposé au-delà de ce que l'équipe choisit |
| **Au plus tard une semaine avant la séance 5** | Réponse du RSSI, et **gel des fonctionnalités au soir** (ensuite : correctifs, documentation, préparation de la démonstration) |
| **L'avant-veille de la séance 5, 18h** | Tag `v1.0-rc` et dossier de rendu |
| **La veille de la séance 5** | Lecture des dépôts par les évaluateurs ; PR tirées au sort communiquées avant 9h |
| **Vendredi 29 janvier 2027, après-midi** | Séance 5 |

Avant la séance 5 : une répétition de la démonstration, en équipe, avec chronomètre. Règle de prudence : ne pas commencer un gros chantier au dernier moment.

**Avant de quitter la salle** : deux jours séparent la séance de la v1. Répartissez les rubriques 6, 7 et 10 à 12 entre les membres, et levez d'abord les conditions du RSSI qui portent sur la fiche.

**`JOURNAL.md`, dans une PR** (gardien du harnais) : réécrivez l'« État courant » (où on en est, prochaine étape, commandes clés, décisions, reste à faire) ; notez la décision provisoire du RSSI et ses conditions, le plan B s'il a servi, ce qui a glissé et qui s'en charge. Commit, PR, relecture par un coéquipier, fusion par commit de fusion.

**Le quiz de 8 questions** (bloc 13, **Moins utile**, premier coupé) : seul, réponses cachées, dix minutes, en séance ou pendant le sprint (module de conformité, section 8.3).

*Explications : chapitre 4, sections 9 et 10 ; chapitre 2, sections 9 et 10 ; chapitre 3, section 9.3 ; chapitre 1, section 11.*

---

## Fiche V · Dépannage de la séance 4

**Premier réflexe, toujours :** `git status`, et lire ce qu'il répond. Les erreurs de la séance 3 (génération, conflits, migrations) sont dans la fiche N de la séance 3 ; les erreurs git de base dans la fiche F de la séance 2.

**Test d'acceptation et rôles**

| Ce que vous voyez | Ce qui se passe | Ce qu'il faut faire |
|---|---|---|
| `flutter test` rouge après le `git pull` : `Error when reading 'lib/core/data/base_de_donnees.g.dart'` | Les fichiers générés n'existent pas : ils ne sont pas versionnés (clone frais, ou douze jours de PR) | `dart run build_runner build --delete-conflicting-outputs`, puis `flutter test` (fiche O, étape 1) |
| Juste après la génération : `Expected a function body or '=>'` ou `Expected a declaration, but got '}'` dans un fichier de `test/steps/` | Squelette d'étape abîmé par `bdd_widget_test` 3.1.0 (une phrase qui revient avec des valeurs de longueurs différentes) | Ouvrir le fichier, supprimer tout ce qui suit la première ligne qui ne contient que `}`, relancer `flutter test` (chapitre 1, section 7.2) |
| Le fichier abîmé a été supprimé, `build_runner` répond `wrote 0 outputs` et l'étape n'est pas recréée | La génération se croit à jour tant que le `.feature` n'a pas changé | Ne pas supprimer : réparer le fichier (ligne précédente) |
| Les cas d'acceptation échouent tous sur `UnimplementedError` | Les étapes sont encore des squelettes | Normal : c'est le rouge attendu, à commiter (fiche P, étape 3) |
| Une phrase reprise de la séance 3 (« la disponibilité affichée est ») ne lit pas le résultat du TRS | L'étape existante a été écrite pour la story de la séance 3 | Adapter **l'étape** dans `test/steps/`, en gardant le scénario de la séance 3 vert ; **jamais le `.feature`** (chapitre 1, section 7.1) |
| La CI de la PR du `.feature` est rouge à l'étape « Tester et mesurer la couverture » | Les cas n'ont pas encore de code | Normal : la PR reste en brouillon. Ne pas toucher au test |
| La CI de la PR du `.feature` est rouge à l'étape « Vérifier la mise en forme » | Des squelettes générés ont une ligne vide en trop | `dart format test/steps`, commit, push (chapitre 1, sections 7.2 et 7.4) |
| L'agent répond `File is in a directory that is denied by your permission settings.` | La règle `deny` sur `test/acceptance/` fonctionne | Rien : c'est le résultat attendu de l'essai (fiche P, étape 6) |
| L'agent propose de modifier le `.feature` ou de retirer la règle `deny` « pour faire passer » | Il change le juge au lieu du jugé | Refuser ; demander pourquoi le cas échoue ; noter le refus dans la PR |
| Un cas reste vert avec une valeur faussée | Son étape ne compare rien (ligne `expect` absente ou désactivée) | Commentaire `[bloquant]` (chapitre 1, section 8.3) |
| Après `git restore test/`, le cas faussé reste rouge (`Expected: '92,9 %'`) | Le test généré, ignoré par git, garde la valeur faussée | `dart run build_runner build --delete-conflicting-outputs`, puis `flutter test test/acceptance` (chapitre 1, section 8.3) |
| `flutter test --plain-name "refuse"` montre `la base refuse un jet de valeur 0` | Le filtre porte sur le nom : c'est un test d'intégrité de la base | Rien. Lire les titres pour trouver les tests de rôle |

**CI, protection et publication**

| Ce que vous voyez | Ce qui se passe | Ce qu'il faut faire |
|---|---|---|
| `cp` ne trouve pas `docs/seance-4/ci.yml` (ou `CODEOWNERS.modele`) | Votre dépôt a été créé avant la mise à jour du modèle | Prévenir l'enseignant (chapitre 2, section 4.1) |
| `site-web` rouge, la PR ne peut pas être fusionnée | La version web ne se construit pas ; `site-web` est un contrôle exigé | Relancer la commande de build de la fiche Q, étape 7, sur votre poste, sur la branche de la PR (chapitre 2, section 7.2) |
| `publication` n'a pas tourné sur `main` | Il attend que `analyse-et-tests`, `securite` et `site-web` soient verts | Traiter d'abord le contrôle rouge : ce n'est pas un second problème (chapitre 2, section 7.2) |
| `publication` rouge en 5 s : `Ensure GitHub Pages has been enabled` | Pages n'est pas encore activé sur le dépôt | Prévenir l'enseignant ; ensuite, onglet *Actions*, « Re-run failed jobs » (chapitre 2, section 5.2) |
| `securite` rouge : `WRN leaks found: 1` | gitleaks a trouvé une forme de secret ; `File`, `Line`, `Commit` disent où | Ne jamais recopier la valeur. Vrai secret : le **révoquer**, prévenir l'enseignant (chapitre 2, section 7.3) |
| `securite` toujours rouge après un commit qui supprime le fichier | Le secret reste dans le commit précédent : gitleaks lit l'historique de `main` et tous les commits de la PR, pas seulement le dernier | Supprimer ne suffit pas : révoquer, et l'enseignant décide de la suite avec vous |
| L'alerte gitleaks porte sur une valeur d'exemple, pas un secret | Faux positif | Ligne `Fingerprint:` du rapport recopiée dans `.gitleaksignore` à la racine, dans une PR relue qui dit pourquoi ; en cas de doute, demander à l'enseignant (chapitre 2, section 7.4) |
| `securite` rouge à l'étape osv-scanner | Une dépendance de `pubspec.lock` a une vulnérabilité connue | Prévenir l'enseignant avec le nom de la bibliothèque. **Jamais** `flutter pub upgrade` (chapitre 2, section 7.5) |
| La PR reste bloquée, `securite` ou `site-web` « en attente » sans jamais démarrer | La PR a été ouverte avant la fusion de la CI complète : ces contrôles n'ont jamais tourné sur elle | Mettre la branche à jour depuis `main` : bouton « Update branch » de la PR, ou `git merge main` puis `git push` (fiche Q, étape 4 ; chapitre 2, section 4.4) |
| Bouton de fusion indisponible, contrôles verts ; refus `the base branch policy prohibits the merge` | Il manque l'approbation d'un coéquipier (ou d'un propriétaire du code) | Demander la relecture à un coéquipier autre que l'auteur ; pour `test/acceptance/`, au second membre |
| `gh api …/branches/main --jq …` répond `[]`, ou une liste sans `site-web` | La CI n'est pas (entièrement) obligatoire sur `main` | Vérifier que la PR de la CI complète est fusionnée, puis prévenir l'enseignant (fiche Q, étape 3) |
| Page blanche ou erreur 404 à l'adresse publiée | Trois causes, dans cet ordre : `publication` pas encore vert (Pages non activé) ; ancienne version en cache ; `base href` qui ne correspond pas au nom du dépôt | Regarder `publication` sur le dernier commit de `main` ; recharger sans le cache ; sur un build local, `grep -o '<base href="[^"]*">' build/web/index.html` doit donner `<base href="/<dépôt>/">` (dans l'onglet Réseau, des fichiers en 404 le signalent). Sinon, prévenir l'enseignant (chapitre 2, section 5.5) |
| L'ancienne version s'affiche après une fusion | Cache de GitHub Pages (`max-age=600`) | Attendre une dizaine de minutes, recharger sans le cache ; la preuve est `publication` vert (chapitre 2, section 5.4) |
| `find build/web -name '.env*'` répond `build/web/.env` | Un `.env` a été placé dans `web/` : tout `web/` est recopié dans le build | Le retirer de `web/` (un `.env` local va à la racine, où il n'entre pas dans le build), reconstruire, refaire les gestes (chapitre 2, section 6.3) |
| Un `.csv` ou `.json` apparaît sous `build/web/assets/` | Un fichier déclaré comme ressource dans `pubspec.yaml` est publié | Il doit être fictif ; sinon, le retirer des ressources |
| `grep -rlI -i 'password' build/web` répond `main.dart.<empreinte>.js` | Bruit : Flutter range des noms de champs de formulaire | Chercher vos propres valeurs, pas des mots-clés (fiche Q, étape 7) |
| `grep` ne retrouve pas un texte accentué du code | Les accents sont encodés dans le fichier publié (`\xe9`) | Chercher une partie sans accent |
| Couverture affichée `58.1 %` en CI, `58,1 %` sur votre poste | Réglage de langue du poste | Rien : c'est le même nombre |
| Aucun contrôle ne tourne après `git push origin v0.1` | Le workflow ne se déclenche pas sur un tag | Normal : la CI verte se lit sur le commit tagué. Taguer un commit de `main` dont la pastille est verte (chapitre 2, section 10) |

**Sécurité**

| Ce que vous voyez | Ce qui se passe | Ce qu'il faut faire |
|---|---|---|
| `SqliteException(1): … unrecognized token: "'"` sur une saisie avec apostrophe | Une valeur est collée dans le texte d'une requête (`customSelect` concaténé) | La recherche de `customSelect` et `customStatement` du chapitre 3 (section 3.2) ; un test qui reproduit, puis `?` et `variables` (sections 3.3 et 3.4) |
| Vous trouvez une vraie clé dans un dépôt audité | Fuite d'un secret | Ne la recopier nulle part ; prévenir l'équipe et l'enseignant à l'oral (fiche T, point 3) |

**Trois choses à ne pas faire, même si un tutoriel ou l'agent le propose :** modifier un fichier de `test/acceptance/` pour faire passer un cas ; `flutter pub upgrade` ; recopier un secret, même pour le signaler.

---

## Glossaire

- **Anneau** : organisation de l'audit croisé où chaque équipe audite la suivante et est auditée par une autre, sans réciprocité.
- **Contrôle exigé** : contrôle de CI qui doit être vert pour que la protection de `main` autorise la fusion ; ici, `analyse-et-tests`, `securite` et `site-web`.
- **Fini quand** : la condition, en tête de chaque fiche, qui dit que l'atelier est terminé.
- **Gel des fonctionnalités** : moment, au plus tard une semaine avant la séance 5, après lequel on ne fait plus que des correctifs, de la documentation et la préparation de la démonstration.
- **Grille go/no-go** : les critères go et no-go du module de conformité (section 6.2), avec lesquels le RSSI décide et les observateurs suivent un passage.
- **Livrable** : ce que l'équipe doit avoir fusionné ou montré à la fin de la séance.
- **Plan B** : build web local et démonstration avec `flutter run -d chrome` quand Pages ou Actions posent problème, publication terminée dans le sprint.
- **Valeur faussée** : valeur attendue changée exprès, sur son poste, pour vérifier qu'un cas la contrôle vraiment ; on annule ensuite.

Les autres termes (self-grading, test d'acceptation indépendant, `CODEOWNERS`, PR en brouillon, artefact, bundle, gitleaks, osv-scanner, variable liée, système d'IA, fournisseur, déployeur…) sont définis dans les glossaires des chapitres 1 à 4.

---

## Pour aller plus loin

- Supports de la séance 3, chapitre 5 : fiches G (contrôle d'ouverture), I (checklist de revue de PR) et N (dépannage).
- Supports de la séance 2, chapitre 4 : fiches C (initialisation, PR) et F (dépannage git).
- Module de conformité du cours (`cours/conformite-ai-act-rgpd.md`), sections 3, 6, 7 et 8 : l'AI Act, le gabarit et la validation, les trois thèmes, l'atelier, le jeu de rôle, le quiz.
- Dans votre dépôt : `docs/seance-4/ci.yml` (ses commentaires), `test/acceptance/README.md`, `docs/ARCHITECTURE.md` (section 8, les rôles).

---

## Points non vérifiés (à signaler honnêtement)

- **Les fiches n'ont pas été rejouées en tant que telles.** Elles condensent les chapitres 1 à 4, dont les commandes locales ont été exécutées sous Linux seulement, avec Flutter 3.50.1, sur une copie du dépôt-modèle (voir les points non vérifiés de chaque chapitre). Ni Windows ni macOS.
- **Ce qui a été fait en ligne** : deux essais, le 27 novembre 2026, sur un dépôt d'essai créé depuis le dépôt-modèle, avec le compte administrateur de l'organisation. Le premier : PR de la CI complète, `securite` rouge puis vert (faux secret, `.gitleaksignore`), `publication` rouge puis vert après l'activation de Pages et « Re-run failed jobs », site ouvert, protection de `main`, refus de fusion. Le second, avec le workflow durci fourni aujourd'hui : trois contrôles en parallèle, trois contrôles exigés, gitleaks limité à `main` et à la PR, `securite` rouge sur une PR à faux secret, `gh pr checks <numéro> --required` et la lecture `gh api …/branches/main`. **Pas observé** : une PR fusionnée sous cette protection, la demande automatique de relecture aux propriétaires du code, un compte étudiant (droit d'écriture seulement : la relance d'un contrôle), une PR ouverte avant la CI complète et « Update branch », une alerte d'osv-scanner et `osv-scanner.toml`, la release `v0.1` et l'envoi d'un tag, une PR en brouillon (`gh pr create --draft`), la création d'une issue. Le rapport gitleaks détaillé, la suppression du fichier et `.gitleaksignore` viennent du premier essai.
- **Fiche O** : ni les rôles du thème, ni le sort de `jets`, ni le seed réduit n'ont été joués pour les chapitres ; seuls `git grep -n "RequireRole(" -- lib` et les tests de refus du dépôt-modèle ont été lancés.
- **Fiche P** : l'affichage des propriétaires parmi les relecteurs n'a pas été vu sur GitHub ; les effets de `.github/CODEOWNERS` reposent sur la documentation GitHub. La réutilisation des étapes de la séance 3 n'a pas été essayée. Les données à compléter des thèmes A et C n'ont pas été traduites en `.feature`.
- **Fiche Q** : les gestes de contrôle du bundle ont été essayés sur une copie locale et un build local, pas sur un site publié par la CI (sauf l'onglet Réseau) ; ils sont proposés, à valider par l'enseignant. La publication de `flutter.js.map` reste un point à décider par l'enseignant (chapitre 2, section 5.1).
- **Fiches R et S** : faits juridiques de seconde main (module de conformité, sources consultées le 1er octobre 2026) ; la trame de quatre minutes, la répartition de la parole, les réponses préparées et la transformation des conditions en issues sont des propositions des supports. L'ordre de passage dans une table n'est fixé par aucun document.
- **Fiche T** : `gh issue create` n'a pas été exécutée ; les trois gestes de l'auditeur sur le bundle n'ont pas été joués sur le dépôt d'une autre équipe.
- **Fiche V** : les messages cités viennent des chapitres et des essais en ligne ; la PR « en attente » et son remède par « Update branch » sont décrits d'après la documentation GitHub, sans message relevé.
- **Fichiers fournis** : `docs/seance-4/ci.yml` et `docs/seance-4/CODEOWNERS.modele` ne sont dans votre dépôt que si le modèle en ligne a été mis à jour avant la création des dépôts d'équipe ; les fiches sont écrites comme si c'était le cas.

---

## Sources

- Chapitres 1 à 4 de ce support, qui portent le détail des sources et des vérifications (27 novembre 2026, Linux, git 2.53.0, gh 2.100.0, Flutter 3.50.1, `bdd_widget_test` 3.1.0).
- `cours/programme-detaille.md` : séance 4 (blocs 1 à 13, ordre de coupe, « ne se sacrifient jamais », « peut glisser », appariements et tables à 7 et 8 équipes, checklist d'audit, livrable, definition of done) ; section 5 (le sprint final).
- `cours/conformite-ai-act-rgpd.md` : sections 6.1 (gabarit), 6.2 (validation, grille), 8.1 (atelier), 8.2 (jeu de rôle), 8.3 (quiz).
- Essais en ligne du workflow complet, 27 novembre 2026, sur un dépôt d'essai créé depuis le dépôt-modèle : premier essai, puis second essai avec le workflow durci (trois contrôles exigés, lecture `gh api …/branches/main`).
- Dépôt-modèle (`depot-modele/`) : `docs/seance-4/ci.yml`, `docs/seance-4/CODEOWNERS.modele`, `.claude/settings.json`, `CLAUDE.md`, `README.md`, `test/acceptance/README.md`.
- Supports de la séance 3, chapitre 5 : fiches G, I et N.
