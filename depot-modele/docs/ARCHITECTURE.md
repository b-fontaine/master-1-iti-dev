# Architecture du projet

Ce document dit **où ranger chaque chose** et **dans quel ordre travailler**. Il vaut pour tout projet Flutter construit sur ce squelette. La fonctionnalité d'exemple `jets` (un petit jeu de dés) applique chacune des règles ci-dessous : quand une règle vous paraît abstraite, ouvrez le fichier cité.

Version de Flutter : 3.50 ou plus récent ; testé avec 3.50.1, la version de la CI, qui fait foi (voir le README).

## 1. Les trois couches et la règle de dépendance

Le code est séparé en trois **couches** :

| Couche | Sa question | Ce qu'on y trouve | Exemple dans `jets` |
|---|---|---|---|
| `domain` | Quelle est la règle ? | Entités, règles métier, contrats (interfaces), cas d'usage | `lib/features/jets/domain/regles/est_reussite.dart` |
| `data` | D'où viennent les données ? | Tables de la base, implémentation des contrats, import de fichiers | `lib/features/jets/data/jets_repository_drift.dart` |
| `presentation` | Que voit l'utilisateur ? | Écrans (widgets), BLoC et Cubit, états | `lib/features/jets/presentation/jets_page.dart` |

**Règle de dépendance** : `presentation` et `data` connaissent `domain` ; **`domain` ne connaît personne**. Un fichier de `domain/` n'importe jamais un fichier de `data/` ni de `presentation/`, ni Flutter (`package:flutter/…`, `package:material_ui/…`). Pour le vérifier, il suffit de lire les lignes `import` en tête du fichier.

Comment `domain` utilise-t-il la base sans la connaître ? Il déclare un **contrat** (une interface), par exemple `JetsRepository` dans `domain/repositories/`, et la couche `data` fournit l'implémentation (`JetsRepositoryDrift`). L'annuaire `get_it` relie les deux (section 3).

## 2. Question 1 : où créer une nouvelle fonctionnalité ?

Une fonctionnalité = un dossier sous `lib/features/`, avec les trois couches. Ce qui sert à plusieurs fonctionnalités va dans `lib/core/`, avec les mêmes couches.

```text
lib/
├── main.dart                  point d'entrée : configure get_it, lance l'application
├── app.dart                   racine de l'interface : thème, cubits partagés, page d'accueil
├── core/                      commun à toutes les fonctionnalités
│   ├── di/injection.dart      l'annuaire get_it (section 3)
│   ├── data/                  la base drift, son ouverture, l'horloge système
│   ├── domain/roles/          rôles, utilisateur courant simulé, garde RequireRole
│   ├── domain/services/       contrats communs (ex. : horloge.dart)
│   └── presentation/          sélecteur de rôle ; lexique.dart (libellés communs, voir section 6)
└── features/
    └── <fonctionnalite>/      nom en snake_case, sans accent (ex. : jets)
        ├── domain/
        │   ├── entities/      les objets métier (ex. : jet.dart)
        │   ├── regles/        les règles pures, sans base ni écran (ex. : est_reussite.dart)
        │   ├── repositories/  les contrats d'accès aux données
        │   ├── services/      les autres contrats (ex. : source_de_hasard.dart)
        │   └── usecases/      une action de l'utilisateur = un fichier (ex. : lancer_un_de.dart)
        ├── data/              tables drift, implémentations des contrats
        └── presentation/      page, Cubit ou BLoC, états
```

Les tests suivent **la même arborescence** sous `test/` : le test de `lib/features/jets/domain/regles/est_reussite.dart` est `test/features/jets/domain/regles/est_reussite_test.dart`. Un fichier de test se termine toujours par `_test.dart`. S'y ajoutent :

