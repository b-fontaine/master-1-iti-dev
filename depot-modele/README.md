# Projet fil rouge (Flutter)

Squelette Flutter du projet d'équipe : Clean Architecture, `get_it`, `flutter_bloc`, base SQLite `drift`, tests TDD et BDD. Il contient une seule fonctionnalité d'exemple, `jets` (lancer un dé contre un degré de difficulté), qui montre où ranger chaque chose.

> **Données fictives uniquement, aucun secret.** Le dépôt est public, et tout ce qui est dans le build web l'est aussi : pas de clé d'API, pas de mot de passe, pas de donnée personnelle réelle, ni dans le code, ni dans les tests, ni dans un prompt.

## Version de Flutter

**Flutter 3.50 ou plus récent ; testé avec 3.50.1 (Dart 3.14.0), la version de la CI, qui fait foi.** Vérifiez la vôtre avec `flutter --version`. Les outils de génération de code du projet (`build_runner` 2.17.1, nécessaire à `bdd_widget_test` 3.1.0) ne fonctionnent pas avant Flutter 3.50.

Deux commandes à ne pas confondre : `flutter upgrade` met à jour **Flutter** lui-même (permis, pour un poste plus ancien que 3.50) ; `flutter pub upgrade` changerait les **bibliothèques verrouillées** du projet (interdit, et refusé à l'agent par `.claude/settings.json`). Les versions exactes des bibliothèques sont verrouillées dans `pubspec.lock`, qui est versionné. La CI installe les dépendances avec `flutter pub get --enforce-lockfile` : elle échoue si `pubspec.lock` ne correspond pas à `pubspec.yaml`, ou s'il faudrait le modifier.

Ajouter une dépendance se fait par une PR dédiée, avec l'accord de l'équipe et de l'enseignant :

1. `flutter pub add <paquet>` ;
2. vérifier que les commandes de « Vérifier avant une PR » restent vertes ;
3. commiter `pubspec.yaml` et `pubspec.lock` ensemble, dans cette PR.

**Import des widgets.** Depuis Flutter 3.47, `package:flutter/material.dart` est déprécié : ce projet importe `package:material_ui/material_ui.dart`, et `flutter analyze` signale l'ancien import. Les supports de la séance 1 montrent encore l'ancien import : remplacez-le quand vous reprenez un exemple.

## Démarrer : les commandes après le clone

Après `gh repo clone …` et `cd` dans le dossier du dépôt, tapez dans cet ordre :

| Commande | Ce qu'elle fait | Ce que vous devez voir |
|---|---|---|
| `flutter pub get` | Télécharge les bibliothèques, aux versions de `pubspec.lock` | `Got dependencies!` |
| `dart run build_runner build --delete-conflicting-outputs` | Génère le code de la base et les tests des scénarios `.feature` | `Built with build_runner … wrote … outputs.` (plus d'une minute la première fois) |
| `flutter test` | Lance tous les tests | `All tests passed!` |
| `flutter analyze` | Vérifie le code sans l'exécuter | `No issues found!` |
| `flutter run -d chrome` | Compile l'application et l'ouvre dans Chrome | L'écran « Jets de dé » |

Pour produire la version web : `flutter build web` (résultat dans `build/web/`, à la fin : `✓ Built build/web`). Pour la version **publiée** (GitHub Pages, séance 4), la commande recommandée est :

```bash
flutter build web --release --base-href "/<dépôt>/" --no-web-resources-cdn --web-content-hash
```

`<dépôt>` est le nom du dépôt GitHub (par exemple `equipe_01`), entouré de barres obliques. `--no-web-resources-cdn` embarque le moteur de rendu au lieu de le charger chez Google (voir « Fichiers binaires du web ») ; `--web-content-hash` ajoute une empreinte aux noms des fichiers, pour que les navigateurs prennent la nouvelle version après chaque publication.

## Vérifier avant une PR : les commandes de la CI

C'est la liste de référence, citée par `CLAUDE.md` et `docs/ARCHITECTURE.md`. La CI (`.github/workflows/ci.yml`) lance exactement ces commandes, dans cet ordre, à chaque PR :

1. `flutter pub get --enforce-lockfile`
2. `dart run build_runner build --delete-conflicting-outputs`
3. `dart run drift_dev make-migrations`, qui ne doit rien changer (sinon : une table a changé sans nouvelle version, voir `docs/ARCHITECTURE.md`, section 7)
4. `dart format --output=none --set-exit-if-changed .` (si elle échoue, lancez `dart format .` puis commitez)
5. `flutter analyze`
6. `flutter test`

Bon à savoir :

- Les fichiers générés par `build_runner` (`*.g.dart`, tests tirés des `.feature`) ne sont pas versionnés : relancez `build_runner` après chaque clone et après chaque modification d'un `.feature` ou d'une table.
- Le premier `flutter test` télécharge une copie de SQLite pour votre système (sous Windows, macOS ou Linux, sans rien installer) : il faut une connexion Internet cette fois-là.
- Mise en forme du code : `dart format .`
- **Bureau optionnel.** La cible par défaut est Chrome. Pour essayer l'application en version bureau, ajoutez la plateforme de votre système (`flutter create --platforms=windows .`, `--platforms=macos` ou `--platforms=linux`) : cela demande la chaîne de compilation native correspondante (Visual Studio sous Windows, Xcode sous macOS) et n'est pas coaché en séance.

## Ce que contient le dépôt

```text
.
├── CLAUDE.md                     instructions de l'agent (à lire avant de le lancer)
├── .claude/settings.json         permissions de l'agent : ce qu'il n'a pas le droit de faire
├── docs/ARCHITECTURE.md          où ranger quoi, conventions, ordre de travail (à lire)
├── PROJET.md                     vision et user stories du thème
├── JOURNAL.md                    état courant du projet et décisions
├── docs/fiche_conformite.md      fiche de conformité (séances 3 et 4)
├── .github/
│   ├── workflows/ci.yml          CI : analyse et tests à chaque PR
│   └── pull_request_template.md  modèle de description de PR
├── .env.example                  modèle de fichier d'environnement, sans secret
├── pubspec.yaml, pubspec.lock    dépendances déclarées et versions verrouillées
├── analysis_options.yaml         règles de `flutter analyze`
├── build.yaml                    réglages de la génération de code
├── .gitattributes                fins de ligne LF pour drift_schemas/
├── drift_schemas/                instantanés du schéma de la base, un par version (migrations)
├── lib/
│   ├── main.dart                 point d'entrée
│   ├── app.dart                  racine de l'interface
│   ├── core/                     commun : injection (di/), base (data/), rôles (domain/roles/)
│   └── features/jets/            la fonctionnalité d'exemple : domain/, data/, presentation/
├── test/
│   ├── app_test.dart             test de app.dart (libellés de Material en français)
│   ├── core/, features/jets/     tests unitaires, même arborescence que lib/
│   │                             (test/core/data/migrations/ apparaîtra en version 2 du schéma)
│   ├── scenarios/jets/           scénarios BDD en français (.feature)
│   ├── steps/                    étapes des scénarios
│   ├── helpers/                  fausses pièces et ouverture de l'application pour les tests
│   └── acceptance/               réservé aux cas d'acceptation de la séance 4 (humains uniquement)
├── tool/drift_worker.dart        source du worker drift du web
└── web/                          page d'accueil web, sqlite3.wasm, drift_worker.dart.js
```

## Fichiers binaires du web

Sur le web, la base SQLite tourne dans le navigateur. drift a besoin pour cela de deux fichiers, déjà présents dans `web/` et versionnés (documentation : page « Web » de drift, https://drift.simonbinder.eu/platforms/web/) :

| Fichier | Origine | Version | sha256 |
|---|---|---|---|
| `web/sqlite3.wasm` | Téléchargé depuis https://github.com/simolus3/sqlite3.dart/releases/download/sqlite3-3.9.2/sqlite3.wasm | `sqlite3` 3.9.2 (celle de `pubspec.lock`) | `e7451780e78c56ff864fe9317a0fbcd6aeb2e8de3beba7f5efd963202f7ec3d9` |
| `web/drift_worker.dart.js` | Compilé localement depuis `tool/drift_worker.dart` avec `dart compile js -O4 --no-source-maps -o web/drift_worker.dart.js tool/drift_worker.dart` | `drift` 2.35.4 (celle de `pubspec.lock`) | `8a5651e02fd5c73a8f9cce793f9a19e9c26e73582247c3f7a79297ceb1da370f` |

Ces deux fichiers ne changent que si les versions de `drift` ou de `sqlite3` changent dans `pubspec.lock` ; il faut alors les remplacer ensemble (même version que le verrou) et mettre ce tableau à jour.

Pour vérifier une empreinte : `sha256sum web/sqlite3.wasm` (Linux), `shasum -a 256 web/sqlite3.wasm` (macOS), `Get-FileHash web/sqlite3.wasm` (PowerShell).

**CanvasKit et Internet.** Par défaut, l'application construite par `flutter build web` fait charger au navigateur son moteur de rendu (CanvasKit, fichiers `.wasm` et `.js`) depuis `www.gstatic.com`, un serveur de Google. Il faut donc Internet à l'ouverture de l'application, et cette requête vers un tiers est à déclarer dans la fiche de conformité. L'option `--no-web-resources-cdn` (comprise dans la commande de publication ci-dessus) embarque ces fichiers dans `build/web/` et supprime cette requête.

La base web fonctionne sans réglage particulier du serveur. Chrome indique dans la console le mode de stockage choisi (par exemple « Using WasmStorageImplementation.sharedIndexedDb ») : ce message est normal.
