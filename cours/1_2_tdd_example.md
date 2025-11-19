# TDD et BDD par l'exemple : Calculatrice simple

## Table des matières

1. [Introduction aux concepts](#1-introduction-aux-concepts)
2. [Partie 1 : TDD avec tests unitaires (Baby Steps)](#2-partie-1--tdd-avec-tests-unitaires-baby-steps)
3. [Partie 2 : BDD avec Gherkin et bdd_widget_test](#3-partie-2--bdd-avec-gherkin-et-bdd_widget_test)
4. [Comparaison TDD vs BDD](#4-comparaison-tdd-vs-bdd)
5. [Pièges courants et bonnes pratiques](#5-pièges-courants-et-bonnes-pratiques)
6. [Conclusion](#6-conclusion)

---

## 1. Introduction aux concepts

### Qu'est-ce que le TDD (Test-Driven Development) ?

Le **TDD** est une pratique de développement où l'on **écrit les tests AVANT le code de production**. Cette approche peut sembler contre-intuitive au début, mais elle offre de nombreux avantages :

**Le cycle Red-Green-Refactor :**

```
🔴 RED    → Écrire un test qui échoue
🟢 GREEN  → Écrire le code minimal pour faire passer le test
🔵 REFACTOR → Améliorer le code sans changer son comportement
```

**Pourquoi TDD ?**
- ✅ **Conception émergente** : les tests guident la conception de l'API
- ✅ **Confiance** : chaque ligne de code est testée
- ✅ **Documentation vivante** : les tests montrent comment utiliser le code
- ✅ **Refactoring sûr** : on peut améliorer le code sans crainte de casser quelque chose
- ✅ **Moins de bugs** : les problèmes sont détectés immédiatement

### Qu'est-ce que le BDD (Behavior-Driven Development) ?

Le **BDD** est une extension du TDD qui se concentre sur le **comportement** du système du point de vue de l'utilisateur. Il utilise un langage naturel (Gherkin) pour décrire les scénarios.

**Structure Gherkin (Given-When-Then) :**

```gherkin
Given [contexte initial]  → État de départ
When [action]             → Ce que fait l'utilisateur
Then [résultat attendu]   → Ce qui devrait se passer
```

**Pourquoi BDD ?**
- ✅ **Langage commun** : compréhensible par tous (PO, dev, testeurs)
- ✅ **Focus sur la valeur** : on teste ce qui compte pour l'utilisateur
- ✅ **Spécifications exécutables** : les scénarios sont à la fois documentation et tests
- ✅ **Collaboration** : facilite les discussions avec les non-techniques

### TDD vs BDD : Quand utiliser quoi ?

| Aspect | TDD (Unit Tests) | BDD (Widget/Integration Tests) |
|--------|------------------|--------------------------------|
| **Niveau** | Unitaire (fonctions, classes) | Comportement (features, UI) |
| **Langage** | Code de programmation | Gherkin (langage naturel) |
| **Audience** | Développeurs | Toute l'équipe |
| **Granularité** | Fine (une fonction) | Large (un scénario utilisateur) |
| **Vitesse** | Très rapide | Plus lent |
| **Quand** | Logique métier, algorithmes | Parcours utilisateur, UI |

**Approche recommandée :** Utiliser les deux ! TDD pour la logique métier, BDD pour les comportements utilisateur.

---

## 2. Partie 1 : TDD avec tests unitaires (Baby Steps)

### Objectif

Nous allons créer une **calculatrice simple** capable d'additionner deux nombres. Nous utiliserons l'approche **Baby Steps** : les plus petits incréments possibles.

### Pourquoi Baby Steps ?

- 🎯 **Focus** : on ne résout qu'un problème à la fois
- 🐛 **Moins de bugs** : moins de code = moins d'erreurs
- 🧠 **Apprentissage** : on comprend mieux chaque étape
- ⚡ **Feedback rapide** : on sait immédiatement si ça marche

### Configuration initiale

**Fichier : `lib/calculator.dart`** (vide pour l'instant)

**Fichier : `test/calculator_test.dart`**

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:master_1_iti_dev/calculator.dart';

void main() {
  group('Calculator', () {
    // Nos tests iront ici
  });
}
```

---

### Étape 1 : Additionner deux nombres positifs

#### 🔴 RED - Test qui échoue

**Pourquoi commencer par ce test ?**
C'est le cas le plus simple : deux nombres positifs. On commence toujours par le cas le plus basique.

```dart
test('devrait additionner deux nombres positifs', () {
  // Arrange (Préparer)
  final calculator = Calculator();

  // Act (Agir)
  final result = calculator.add(2, 3);

  // Assert (Vérifier)
  expect(result, equals(5));
});
```

**Résultat :** ❌ Le test échoue car la classe `Calculator` n'existe pas encore.

```
Error: Undefined name 'Calculator'
```

#### 🟢 GREEN - Code minimal pour passer le test

**Principe :** Écrire le code **le plus simple possible** pour faire passer le test. Pas plus !

```dart
// lib/calculator.dart
class Calculator {
  int add(int a, int b) {
    return 5;  // 🤔 Oui, vraiment ! C'est le minimum pour passer CE test
  }
}
```

**Résultat :** ✅ Le test passe !

**Pourquoi retourner 5 en dur ?**
C'est le code le plus simple qui fait passer le test. Cela peut sembler absurde, mais c'est intentionnel : on force l'écriture d'un nouveau test pour généraliser.

#### 🔵 REFACTOR - Amélioration

Pour l'instant, pas de refactoring nécessaire. Le code est simple et clair.

---

### Étape 2 : Forcer la généralisation

#### 🔴 RED - Nouveau test

**Pourquoi ce test ?**
Pour forcer l'implémentation réelle de l'addition. Un seul test ne suffit jamais !

```dart
test('devrait additionner 5 et 7', () {
  final calculator = Calculator();
  final result = calculator.add(5, 7);
  expect(result, equals(12));
});
```

**Résultat :** ❌ Le test échoue car on retourne toujours 5.

```
Expected: <12>
  Actual: <5>
```

#### 🟢 GREEN - Implémentation réelle

Maintenant, on est **forcé** d'implémenter la vraie logique.

```dart
class Calculator {
  int add(int a, int b) {
    return a + b;  // ✅ Implémentation réelle
  }
}
```

**Résultat :** ✅ Les deux tests passent !

#### 🔵 REFACTOR

Le code est déjà optimal. Pas de refactoring nécessaire.

---

### Étape 3 : Additionner avec zéro

#### 🔴 RED - Test pour le zéro

**Pourquoi ce test ?**
Le zéro est un cas limite important. Il teste l'**élément neutre** de l'addition.

```dart
test('devrait retourner le même nombre quand on additionne zéro', () {
  final calculator = Calculator();
  expect(calculator.add(5, 0), equals(5));
  expect(calculator.add(0, 5), equals(5));
  expect(calculator.add(0, 0), equals(0));
});
```

**Résultat :** ✅ Le test passe immédiatement !

**Pourquoi ?**
Notre implémentation `a + b` gère déjà ce cas. C'est une **validation** : on confirme que notre code fonctionne correctement.

#### 🟢 GREEN

Aucun code à ajouter, le test passe déjà.

#### 🔵 REFACTOR

Pas de refactoring nécessaire.

---

### Étape 4 : Additionner des nombres négatifs

#### 🔴 RED - Test pour les négatifs

**Pourquoi ce test ?**
Les nombres négatifs sont un autre cas limite important.

```dart
test('devrait additionner des nombres négatifs', () {
  final calculator = Calculator();
  expect(calculator.add(-5, -3), equals(-8));
  expect(calculator.add(-5, 3), equals(-2));
  expect(calculator.add(5, -3), equals(2));
});
```

**Résultat :** ✅ Le test passe immédiatement !

Notre implémentation gère déjà les négatifs. Encore une validation.

---

### Étape 5 : Grands nombres

#### 🔴 RED - Test pour les grands nombres

**Pourquoi ce test ?**
Pour vérifier qu'on ne dépasse pas les limites du type `int`.

```dart
test('devrait additionner de grands nombres', () {
  final calculator = Calculator();
  expect(calculator.add(1000000, 2000000), equals(3000000));
});
```

**Résultat :** ✅ Le test passe !

---

### Étape 6 : Refactoring - Extraction de la fixture

#### 🔵 REFACTOR - Éliminer la duplication

**Observation :** On crée un `Calculator()` dans chaque test. C'est de la duplication !

**Avant :**
```dart
test('test 1', () {
  final calculator = Calculator();  // Duplication
  // ...
});

test('test 2', () {
  final calculator = Calculator();  // Duplication
  // ...
});
```

**Après :**
```dart
group('Calculator', () {
  late Calculator calculator;

  setUp(() {
    calculator = Calculator();  // ✅ Créé une fois avant chaque test
  });

  test('devrait additionner deux nombres positifs', () {
    expect(calculator.add(2, 3), equals(5));
  });

  test('devrait additionner 5 et 7', () {
    expect(calculator.add(5, 7), equals(12));
  });

  // ... autres tests
});
```

**Résultat :** ✅ Tous les tests passent toujours, mais le code est plus propre !

---

### Étape 7 : Nombres décimaux (Extension)

#### 🔴 RED - Test pour les décimaux

**Pourquoi ce test ?**
Pour supporter les calculs avec des nombres à virgule. Cela nécessite un changement de type.

```dart
test('devrait additionner des nombres décimaux', () {
  expect(calculator.add(2.5, 3.7), equals(6.2));
  expect(calculator.add(0.1, 0.2), closeTo(0.3, 0.0001)); // Précision flottante
});
```

**Résultat :** ❌ Le test échoue car `add` retourne un `int`, pas un `double`.

```
Error: The argument type 'double' can't be assigned to the parameter type 'int'
```

#### 🟢 GREEN - Modification du type

```dart
class Calculator {
  double add(double a, double b) {  // ✅ Changement de int à double
    return a + b;
  }
}
```

**Résultat :** ✅ Tous les tests passent !

**Note :** En Dart, `double` peut représenter les entiers aussi, donc nos anciens tests fonctionnent toujours.

#### 🔵 REFACTOR

Pas de refactoring nécessaire.

---

### Code final de la Partie 1

**`lib/calculator.dart` :**

```dart
/// Calculatrice simple pour démontrer le TDD
class Calculator {
  /// Additionne deux nombres
  ///
  /// Exemples:
  /// ```dart
  /// calculator.add(2, 3);     // 5
  /// calculator.add(-5, 3);    // -2
  /// calculator.add(2.5, 3.7); // 6.2
  /// ```
  double add(double a, double b) {
    return a + b;
  }
}
```

**`test/calculator_test.dart` :**

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:master_1_iti_dev/calculator.dart';

void main() {
  group('Calculator', () {
    late Calculator calculator;

    setUp(() {
      calculator = Calculator();
    });

    test('devrait additionner deux nombres positifs', () {
      expect(calculator.add(2, 3), equals(5));
    });

    test('devrait additionner 5 et 7', () {
      expect(calculator.add(5, 7), equals(12));
    });

    test('devrait retourner le même nombre quand on additionne zéro', () {
      expect(calculator.add(5, 0), equals(5));
      expect(calculator.add(0, 5), equals(5));
      expect(calculator.add(0, 0), equals(0));
    });

    test('devrait additionner des nombres négatifs', () {
      expect(calculator.add(-5, -3), equals(-8));
      expect(calculator.add(-5, 3), equals(-2));
      expect(calculator.add(5, -3), equals(2));
    });

    test('devrait additionner de grands nombres', () {
      expect(calculator.add(1000000, 2000000), equals(3000000));
    });

    test('devrait additionner des nombres décimaux', () {
      expect(calculator.add(2.5, 3.7), equals(6.2));
      expect(calculator.add(0.1, 0.2), closeTo(0.3, 0.0001));
    });
  });
}
```

### Leçons apprises de la Partie 1

✅ **Le cycle Red-Green-Refactor fonctionne** : chaque étape est petite et maîtrisée

✅ **Baby Steps = Confiance** : on avance lentement mais sûrement

✅ **Les tests guident la conception** : on n'a écrit que le code nécessaire

✅ **Refactoring sécurisé** : les tests nous protègent pendant les changements

✅ **Documentation vivante** : les tests montrent tous les cas d'usage

---

## 3. Partie 2 : BDD avec Gherkin et bdd_widget_test

### Objectif

Maintenant que nous avons la logique métier (la classe `Calculator`), nous allons créer une **interface utilisateur** et la tester avec **BDD**.

Nous allons créer un widget Flutter qui :
- Affiche deux champs de saisie pour les nombres
- Affiche un bouton "Calculer"
- Affiche le résultat de l'addition

### Configuration

**Installation de `bdd_widget_test` :**

```yaml
# pubspec.yaml
dev_dependencies:
  flutter_test:
    sdk: flutter
  bdd_widget_test: ^1.6.1
```

### Architecture

```
lib/
  calculator.dart          # ✅ Déjà créé (logique métier)
  calculator_widget.dart   # 🆕 À créer (UI)

test/
  calculator_test.dart     # ✅ Déjà créé (tests unitaires)
  calculator_widget_test.dart  # 🆕 À créer (tests BDD)

integration_test/
  features/
    calculator.feature     # 🆕 Scénarios Gherkin
  step/
    calculator_steps.dart  # 🆕 Implémentation des steps
```

---

### Étape 1 : Écrire les scénarios Gherkin

#### Pourquoi commencer par Gherkin ?

En BDD, on commence par décrire le **comportement attendu** en langage naturel, AVANT d'écrire le code. C'est l'équivalent du "Red" en TDD.

**Fichier : `integration_test/features/calculator.feature`**

```gherkin
Feature: Calculatrice d'addition
  En tant qu'utilisateur
  Je veux additionner deux nombres
  Afin d'obtenir leur somme

  Scenario: Affichage initial de la calculatrice
    Given l'application est lancée
    Then je vois le titre "Calculatrice"
    And je vois le champ "Premier nombre"
    And je vois le champ "Deuxième nombre"
    And je vois le bouton "Calculer"
    And je ne vois pas de résultat

  Scenario: Addition de deux nombres positifs
    Given l'application est lancée
    When je saisis "5" dans le champ "Premier nombre"
    And je saisis "3" dans le champ "Deuxième nombre"
    And je tape sur le bouton "Calculer"
    Then je vois le résultat "Résultat : 8.0"

  Scenario: Addition avec zéro
    Given l'application est lancée
    When je saisis "10" dans le champ "Premier nombre"
    And je saisis "0" dans le champ "Deuxième nombre"
    And je tape sur le bouton "Calculer"
    Then je vois le résultat "Résultat : 10.0"

  Scenario: Addition de nombres négatifs
    Given l'application est lancée
    When je saisis "-5" dans le champ "Premier nombre"
    And je saisis "3" dans le champ "Deuxième nombre"
    And je tape sur le bouton "Calculer"
    Then je vois le résultat "Résultat : -2.0"

  Scenario: Addition de nombres décimaux
    Given l'application est lancée
    When je saisis "2.5" dans le champ "Premier nombre"
    And je saisis "3.7" dans le champ "Deuxième nombre"
    And je tape sur le bouton "Calculer"
    Then je vois le résultat "Résultat : 6.2"

  Scenario: Champs vides
    Given l'application est lancée
    When je tape sur le bouton "Calculer"
    Then je vois le message d'erreur "Veuillez saisir deux nombres"
```

**Analyse des scénarios :**

1. **Scenario 1** : Vérifie l'affichage initial (structure de l'UI)
2. **Scenario 2-5** : Testent différents cas d'addition (comportement)
3. **Scenario 6** : Teste la gestion d'erreur (robustesse)

---

### Étape 2 : Créer le widget (TDD style)

Même en BDD, on peut utiliser TDD pour créer le widget ! On va d'abord créer un test widget simple.

**Fichier : `test/calculator_widget_test.dart`**

```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:master_1_iti_dev/calculator_widget.dart';

void main() {
  testWidgets('CalculatorWidget affiche les éléments de base', (tester) async {
    // Arrange
    await tester.pumpWidget(
      const MaterialApp(
        home: CalculatorWidget(),
      ),
    );

    // Assert
    expect(find.text('Calculatrice'), findsOneWidget);
    expect(find.byType(TextField), findsNWidgets(2));
    expect(find.text('Calculer'), findsOneWidget);
  });
}
```

**Résultat :** ❌ Le test échoue car `CalculatorWidget` n'existe pas.

---

### Étape 3 : Implémenter le widget

**Fichier : `lib/calculator_widget.dart`**

```dart
import 'package:flutter/material.dart';
import 'calculator.dart';

class CalculatorWidget extends StatefulWidget {
  const CalculatorWidget({Key? key}) : super(key: key);

  @override
  State<CalculatorWidget> createState() => _CalculatorWidgetState();
}

class _CalculatorWidgetState extends State<CalculatorWidget> {
  final _firstNumberController = TextEditingController();
  final _secondNumberController = TextEditingController();
  final _calculator = Calculator();

  String _result = '';
  String _error = '';

  void _calculate() {
    setState(() {
      _error = '';
      _result = '';

      final firstText = _firstNumberController.text.trim();
      final secondText = _secondNumberController.text.trim();

      if (firstText.isEmpty || secondText.isEmpty) {
        _error = 'Veuillez saisir deux nombres';
        return;
      }

      final first = double.tryParse(firstText);
      final second = double.tryParse(secondText);

      if (first == null || second == null) {
        _error = 'Veuillez saisir des nombres valides';
        return;
      }

      final sum = _calculator.add(first, second);
      _result = 'Résultat : $sum';
    });
  }

  @override
  void dispose() {
    _firstNumberController.dispose();
    _secondNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculatrice'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              key: const Key('first_number_field'),
              controller: _firstNumberController,
              decoration: const InputDecoration(
                labelText: 'Premier nombre',
                border: OutlineInputBorder(),
              ),
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
            ),
            const SizedBox(height: 16),
            TextField(
              key: const Key('second_number_field'),
              controller: _secondNumberController,
              decoration: const InputDecoration(
                labelText: 'Deuxième nombre',
                border: OutlineInputBorder(),
              ),
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              key: const Key('calculate_button'),
              onPressed: _calculate,
              child: const Text('Calculer'),
            ),
            const SizedBox(height: 24),
            if (_error.isNotEmpty)
              Text(
                _error,
                key: const Key('error_message'),
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
            if (_result.isNotEmpty)
              Text(
                _result,
                key: const Key('result_text'),
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
          ],
        ),
      ),
    );
  }
}
```

**Résultat :** ✅ Le test widget passe !

---

### Étape 4 : Implémenter les step definitions

Maintenant, nous allons **connecter** les scénarios Gherkin au code Flutter avec `bdd_widget_test`.

**Fichier : `test/calculator_bdd_test.dart`**

```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bdd_widget_test/bdd_widget_test.dart';
import 'package:master_1_iti_dev/calculator_widget.dart';

void main() {
  group('Calculatrice BDD', () {
    bddSetUp((WidgetTester tester) async {
      // Configuration commune à tous les scénarios
    });

    /// Given: l'application est lancée
    Future<void> givenLApplicationEstLancee(WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: CalculatorWidget(),
        ),
      );
      await tester.pumpAndSettle();
    }

    /// When: je saisis {string} dans le champ {string}
    Future<void> whenJeSaisisDansLeChamp(
      WidgetTester tester,
      String valeur,
      String nomChamp,
    ) async {
      final finder = find.widgetWithText(TextField, nomChamp);
      expect(finder, findsOneWidget, reason: 'Le champ "$nomChamp" devrait exister');

      await tester.enterText(finder, valeur);
      await tester.pumpAndSettle();
    }

    /// When: je tape sur le bouton {string}
    Future<void> whenJeTapeSurLeBouton(
      WidgetTester tester,
      String nomBouton,
    ) async {
      final finder = find.widgetWithText(ElevatedButton, nomBouton);
      expect(finder, findsOneWidget, reason: 'Le bouton "$nomBouton" devrait exister');

      await tester.tap(finder);
      await tester.pumpAndSettle();
    }

    /// Then: je vois le titre {string}
    Future<void> thenJeVoisLeTitre(
      WidgetTester tester,
      String titre,
    ) async {
      final finder = find.widgetWithText(AppBar, titre);
      expect(finder, findsOneWidget, reason: 'Le titre "$titre" devrait être visible');
    }

    /// Then: je vois le champ {string}
    Future<void> thenJeVoisLeChamp(
      WidgetTester tester,
      String nomChamp,
    ) async {
      final finder = find.widgetWithText(TextField, nomChamp);
      expect(finder, findsOneWidget, reason: 'Le champ "$nomChamp" devrait être visible');
    }

    /// Then: je vois le bouton {string}
    Future<void> thenJeVoisLeBouton(
      WidgetTester tester,
      String nomBouton,
    ) async {
      final finder = find.widgetWithText(ElevatedButton, nomBouton);
      expect(finder, findsOneWidget, reason: 'Le bouton "$nomBouton" devrait être visible');
    }

    /// Then: je ne vois pas de résultat
    Future<void> thenJeNeVoisPasDeResultat(WidgetTester tester) async {
      final finder = find.byKey(const Key('result_text'));
      expect(finder, findsNothing, reason: 'Aucun résultat ne devrait être affiché');
    }

    /// Then: je vois le résultat {string}
    Future<void> thenJeVoisLeResultat(
      WidgetTester tester,
      String resultat,
    ) async {
      final finder = find.text(resultat);
      expect(finder, findsOneWidget, reason: 'Le résultat "$resultat" devrait être affiché');
    }

    /// Then: je vois le message d'erreur {string}
    Future<void> thenJeVoisLeMessageDErreur(
      WidgetTester tester,
      String message,
    ) async {
      final finder = find.text(message);
      expect(finder, findsOneWidget, reason: 'Le message d\'erreur "$message" devrait être affiché');
    }

    // ========================================
    // SCÉNARIOS BDD
    // ========================================

    bddWidget(
      'Affichage initial de la calculatrice',
      (WidgetTester tester) async {
        await givenLApplicationEstLancee(tester);
        await thenJeVoisLeTitre(tester, 'Calculatrice');
        await thenJeVoisLeChamp(tester, 'Premier nombre');
        await thenJeVoisLeChamp(tester, 'Deuxième nombre');
        await thenJeVoisLeBouton(tester, 'Calculer');
        await thenJeNeVoisPasDeResultat(tester);
      },
    );

    bddWidget(
      'Addition de deux nombres positifs',
      (WidgetTester tester) async {
        await givenLApplicationEstLancee(tester);
        await whenJeSaisisDansLeChamp(tester, '5', 'Premier nombre');
        await whenJeSaisisDansLeChamp(tester, '3', 'Deuxième nombre');
        await whenJeTapeSurLeBouton(tester, 'Calculer');
        await thenJeVoisLeResultat(tester, 'Résultat : 8.0');
      },
    );

    bddWidget(
      'Addition avec zéro',
      (WidgetTester tester) async {
        await givenLApplicationEstLancee(tester);
        await whenJeSaisisDansLeChamp(tester, '10', 'Premier nombre');
        await whenJeSaisisDansLeChamp(tester, '0', 'Deuxième nombre');
        await whenJeTapeSurLeBouton(tester, 'Calculer');
        await thenJeVoisLeResultat(tester, 'Résultat : 10.0');
      },
    );

    bddWidget(
      'Addition de nombres négatifs',
      (WidgetTester tester) async {
        await givenLApplicationEstLancee(tester);
        await whenJeSaisisDansLeChamp(tester, '-5', 'Premier nombre');
        await whenJeSaisisDansLeChamp(tester, '3', 'Deuxième nombre');
        await whenJeTapeSurLeBouton(tester, 'Calculer');
        await thenJeVoisLeResultat(tester, 'Résultat : -2.0');
      },
    );

    bddWidget(
      'Addition de nombres décimaux',
      (WidgetTester tester) async {
        await givenLApplicationEstLancee(tester);
        await whenJeSaisisDansLeChamp(tester, '2.5', 'Premier nombre');
        await whenJeSaisisDansLeChamp(tester, '3.7', 'Deuxième nombre');
        await whenJeTapeSurLeBouton(tester, 'Calculer');
        await thenJeVoisLeResultat(tester, 'Résultat : 6.2');
      },
    );

    bddWidget(
      'Champs vides',
      (WidgetTester tester) async {
        await givenLApplicationEstLancee(tester);
        await whenJeTapeSurLeBouton(tester, 'Calculer');
        await thenJeVoisLeMessageDErreur(tester, 'Veuillez saisir deux nombres');
      },
    );
  });
}
```

**Résultat :** ✅ Tous les scénarios BDD passent !

---

### Étape 5 : Exécuter les tests

**Commande pour les tests unitaires :**
```bash
flutter test test/calculator_test.dart
```

**Sortie attendue :**
```
✓ Calculator devrait additionner deux nombres positifs
✓ Calculator devrait additionner 5 et 7
✓ Calculator devrait retourner le même nombre quand on additionne zéro
✓ Calculator devrait additionner des nombres négatifs
✓ Calculator devrait additionner de grands nombres
✓ Calculator devrait additionner des nombres décimaux

6 tests passed
```

**Commande pour les tests BDD :**
```bash
flutter test test/calculator_bdd_test.dart
```

**Sortie attendue :**
```
✓ Affichage initial de la calculatrice
✓ Addition de deux nombres positifs
✓ Addition avec zéro
✓ Addition de nombres négatifs
✓ Addition de nombres décimaux
✓ Champs vides

6 tests passed
```

---

### Analyse de la structure BDD

#### 1. **Séparation des responsabilités**

```dart
// ✅ Step definitions (réutilisables)
Future<void> whenJeSaisisDansLeChamp(...) async { ... }

// ✅ Scénarios (lisibles)
bddWidget('Addition de deux nombres positifs', (tester) async {
  await givenLApplicationEstLancee(tester);
  await whenJeSaisisDansLeChamp(tester, '5', 'Premier nombre');
  // ...
});
```

**Avantage :** Les steps sont réutilisables dans plusieurs scénarios.

#### 2. **Langage métier**

Les noms des fonctions utilisent le **langage naturel** :
- `givenLApplicationEstLancee` → "Given l'application est lancée"
- `whenJeSaisisDansLeChamp` → "When je saisis dans le champ"
- `thenJeVoisLeResultat` → "Then je vois le résultat"

**Avantage :** Compréhensible par tous, pas seulement les développeurs.

#### 3. **Messages d'erreur explicites**

```dart
expect(finder, findsOneWidget,
  reason: 'Le champ "$nomChamp" devrait exister');
```

**Avantage :** Quand un test échoue, on sait exactement pourquoi.

---

## 4. Comparaison TDD vs BDD

### Pyramide des tests

```
        /\
       /  \
      / UI \  ← BDD (peu nombreux, lents, fragiles)
     /------\
    /        \
   / Intégra-\
  /   tion    \ ← BDD/TDD (moyennement nombreux)
 /------------\
/              \
/   Unitaires  \ ← TDD (très nombreux, rapides, robustes)
/________________\
```

### Quand utiliser TDD (tests unitaires) ?

✅ **Logique métier pure**
- Calculs, algorithmes
- Transformations de données
- Règles métier complexes

✅ **Avantages**
- Très rapide (millisecondes)
- Facile à déboguer
- Couvre tous les cas limites
- Encourage le bon design

**Exemple :** Notre classe `Calculator`

### Quand utiliser BDD (tests de comportement) ?

✅ **Parcours utilisateur**
- Interactions UI
- Flux complets
- Intégration de plusieurs composants

✅ **Avantages**
- Langage commun avec le métier
- Teste la vraie valeur utilisateur
- Documentation vivante
- Détecte les problèmes d'intégration

**Exemple :** Notre `CalculatorWidget`

### Stratégie recommandée

```
1. TDD pour la logique métier (Calculator)
   ↓
2. TDD pour le widget (structure de base)
   ↓
3. BDD pour les scénarios utilisateur (comportement complet)
```

**Ratio recommandé :**
- 70% tests unitaires (TDD)
- 20% tests d'intégration (BDD)
- 10% tests end-to-end (BDD)

---

## 5. Pièges courants et bonnes pratiques

### ❌ Pièges courants en TDD

#### 1. **Écrire trop de code d'un coup**

```dart
// ❌ Mauvais : tout implémenter d'un coup
class Calculator {
  double add(double a, double b) => a + b;
  double subtract(double a, double b) => a - b;
  double multiply(double a, double b) => a * b;
  double divide(double a, double b) => a / b;
}
```

**Problème :** On n'a pas de tests pour `subtract`, `multiply`, `divide`.

**✅ Solution :** Baby steps ! Une fonction à la fois.

#### 2. **Tests qui testent l'implémentation, pas le comportement**

```dart
// ❌ Mauvais : teste l'implémentation interne
test('devrait appeler la méthode _calculate', () {
  verify(calculator._calculate()).called(1);
});

// ✅ Bon : teste le comportement observable
test('devrait retourner 8 quand on additionne 5 et 3', () {
  expect(calculator.add(5, 3), equals(8));
});
```

#### 3. **Tests dépendants les uns des autres**

```dart
// ❌ Mauvais : les tests partagent un état
late int result;

test('test 1', () {
  result = calculator.add(2, 3);
});

test('test 2', () {
  expect(result, equals(5)); // Dépend du test 1 !
});
```

**✅ Solution :** Chaque test doit être indépendant (utiliser `setUp`).

---

### ❌ Pièges courants en BDD

#### 1. **Scénarios trop techniques**

```gherkin
# ❌ Mauvais : trop technique
Scenario: Appeler l'API REST
  Given le endpoint "/api/calculate" est disponible
  When je POST {"a": 5, "b": 3}
  Then je reçois un status 200
```

```gherkin
# ✅ Bon : langage métier
Scenario: Calculer une addition
  Given je suis sur la calculatrice
  When je saisis 5 et 3
  Then je vois le résultat 8
```

#### 2. **Trop de détails dans les scénarios**

```gherkin
# ❌ Mauvais : trop de détails UI
Scenario: Addition
  Given je clique sur le premier TextField
  And je tape "5"
  And je clique sur le deuxième TextField
  And je tape "3"
  And je clique sur le bouton bleu en bas
```

```gherkin
# ✅ Bon : focus sur l'intention
Scenario: Addition
  When je saisis 5 et 3
  And je calcule
  Then je vois 8
```

#### 3. **Steps non réutilisables**

```dart
// ❌ Mauvais : step trop spécifique
Future<void> whenJeSaisis5DansLePremierChamp(tester) async { ... }

// ✅ Bon : step paramétré et réutilisable
Future<void> whenJeSaisisDansLeChamp(tester, String valeur, String champ) async { ... }
```

---

### ✅ Bonnes pratiques

#### 1. **Nommer les tests clairement**

```dart
// ❌ Mauvais
test('test 1', () { ... });

// ✅ Bon
test('devrait retourner 8 quand on additionne 5 et 3', () { ... });
```

#### 2. **Suivre le pattern AAA (Arrange-Act-Assert)**

```dart
test('devrait additionner deux nombres', () {
  // Arrange (Préparer)
  final calculator = Calculator();

  // Act (Agir)
  final result = calculator.add(2, 3);

  // Assert (Vérifier)
  expect(result, equals(5));
});
```

#### 3. **Un seul concept par test**

```dart
// ❌ Mauvais : teste plusieurs choses
test('devrait gérer tous les cas', () {
  expect(calculator.add(2, 3), equals(5));
  expect(calculator.add(-5, 3), equals(-2));
  expect(calculator.add(0, 0), equals(0));
});

// ✅ Bon : un test par cas
test('devrait additionner des positifs', () {
  expect(calculator.add(2, 3), equals(5));
});

test('devrait additionner des négatifs', () {
  expect(calculator.add(-5, 3), equals(-2));
});
```

#### 4. **Tester les cas limites**

```dart
test('devrait gérer les cas limites', () {
  expect(calculator.add(0, 0), equals(0));           // Zéro
  expect(calculator.add(-5, 5), equals(0));          // Opposés
  expect(calculator.add(double.maxFinite, 1), ...);  // Overflow
});
```

#### 5. **Refactorer régulièrement**

Après chaque test qui passe, se demander :
- Y a-t-il de la duplication ?
- Le code est-il lisible ?
- Les noms sont-ils explicites ?
- Peut-on simplifier ?

---

## 6. Conclusion

### Ce que nous avons appris

#### 1. **TDD (Test-Driven Development)**

✅ **Le cycle Red-Green-Refactor fonctionne vraiment**
- 🔴 **Red** : Écrire un test qui échoue force à réfléchir au comportement attendu
- 🟢 **Green** : Écrire le code minimal force à rester simple
- 🔵 **Refactor** : Améliorer le code en toute sécurité grâce aux tests

✅ **Baby Steps = Confiance**
- Chaque étape est petite et maîtrisée
- On avance lentement mais sûrement
- Moins de bugs, plus de qualité

✅ **Les tests guident la conception**
- On n'écrit que le code nécessaire
- L'API émerge naturellement
- Le design est meilleur car testé dès le départ

#### 2. **BDD (Behavior-Driven Development)**

✅ **Langage commun**
- Les scénarios Gherkin sont compréhensibles par tous
- Facilite la collaboration entre PO, dev, et testeurs
- Réduit les malentendus

✅ **Focus sur la valeur utilisateur**
- On teste ce qui compte vraiment
- Les scénarios décrivent le "pourquoi", pas le "comment"
- Documentation vivante du comportement

✅ **Complémentarité avec TDD**
- TDD pour la logique métier (rapide, précis)
- BDD pour les parcours utilisateur (complet, réaliste)
- Ensemble, ils couvrent tous les aspects

### Bénéfices concrets

#### Pour le développeur

1. **Confiance** : Je peux refactorer sans crainte
2. **Productivité** : Moins de temps en débogage
3. **Qualité** : Moins de bugs en production
4. **Design** : Code mieux structuré
5. **Documentation** : Les tests expliquent le code

#### Pour l'équipe

1. **Collaboration** : Langage commun avec le métier
2. **Rapidité** : Détection précoce des problèmes
3. **Maintenabilité** : Code plus facile à faire évoluer
4. **Onboarding** : Les nouveaux comprennent vite grâce aux tests
5. **Confiance** : Déploiements plus sereins

#### Pour le projet

1. **Moins de bugs** : Détection immédiate des régressions
2. **Coût réduit** : Corriger un bug tôt coûte moins cher
3. **Flexibilité** : Facile d'ajouter des fonctionnalités
4. **Qualité** : Code professionnel et maintenable
5. **Satisfaction** : Utilisateurs et développeurs contents

### Progression recommandée pour apprendre

#### Semaine 1-2 : Bases du TDD
1. Comprendre le cycle Red-Green-Refactor
2. Pratiquer avec des katas simples (FizzBuzz, StringCalculator)
3. S'habituer à écrire les tests en premier
4. Apprendre à faire des baby steps

#### Semaine 3-4 : TDD avancé
1. Refactoring avec confiance
2. Tester les cas limites
3. Utiliser les mocks et stubs
4. Organiser les tests (AAA, fixtures)

#### Semaine 5-6 : Introduction au BDD
1. Écrire des scénarios Gherkin
2. Implémenter des step definitions
3. Tester des widgets Flutter
4. Comprendre la différence TDD/BDD

#### Semaine 7-8 : BDD avancé
1. Scénarios complexes
2. Steps réutilisables
3. Tests d'intégration
4. Stratégie de test complète

### Ressources pour aller plus loin

#### Livres

📚 **"Test Driven Development: By Example"** - Kent Beck (2002)
- Le livre fondateur du TDD
- Exemples pas-à-pas
- Philosophie et pratique

📚 **"Growing Object-Oriented Software, Guided by Tests"** - Steve Freeman & Nat Pryce (2009)
- TDD appliqué à des systèmes réels
- Outside-in TDD
- Mocks et tests d'intégration

📚 **"The BDD Books - Discovery"** - Gaspar Nagy & Seb Rose (2021)
- BDD moderne
- Example Mapping
- Collaboration efficace

#### Pratique

🥋 **Coding Dojos et Katas**
- [Cyber-Dojo](https://cyber-dojo.org) : Katas en ligne
- [Codewars](https://codewars.com) : Défis de code
- [Exercism](https://exercism.org) : Exercices avec mentoring

🎮 **Jeux de code**
- [TDD Manifesto Game](https://tddmanifesto.com/exercises/)
- [Gilded Rose Kata](https://github.com/emilybache/GildedRose-Refactoring-Kata)
- [Tennis Refactoring Kata](https://github.com/emilybache/Tennis-Refactoring-Kata)

#### Communautés

👥 **Meetups et conférences**
- Software Craftsmanship meetups
- Coding Dojos locaux
- Conférences Agile

💬 **En ligne**
- [r/tdd](https://reddit.com/r/tdd) sur Reddit
- Stack Overflow (tag: tdd, bdd)
- Discord/Slack de développeurs

### Exercices pratiques suggérés

#### Exercice 1 : FizzBuzz (TDD pur)

**Objectif :** Implémenter FizzBuzz en TDD strict

**Règles :**
- Retourner "Fizz" pour les multiples de 3
- Retourner "Buzz" pour les multiples de 5
- Retourner "FizzBuzz" pour les multiples de 3 et 5
- Retourner le nombre sinon

**Contrainte :** Baby steps ! Un test à la fois.

#### Exercice 2 : String Calculator (TDD)

**Objectif :** Créer une calculatrice de chaînes

**Règles :**
- `add("")` retourne 0
- `add("1")` retourne 1
- `add("1,2")` retourne 3
- `add("1\n2,3")` retourne 6
- Gérer les délimiteurs personnalisés

**Contrainte :** Suivre strictement Red-Green-Refactor

#### Exercice 3 : Todo List (BDD)

**Objectif :** Créer une application Todo avec BDD

**Scénarios :**
- Ajouter une tâche
- Marquer une tâche comme terminée
- Supprimer une tâche
- Filtrer les tâches (toutes, actives, terminées)

**Contrainte :** Écrire les scénarios Gherkin d'abord

#### Exercice 4 : Calculatrice complète (TDD + BDD)

**Objectif :** Étendre notre calculatrice

**Nouvelles fonctionnalités :**
- Soustraction, multiplication, division
- Historique des calculs
- Gestion des erreurs (division par zéro)

**Contrainte :** TDD pour la logique, BDD pour l'UI

### Métriques de succès

Comment savoir si vous maîtrisez TDD/BDD ?

#### Vous maîtrisez TDD quand :

✅ Vous écrivez naturellement les tests en premier
✅ Vous faites des baby steps sans y penser
✅ Vous refactorez régulièrement avec confiance
✅ Vos tests sont rapides (< 1 seconde pour 100 tests)
✅ Vous avez > 80% de couverture de code
✅ Vous pouvez expliquer chaque test

#### Vous maîtrisez BDD quand :

✅ Vous écrivez des scénarios compréhensibles par tous
✅ Vos steps sont réutilisables
✅ Vous pensez "comportement" avant "implémentation"
✅ Vous collaborez efficacement avec le PO
✅ Vos scénarios servent de documentation
✅ Vous savez quand utiliser BDD vs TDD

### Derniers conseils

#### 1. **Pratiquez régulièrement**
Le TDD/BDD est une compétence qui s'acquiert par la pratique. Faites des katas régulièrement.

#### 2. **Soyez patient**
Au début, TDD/BDD semble ralentir le développement. C'est normal ! Avec la pratique, vous deviendrez plus rapide.

#### 3. **Ne sautez pas les tests**
Même sous pression, ne cédez pas à la tentation de sauter les tests. C'est un investissement qui paie toujours.

#### 4. **Refactorez sans crainte**
Les tests sont votre filet de sécurité. Utilisez-les pour améliorer continuellement votre code.

#### 5. **Partagez vos connaissances**
Enseignez TDD/BDD à vos collègues. Enseigner est la meilleure façon d'apprendre.

#### 6. **Adaptez à votre contexte**
TDD/BDD sont des outils, pas des dogmes. Adaptez-les à votre situation.

---

## Récapitulatif final

### TDD en 3 étapes

```
1. 🔴 RED    → Écrire un test qui échoue
2. 🟢 GREEN  → Écrire le code minimal qui passe
3. 🔵 REFACTOR → Améliorer sans changer le comportement
```

### BDD en 3 questions

```
1. Given → Quel est le contexte ?
2. When  → Que fait l'utilisateur ?
3. Then  → Quel est le résultat attendu ?
```

### La règle d'or

> **"Never write production code without a failing test first."**
> — Kent Beck

### Le secret du succès

**Baby Steps + Discipline + Pratique = Maîtrise**

---

**Félicitations !** 🎉

Vous avez maintenant les bases solides pour pratiquer TDD et BDD. N'oubliez pas : la théorie est importante, mais c'est la **pratique** qui fait la différence.

Commencez petit, soyez patient, et pratiquez régulièrement. Bientôt, écrire les tests en premier deviendra une seconde nature.

**Bon courage dans votre voyage vers l'excellence technique !** 🚀

---

**"The only way to go fast, is to go well."**
— Robert C. Martin