- `test/scenarios/<fonctionnalite>/` : les scénarios `.feature` (BDD) ;
- `test/steps/` : les étapes de tous les scénarios ;
- `test/helpers/` : les fausses pièces partagées par les tests et `ouvrir_application.dart`, qui ouvre l'application sur une base en mémoire (un fichier d'aide ne se termine jamais par `_test.dart`, sinon `flutter test` le prend pour un test) ;
- `test/acceptance/` : réservé aux cas d'acceptation de la séance 4, **modifié par des humains uniquement**.

## 3. Question 2 : où enregistrer une pièce dans `get_it` ?

**Dans `lib/core/di/injection.dart`, et nulle part ailleurs.** La fonction `configurerDependances()` y enregistre toutes les pièces ; `main.dart` l'appelle une fois au démarrage. Ailleurs, on demande une pièce avec `sl<LeType>()`, sans jamais la construire soi-même.

Ajoutez un bloc par fonctionnalité, dans l'ordre data, puis domain, puis presentation :

| Pièce | Enregistrement | Pourquoi |
|---|---|---|
| Base, horloge, repository, source de hasard | `registerLazySingleton` | Une seule instance, créée au premier usage |
| Cas d'usage | `registerFactory` | Sans état : une instance neuve à chaque demande |
| Cubit ou BLoC | `registerFactory` | Chaque écran a le sien, fermé avec l'écran |

On enregistre toujours une pièce **sous le type de son contrat** (`registerLazySingleton<JetsRepository>(…)`) : c'est ce qui permet aux tests de la remplacer par une fausse. `configurerDependances` accepte d'ailleurs une base et une source de hasard de remplacement : c'est ainsi que les scénarios BDD tournent sur une base en mémoire avec un dé truqué (`test/steps/le_de_va_donner.dart`).

## 4. Question 3 : comment nommer un BLoC, ses événements et ses états ?

Un **Cubit** suffit dans la plupart des cas : l'écran appelle ses méthodes (`cubit.lancer()`). Prenez un **BLoC** quand les actions arrivent sous forme d'événements à traiter dans l'ordre ou à filtrer (saisie au clavier, par exemple).

| Élément | Convention | Exemple |
|---|---|---|
| Fichiers | `<fonctionnalite>_cubit.dart` (ou `_bloc.dart`), `<fonctionnalite>_state.dart`, `<fonctionnalite>_event.dart` | `jets_cubit.dart`, `jets_state.dart` |
| Classe | `<Fonctionnalite>Cubit` ou `<Fonctionnalite>Bloc` | `JetsCubit` |
| Méthodes d'un Cubit | Verbe à l'infinitif, ce que fait l'utilisateur | `charger()`, `lancer()`, `vider()` |
| Événements d'un BLoC | Classe mère `<Fonctionnalite>Event`, puis une sous-classe par fait : `<Fonctionnalite>` + nom + participe passé, ce que l'utilisateur vient de faire | `JetsEvent` : `JetsLancementDemande` (« lancement demandé »), `JetsEffacementDemande` (« effacement demandé ») |
| États | Classe mère scellée `<Fonctionnalite>State`, une sous-classe par situation de l'écran | `JetsState` : `JetsChargement`, `JetsPret`, `JetsErreur` |

Les états sont **immuables** (champs `final`) et comparables par valeur (`Equatable`) : c'est ce qui permet à `blocTest` de comparer la liste des états attendus. Un Cubit ne contient pas de règle métier : il appelle des cas d'usage et traduit leur résultat en états.

**Un Cubit ou un BLoC ne reçoit que des cas d'usage, jamais un repository.** Sinon il pourrait écrire dans la base sans passer par le cas d'usage, donc sans la garde `RequireRole` (section 8). Voir le constructeur de `JetsCubit`.

## 5. Question 4 : dans quel ordre écrire scénario, test et code ?

