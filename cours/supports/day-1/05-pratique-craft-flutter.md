# Chapitre 5 · Mettre le craft en pratique avec Flutter : un dojo guidé inspiré de la fourmi de Langton

*Supports de la séance 1 « Comprendre et s'équiper » · Master ITI, Nantes Université · Ingénierie logicielle à l'ère de l'IA agentique. État des outils vérifié le 6 octobre 2026.*

Ce chapitre est un **atelier à faire au clavier**. Il ne suppose aucune compétence en programmation : chaque mot technique est défini à sa première apparition (et repris dans le glossaire final), et chaque étape suit le même schéma : objectif, test à écrire, code minimal, nettoyage, commande à lancer, résultat attendu, erreurs probables. Vous y vivez trois pratiques que les chapitres précédents ont présentées en théorie : le **TDD** (écrire le test avant le code), le **BDD** (décrire le comportement en langage presque naturel) et les **petits commits** (sauvegardes fréquentes et commentées). Vous y apprenez enfin à demander à un agent (Claude Code) de travailler de cette façon **sans qu'il vous trompe**.

## Ce que vous allez retenir

- Le TDD (*Test-Driven Development*, développement piloté par les tests) est une boucle de trois temps : **rouge** (un test qui échoue), **vert** (le code le plus simple qui le fait passer), **refactor** (nettoyer sans changer le comportement).
- Un test est une **spécification exécutable** : il dit ce que le code doit faire, et la machine le vérifie en une seconde. Quand on ne sait pas lire le code, on peut lire les tests.
- Un test qui n'a **jamais été rouge** ne prouve rien : on veut le voir échouer pour la bonne raison avant de le voir réussir.
- Une règle métier simple (la fourmi de Langton) se découpe en **petites règles** testables une par une ; l'affichage Flutter vient ensuite, en s'appuyant sur une logique déjà fiable.
- Le BDD écrit le même test sous forme de scénario **Soit / Quand / Alors**, lisible par un non-développeur.
- On **commit après chaque vert** (et après chaque refactor) : l'historique raconte le raisonnement et permet de revenir en arrière.
- Avec un agent, la règle est : **l'humain écrit (ou au moins valide) les tests, l'agent écrit le code**, et c'est **vous** qui lancez la commande de vérification. Un agent qui écrit à la fois le code et ses propres tests se « corrige lui-même » : une suite verte prouve alors la cohérence, pas la justesse.
- Une consigne dans un fichier d'instructions **guide** l'agent mais ne **l'empêche** pas de tricher ; seul un réglage de permissions ou un contrôle externe (intégration continue, relecture) l'impose.

---

## 1. Pourquoi un dojo, et d'où vient celui-ci

### 1.1 Un dojo de code

Un **dojo** (mot japonais : le lieu où l'on s'entraîne) est, en développement logiciel, une séance d'entraînement collective sur un **exercice court** que l'on refait volontairement pour progresser, comme un musicien refait ses gammes. Les exercices de ce type s'appellent des **katas**. L'intérêt n'est pas le résultat (on connaît la solution) mais la **qualité du geste** : petits pas, vérification continue, nettoyage régulier.

### 1.2 Le dépôt de l'enseignant

Ce chapitre s'inspire du dépôt `flutter_dojo_langton_ant` rédigé par l'enseignant (https://github.com/b-fontaine/flutter_dojo_langton_ant), dont j'ai lu le contenu et l'historique. Pour éviter tout malentendu, voici ce qu'il contient réellement (état lu pour ce chapitre, un seul commit : « feat(devtools): first version of exercices about devtools ») :

- un **README** (« Flutter: BDD & Clean ») qui présente la fourmi de Langton, une méthode d'**Example Mapping** avec 20 images PNG des 20 premiers états de la grille (dossier `ant_movements/`, qui contient aussi un fichier `Untitled.jpeg`), puis un cours sur le BDD, le langage Gherkin et la bibliothèque `bdd_widget_test` ;
- un **serveur** en langage Rust (`server/langton-rs/`) qui expose un pas de la fourmi par une **API REST** (`POST /api/step`), avec des tests unitaires et **11 scénarios Gherkin** (`tests/features/langton_ant.feature`) ;
- un **squelette d'application Flutter** (`front/langton_flutter/`) qui n'affiche pour l'instant qu'une image de fourmi ;
- un fichier d'exercices sur les outils de développement (`exercices_devtools.md`).

Deux constats honnêtes, utiles pour la suite. D'une part, le dépôt ne contient **pas encore** de code Dart pour la logique de la fourmi : celle-ci est écrite en Rust côté serveur. Le code Dart de ce chapitre a donc été **écrit pour ce support**, en reprenant fidèlement les règles et les valeurs de test du serveur Rust ; vous retrouverez les mêmes cas (par exemple la fourmi en (0, 0), tournée vers le nord, sur une case blanche, qui finit tournée vers l'est en (1, 0)). D'autre part, le test fourni dans le squelette Flutter (`widget_test.dart`) est le **test d'exemple du compteur** généré par Flutter, qui cherche un texte « 0 » et une icône « + » absents de l'application actuelle : d'après ma lecture (non exécuté), il échouerait tel quel. Ce n'est pas grave, c'est même un bon exemple de **test périmé** : un test rouge n'est utile que si l'on sait pourquoi il est rouge (voir section 9).

Tout le code Dart de ce chapitre a été **exécuté** pour la rédaction, avec Flutter 3.47.6 et Dart 3.13.5 (versions stables du 6 octobre 2026) : les 20 tests de l'atelier passent, l'analyse statique (`dart analyze`) ne signale rien, et l'application se compile pour le web (`flutter build web`). Les messages d'erreur cités sont ceux observés ; les chemins de fichiers y ont été raccourcis.

> **À retenir.** Le dépôt de l'enseignant est la **source des règles et des scénarios** ; le code Dart pas à pas de ce chapitre est une **proposition d'étude** exécutée pour ce support, pas une copie du dépôt.

---

## 2. La fourmi de Langton en deux minutes

La fourmi de Langton est un **automate cellulaire** : un petit « jeu » sans joueur, où des règles très simples, répétées, produisent un comportement difficile à prévoir. Elle a été imaginée par Chris Langton en 1986 (Wikipédia, *Langton's ant*, « invented by Chris Langton in 1986 » ; le README du dépôt la situe aussi en 1986).

**Le décor.** Une grille quadrillée infinie, dont toutes les cases sont d'abord blanches. Une fourmi se trouve sur une case et regarde dans une direction (nord, est, sud ou ouest).

**Les deux règles.** À chaque pas :

1. si la fourmi est sur une case **blanche** : elle tourne d'un quart de tour **à droite**, la case devient **noire**, la fourmi **avance** d'une case ;
2. si elle est sur une case **noire** : elle tourne d'un quart de tour **à gauche**, la case devient **blanche**, la fourmi **avance** d'une case.

**Pourquoi c'est un bon support.** Les règles tiennent en trois lignes, mais le résultat est surprenant : la trajectoire paraît d'abord chaotique, puis, d'après Wikipédia, après environ 10 000 pas la fourmi se met à construire une « autoroute » (*highway*) qui se répète tous les 104 pas. Ce phénomène (un comportement d'ensemble que les règles ne laissent pas deviner) s'appelle l'**émergence**. Pour un cours de génie logiciel, c'est idéal : on peut **tout vérifier avec des tests**, du plus petit pas jusqu'au comportement global (exercice 3).

**Convention de ce chapitre.** On repère les cases par deux nombres (x, y). Aller vers l'est fait croître x, aller vers le nord fait croître y (comme sur une carte). Même convention que le serveur Rust du dépôt.

*Sources : Wikipédia, « Langton's ant » ; README du dépôt de l'enseignant (section 0).*

---

## 3. Préparer l'atelier

### 3.1 Ce qu'il vous faut