1. **Le scénario** (`.feature`, en français), dans `test/scenarios/<fonctionnalite>/`, relu par l'équipe : il dit la règle avec des exemples chiffrés.
2. **`dart run build_runner build --delete-conflicting-outputs`** : le test correspondant est généré. Les étapes qui manquent sont créées dans `test/steps/` avec une erreur `UnimplementedError` : `flutter test` est **rouge**.
3. **Les tests unitaires** de la règle (`domain`), puis du Cubit (`blocTest`) : rouges eux aussi.
4. **Le code minimal** qui fait passer les tests unitaires, couche par couche : `domain`, puis `data`, puis `presentation`.
5. **Les étapes** du scénario, dans `test/steps/` : le scénario passe au vert.
6. **Les commandes de vérification de la CI** (README, « Vérifier avant une PR ») : tout est vert. On commite le test avant le code (règle du jeu n° 3).

Un test qui échoue ne se corrige jamais en modifiant, désactivant ou supprimant le test : on corrige le code.

### Écrire un scénario

```gherkin
# language: fr
Fonctionnalité: Lancer un dé contre un degré de difficulté

  Scénario: un jet égal au degré de difficulté est une réussite
    Soit le dé va donner {10}
    Et l'écran des jets est ouvert
    Quand je lance le dé
    Alors je vois le texte {'Dernier jet : 10 · Réussite'}
```

- La première ligne `# language: fr` est obligatoire pour les mots-clés français (`Fonctionnalité`, `Scénario`, `Soit`, `Quand`, `Alors`, `Et`).
- Les valeurs entre accolades sont des **paramètres** : `{10}` est un nombre, `{'texte'}` un texte.
- Chaque phrase devient une fonction de `test/steps/` : « le dé va donner » donne `le_de_va_donner.dart`. Réutilisez une phrase existante plutôt que d'en inventer une voisine.
- Les tests `*_test.dart` générés à côté des `.feature` ne sont pas versionnés et ne se modifient pas à la main.

Exemples : `test/scenarios/jets/lancer_un_de.feature`, `test/steps/`, `test/features/jets/presentation/jets_cubit_test.dart`.

### Les outils de test

- `flutter_test` : `test(…)` pour une règle, `testWidgets(…)` pour un écran. Un **test paramétré** parcourt une liste de cas (voir `est_reussite_test.dart`).
- `bloc_test` : `blocTest(…)` vérifie la suite d'états d'un Cubit ou d'un BLoC.
- `mocktail` : fabrique une fausse pièce dont on dicte les réponses (`MockJetsRepository` dans `test/helpers/fausses_pieces.dart`).
- Le **hasard** et l'**heure** ne sont jamais lus directement dans `domain` : ils sont injectés, pour que les tests soient reproductibles. L'heure sert à toutes les fonctionnalités : son contrat `Horloge` est dans `lib/core/domain/services/horloge.dart`, l'implémentation `HorlogeSysteme` dans `lib/core/data/horloge_systeme.dart`, et les tests utilisent `FausseHorloge` (`test/helpers/fausses_pieces.dart`). Le hasard, propre aux jets, suit le même schéma dans la fonctionnalité (`SourceDeHasard`, `SourceDeHasardAleatoire`, `FausseSourceDeHasard`).

### Dart moderne : écritures à reconnaître

- **`sealed` et `switch`** : `sealed class JetsState` annonce une liste fermée d'états ; le `switch` de `jets_page.dart` traite chacun d'eux, et l'analyse signale l'oubli d'un cas.
- **Motif** : `if (state case JetsPret(alerte: final message?))` se lit « si l'état est prêt et porte une alerte présente (non nulle), appelons-la `message` » ; on évite ainsi le point d'exclamation qui force une valeur supposée non nulle.
- **Motif abrégé** : dans `JetsErreur(:final message) => …`, le nom de la variable vient du champ : `message` reçoit le champ `message` de l'état.
- **Raccourci par point** : `crossAxisAlignment: .start` veut dire `CrossAxisAlignment.start`, et `padding: const .all(16)` veut dire `EdgeInsetsGeometry.all(16)` ; le type est déjà connu par le paramètre, on ne le répète pas.
- **`required this._x`** : dans le constructeur de `JetsCubit`, `required this._lancerUnDe` range directement le paramètre `lancerUnDe:` dans le champ privé `_lancerUnDe`.
- En cas de doute, survolez l'écriture dans l'éditeur (VS Code) : il affiche le type complet.

## 6. Conventions de nommage

| Quoi | Convention | Exemple |
|---|---|---|
| Fichiers et dossiers | snake_case, sans accent | `lancer_un_de.dart` |
| Types (classes, énumérations) | UpperCamelCase, sans accent | `LancerUnDe`, `JetsCubit` |
| Variables, fonctions, méthodes | lowerCamelCase, sans accent | `estReussite`, `lanceLe` |
| Tables et colonnes de la base | ASCII snake_case, sans accent | table `jets`, colonne `lance_le` |
| Textes affichés, commentaires, scénarios | Français correct, accentué | `'Vider l’historique'` |

Les noms de code sont en français, comme le métier ; les mots imposés par les bibliothèques (`Cubit`, `State`, `Repository`) restent en anglais.

**Libellés communs** : un libellé affiché par plusieurs écrans (nom d'une entité, d'un statut, d'une unité) est écrit une seule fois, dans `lib/core/presentation/lexique.dart`. Ce fichier n'existe pas dans le squelette : l'équipe le crée quand elle en a besoin. Un libellé propre à un seul écran reste dans cet écran.

## 7. La base de données (drift)

- **Une seule base** pour l'application : `lib/core/data/base_de_donnees.dart`. Chaque fonctionnalité définit ses tables dans son dossier `data/` (ex. : `lib/features/jets/data/table_jets.dart`) et les ajoute à la liste `@DriftDatabase(tables: [...])`.
- Le code de la base est **généré** (`base_de_donnees.g.dart`, non versionné) : relancez `build_runner` après chaque modification d'une table.
- **Noms** : tables et colonnes en ASCII snake_case. drift transforme le nom Dart `lanceLe` en colonne `lance_le`. Quand le nom de la ligne générée entrerait en conflit avec une entité du domaine, on le change avec `@DataClassName` (ex. : `JetLigne`).
- **Clés étrangères** : SQLite ne les vérifie que si on le lui demande. `beforeOpen` exécute `PRAGMA foreign_keys = ON` à chaque ouverture ; ne le retirez pas. Une colonne qui en référence une autre se déclare avec `.references(AutreTable, #id)`.
- **Dates** : stockées en UTC (`DateTime.toUtc()`), converties en heure de Paris seulement à l'affichage.
- **Migrations** : `schemaVersion` vaut 1, la version du squelette. **Toute modification d'une table drift = `schemaVersion` + 1**, avec la procédure ci-dessous, même avant la première publication ; `drift_schemas/` et les fichiers `*.steps.dart` ne se modifient jamais à la main. Sans nouvelle version, la base de chaque navigateur qui a déjà ouvert l'application garde sinon l'ancien schéma. Les migrations se préparent avec l'outil officiel de drift, `dart run drift_dev make-migrations` (réglé dans `build.yaml`). Il garde un **instantané** du schéma de chaque version dans `drift_schemas/base_de_donnees/` (celui de la version 1, `drift_schema_v1.json`, est fourni), écrit le fichier d'étapes `lib/core/data/base_de_donnees.steps.dart` et les **tests de migration** dans `test/core/data/migrations/`. Ces fichiers sont versionnés : ils ne sont pas produits par `build_runner`. L'outil compare l'instantané de la version courante **au caractère près** : `.gitattributes` force donc des fins de ligne LF dans `drift_schemas/`, que Windows convertirait sinon. **Contrôle** : relancer `dart run drift_dev make-migrations` sur une table modifiée sans nouvelle version s'arrête sur « A schema for version … already exists and differs from the current schema » ; la CI fait ce contrôle à chaque PR.
- **Dépannage** : si une base de développement est dans un état incohérent sur votre poste, effacez-la dans Chrome (outils de développement, onglet « Application », « Clear site data »). Ce n'est pas une façon de migrer : les autres navigateurs gardent leur base.
- **Tests** : toujours sur une base en mémoire, `BaseDeDonnees(NativeDatabase.memory())`. Le test d'intégrité `test/core/data/base_de_donnees_test.dart` vérifie le schéma, les clés étrangères (`PRAGMA foreign_keys`, `PRAGMA foreign_key_check`), `PRAGMA integrity_check` et les contraintes. Complétez-le à chaque nouvelle table.
- **Sur le web** : la base vit dans le navigateur, grâce aux fichiers `web/sqlite3.wasm` et `web/drift_worker.dart.js` (voir le README). Chaque visiteur a sa propre base, vide au départ : c'est le rôle du seed.

### Passer en version 2 : les tables du thème, et le retrait de `jets`

L'ajout des tables du thème est le passage en version 2. Cette procédure a été jouée mot à mot, deux fois, sur une copie du squelette (ajout d'une table, retrait de `jets`), jusqu'aux commandes de vérification de la CI au vert.