Les outils installés en séance 1 : **Flutter** (qui embarque le langage **Dart**), **git**, **VS Code**. Vérifiez dans un terminal (le **terminal** est la fenêtre où l'on tape des commandes) :

```bash
flutter --version
git --version
```

Résultat attendu : une ligne de version pour chacun. Si `flutter` est « introuvable », le dossier `bin` de Flutter n'est pas dans votre `PATH` (la liste des dossiers où le système cherche les programmes) : reprenez la fiche d'installation de la séance.

### 3.2 Créer le projet

```bash
flutter create --empty --platforms=web fourmi_langton
cd fourmi_langton
git init
mkdir test
```

- `flutter create --empty` génère un projet minimal (sans l'exemple de compteur) ; `--platforms=web` limite aux fichiers utiles pour Chrome.
- Le dossier `lib/` contiendra **le code du programme**, le dossier `test/` **les tests**. Cette séparation est une convention de Dart et Flutter : un fichier de test s'appelle `quelquechose_test.dart` et se place dans `test/`.
- Le nom du projet, `fourmi_langton`, est écrit dans le fichier `pubspec.yaml` (la « carte d'identité » du projet : nom, dépendances). Il sert dans les `import` ci-dessous.

Premier commit (voir section 8) :

```bash
git add .
git commit -m "chore: projet Flutter vide"
```

**Erreurs probables.**

| Symptôme | Cause | Remède |
|---|---|---|
| `flutter: command not found` | Flutter absent du `PATH` | Ajouter `.../flutter/bin` au `PATH`, rouvrir le terminal |
| « Target directory already exists » | le dossier existe déjà | choisir un autre nom ou supprimer le dossier |
| `git: command not found` | git non installé | refaire l'installation de git |

### 3.3 Le cycle TDD, en trois couleurs

| Temps | Vous faites | Vous observez |
|---|---|---|
| **Rouge** | écrire **un** test pour un comportement qui n'existe pas encore | le test **échoue** (c'est normal, et nécessaire) |
| **Vert** | écrire le code **le plus simple** qui fait passer le test | tous les tests passent |
| **Refactor** | nettoyer le code (noms, doublons) **sans changer** ce qu'il fait | tous les tests restent verts |

Le TDD est associé à Kent Beck, qui l'a décrit dans *Test-Driven Development by Example* (2002) (cadrage vu en séance 1, diapositive « Jalon 4 »). Deux idées guident ce chapitre.

**Pourquoi voir rouge d'abord.** Un test qui n'a jamais échoué pourrait réussir pour n'importe quelle raison, y compris parce qu'il ne teste rien. Voir rouge prouve que le test est capable de détecter l'absence du comportement.

**Pourquoi le code « le plus simple ».** On écrit juste de quoi passer le test courant, pas ce dont on pense avoir besoin plus tard. Deux méthodes classiques (décrites par Beck, ici présentées de mémoire de praticien : non re-vérifiées dans l'ouvrage) : « faire semblant » (renvoyer une valeur écrite en dur, ce que l'on fait à l'étape 1) puis **trianguler** (ajouter un deuxième test qui oblige à généraliser).

La commande de vérification est toujours la même, à la racine du projet :

```bash
flutter test
```

Elle compile et exécute tous les fichiers de `test/`. Sa sortie se lit ainsi : `+N` = N tests réussis, `-M` = M tests échoués, « All tests passed! » = tout est vert.

---

## 4. Étape 1 · Tourner à droite

**Objectif.** Modéliser les quatre directions et le quart de tour à droite.

**Vocabulaire minimal.** Une **énumération** (`enum`) est une liste fermée de valeurs possibles : ici les quatre caps. Une **méthode** est une action attachée à une valeur : `Cap.nord.aDroite()` se lit « le cap nord, tourné à droite ».

### 4.1 Rouge : le test

Créez `test/langton_test.dart` :

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:fourmi_langton/langton.dart';

void main() {
  test('tourner à droite depuis le nord donne l\'est', () {
    expect(Cap.nord.aDroite(), Cap.est);
  });
}
```

Lecture : `test('description', () { ... })` déclare un test ; `expect(obtenu, attendu)` compare. Le `\'` est une apostrophe protégée dans le texte.

Lancez `flutter test`. Résultat attendu (extrait, observé) :

```text
test/langton_test.dart:2:8: Error: Error when reading 'lib/langton.dart': No such file or directory
test/langton_test.dart:6:12: Error: Undefined name 'Cap'.
00:00 +0 -1: Some tests failed.
```

C'est **rouge**, pour la bonne raison : ni le fichier ni `Cap` n'existent. En Dart, un test qui référence du code absent échoue **à la compilation** ; c'est la forme que prend le rouge ici.

### 4.2 Vert : le code minimal

Créez `lib/langton.dart` avec le strict nécessaire, en « faisant semblant » :

```dart
enum Cap {
  nord,
  est,
  sud,
  ouest;

  Cap aDroite() => Cap.est;
}
```

`flutter test` → `00:00 +1: All tests passed!`. Un seul test, une seule réponse : écrite en dur, mais **verte**.

### 4.3 Triangulation : un deuxième test rouge

Ajoutez dans `main()`, sous le premier test :

```dart
  test('tourner à droite depuis l\'est donne le sud', () {
    expect(Cap.est.aDroite(), Cap.sud);
  });
```

Résultat observé :

```text
00:00 +1 -1: tourner à droite depuis l'est donne le sud [E]
  Expected: Cap:<Cap.sud>
    Actual: Cap:<Cap.est>
```

Le message est précieux : « attendu sud, obtenu est ». Il vous dit exactement ce qui manque. Remplacez la méthode par la vraie règle :

```dart
  Cap aDroite() => switch (this) {
        Cap.nord => Cap.est,
        Cap.est => Cap.sud,
        Cap.sud => Cap.ouest,
        Cap.ouest => Cap.nord,
      };
```

(`switch` est ici une expression de choix : selon la valeur de `this`, c'est-à-dire du cap courant, elle renvoie la valeur à droite de la flèche. Le compilateur Dart refuse un `switch` qui oublierait un cas d'une énumération : filet de sécurité gratuit.)

`flutter test` → `+2: All tests passed!`.

### 4.4 Refactor : un tableau de cas

Deux tests presque identiques, quatre cas à couvrir : on les regroupe. Remplacez tout le contenu de `main()` par :

```dart
void main() {
  group('Cap, tourner à droite', () {
    const cas = [
      (Cap.nord, Cap.est),
      (Cap.est, Cap.sud),
      (Cap.sud, Cap.ouest),
      (Cap.ouest, Cap.nord),
    ];
    for (final (depart, attendu) in cas) {
      test('$depart donne $attendu', () {
        expect(depart.aDroite(), attendu);
      });
    }
  });
}
```

Une paire entre parenthèses, `(Cap.nord, Cap.est)`, est un **enregistrement** (*record*, fonctionnalité de Dart 3) ; la boucle `for` en extrait les deux éléments et crée **un test par ligne**. `group` range les tests sous une étiquette. `flutter test` → `+4: All tests passed!`.

Côté code, nettoyez aussi : la même règle s'exprime par un calcul sur la position du cap dans la liste (`index` : nord vaut 0, est 1, sud 2, ouest 3) :

```dart
enum Cap {
  nord,
  est,
  sud,
  ouest;

  /// Quart de tour dans le sens des aiguilles d'une montre.
  Cap aDroite() => Cap.values[(index + 1) % Cap.values.length];
}
```

(`%` est le reste de la division : après ouest, 3 + 1 = 4, et 4 modulo 4 vaut 0, c'est-à-dire nord.) **Les quatre tests protègent ce nettoyage** : si vous vous trompez, l'un d'eux devient rouge. C'est toute la valeur du refactor sous filet.

Commit : `git add . && git commit -m "feat(cap): tourner à droite"`.

**Erreurs probables.**

| Symptôme | Cause | Remède |
|---|---|---|
| `Target of URI doesn't exist: 'package:fourmi_langton/langton.dart'` | nom du projet différent dans `pubspec.yaml` | corriger le début de l'`import` |
| `Expected ';' after this` | parenthèse ou accolade oubliée en collant du code | relire la ligne indiquée, `dart format .` aide à repérer |
| aucun test détecté | fichier de test mal nommé ou hors de `test/` | `*_test.dart` dans `test/` |
| test vert dès le premier lancement | le test ne teste rien, ou le code existait déjà | **méfiance** : rendez-le rouge volontairement (voir exercice 1) |

---

## 5. Étape 2 · Tourner à gauche

**Objectif.** Même chose dans l'autre sens.

**Rouge.** Ajoutez, dans `main()` après le premier `group` :

```dart
  group('Cap, tourner à gauche', () {
    const cas = [
      (Cap.nord, Cap.ouest),
      (Cap.ouest, Cap.sud),
      (Cap.sud, Cap.est),
      (Cap.est, Cap.nord),
    ];
    for (final (depart, attendu) in cas) {
      test('$depart donne $attendu', () {
        expect(depart.aGauche(), attendu);
      });
    }
  });
```

`flutter test` : erreur de compilation « The method 'aGauche' isn't defined for the type 'Cap' » (observé). Rouge.

**Vert.** Dans l'énumération, sous `aDroite` :

```dart
  /// Quart de tour dans le sens inverse.
  Cap aGauche() => Cap.values[(index + 3) % Cap.values.length];
```

(Trois quarts de tour à droite font un quart de tour à gauche : d'où `+ 3`.) Ici nous sautons le « faire semblant », car la règle est déjà claire : le TDD tolère de grands pas **quand on est sûr de soi**, et impose de petits pas **dès que l'on doute**. Si le doute survient, revenez au petit pas.

`flutter test` → `+8: All tests passed!`. Commit : `feat(cap): tourner à gauche`.

**Refactor.** Rien à nettoyer ici ; savoir **ne pas** refactorer fait partie du métier. *Erreur probable* : mettre `+ 1` au lieu de `+ 3` ; le test dit alors « attendu ouest, obtenu est », donc l'erreur de sens saute aux yeux.

---

## 6. Étape 3 · Avancer d'une case

**Objectif.** Calculer la nouvelle position quand la fourmi avance dans la direction de son cap.

**Rouge.** Ajoutez dans `main()` :

```dart
  group('Cap, avancer d\'une case', () {
    const cas = [
      (Cap.nord, (0, 1)),
      (Cap.est, (1, 0)),
      (Cap.sud, (0, -1)),
      (Cap.ouest, (-1, 0)),
    ];
    for (final (cap, attendu) in cas) {
      test('depuis (0, 0) vers $cap on arrive en $attendu', () {
        expect(cap.avancer((0, 0)), attendu);
      });
    }
  });
```

Une position est une paire `(x, y)`. Le test dit : depuis (0, 0), le nord mène en (0, 1), l'est en (1, 0), etc. Rouge (« The method 'avancer' isn't defined »).

**Vert.** En tête de `lib/langton.dart`, nommez le type « position » (un **alias**, `typedef`, est un surnom donné à un type existant), puis ajoutez la méthode :

```dart
/// Une position sur la grille : (x, y). Le nord correspond à y qui augmente.
typedef Position = (int, int);

enum Cap {
  nord,
  est,
  sud,
  ouest;

  /// Quart de tour dans le sens des aiguilles d'une montre.
  Cap aDroite() => Cap.values[(index + 1) % Cap.values.length];

  /// Quart de tour dans le sens inverse.
  Cap aGauche() => Cap.values[(index + 3) % Cap.values.length];

  /// La position obtenue en avançant d'une case dans cette direction.
  Position avancer(Position p) {
    final (x, y) = p;
    return switch (this) {
      Cap.nord => (x, y + 1),
      Cap.est => (x + 1, y),
      Cap.sud => (x, y - 1),
      Cap.ouest => (x - 1, y),
    };
  }
}
```

`flutter test` → `+12: All tests passed!`. Commit : `feat(cap): avancer d'une case`.

**Refactor.** Le code est déjà lisible. Un bon réflexe : relire les **noms**. Ici, `p` est court mais le commentaire et le type `Position` l'expliquent.

*Erreur probable* : inverser le sens de y (nord = y qui diminue, comme sur un écran). Le test échoue, c'est précisément son rôle : il fixe la **convention** noir sur blanc.

---

## 7. Étape 4 · Un pas de la fourmi

**Objectif.** Combiner les trois briques : lire la couleur de la case, tourner, noircir ou blanchir, avancer.

### 7.1 Rouge

Ajoutez dans `main()` (les valeurs viennent des tests du serveur Rust du dépôt) :

```dart
  group('Un pas de la fourmi', () {
    test('sur une case blanche : tourne à droite, noircit, avance', () {
      const fourmi = (cap: Cap.nord, position: (0, 0));

      final resultat = pas(fourmi, Couleur.blanc);

      expect(resultat.fourmi, (cap: Cap.est, position: (1, 0)));
      expect(resultat.couleurLaissee, Couleur.noir);
    });

    test('sur une case noire : tourne à gauche, blanchit, avance', () {
      const fourmi = (cap: Cap.est, position: (1, 0));

      final resultat = pas(fourmi, Couleur.noir);

      expect(resultat.fourmi, (cap: Cap.nord, position: (1, 1)));
      expect(resultat.couleurLaissee, Couleur.blanc);
    });
  });
```

Remarquez la structure en trois paragraphes : **préparer** (la fourmi), **agir** (`pas`), **vérifier** (`expect`). C'est la forme que le BDD rend explicite (section 10).

Rouge : `Undefined name 'Couleur'`, `Method not found: 'pas'`.

### 7.2 Vert, en deux temps

**Temps 1 : on ne traite que la case blanche.** Ajoutez à la fin de `lib/langton.dart` :

```dart
enum Couleur { blanc, noir }

/// L'état de la fourmi : où elle regarde et où elle se trouve.
typedef Fourmi = ({Cap cap, Position position});

/// Un pas, version minimale : on ne gère que la case blanche.
({Fourmi fourmi, Couleur couleurLaissee}) pas(Fourmi fourmi, Couleur sous) {
  final cap = fourmi.cap.aDroite();
  return (
    fourmi: (cap: cap, position: cap.avancer(fourmi.position)),
    couleurLaissee: Couleur.noir,
  );
}
```

(Les accolades dans `({Cap cap, Position position})` définissent un enregistrement **à champs nommés** : `fourmi.cap`, `fourmi.position`.) Résultat observé : le test « blanche » est vert, le test « noire » reste rouge : `+13 -1`. On avance **un** test à la fois.

**Temps 2 : la vraie règle.** Remplacez l'ensemble de `enum Couleur` jusqu'à la fin de `pas` par :

```dart
enum Couleur {
  blanc,
  noir;

  Couleur inverse() => this == Couleur.blanc ? Couleur.noir : Couleur.blanc;
}

/// L'état de la fourmi : où elle regarde et où elle se trouve.
typedef Fourmi = ({Cap cap, Position position});

/// Un pas de la fourmi sur une case de la couleur [sous].
/// Rend la fourmi après le pas et la couleur laissée sur la case quittée.
({Fourmi fourmi, Couleur couleurLaissee}) pas(Fourmi fourmi, Couleur sous) {
  final cap = switch (sous) {
    Couleur.blanc => fourmi.cap.aDroite(),
    Couleur.noir => fourmi.cap.aGauche(),
  };
  return (
    fourmi: (cap: cap, position: cap.avancer(fourmi.position)),
    couleurLaissee: sous.inverse(),
  );
}
```

`flutter test` → `+14: All tests passed!`.

### 7.3 Refactor

Le nettoyage a eu lieu pendant le vert : `Couleur.inverse()` remplace la valeur écrite en dur et porte le sens (« l'autre couleur »). Relancez les tests : toujours verts. Commit : `feat(fourmi): un pas selon la couleur de la case`.

**Erreurs probables.** Oublier le `const` devant `fourmi` n'est pas bloquant (c'est seulement une bonne habitude). Mettre `couleurLaissee: sous` (la couleur de départ, non inversée) : les deux tests deviennent rouges, avec « attendu noir, obtenu blanc ».

---

## 8. Étape 5 · La grille et plusieurs pas

**Objectif.** Garder en mémoire quelles cases sont noires et enchaîner les pas.

**Idée de conception.** Une grille infinie ne se stocke pas en entier : on retient seulement **l'ensemble des cases noires** (tout le reste est blanc). Un **ensemble** (`Set`) est une collection sans doublons où l'on teste très vite « cette case est-elle dedans ? ».

### 8.1 Rouge

Les valeurs du test viennent du test `test_complete_sequence` du serveur Rust : quatre pas ramènent la fourmi à son point de départ, puis le cinquième tombe sur une case noire. Ajoutez dans `main()` :

```dart
  group('Le monde', () {
    test('au départ : tout est blanc, la fourmi regarde le nord en (0, 0)', () {
      final monde = Monde();

      expect(monde.fourmi, (cap: Cap.nord, position: (0, 0)));
      expect(monde.couleurEn((0, 0)), Couleur.blanc);
      expect(monde.etapes, 0);
    });

    test('après 4 pas, la fourmi est revenue au départ sur 4 cases noires', () {
      final monde = Monde();

      for (var i = 0; i < 4; i++) {
        monde.avancerUnPas();
      }

      expect(monde.fourmi, (cap: Cap.nord, position: (0, 0)));
      expect(monde.etapes, 4);
      for (final p in [(0, 0), (1, 0), (1, -1), (0, -1)]) {
        expect(monde.couleurEn(p), Couleur.noir, reason: 'case $p');
      }
    });

    test('au 5e pas, elle retrouve une case noire : elle tourne à gauche', () {
      final monde = Monde();
      for (var i = 0; i < 5; i++) {
        monde.avancerUnPas();
      }

      expect(monde.fourmi, (cap: Cap.ouest, position: (-1, 0)));
      expect(monde.couleurEn((0, 0)), Couleur.blanc);
    });
  });
```

Rouge : `Method not found: 'Monde'`. Vous pouvez vérifier à la main la valeur du deuxième test : nord/blanc → est en (1, 0) ; est/blanc → sud en (1, -1) ; sud/blanc → ouest en (0, -1) ; ouest/blanc → nord en (0, 0) ; la case (0, 0) est alors noire, d'où le virage à gauche au cinquième pas.

### 8.2 Vert

Ajoutez à la fin de `lib/langton.dart` :

```dart
/// La grille (infinie, toute blanche au départ) et la fourmi qui s'y déplace.
class Monde {
  Fourmi fourmi = (cap: Cap.nord, position: (0, 0));
  int etapes = 0;
  final Set<Position> _casesNoires = {};

  Couleur couleurEn(Position p) =>
      _casesNoires.contains(p) ? Couleur.noir : Couleur.blanc;

  void avancerUnPas() {
    final quittee = fourmi.position;
    final resultat = pas(fourmi, couleurEn(quittee));
    if (resultat.couleurLaissee == Couleur.noir) {
      _casesNoires.add(quittee);
    } else {
      _casesNoires.remove(quittee);
    }
    fourmi = resultat.fourmi;
    etapes++;
  }
}
```

Une **classe** regroupe des données (la fourmi, le compteur, les cases noires) et les actions qui les modifient. Le trait de soulignement dans `_casesNoires` signale un détail interne, non destiné à l'extérieur du fichier.

`flutter test` → `+17: All tests passed!`. Commit : `feat(monde): grille et enchaînement des pas`.

### 8.3 Refactor

À ce stade, la logique est découpée en trois niveaux : la **direction** (`Cap`), la **règle** (`pas`, une fonction sans mémoire), le **monde** (qui mémorise). Cette séparation est ce que le programme du cours appelle plus tard l'architecture en couches (séance 2) : la règle métier ne sait rien de l'écran. Vous n'avez rien à changer, mais gardez-la en tête pour l'étape suivante : **l'affichage ne contiendra aucune règle**.

**Erreurs probables.** Oublier `etapes++` (le compteur reste à 0, le test 2 le dit). Oublier de retirer la case de l'ensemble quand elle redevient blanche (le test du 5e pas échoue sur `couleurEn((0, 0))`).

---

## 9. Étape 6 · Un affichage Flutter, test d'abord

**Objectif.** Afficher une fenêtre de 11 × 11 cases autour de l'origine, la fourmi, un compteur, et un bouton « Pas suivant ».

**Vocabulaire Flutter minimal.** Dans Flutter, l'écran est un **arbre de widgets** : un *widget* est une brique d'interface (un texte, un bouton, une ligne, une colonne). Un widget **avec état** (`StatefulWidget`) peut changer ; on demande le redessin avec `setState`. Un **widget test** (`testWidgets`) lance l'interface dans un faux écran, sans navigateur, et la manipule comme un utilisateur (`tester.tap`) ; `find` retrouve des éléments, par leur texte ou par une **clé** (`ValueKey`, une étiquette qu'on leur colle pour les retrouver). Ces fonctions sont décrites dans la documentation officielle Flutter (« An introduction to widget testing »).

### 9.1 Rouge

Créez `test/ecran_test.dart` :

```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fourmi_langton/ecran.dart';

Color? couleurDeLaCase(WidgetTester tester, int x, int y) {
  final boite = tester.widget<DecoratedBox>(find.byKey(ValueKey('case-$x-$y')));
  return (boite.decoration as BoxDecoration).color;
}

Finder fourmiEn(int x, int y) => find.descendant(
  of: find.byKey(ValueKey('case-$x-$y')),
  matching: find.byKey(const ValueKey('fourmi')),
);

void main() {
  testWidgets(
    'au départ : compteur à 0, case centrale blanche avec la fourmi',
    (tester) async {
      await tester.pumpWidget(const ApplicationLangton());

      expect(find.text('Pas : 0'), findsOneWidget);
      expect(couleurDeLaCase(tester, 0, 0), Colors.white);
      expect(fourmiEn(0, 0), findsOneWidget);
    },
  );

  testWidgets('un clic sur « Pas suivant » : la case quittée devient noire', (
    tester,
  ) async {
    await tester.pumpWidget(const ApplicationLangton());

    await tester.tap(find.text('Pas suivant'));
    await tester.pump();

    expect(find.text('Pas : 1'), findsOneWidget);
    expect(couleurDeLaCase(tester, 0, 0), Colors.black);
    expect(fourmiEn(1, 0), findsOneWidget);
    expect(fourmiEn(0, 0), findsNothing);
  });
}
```

Les deux fonctions d'aide en tête évitent de répéter du code technique : elles rendent les tests **lisibles** (« la couleur de la case (0, 0) », « la fourmi en (1, 0) »). `pumpWidget` construit l'interface, `pump` la redessine après une action. Le test précise le comportement attendu : au départ le compteur affiche « Pas : 0 » ; après un clic, « Pas : 1 », la case (0, 0) est noire et la fourmi est en (1, 0).

`flutter test test/ecran_test.dart` : rouge, `Couldn't find constructor 'ApplicationLangton'` (observé).

### 9.2 Vert

Créez `lib/ecran.dart` :

```dart
import 'package:flutter/material.dart';

import 'langton.dart';

class ApplicationLangton extends StatelessWidget {
  const ApplicationLangton({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fourmi de Langton',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
      ),
      home: const EcranLangton(),
    );
  }
}

class EcranLangton extends StatefulWidget {
  const EcranLangton({super.key});

  @override
  State<EcranLangton> createState() => _EtatEcranLangton();
}

class _EtatEcranLangton extends State<EcranLangton> {
  static const int _rayon = 5; // on affiche de -5 à +5 : 11 x 11 cases
  static const double _tailleCase = 24;

  final Monde _monde = Monde();

  void _pasSuivant() => setState(_monde.avancerUnPas);

  Widget _case(int x, int y) {
    final estNoire = _monde.couleurEn((x, y)) == Couleur.noir;
    final contientFourmi = _monde.fourmi.position == (x, y);
    return DecoratedBox(
      key: ValueKey('case-$x-$y'),
      decoration: BoxDecoration(
        color: estNoire ? Colors.black : Colors.white,
        border: Border.all(color: Colors.grey),
      ),
      child: SizedBox(
        width: _tailleCase,
        height: _tailleCase,
        child: contientFourmi
            ? const Icon(
                Icons.bug_report,
                key: ValueKey('fourmi'),
                size: 18,
                color: Colors.red,
              )
            : null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Fourmi de Langton')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Pas : ${_monde.etapes}'),
            const SizedBox(height: 16),
            for (var y = _rayon; y >= -_rayon; y--)
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [for (var x = -_rayon; x <= _rayon; x++) _case(x, y)],
              ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _pasSuivant,
              child: const Text('Pas suivant'),
            ),
          ],
        ),
      ),
    );
  }
}
```

Points de lecture : le widget **ne contient aucune règle** de la fourmi, il appelle `Monde` (`avancerUnPas`, `couleurEn`) ; l'axe y est parcouru **du haut vers le bas** (de +5 à -5) pour que le nord soit en haut de l'écran ; `setState` demande à Flutter de redessiner.

Branchez ensuite le programme principal, `lib/main.dart` (remplacez tout) :

```dart
import 'package:flutter/material.dart';

import 'ecran.dart';

void main() {
  runApp(const ApplicationLangton());
}
```

`flutter test` → `+19: All tests passed!`. Vérification à l'œil, dans Chrome :

```bash
flutter run -d chrome
```

Résultat attendu : une grille blanche de 11 × 11 cases, une petite icône rouge au centre, « Pas : 0 ». Chaque clic sur « Pas suivant » fait avancer la fourmi. (Le lancement dans Chrome n'a pas pu être **observé visuellement** pendant la rédaction ; la compilation web, elle, a été exécutée avec succès par `flutter build web`.)

Commit : `feat(ui): affichage de la grille et bouton Pas suivant`.

### 9.3 Refactor et limites

Rien à nettoyer d'urgent. Notez deux limites **assumées** : la fenêtre ne montre que ±5 cases (au bout d'un moment la fourmi sort de l'écran, voir exercice 6) et le test de l'écran vérifie la **logique visible** (couleur, position) mais pas l'apparence exacte (taille, teinte du gris). Un test se concentre sur ce qui compte pour l'utilisateur.

**Erreurs probables.**

| Symptôme | Cause | Remède |
|---|---|---|
| `Bad state: No element` au `tester.widget` | la clé cherchée n'existe pas (par exemple `case-6-0` hors fenêtre) | rester dans [-5, 5] |
| `A RenderFlex overflowed` | écran trop petit pour la colonne | réduire `_tailleCase` ou entourer de `SingleChildScrollView` |
| le texte « Pas : 1 » n'est pas trouvé | oubli du `tester.pump()` après le clic | toujours `pump` après une action |
| Chrome ne s'ouvre pas | Chrome absent ou non détecté | `flutter devices` doit lister Chrome ; `flutter doctor` |

---

## 10. Le BDD en aperçu : Soit, Quand, Alors

Le **BDD** (*Behavior-Driven Development*, développement piloté par le comportement) est présenté en séance 1 comme le jalon de 2006 : Dan North, article « Introducing BDD », publié dans la revue *Better Software* (article de mars 2006, d'après l'historique du BDD publié par Cucumber, https://cucumber.io/docs/bdd/history ; consulté le 6 octobre 2026). Son idée : en enseignant le TDD, il rencontrait toujours les mêmes confusions (par où commencer, que tester, comment nommer), et il a répondu en parlant de **comportement** plutôt que de test.

Un comportement se décrit par un **scénario** en trois temps :

| Mot anglais | Mot français | Rôle |
|---|---|---|
| *Given* | **Soit** | le contexte de départ |
| *When* | **Quand** | l'action |
| *Then* | **Alors** | le résultat attendu |

Voici un scénario de la fourmi, au format **Gherkin** (le langage des scénarios, utilisé par l'outil **Cucumber**). Il est directement tiré du premier scénario du fichier `langton_ant.feature` du dépôt (traduit en français) :

```gherkin
Fonctionnalité: Un pas de la fourmi de Langton

  Scénario: Fourmi sur une case blanche, tournée vers le nord
    Soit une fourmi en (0, 0) tournée vers le nord
    Et une case (0, 0) blanche
    Quand elle fait un pas
    Alors elle est tournée vers l'est
    Et elle est en (1, 0)
    Et la case (0, 0) est noire
```

Il se lit sans connaître la programmation : c'est son intérêt, il peut être écrit et relu par un expert métier. Le dépôt de l'enseignant présente ensuite la bibliothèque `bdd_widget_test`, qui **génère** des tests Flutter à partir de fichiers `.feature` (son README indique la version `^1.7.4` ; à la date de rédaction, `flutter pub add --dev --dry-run` résout une version 2.1.4 : **vérifiez la version actuelle sur pub.dev** avant installation, la mise en œuvre complète est vue en séance 3).

**Sans outil, on peut déjà penser en BDD.** Voici le même scénario écrit à la main, dans `test/scenarios_test.dart`, avec les trois temps en commentaires (exécuté : `+1`, vert) :

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:fourmi_langton/langton.dart';

// Scénario : fourmi sur une case blanche, tournée vers le nord
//   Soit une fourmi en (0, 0) tournée vers le nord
//   Et une case (0, 0) blanche
//   Quand elle fait un pas
//   Alors elle est tournée vers l'est
//   Et elle est en (1, 0)
//   Et la case (0, 0) est noire
void main() {
  test('Fourmi sur une case blanche, tournée vers le nord', () {
    // Soit
    final monde = Monde();

    // Quand
    monde.avancerUnPas();

    // Alors
    expect(monde.fourmi.cap, Cap.est);
    expect(monde.fourmi.position, (1, 0));
    expect(monde.couleurEn((0, 0)), Couleur.noir);
  });
}
```

Le fichier complet fait maintenant **20 tests verts** (`flutter test`).

**Qui écrit quoi ?** Le scénario est écrit **avant** le code, par l'humain qui connaît la règle (vous). Il devient la **spécification** de départ de l'agent. Le dépôt de l'enseignant appuie cette démarche par l'*Example Mapping* : s'accorder, avant de coder, sur des exemples concrets et des cas limites (cases à coordonnées négatives, par exemple, comme dans le scénario `(-3, -7)` du dépôt). Le *spec-driven development*, vu plus tard, reprend cette logique.

> **À retenir.** Même idée que le TDD (un test est une spécification exécutable), mais **dans les mots du métier** : c'est le pont entre l'expert et l'agent.

---

## 11. Petits commits git : un commit par vert

**Rappel.** Un **commit** est une photographie de votre projet, avec un message et un auteur, que git range dans l'historique. On peut revenir à n'importe quel commit.

**La règle de l'atelier : un commit à chaque vert, un autre après chaque refactor.** Voici l'historique que vous devriez avoir à la fin (les messages suivent le style du dépôt de l'enseignant : `type(portée): description`) :

```bash
git log --oneline
```

```text
feat(ui): affichage de la grille et bouton Pas suivant
feat(monde): grille et enchaînement des pas
feat(fourmi): un pas selon la couleur de la case
feat(cap): avancer d'une case
feat(cap): tourner à gauche
feat(cap): tourner à droite
chore: projet Flutter vide
```

(Les empreintes de commits, des suites de caractères, varient d'un poste à l'autre.) Le cycle de commandes est toujours :

```bash
flutter test            # tout est vert ?
git status              # qu'est-ce qui a changé ?
git add .
git commit -m "feat(cap): tourner à droite"
```

**Pourquoi des commits aussi petits ?**

1. On peut **annuler** un seul pas sans perdre le reste.
2. L'historique **raconte** le raisonnement (le « pourquoi » de chaque changement).
3. Quand un agent travaille, un commit après chaque vert est un **point de reprise** : s'il s'égare, vous revenez au dernier vert.
4. La relecture reste possible : le chapitre sur le craft a rappelé que de très grosses modifications sont relues en diagonale (voir `sources/craft.md`, section « massive pull requests », avis de praticiens).

**Erreurs probables.** « nothing to commit » : rien n'a changé depuis le dernier commit. « Author identity unknown » : réglez `git config user.name` et `git config user.email` (pour des dépôts publics, utilisez l'adresse de type `identifiant+login@users.noreply.github.com` vue en séance). Commit d'un fichier qui ne devrait pas y être (dossier `build/`) : vérifiez le fichier `.gitignore` généré par Flutter.

---

## 12. Le rôle de l'agent : du TDD sans triche

### 12.1 Le problème

Un agent de code comme Claude Code peut écrire du code **et** des tests, les lancer et corriger jusqu'à ce que tout passe. Cela paraît idéal. Voici le piège, décrit par plusieurs sources :

- Si l'agent écrit à la fois le code et ses propres tests, il se **note lui-même** (*self-grading*) : une suite verte prouve la **cohérence**, pas la **justesse**. Ce point est documenté par des analyses tierces sur la méthode AI-DLC (voir `sources/ai-dlc.md`), qui recommandent des tests d'acceptation de **provenance indépendante**, figés avant la construction.
- Générer les tests **après** le code retourne la logique du test (« flips testing on its head ») : les tests deviennent un cachet de validation automatique (*rubber stamp*) qui fige les défauts existants (Sandro Mancuso, Codurance, d'après `sources/craft.md` ; Codurance a un intérêt commercial dans le sujet).
- Kent Beck, dans « Augmented Coding: Beyond the Vibes » (25 juin 2025), surveille trois signaux d'alerte : les boucles, les fonctionnalités non demandées et la **triche**, c'est-à-dire l'agent qui **désactive ou supprime des tests** (article relu le 6 octobre 2026 : « Any indication that the genie was cheating, for example by disabling or deleting tests »).
- Simon Willison présente le « red/green TDD » comme une formule courte que les modèles comprennent : « Use red/green TDD » signifie, selon lui, « write the tests first, confirm that the tests fail before you implement the change that gets them to pass » (https://simonwillison.net/guides/agentic-engineering-patterns/red-green-tdd/).

**Fait, consensus, opinion.** Fait : un agent peut modifier des tests (c'est un outil d'édition de fichiers). Consensus de praticiens (Beck, Willison, Mancuso, et la synthèse de ce cours) : le test d'abord est un garde-fou efficace. Opinion discutable : jusqu'où on peut remplacer la relecture du code par des contrôles automatiques (Robert C. Martin l'affirme en juillet 2026 pour ses propres projets, Grady Booch le conteste ; voir `sources/craft.md`).

### 12.2 La méthode en cinq règles

1. **L'humain écrit (ou valide) les tests avant tout code.** Ce chapitre vous l'a fait faire.
2. **L'agent n'a pas le droit de modifier les tests.** Il écrit le code, il ne touche ni aux tests ni au scénario.
3. **L'humain lance la commande de vérification.** `flutter test` et `dart analyze`, vus de vos yeux, pas seulement racontés par l'agent.
4. **Un vert à la fois, un commit par vert.** Vous relisez le **diff** (la liste des lignes changées, `git diff`) avant de valider.
5. **On vérifie que le test a été rouge avant d'être vert.** Demandez à l'agent de vous montrer la sortie rouge, puis la sortie verte.

### 12.3 Le prompt à donner

Exemple pour l'étape « un pas de la fourmi » (les tests existent déjà, rouges) :

```text
Contexte : projet Flutter "fourmi_langton". Les tests de test/langton_test.dart
décrivent la règle de la fourmi de Langton. Je les ai écrits, ils sont la
spécification.

Tâche : fais passer le groupe de tests « Un pas de la fourmi », en
travaillant en TDD (red/green).

Règles :
1. Lance d'abord `flutter test` et montre-moi la sortie rouge.
2. Écris le code le plus simple dans lib/ uniquement, un test à la fois.
3. Tu ne modifies, ne supprimes, ne désactives et ne contournes AUCUN test
   (pas de skip, pas d'assertion affaiblie, pas de valeur écrite en dur
   qui ne sert qu'à passer un test).
4. Si un test te semble faux, arrête-toi et explique-le moi : c'est moi qui
   décide de le changer.
5. Après chaque vert, lance `flutter test` et `dart analyze`, montre-moi les
   résultats, puis propose un message de commit. Ne commit pas sans mon accord.
6. Fais ensuite un refactor séparé, tests toujours verts.
```

### 12.4 Un fichier d'instructions et une vraie barrière

Le fichier **`CLAUDE.md`**, placé à la racine du projet, est lu au début de chaque session et sert d'instructions permanentes (documentation officielle Claude Code, page « How Claude remembers your project »). Cette même page précise toutefois que Claude le traite comme du **contexte, non comme une configuration appliquée de force** ; pour bloquer une action quoi que décide Claude, il faut un contrôle d'un autre ordre (un *hook*, ou une règle de permission). Exemple de contenu minimal :

```markdown
# Règles du projet fourmi_langton

- Commandes : `flutter test` (tests), `dart analyze` (analyse), `dart format .`
- Méthode : TDD. Le test existe et est rouge AVANT le code.
- Ne jamais modifier le dossier test/ sans demande explicite de l'humain.
- Ne jamais désactiver, supprimer ou affaiblir un test pour le faire passer.
- Un commit par test vert ; message au format `type(portée): description`.
```

Pour **imposer** la règle 2, la documentation des permissions de Claude Code permet de refuser l'édition d'un chemin : les règles `deny` sont évaluées en premier et ne peuvent pas être contournées par une règle `allow`, et la syntaxe de chemin suit celle de `.gitignore`. Dans le fichier `.claude/settings.json` du projet :

```json
{
  "permissions": {
    "deny": ["Edit(/test/**)"]
  }
}
```

Cette règle empêche les outils d'édition de l'agent de modifier `test/`. Deux précautions tirées de la même documentation : une règle `Edit` couvre les outils de fichiers intégrés et les commandes de fichiers que Claude Code reconnaît, **mais pas** un programme arbitraire (par exemple un script Python qui écrit lui-même dans des fichiers) ; pour une barrière au niveau du système, il faut activer le **bac à sable** (*sandbox*). Et le format précis des règles évolue : relisez la page « Configure permissions » de la documentation avant de vous y fier (état consulté le 6 octobre 2026). Autre garde-fou, indépendant de l'agent : l'**intégration continue** (vue au bloc CI/CD de la séance), qui relance tous les tests sur une machine distante à chaque modification.

Ce réglage est **contraignant** : si vous voulez à l'étape suivante ajouter un test, c'est vous qui l'éditez (votre éditeur n'est pas concerné par la règle de l'agent).

### 12.5 Reconnaître la triche

Voici ce qu'il faut surveiller dans le diff, par ordre de gravité :

| Signe dans le diff | Pourquoi c'est suspect |
|---|---|
| un fichier de `test/` modifié alors que vous avez demandé du code | le juge a été changé |
| un test supprimé, ou `skip: true`, ou un test mis en commentaire | on a fait disparaître l'échec |
| `expect(x, isNotNull)` à la place de `expect(x, Cap.est)` | l'assertion a été affaiblie |
| du code qui renvoie la valeur attendue **en dur** pour chaque test | « faire semblant » (étape 1) laissé en l'état |
| un test devenu vert sans que le code concerné ait changé | test qui ne teste rien |
| tous les tests verts dès le premier lancement | rouge jamais observé |

Exemple concret de code tricheur pour le test `Cap.est.aDroite()` :

```dart
Cap aDroite() {
  if (this == Cap.nord) return Cap.est;
  if (this == Cap.est) return Cap.sud;
  return Cap.nord; // faux pour sud et ouest, mais "ça passe" si ces cas ne sont pas testés
}
```

Seule la **qualité des tests** vous protège ici : c'est pourquoi on écrit un test **par cas** (les quatre directions), et pourquoi ce chapitre travaille sur des tableaux de cas.

> **À retenir.** Demander « fais-le en TDD » ne suffit pas. Il faut (1) écrire les tests soi-même, (2) interdire de les modifier, (3) lancer soi-même les commandes, (4) lire le diff, (5) committer par petits pas.

---

## 13. Exercices

1. **Casser pour comprendre (mutation à la main).** Dans `Cap.aGauche`, remplacez `index + 3` par `index + 2`. Lancez `flutter test`. Combien de tests deviennent rouges, et lesquels ? Annulez la modification ensuite (`git checkout -- lib/langton.dart`).
2. **Cas limite.** Écrivez, **avant** toute modification du code, un test pour la fourmi en (-3, -7) tournée vers le sud sur une case noire (scénario présent dans le dépôt, côté Rust). Quel résultat attendez-vous ? Est-il rouge ou vert dès l'écriture ? Que conclure ?
3. **L'autoroute.** Écrivez un test qui exécute 11 000 pas, mémorise la fourmi, exécute 104 pas de plus, et vérifie que le cap est identique et que la position a bougé d'un décalage constant. Quel décalage observez-vous ?
4. **Interface.** Ajoutez un bouton « Réinitialiser » qui remet la fourmi au départ. Écrivez le test d'abord.
5. **Scénario.** Écrivez en Soit/Quand/Alors le cas « fourmi sur une case noire, tournée vers l'est, en (1, 0) ».
6. **Évolution (réflexion).** La fourmi sort de la fenêtre 11 × 11 au bout d'un certain temps. Proposez, en une phrase, deux solutions possibles, et dites quel test vous écririez d'abord pour chacune.
7. **L'agent.** (a) Rédigez le prompt à donner à un agent pour l'exercice 4, en reprenant les six règles de la section 12.3. (b) Un agent vous rend un diff où le test `Cap, tourner à gauche` a été modifié et où un cas a disparu. Que faites-vous ?

---

## 14. Corrigé

**Exercice 1.** Avec `index + 2`, la méthode renvoie le cap **opposé**. Pour les quatre cas du groupe « tourner à gauche » : nord (0) donne sud (2), attendu ouest ; est (1) donne ouest (3), attendu nord ; sud (2) donne nord (0), attendu est ; ouest (3) donne est (1), attendu sud. Les **quatre tests** du groupe deviennent rouges (aucun test du groupe « droite » n'est touché). Leçon : un test utile **échoue quand le code est faux**.

**Exercice 2.** Attendu : en (-3, -7), cap sud, case noire : tourner à gauche depuis le sud donne l'est ; avancer vers l'est donne (-2, -7) ; la case redevient blanche.

```dart
  test('positions négatives : sud sur case noire en (-3, -7)', () {
    const fourmi = (cap: Cap.sud, position: (-3, -7));

    final resultat = pas(fourmi, Couleur.noir);

    expect(resultat.fourmi, (cap: Cap.est, position: (-2, -7)));
    expect(resultat.couleurLaissee, Couleur.blanc);
  });
```

Résultat observé : **vert immédiatement** (le code généralise déjà). C'est normal : ce test n'est pas un test de nouveau comportement mais un **test de non-régression** qui fige un cas limite. Une règle pratique : un test vert dès l'écriture n'est pas interdit, mais demande de vérifier qu'il peut devenir rouge (cassez le code, voyez-le échouer, rétablissez).

**Exercice 3.**

```dart
  test('l\'autoroute : 104 pas décalent la fourmi de (-2, -2)', () {
    final monde = Monde();
    for (var i = 0; i < 11000; i++) {
      monde.avancerUnPas();
    }
    final avant = monde.fourmi;

    for (var i = 0; i < 104; i++) {
      monde.avancerUnPas();
    }

    expect(monde.fourmi.cap, avant.cap);
    expect(monde.fourmi.position, (avant.position.$1 - 2, avant.position.$2 - 2));
  });
```

Valeurs observées avec notre code : après 11 000 pas, la fourmi est en (-34, -14) tournée vers le sud ; après 104 pas de plus, elle est en (-36, -16), même cap. L'autoroute avance donc de 2 cases en diagonale tous les 104 pas, ce qui est cohérent avec la période de 104 pas indiquée par Wikipédia. (Le sens du décalage dépend de notre convention d'axes et de la direction de départ.) `avant.position.$1` désigne le premier élément de la paire. Le test est **vert dès l'écriture** (voir exercice 2).

**Exercice 4.** Test (rouge, car le texte « Réinitialiser » n'existe pas encore) :

```dart
  testWidgets('Réinitialiser remet le compteur à zéro', (tester) async {
    await tester.pumpWidget(const ApplicationLangton());
    await tester.tap(find.text('Pas suivant'));
    await tester.pump();

    await tester.tap(find.text('Réinitialiser'));
    await tester.pump();

    expect(find.text('Pas : 0'), findsOneWidget);
  });
```

Code minimal dans `_EtatEcranLangton` : rendre `_monde` modifiable, ajouter la méthode, ajouter le bouton :

```dart
  Monde _monde = Monde();   // à la place de : final Monde _monde = Monde();

  void _reinitialiser() => setState(() => _monde = Monde());
```

```dart
            TextButton(
              onPressed: _reinitialiser,
              child: const Text('Réinitialiser'),
            ),
```

(à placer dans la liste `children`, sous le `ElevatedButton`). Résultat observé : `flutter test` → `+23: All tests passed!` avec les exercices 2, 3 et 4 (20 + 3). Commit : `feat(ui): bouton réinitialiser`.

**Exercice 5.**

```gherkin
  Scénario: Fourmi sur une case noire, tournée vers l'est
    Soit une fourmi en (1, 0) tournée vers l'est
    Et une case (1, 0) noire
    Quand elle fait un pas
    Alors elle est tournée vers le nord
    Et elle est en (1, 1)
    Et la case (1, 0) est blanche
```

(Même valeurs que le test `test_ant_step_on_black_cell` du serveur Rust du dépôt.)

**Exercice 6.** Pas de réponse unique ; deux pistes : (a) **recentrer** la fenêtre sur la fourmi : premier test à écrire, « la fourmi est toujours affichée au centre » ; (b) **agrandir** la fenêtre ou la rendre défilante : premier test, « une case lointaine, par exemple (20, 0), existe et peut être noircie ». Le choix de conception se fait **avant** le code, par le test.

**Exercice 7.** (a) Exemple de prompt : « Contexte : projet Flutter fourmi_langton. J'ai écrit un test rouge dans test/ecran_test.dart qui décrit un bouton Réinitialiser. Fais-le passer en red/green TDD. Lance d'abord `flutter test` et montre-moi la sortie rouge. Modifie uniquement lib/ecran.dart. Ne touche à aucun test. Après le vert, lance `flutter test` et `dart analyze`, montre les sorties, propose un message de commit sans le lancer. » (b) On **n'accepte pas** le diff : on revient au dernier commit vert (`git restore test/` ou `git checkout -- test/`), on redonne la consigne (règle 3 : interdit de toucher aux tests), on active si besoin la règle `deny` de la section 12.4, et si le test semble réellement faux on le corrige **soi-même**, en le rendant d'abord rouge puis vert. Un test supprimé ou affaibli par l'agent est un signal d'alerte au sens de Beck (section 12.1).

---

## Glossaire du chapitre

- **Agent** : programme à base d'IA qui peut lire, modifier des fichiers et lancer des commandes (ici Claude Code).
- **Alias de type (`typedef`)** : surnom donné à un type existant (ici `Position`).
- **Analyse statique (`dart analyze`)** : vérification automatique du code sans l'exécuter (fautes de frappe, avertissements).
- **API REST** : moyen pour un programme de répondre à des requêtes envoyées par le réseau (ici le serveur Rust du dépôt).
- **Automate cellulaire** : modèle où une grille de cases change selon des règles locales simples.
- **BDD (*Behavior-Driven Development*)** : méthode qui décrit le comportement attendu par des scénarios en langage presque naturel.
- **Classe** : modèle qui regroupe des données et les actions qui les modifient.
- **Commit** : photographie datée et commentée du projet dans l'historique git.
- **Compilation** : traduction du code en un programme exécutable par la machine ; une erreur de compilation empêche tout test.
- **Diff** : liste des lignes ajoutées et supprimées entre deux versions.
- **Dojo / kata** : séance d'entraînement / exercice court répété pour travailler le geste.
- **Émergence** : comportement d'ensemble complexe produit par des règles locales simples.
- **Énumération (`enum`)** : liste fermée de valeurs possibles.
- **Enregistrement (*record*)** : valeur composée de plusieurs éléments, avec ou sans noms, comparable directement (fonctionnalité de Dart 3).
- **Example Mapping** : atelier où l'on s'accorde sur des exemples concrets avant de coder.
- **Gherkin** : langage des scénarios (`Given/When/Then`, en français `Soit/Quand/Alors`).
- **Hook** : script que l'outil déclenche automatiquement à un moment précis (par exemple avant une édition).
- **Intégration continue (CI)** : exécution automatique des tests sur une machine distante à chaque modification.
- **Méthode** : action attachée à une valeur ou à une classe.
- **Refactor (refactoring)** : amélioration de la structure du code sans changer son comportement.
- **Self-grading** : situation où le même agent écrit le code et les tests qui le jugent.
- **TDD (*Test-Driven Development*)** : cycle rouge, vert, refactor.
- **Test (unitaire)** : petit programme qui vérifie un comportement précis et répond « réussi » ou « échoué ».
- **Widget** : brique d'interface Flutter ; **widget test** : test qui manipule une interface dans un faux écran.

---

## Pour aller plus loin

- Rejouer l'atelier **sans l'agent**, puis **avec** : comparez le nombre de commits, ce que vous avez relu, ce qui vous a surpris.
- Dans le dépôt de l'enseignant : lire `server/langton-rs/tests/features/langton_ant.feature` (11 scénarios) et le comparer à vos tests Dart ; faire l'**Example Mapping** des 20 images de `ant_movements/`.
- Étendre le dojo : variantes de la fourmi (plusieurs fourmis, règles à plus de deux couleurs), zoom de la fenêtre, vitesse automatique (un `Timer` qui fait avancer la fourmi : test d'abord).
- Lire l'article de Willison sur le red/green TDD et l'article de Beck sur l'augmented coding (voir sources).
- Séance 3 : première user story en TDD et BDD avec l'agent, et mise en place de `bdd_widget_test`.

---

## Points non vérifiés

- **Exercice 1** (mutation `index + 2`) : la conclusion « les quatre tests du groupe gauche deviennent rouges » est déduite par calcul (voir le corrigé), non relancée.
- **Lancement dans Chrome** (`flutter run -d chrome`) : l'affichage n'a pas été observé visuellement ; seuls les tests, `dart analyze` et `flutter build web` ont été exécutés.
- **Test `widget_test.dart` du dépôt** : jugé périmé d'après la lecture du code, non exécuté.
- **Kent Beck, *Test-Driven Development by Example* (2002)** et les méthodes « faire semblant » et « trianguler » : ouvrage non relu ; date d'après les notes de séance.
- **Revirement de Robert C. Martin (juillet 2026) et désaccord avec Grady Booch** : repris de `sources/craft.md`, non revérifiés à la source.
- **Version de `bdd_widget_test`** : 2.1.4 résolue le 6 octobre 2026 ; à revérifier avant installation.
- **Format des règles de permissions Claude Code** : peut évoluer ; relire la documentation.

---

## Sources

**Dépôt de l'enseignant (source principale de ce chapitre)**
- Dépôt `flutter_dojo_langton_ant` (README, `ant_movements/`, `server/langton-rs/`, `front/langton_flutter/`, `exercices_devtools.md`) : https://github.com/b-fontaine/flutter_dojo_langton_ant (copie locale lue : `/tmp/claude-1000/-home-bfontaine-git-master-1-iti-dev/d23f8d3a-3a49-463b-8078-f2bec091248e/scratchpad/repos/flutter_dojo_langton_ant`).

**Fourmi de Langton**
- Wikipédia (anglais), « Langton's ant » : https://en.wikipedia.org/wiki/Langton%27s_ant (invention en 1986, règles, autoroute de 104 pas après environ 10 000 pas ; consulté le 6 octobre 2026).

**TDD, BDD, agents**
- Diapositives et notes de la séance 1 : `/home/bfontaine/git/master-1-iti-dev/cours/presentations/day-1/index.html` et `notes.html` (jalons « XP et TDD », « BDD », démonstration `estReussite`) ; programme : `/home/bfontaine/git/master-1-iti-dev/cours/programme-detaille.md` (séance S1, bloc 5).
- Kent Beck, *Test-Driven Development by Example*, 2002 (date et auteur d'après les notes de séance ; contenu non relu pour ce chapitre).
- Kent Beck, « Augmented Coding: Beyond the Vibes », 25 juin 2025 : https://newsletter.kentbeck.com/p/augmented-coding-beyond-the-vibes (relu le 6 octobre 2026 : date et trois signaux d'alerte confirmés).
- Simon Willison, « Red/green TDD », guide *Agentic Engineering Patterns* : https://simonwillison.net/guides/agentic-engineering-patterns/red-green-tdd/ (consulté le 6 octobre 2026).
- Dan North, « Introducing BDD », *Better Software*, mars 2006 : https://cucumber.io/docs/bdd/history (consulté le 6 octobre 2026).
- `/home/bfontaine/git/master-1-iti-dev/cours/sources/craft.md` (Beck, Mancuso, Martin, Booch ; garde-fou TDD) et `/home/bfontaine/git/master-1-iti-dev/cours/sources/ai-dlc.md` (self-grading, tests d'acceptation indépendants).

**Documentation officielle (état consulté le 6 octobre 2026)**
- Flutter, « An introduction to widget testing » : https://docs.flutter.dev/cookbook/testing/widget/introduction
- Claude Code, « How Claude remembers your project » (CLAUDE.md) : https://code.claude.com/docs/en/memory
- Claude Code, « Configure permissions » (règles `deny`, `Edit`, syntaxe de chemins, bac à sable) : https://code.claude.com/docs/en/permissions
- `bdd_widget_test` : https://pub.dev/packages/bdd_widget_test (version à vérifier ; 2.1.4 résolue par `flutter pub add --dry-run` le 6 octobre 2026).

**Exécution du code de ce chapitre.** Projet de contrôle `fourmi_langton` créé par `flutter create --empty --platforms=web`, Flutter 3.47.6, Dart 3.13.5 ; 20 tests verts pour les étapes 1 à 6 et le scénario BDD, 23 avec les exercices 2, 3 et 4 ; `dart analyze` sans remarque sur le code des étapes ; `flutter build web` réussi.