1. **Retirer la fonctionnalité d'exemple** (si l'équipe la retire) :
   - supprimer `lib/features/jets/`, `test/features/jets/`, `test/scenarios/jets/` et les étapes de `test/steps/` propres aux jets (`le_de_va_donner.dart`, `lecran_des_jets_est_ouvert.dart`, `je_lance_le_de.dart` ; `je_vois_le_texte.dart` reste utile) ;
   - `lib/core/di/injection.dart` : retirer les imports et les lignes de `jets`, et le paramètre `hasard` de `configurerDependances` ;
   - `lib/app.dart` : retirer le `BlocProvider` de `JetsCubit` et les imports de `jets` ; remplacer `JetsPage` par la page d'accueil du thème (rangée dans le dossier `presentation/` de sa fonctionnalité), qui **reprend le `SelecteurDeRole`** dans sa barre de titre (sinon la démonstration des rôles disparaît sans aucune erreur) ;
   - `test/helpers/` : retirer les fausses pièces de `jets` (`FausseSourceDeHasard`, `MockJetsRepository`) et le paramètre `valeurDuDe` de `ouvrir_application.dart` ;
   - adapter `test/app_test.dart` à la nouvelle page, et **réécrire un test d'accessibilité** pour elle (celui de `jets` est parti avec son dossier) ;
   - **ne pas supprimer** `drift_schemas/base_de_donnees/drift_schema_v1.json`, même s'il décrit `jets` : sans lui, l'étape `from1To2` n'est pas générée.
2. **Déclarer les tables du thème** : une table par fichier dans le dossier `data/` de chaque fonctionnalité ; dans `base_de_donnees.dart`, remplacer `Jets` par ces tables dans `@DriftDatabase(tables: [...])` et passer `schemaVersion` à **2**. Ne pas encore toucher à `onUpgrade`.
3. **Générer** : `dart run build_runner build --delete-conflicting-outputs`, puis `dart run drift_dev make-migrations`. Tant qu'il n'existe qu'une version, cette commande n'écrit que l'instantané (c'est pourquoi le squelette ne contient ni fichier d'étapes ni test de migration). Dès la version 2, elle crée `drift_schema_v2.json`, le fichier `lib/core/data/base_de_donnees.steps.dart` et le dossier `test/core/data/migrations/base_de_donnees/` (`migration_test.dart` et ses fichiers `generated/`). Tous ces fichiers se versionnent.
4. **Écrire l'étape** dans `base_de_donnees.dart` : ajouter `import 'base_de_donnees.steps.dart';` avec les autres imports, **avant** la ligne `part 'base_de_donnees.g.dart';`, puis remplacer toute la fonction `onUpgrade` par :
   ```dart
   onUpgrade: stepByStep(
     from1To2: (m, schema) async {
       await m.deleteTable('jets'); // seulement si l'équipe a retiré jets (étape 1)
       await m.createTable(schema.fiches); // une ligne par table du thème
     },
   ),
   ```
   Si l'équipe garde `jets`, la ligne `deleteTable` ne s'écrit pas : l'étape ne contient que les `createTable`.
   On écrit `schema.fiches` (la table telle qu'elle est en version 2) et non `fiches` : l'étape reste juste quand la table changera en version 3.
5. **Nettoyer le test généré** : `migration_test.dart` contient deux parties. La première (« simple database migrations ») vérifie le schéma après chaque migration : on la garde telle quelle. La seconde est un vrai test, « migration from v1 to v2 does not corrupt data », mais avec des listes de données vides et des commentaires `TODO` en anglais : on le supprime (de son commentaire d'introduction jusqu'à sa dernière accolade), ou on le remplit si la migration doit conserver des données existantes. Ce n'est pas le cas quand on ne fait que créer des tables et supprimer `jets`.
6. **Adapter le test d'intégrité** `test/core/data/base_de_donnees_test.dart` aux nouvelles tables (colonnes, contraintes, clés étrangères).
7. **Vérifier** : lancer d'abord `dart format .` (les fichiers retouchés à la main en ont besoin ; les fichiers générés sont déjà en forme), puis les commandes de vérification de la CI (README, « Vérifier avant une PR »), dans l'ordre. `flutter test test/core/data/migrations` doit passer ; pendant la répétition, une étape volontairement incomplète (table non créée) l'a fait échouer avec « Schema does not match ». Relancer ensuite `dart run drift_dev make-migrations` ne doit plus rien changer (`git status`).

Une colonne ajoutée plus tard sera la version 3 : modifier la table, passer `schemaVersion` à 3, relancer les deux commandes de l'étape 3, puis ajouter `from2To3: (m, schema) async { await m.addColumn(schema.fiches, schema.fiches.commentaire); }` à côté de `from1To2`, sans jamais modifier une étape déjà écrite. La nouvelle colonne doit être facultative (`text().nullable()()`) ou avoir une valeur par défaut (`.withDefault(const Constant(''))`) : SQLite refuse d'ajouter à une table existante une colonne obligatoire sans valeur par défaut. Ce passage en version 3 n'a pas été répété.

## 8. Les rôles et la garde `RequireRole`

- Les rôles de démonstration sont `meneur` et `joueur` (`lib/core/domain/roles/role.dart`). Chaque équipe les remplace par les deux rôles de son thème.
- L'**utilisateur courant est simulé** (`UtilisateurCourantSimule`) : le rôle se choisit avec le sélecteur en haut de l'écran. Il porte aussi un `identifiant`, un **pseudonyme fictif** (`pseudo-demo-1`), jamais un nom de personne ni une adresse électronique : c'est lui qu'on enregistre pour retrouver « sa propre fiche » ou « son propre résultat ». Il n'y a ni compte, ni mot de passe. **Ce n'est pas une sécurité réelle** : l'application web est publique et tout son code est lisible.
- Une action réservée se protège **dans le cas d'usage** (couche `domain`), pas dans l'écran : voir `ViderHistorique`, qui déclare `RequireRole({Role.meneur})` et appelle `garde.verifier(utilisateur)` avant d'agir. Un rôle non autorisé lève `AccesRefuse`, que le Cubit traduit en message.
- Chaque action protégée a son **test de refus** : le rôle non autorisé est refusé et rien n'est modifié (`test/features/jets/domain/usecases/vider_historique_test.dart`, `test/core/domain/roles/require_role_test.dart`).

## 9. Ce qu'on ne fait pas

- Pas de règle métier dans un écran ou dans un Cubit ; pas de requête de base dans `domain`.
- Pas de `sl<…>()` dans `domain` : les pièces y arrivent par le constructeur.
- Pas de repository dans un Cubit ou un BLoC : uniquement des cas d'usage.
- Pas d'import `package:flutter/material.dart` (déprécié depuis Flutter 3.50) : on importe `package:material_ui/material_ui.dart`.
- Pas de donnée réelle, de secret ni de nom de personne, ni dans le code, ni dans les tests, ni dans le seed.
- Pas de modification de `test/acceptance/` par l'agent ; pas de test désactivé ou assoupli.
