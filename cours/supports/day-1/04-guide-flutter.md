# Chapitre 4 · Guide Flutter pour non-développeurs

*Support de la séance 1 « Comprendre et s'équiper », Master ITI, Nantes Université, 2026-2027. État des outils vérifié le 6 octobre 2026.*

## Ce que vous allez retenir

- **Flutter** est un cadre de développement (en anglais *framework*) de Google qui permet d'écrire une seule application et de la faire tourner sur mobile, web et ordinateur ; **Dart** est le langage dans lequel on l'écrit. Dans ce cours, nous l'exécuterons dans le navigateur Chrome, ce qui évite toute installation lourde.
- L'installation tient en quatre gestes : Git, VS Code avec l'extension Flutter, le SDK Flutter, puis la commande `flutter doctor` qui contrôle le tout. Pour le cours, **seul Chrome doit être au vert** ; Android et le bureau sont facultatifs.
- Pour **lire** du Dart, il suffit de repérer six briques : variable, type, fonction, condition, boucle, classe. Deux particularités à connaître : la **null safety** (le langage vous protège des valeurs « vides ») et `async` (attendre un résultat sans bloquer l'écran).
- Une application Flutter est un **arbre de widgets** : tout est un widget, et l'on construit un écran en emboîtant des petits widgets, comme des poupées russes.
- Un widget **sans état** (`StatelessWidget`) affiche ; un widget **avec état** (`StatefulWidget`) se souvient de quelque chose et se redessine quand cela change (`setState`). Pour les applications réelles, le projet utilise **BLoC/Cubit**, qui sort l'état de l'écran pour le rendre testable.
- Il existe trois niveaux de tests : **unitaire**, **de widget**, **d'intégration**. Les deux premiers se lancent avec `flutter test` et sont la base du TDD vu en séance.
- Un projet est rangé de façon prévisible : `pubspec.yaml` (la carte d'identité et la liste des dépendances), `lib/` (le code), `test/` (les tests). Savoir où regarder suffit pour s'y repérer et pour relire le travail d'un agent.
- Les messages d'erreur ont l'air hostiles mais suivent une structure constante : **le type d'erreur, le fichier et la ligne, puis souvent la solution proposée**. On apprend à les lire du haut vers le bas, et à les copier tels quels vers l'agent.

> **Ce chapitre ne vise pas à faire de vous un développeur.** Il vise à vous donner assez de repères pour comprendre ce que l'agent produit, poser les bonnes questions et vérifier que cela fonctionne. Tous les extraits de code ont été exécutés (ou, quand c'est précisé, relus avec soin), avec Flutter 3.47.6 et Dart 3.13.5, versions stables au 6 octobre 2026.

---

## 1. Qu'est-ce que Flutter, et pourquoi ce choix pour le cours ?

### 1.1 Flutter et Dart en deux phrases

D'après la documentation officielle, Flutter est le cadre open source de Google pour créer des applications compilées nativement pour le mobile (iOS, Android), le web, le bureau (macOS, Windows, Linux) et les appareils embarqués, à partir d'un code unique. Il est écrit en Dart, le langage conçu par Google pour les applications clientes ([FAQ Flutter](https://docs.flutter.dev/resources/faq), [Dart overview](https://dart.dev/overview)).

Définissons trois termes qui reviendront sans cesse :

- **Langage de programmation** : un ensemble de mots et de règles qui permet de décrire à l'ordinateur ce qu'il doit faire. Dart est le langage ; c'est l'équivalent de la « langue » dans laquelle on rédige.
- **Cadre de développement (framework)** : une boîte à outils prête à l'emploi, avec des composants déjà construits (boutons, listes, animations). Flutter est le cadre ; c'est l'équivalent d'un atelier équipé plutôt que d'un atelier vide.
- **SDK (Software Development Kit)** : le paquet à télécharger qui contient le cadre, le langage et les outils en ligne de commande. Installer « Flutter », c'est installer le SDK Flutter, qui embarque aussi Dart.

### 1.2 Un code, plusieurs plateformes

Le problème que Flutter résout est économique avant d'être technique. Sans lui, publier la même application sur le web, sur Android et sur iPhone demande en général trois bases de code, trois compétences et trois cycles de tests. Avec Flutter, une équipe maintient une seule base de code.

Le mécanisme qui rend cela possible est un choix d'architecture documenté : Flutter ne s'appuie pas sur les composants d'interface fournis par le navigateur ou par le système, il dessine lui-même chaque pixel avec son propre moteur de rendu (Impeller, selon la FAQ). Selon la FAQ, cette approche évite les contraintes de performance et les différences de comportement des composants natifs, et donne des performances et une apparence homogènes d'une plateforme à l'autre ([FAQ Flutter](https://docs.flutter.dev/resources/faq)). Analogie : au lieu de commander des meubles dans trois magasins aux styles différents, vous fabriquez vous-même les meubles dans un seul atelier et vous les livrez partout.

La contrepartie existe aussi. Une application qui dessine tout elle-même peut se sentir un peu moins « native » qu'une application écrite avec les outils du système, et les pages web Flutter ne se comportent pas comme des pages web classiques (par exemple, le référencement par les moteurs de recherche n'est pas leur point fort). Ce dernier point est un **consensus de praticiens**, non vérifié ici sur une source officielle : on ne choisit pas Flutter pour un site vitrine, mais pour une application.

### 1.3 Pourquoi Dart ?

L'équipe Flutter avance, dans sa FAQ, plusieurs raisons à ce choix : une productivité de développement (compilation « juste à temps » en développement, qui permet le rechargement à chaud, puis compilation anticipée en production pour du code machine efficace), un langage orienté objet adapté à la construction d'interfaces sans langage de balisage séparé, une performance prévisible et une allocation mémoire rapide ([FAQ Flutter](https://docs.flutter.dev/resources/faq)).

Deux termes à définir :

- **Rechargement à chaud (hot reload)** : vous modifiez le code, vous enregistrez, et l'application affichée à l'écran se met à jour en une fraction de seconde, **sans perdre son état** (le compteur à 7 reste à 7). Dart annonce un rechargement « sub-second » ([Dart overview](https://dart.dev/overview)).
- **Compilation** : la traduction du code lisible par un humain en instructions que la machine exécute. Pour le web, Dart peut produire du JavaScript ou du WebAssembly ([Dart overview](https://dart.dev/overview)).

Un peu d'histoire, utile pour situer la maturité de l'outil : Dart a été dévoilé en octobre 2011 à la conférence GOTO d'Aarhus ([InfoQ, 2011](https://www.infoq.com/news/2011/10/google-dart-language/)) ; Flutter a été présenté en version alpha à Google I/O en mai 2017 ([Wikipédia, Flutter](https://en.wikipedia.org/wiki/Flutter_(software)), source secondaire) ; la version 1.0 est sortie le 4 décembre 2018, lors de Flutter Live à Londres ([InfoQ](https://www.infoq.com/news/2018/12/flutter-1.0-released) ; le [blog officiel](https://flutter.dev/blog/flutter-1-0-launch-wrap-up) confirme décembre 2018). Flutter a donc près de huit ans d'existence publique.

### 1.4 Pourquoi Flutter dans ce cours ?

Ce sont des choix pédagogiques de l'enseignant, pas des vérités universelles :

1. **Un seul poste suffit.** Chrome est installé presque partout. La documentation indique que le développement web « ne demande aucune configuration supplémentaire en dehors d'un navigateur approprié » (traduction de « requires no additional setup besides an appropriate browser », [installation personnalisée](https://docs.flutter.dev/install/custom)). Pas besoin d'émulateur Android ni d'un Mac pour iPhone.
2. **Le résultat se voit.** On modifie, on enregistre, la page change : la boucle de retour est immédiate, ce qui convient à un travail en binôme avec un agent.
3. **Un langage fortement typé** : le compilateur et l'analyseur détectent beaucoup d'erreurs avant même l'exécution. C'est un filet de sécurité précieux quand le code est écrit par un agent (nous y reviendrons).
4. **Un écosystème de test intégré** : le paquet de test fait partie du SDK, ce qui rend le TDD accessible dès le premier jour.
5. **Un projet fil rouge** : chaque équipe publie en version web une application Flutter ; l'architecture suit les principes de la *Clean Architecture* (code rangé en couches), avec les paquets `flutter_bloc`, `get_it` et `drift` (diapositive « Le projet : Flutter »).

> **À retenir.** Flutter est le cadre, Dart est le langage, le SDK est le paquet qui contient les deux. On choisit Flutter ici pour trois raisons concrètes : un code pour plusieurs plateformes, une exécution possible dans Chrome, un cycle modification-résultat très court.

---

## 2. Installer et vérifier son poste

### 2.1 Ce dont vous avez besoin

D'après le guide de démarrage rapide ([docs.flutter.dev/install/quick](https://docs.flutter.dev/install/quick)), il faut :

1. **Git** : outil de gestion de versions, vu en séance 2 (macOS : `xcode-select --install` ; Linux : via les paquets système du point 3 ci-dessous ; Windows : le programme d'installation de Git for Windows).
2. **Visual Studio Code** (VS Code), l'éditeur de texte du cours.
3. Sous Linux uniquement, quelques paquets système (`curl git unzip xz-utils zip libglu1-mesa`, selon le guide officiel).
4. **Google Chrome**, qui servira à afficher l'application.

### 2.2 Installation par VS Code (méthode recommandée par la documentation)

Le guide officiel décrit une installation pilotée depuis l'éditeur :

1. Lancez VS Code et installez l'extension **Flutter** (éditeur « Dart-Code », [page de l'extension](https://marketplace.visualstudio.com/items?itemName=Dart-Code.flutter)). Elle installe aussi l'extension Dart.
2. Ouvrez la palette de commandes (`Ctrl+Maj+P`, ou `Cmd+Maj+P` sur Mac), tapez `flutter` et choisissez **Flutter: New Project**.
3. Lorsque l'éditeur propose de télécharger le SDK, cliquez **Download SDK**, choisissez un dossier, puis **Clone Flutter**, puis **Add SDK to PATH**.
4. **Fermez et rouvrez tous les terminaux ainsi que VS Code.** Cette étape est la plus souvent oubliée : sans elle, la commande `flutter` reste « introuvable » parce que le terminal ouvert ne connaît pas encore le nouveau chemin.

Le **PATH** (chemin de recherche) est la liste des dossiers où votre ordinateur cherche les programmes quand vous tapez une commande. « Ajouter le SDK au PATH », c'est lui donner l'adresse de Flutter pour que `flutter` fonctionne depuis n'importe quel dossier.

Une alternative, pour qui préfère le manuel : télécharger le SDK depuis la page [docs.flutter.dev/install](https://docs.flutter.dev/install) puis l'ajouter au PATH ([guide d'ajout au PATH](https://docs.flutter.dev/install/add-to-path)). Les deux chemins donnent le même résultat.

### 2.3 La commande de contrôle : `flutter doctor`

Dans un terminal (c'est le même que celui de VS Code, menu *Terminal > Nouveau terminal*), tapez :

```bash
flutter doctor
```

Cette commande inspecte votre poste et affiche une liste de contrôles. Voici ce que donne un poste en bon état, sur la machine utilisée pour rédiger ce chapitre (Linux, le 6 octobre 2026) :

```text
[✓] Flutter (Channel stable, 3.47.6, on Ubuntu 24.04.5 LTS, locale fr_FR.UTF-8)
[✓] Android toolchain - develop for Android devices (Android SDK version 36.1.0)
[✓] Chrome - develop for the web
[✓] Linux toolchain - develop for Linux desktop
[✓] Connected device (2 available)
[✓] Network resources

• No issues found!
```

Comment lire cette sortie : une coche verte `[✓]` signifie « prêt », un point d'exclamation `[!]` signifie « fonctionne mais avec un avertissement », une croix rouge `[✗]` signifie « manquant ».

**Pour ce cours, une seule ligne est indispensable : `Chrome - develop for the web`.** La chaîne Android peut rester en rouge, de même que Visual Studio (Windows) ou Xcode (macOS) : ces éléments ne servent que pour compiler des applications natives, que nous ne ferons pas. Ne perdez pas une heure à les corriger (programme détaillé, bloc 6).

Si Chrome est installé mais non détecté, la variable d'environnement `CHROME_EXECUTABLE` permet d'indiquer son emplacement. Ce point est courant dans la communauté mais **non revérifié** sur la documentation lors de la rédaction.

### 2.4 Lancer une première application dans Chrome

Créez un projet de démonstration depuis le terminal (c'est la méthode utilisée pour ce chapitre) :

```bash
flutter create --platforms=web demo
cd demo
flutter run -d chrome
```

Détaillons :

- `flutter create` génère un projet complet. L'option `--platforms=web` limite la génération au web (sans elle, Flutter prépare aussi Android, iOS et le bureau).
- `cd demo` change de dossier (*change directory*) pour entrer dans le projet.
- `flutter run -d chrome` compile l'application et l'ouvre dans Chrome. L'option `-d` désigne le **device** (appareil) cible ; `chrome` est son identifiant. Vous pouvez lister les appareils disponibles avec `flutter devices`. Sur la machine de rédaction, la liste contient `Chrome (web) • chrome • web-javascript • Google Chrome 154`.

L'application d'exemple est un compteur : un bouton « + » augmente un nombre. Dans le terminal où l'application tourne, la touche `r` déclenche un rechargement à chaud, `R` un redémarrage complet, `q` quitte (touches indiquées par l'outil lui-même au lancement ; **non revérifiées** ici en session interactive).

L'autre méthode, entièrement dans VS Code, est décrite dans le guide officiel : palette de commandes, **Flutter: Select Device**, choix de **Chrome**, puis menu *Run > Start Debugging* (touche `F5`) ([guide de démarrage rapide](https://docs.flutter.dev/install/quick)).

> **À retenir.** Le test d'installation de la séance : `flutter doctor` (Chrome au vert), `flutter test` (les tests passent), `flutter run -d chrome` (l'application s'affiche). Si une de ces trois commandes échoue, notez le message d'erreur exact et demandez de l'aide à votre binôme ou à l'agent (voir section 11).

---

## 3. Le strict minimum de Dart pour lire du code

Cette section reprend les « six notions » de la diapositive, avec un peu plus de détail. Tous les exemples ont été exécutés avec `dart run` (Dart 3.13.5) ; la sortie est donnée à la fin. L'univers est celui de la démonstration de la séance : un jeu de rôle, où l'on réussit une action si le total (jet de dé plus bonus) atteint ou dépasse un **degré de difficulté** (dd).

### 3.1 Variables et types

Une **variable** est une valeur à laquelle on donne un nom. Le **type** dit de quelle sorte de valeur il s'agit : nombre entier (`int`), texte (`String`), vrai ou faux (`bool`), etc.

```dart
const dd = 12;        // constante : connue d'avance, ne change jamais
final jet = 11;       // final : affectée une fois, ne change plus ensuite
var bonus = 3;        // var : peut être modifiée
bonus = bonus + 1;    // le signe = signifie « range cette valeur dans ce nom »
```

Trois mots à distinguer : `const` (la valeur est connue avant même d'exécuter le programme), `final` (la valeur est fixée à l'exécution puis ne bouge plus) et `var` (variable modifiable). En pratique, on préfère `final` partout où c'est possible : moins de valeurs qui changent, moins de surprises. Dart devine le type tout seul (`var bonus = 3` est un `int`), ce qui s'appelle l'**inférence de type**. Le texte après `//` est un **commentaire**, ignoré par l'ordinateur.

Pour insérer une valeur dans un texte, on utilise `$` : `'Quête : $quete'` ou, pour une expression, `${total(jet, bonus)}`.

### 3.2 Fonctions

Une **fonction** est une recette réutilisable : on lui donne des ingrédients (les **paramètres**), elle rend un résultat (`return`).

```dart
int total(int jet, int bonus) {
  return jet + bonus;
}

bool estReussite(int total, int dd) => total >= dd;
```

La deuxième fonction utilise la **notation fléchée** (`=>`), un raccourci quand la fonction tient en une expression. Le mot avant le nom de la fonction (`int`, `bool`) indique le type du résultat. Les accolades `{ }` délimitent ce qui appartient à la fonction. Un appel s'écrit `total(11, 4)` et donne `15`.

### 3.3 Conditions et boucles

```dart
print(estReussite(total(jet, bonus), dd) ? 'Réussite' : 'Échec');

final quetes = <String>['Taverne', 'Donjon'];
quetes.add('Marché');
for (final quete in quetes) {
  print('Quête : $quete');
}
```

La **condition** est un choix. L'écriture `condition ? a : b` signifie « si la condition est vraie, a, sinon b » (on trouve aussi l'écriture `if (...) { ... } else { ... }`). La **boucle** `for` répète une action pour chaque élément d'une collection.

### 3.4 Collections : listes et dictionnaires

Une **liste** (`List`) est une suite ordonnée de valeurs : `<String>['Taverne', 'Donjon']` est une liste de textes. Un **dictionnaire** (`Map`, « table associative ») associe une clé à une valeur :

```dart
final surnoms = {'Aldric': 'le Sage'};   // clé 'Aldric', valeur 'le Sage'
final surnom = surnoms['Brenna'];        // clé absente : le résultat est « rien » (null)
```

Analogie : la liste est une file d'attente numérotée ; le dictionnaire est un annuaire où l'on cherche par nom.

### 3.5 Classes et objets

Une **classe** est un moule qui regroupe des données et les actions qui s'y rapportent. Un **objet** est un exemplaire fabriqué avec ce moule.

```dart
class Personnage {
  Personnage(this.nom, this.pointsDeVie);

  final String nom;
  int pointsDeVie;

  void subirDegats(int degats) {
    pointsDeVie = pointsDeVie - degats;
  }
}

final heros = Personnage('Aldric', 10)..subirDegats(3);
print('${heros.nom} : ${heros.pointsDeVie} PV');   // Aldric : 7 PV
```

La classe `Personnage` a deux **propriétés** (`nom`, `pointsDeVie`) et une **méthode** (`subirDegats`, une fonction attachée à la classe). La première ligne, `Personnage(this.nom, this.pointsDeVie);`, est le **constructeur** : la fonction qui fabrique l'objet. L'écriture `..` (cascade) enchaîne un appel sur l'objet qui vient d'être créé. Tout ce qui est dans Flutter est bâti avec des classes : un écran est une classe, un bouton est un objet de la classe `ElevatedButton`.

### 3.6 Null safety : se protéger du « rien »

Le **null** est la valeur « absence de valeur ». Dans beaucoup de langages, utiliser un null par erreur fait planter le programme en cours d'exécution, parfois chez le client. Dart pratique la **null safety** : par défaut, un type n'accepte **jamais** null. Pour l'autoriser, on ajoute un point d'interrogation au type : `String?` signifie « un texte, ou rien » ([dart.dev/null-safety](https://dart.dev/null-safety)). La documentation précise que Dart applique la null safety « saine » (*sound*) depuis Dart 3, sorti en mai 2023.

Quand une valeur peut être nulle, le compilateur **oblige** à traiter le cas :

```dart
String? trouverSurnom(Map<String, String> surnoms, String nom) {
  return surnoms[nom];
}

final surnom = trouverSurnom(surnoms, 'Brenna');
print(surnom ?? 'aucun surnom');   // ?? : « ou, à défaut, ceci »  -> aucun surnom
print(surnom?.length);             // ?. : « seulement si ce n'est pas null » -> null
```

Si l'on oublie le cas, l'analyseur le signale avant toute exécution. Voici le message réel pour `print(surnom.length);` :

```text
error - f.dart:4:11 - The property 'length' can't be unconditionally accessed because the receiver can be 'null'. Try making the access conditional (using '?.') or adding a null check to the target ('!'). - unchecked_use_of_nullable_value
```

Le message dit exactement quoi faire : utiliser `?.` ou ajouter une vérification. Un dernier opérateur à reconnaître : `!` (« je vous garantis que ce n'est pas null »). Il désactive la protection : si vous le voyez dans le code d'un agent, c'est un endroit où il faut se demander « et si c'était vraiment null ? ».

### 3.7 Asynchrone : attendre sans bloquer

Certaines opérations prennent du temps : interroger un serveur, lire un fichier. Pendant l'attente, l'écran ne doit pas se figer. Dart utilise pour cela `Future` (une promesse de résultat à venir) et les mots `async` et `await` :

```dart
Future<String> chargerQuete() async {
  await Future<void>.delayed(const Duration(milliseconds: 10));
  return 'Sauver le village';
}

// dans une fonction marquée async :
print(await chargerQuete());   // Sauver le village
```

Analogie : vous commandez un café, on vous remet un buzzer (le `Future`) ; `await` signifie « je m'assieds jusqu'à ce que le buzzer sonne », mais le café, lui, n'empêche pas les autres clients d'être servis. Retenez simplement : quand vous voyez `Future`, `async` ou `await`, quelque chose prend du temps, et c'est normal.

### 3.8 Une écriture moderne : les *records*

Depuis Dart 3, on peut regrouper plusieurs valeurs entre parenthèses, ce qu'on appelle un **record** : `(12, 12, true)`. La démonstration de TDD l'emploie pour lister des cas de test, et on peut les « déballer » : `final (a, b) = (12, 12);`.

### 3.9 Résultat de l'exécution

Le programme complet, exécuté avec `dart run`, affiche :

```text
Total : 15
Réussite
Quête : Taverne
Quête : Donjon
Quête : Marché
aucun surnom
null
Aldric : 7 PV
Sauver le village
true
```

> **À retenir.** Pour lire du Dart : repérez les variables (`final`, `var`), les fonctions (un type, un nom, des parenthèses), les classes (`class`), les `?` (valeur possiblement vide), les `async/await` (attente). Le reste est du détail. Et quand vous ne comprenez pas une ligne, demandez à l'agent de l'expliquer **puis** vérifiez par un test.

---

## 4. L'arbre de widgets : tout est un widget

### 4.1 L'idée centrale

Dans Flutter, **tout ce que vous voyez est un widget** : un texte, un bouton, une marge, une colonne, voire l'application entière. Un widget est une description d'une partie de l'interface (« ici, un texte en gras »). On construit un écran en emboîtant des widgets les uns dans les autres : chacun a un **parent** et peut avoir des **enfants**. L'ensemble forme un **arbre de widgets**.

Analogie : une poupée russe, ou l'organigramme d'une entreprise. La racine, c'est l'application ; en dessous, un écran ; dans l'écran, une colonne ; dans la colonne, trois éléments, etc.

```text
MaterialApp
 └─ Scaffold
     ├─ AppBar
     │   └─ Text('Compteur')
     ├─ Center
     │   └─ Column
     │       ├─ Text('Vous avez appuyé :')
     │       ├─ Text('0')
     │       └─ ElevatedButton
     └─ FloatingActionButton
```

Cet arbre est celui de l'exemple de la section 5, dans sa version complète avec le bouton « Voir le détail » (section 8). L'outil **Flutter Inspector** (dans les DevTools, ouvert depuis le panneau Flutter de VS Code, [guide de démarrage rapide](https://docs.flutter.dev/install/quick)) affiche cet arbre pour l'application en cours : c'est très utile pour comprendre un écran qu'on n'a pas écrit.

### 4.2 Les widgets de base à connaître

| Widget | Rôle | Analogie |
|---|---|---|
| `Text` | Afficher du texte | Une étiquette |
| `Icon` | Afficher un pictogramme | Un symbole |
| `ElevatedButton` | Un bouton cliquable | Un interrupteur |
| `Scaffold` | Le squelette d'une page (barre du haut, corps, bouton flottant) | Le gabarit d'un document |
| `AppBar` | La barre de titre | L'en-tête |
| `Center` | Centrer son enfant | Un cadre au milieu du mur |
| `Padding`, `SizedBox` | Marges, espaces de taille fixe | Les blancs entre les lignes |
| `Container` | Boîte avec marge, couleur, bordure, taille | Une boîte de rangement |
| `Row`, `Column` | Aligner des enfants horizontalement, verticalement | Une rangée, une colonne de tableur |
| `ListView` | Une liste qui défile | Un rouleau |

Les composants de style « Material » (`Scaffold`, `AppBar`, `ElevatedButton`) proviennent de la bibliothèque `package:flutter/material.dart`, d'où l'import en tête de fichier. Le catalogue complet des widgets est sur [docs.flutter.dev/ui/widgets](https://docs.flutter.dev/ui/widgets).

### 4.3 La composition plutôt que l'héritage

Un widget ne se personnalise pas en le « déformant », mais en l'**enveloppant** dans d'autres widgets : pour mettre une marge autour d'un texte, on place le `Text` dans un `Padding`. Pour réutiliser un morceau d'interface, on crée **son propre widget**, qui assemble d'autres widgets. C'est ce qu'on fait dans la section 6 avec `CarteQuete`.

Chaque widget possède une méthode `build`, qui dit **comment il se dessine** à partir d'autres widgets. Flutter appelle `build` quand il a besoin de (re)dessiner. C'est la seule méthode que vous aurez presque toujours à lire.

---

## 5. StatelessWidget et StatefulWidget

### 5.1 Sans état : l'affichage pur

Un **`StatelessWidget`** (« widget sans état ») dépend uniquement de ce qu'on lui donne à sa création. Si ces données ne changent pas, il s'affiche toujours pareil. Exemple : un titre, une icône, une page de détail.

```dart
class PageDetail extends StatelessWidget {
  const PageDetail({super.key, required this.valeur});

  final int valeur;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Détail')),
      body: Center(child: Text('Valeur : $valeur')),
    );
  }
}
```

Lecture ligne à ligne :

- `class PageDetail extends StatelessWidget` : « une `PageDetail` est une sorte de widget sans état ».
- `const PageDetail({super.key, required this.valeur})` : le constructeur ; `required` signifie que la valeur est obligatoire.
- `final int valeur;` : la donnée reçue, qui ne changera pas.
- `@override` : « je redéfinis une méthode héritée » ; ici `build`.
- `BuildContext context` : l'**emplacement du widget dans l'arbre** ; il permet, par exemple, d'accéder au thème ou de naviguer.

### 5.2 Avec état : un widget qui se souvient

Un **état** est une donnée qui peut changer pendant la vie de l'écran (un compteur, un champ de saisie, une liste chargée). Un **`StatefulWidget`** (« widget avec état ») sépare deux classes : le widget (immuable) et son objet `State` (qui conserve les données). Quand l'état change, on le signale à Flutter par `setState`, qui redessine l'écran.

Voici le compteur, tel que l'application de démonstration le contient :

```dart
class PageCompteur extends StatefulWidget {
  const PageCompteur({super.key});

  @override
  State<PageCompteur> createState() => _PageCompteurState();
}

class _PageCompteurState extends State<PageCompteur> {
  int _compteur = 0;

  void _incrementer() {
    setState(() {
      _compteur++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Compteur')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Vous avez appuyé :'),
            Text('$_compteur',
                style: Theme.of(context).textTheme.headlineMedium),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementer,
        tooltip: 'Incrémenter',
        child: const Icon(Icons.add),
      ),
    );
  }
}
```

Ce code est une version abrégée de celui qui a été exécuté et testé (le bouton « Voir le détail » en est retiré ici, voir section 8). Le point essentiel :

1. L'état est la variable `_compteur`. Le caractère `_` en tête signifie « privé à ce fichier ».
2. Un clic sur le bouton appelle `_incrementer`.
3. `setState(() { _compteur++; })` modifie la valeur **et** prévient Flutter.
4. Flutter rappelle `build`, qui redessine l'écran avec la nouvelle valeur.

Si l'on modifie `_compteur` **sans** `setState`, la variable change mais l'écran reste figé : c'est l'erreur de débutant la plus classique.

C'est exactement ce que l'application « compteur » générée par `flutter create` met en pratique, et c'est un exemple de **programmation déclarative** : on décrit l'écran *en fonction de l'état*, et on laisse Flutter le redessiner quand l'état change, au lieu de modifier l'écran à la main.

> **À retenir.** Sans état : l'écran dépend seulement de ses paramètres. Avec état : l'écran dépend de données qui évoluent, et `setState` dit à Flutter de se redessiner. Question à se poser en relisant un widget : « où est l'état, et qui le modifie ? »

---

## 6. Mettre en page : Row, Column, Container et les contraintes

### 6.1 Les trois outils de base

- **`Column`** empile ses enfants verticalement.
- **`Row`** les aligne horizontalement.
- **`Container`** est une boîte multi-usage : marge intérieure (`padding`), couleur ou bordure (`decoration`), taille.

Exemple, une carte de quête qui combine les trois (relue par exécution : le code compile et passe l'analyse) :

```dart
class CarteQuete extends StatelessWidget {
  const CarteQuete({super.key, required this.titre, required this.recompense});

  final String titre;
  final int recompense;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.amber.shade100,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          const Icon(Icons.flag),
          const SizedBox(width: 8),
          Expanded(child: Text(titre)),
          Text('$recompense po'),
        ],
      ),
    );
  }
}
```

Les propriétés `mainAxisAlignment` et `crossAxisAlignment` règlent l'alignement : l'**axe principal** est celui dans lequel le widget empile (vertical pour `Column`, horizontal pour `Row`), l'**axe transversal** est l'autre.

### 6.2 La règle qui explique presque tout

La documentation formule la règle de mise en page de Flutter en une phrase : **« Constraints go down. Sizes go up. Parent sets position. »** (les contraintes descendent, les tailles remontent, le parent fixe la position, [Understanding constraints](https://docs.flutter.dev/ui/layout/constraints)). Traduction pour un non-développeur :

1. Le parent dit à chaque enfant : « voici l'espace maximal que je t'accorde » (la contrainte).
2. L'enfant choisit sa taille dans cette limite et la communique au parent.
3. Le parent décide où le placer.

Analogie : un propriétaire (le parent) montre un emplacement à un locataire (l'enfant) et lui dit « tu peux occuper jusqu'à 10 m sur 5 m » ; le locataire répond « il me faut 6 m sur 3 m » ; le propriétaire décide à quel endroit de l'immeuble il l'installe.

### 6.3 Deux erreurs de mise en page que vous rencontrerez

**Débordement (overflow).** Un `Row` contient un texte plus long que la place disponible. Flutter affiche une bande jaune et noire à l'écran et ce message (reproduit en exécutant le cas ; le nombre de pixels dépend de la longueur du texte) :

```text
A RenderFlex overflowed by 1224 pixels on the right.
The relevant error-causing widget was:
  Row
...
Consider applying a flex factor (e.g. using an Expanded widget) to force the children of the RenderFlex to fit within the available space.
```

Le message dit la direction du dépassement (« on the right »), le widget fautif (`Row`) et la solution (envelopper le texte dans un `Expanded`, comme dans `CarteQuete` ci-dessus).

**Hauteur non bornée (unbounded height).** Une liste défilante (`ListView`) placée directement dans une `Column`. Message obtenu :

```text
Vertical viewport was given unbounded height.
Viewports expand in the scrolling direction to fill their container. ...
The relevant error-causing widget was:
  ListView
```

La `Column` accorde un espace infini en hauteur, et le `ListView` essaie de le remplir. Solution : donner une limite, typiquement en enveloppant la liste dans un `Expanded` ([Understanding constraints](https://docs.flutter.dev/ui/layout/constraints)).

> **À retenir.** Quand un écran « ne ressemble pas à ce qu'on attend », la cause est presque toujours dans les contraintes. Question à poser à l'agent : « quelles contraintes ce widget reçoit-il de son parent ? ». Et l'outil à ouvrir : Flutter Inspector.

---

## 7. L'état et sa gestion

### 7.1 Pourquoi `setState` ne suffit pas

`setState` convient pour un **état éphémère** : une donnée qui n'intéresse qu'un seul widget (un onglet sélectionné, un champ en cours de saisie). Dès qu'une donnée doit être partagée entre plusieurs écrans (le panier d'achats, l'utilisateur connecté), ou dès que la logique devient complexe (appeler un serveur, gérer les erreurs, les chargements), mélanger tout cela dans le widget produit un code difficile à tester et à faire évoluer. On appelle cela l'**état d'application**, et on cherche à le **séparer de l'affichage**.

La documentation officielle distingue ces deux familles d'état (état éphémère et état d'application) dans sa section « State management » ([Ephemeral vs app state](https://docs.flutter.dev/data-and-backend/state-mgmt/ephemeral-vs-app)). Son guide d'architecture recommande de séparer l'application en une **couche d'interface** (vues et « vues-modèles ») et une **couche de données** (dépôts et services), avec une couche « domaine » optionnelle ; il ne recommande **aucun paquet de gestion d'état particulier** ([guide d'architecture](https://docs.flutter.dev/app-architecture/guide)). (Les outils de base `ChangeNotifier` et `ListenableBuilder` sont souvent cités ; **non revérifié** sur la documentation.)

Il existe donc de nombreuses solutions (Provider, Riverpod, BLoC, etc.). **Le choix de BLoC dans le cours est une décision de projet**, pas une prescription de Flutter.

### 7.2 BLoC et Cubit : un aperçu

**BLoC** (*Business Logic Component*) est un patron de conception porté par le paquet `bloc` et son complément Flutter `flutter_bloc` ([bloclibrary.dev](https://bloclibrary.dev/)). L'idée : l'écran ne contient **aucune logique** ; il envoie des demandes à un objet « gestionnaire d'état » qui, en retour, publie de nouveaux états ; l'écran se contente de se redessiner à chaque nouvel état.

Deux variantes existent :

- **Cubit** : la plus simple. On expose des **fonctions** (`incrementer()`) qui publient un nouvel état avec `emit`. La documentation la définit comme « une classe qui étend `BlocBase` et peut gérer n'importe quel type d'état ».
- **Bloc** : on envoie des **événements** nommés, ce qui trace *ce qui a provoqué chaque changement* et permet des traitements avancés (anti-rebond, etc.). La documentation conseille de **commencer par un Cubit** et de passer à Bloc lorsqu'on a besoin de cette traçabilité ([Bloc concepts](https://bloclibrary.dev/bloc-concepts/)).

Analogie : l'écran est un client au guichet ; le Cubit est le guichetier qui détient le dossier. Le client demande « ajouter un » ; le guichetier met à jour le dossier et affiche le nouveau numéro sur un panneau ; le client regarde le panneau.

**Le compteur en version Cubit.** On ajoute la dépendance (`flutter pub add flutter_bloc`, version la plus récente au 6 octobre 2026 : 9.1.1, publiée en mai 2025, selon [pub.dev](https://pub.dev/packages/flutter_bloc)), puis :

```dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CompteurCubit extends Cubit<int> {
  CompteurCubit() : super(0);

  void incrementer() => emit(state + 1);
}

class PageCompteurBloc extends StatelessWidget {
  const PageCompteurBloc({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CompteurCubit(),
      child: Scaffold(
        body: Center(
          child: BlocBuilder<CompteurCubit, int>(
            builder: (context, valeur) => Text('$valeur'),
          ),
        ),
        floatingActionButton: Builder(
          builder: (context) => FloatingActionButton(
            onPressed: () => context.read<CompteurCubit>().incrementer(),
            child: const Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}
```

Le Cubit lui-même (`CompteurCubit`) reprend l'exemple de la documentation `bloc` (la méthode s'y appelle `increment`, ici `incrementer`). Lecture :

- `Cubit<int>` : un gestionnaire dont **l'état est un entier** ; `super(0)` fixe l'état initial.
- `emit(state + 1)` : publie un nouvel état ; `state` est l'état actuel.
- `BlocProvider` : **met le Cubit à disposition** de tous les widgets en dessous, dans l'arbre.
- `BlocBuilder` : **écoute** le Cubit et redessine son contenu à chaque nouvel état.
- `context.read<CompteurCubit>()` : va chercher le Cubit pour lui demander une action.

Dans un vrai projet, l'état est rarement un simple entier : c'est une petite classe qui décrit tous les cas d'un écran (chargement, succès avec les données, erreur avec son message). L'intérêt est que **cette logique se teste sans afficher quoi que ce soit** (section 9).

### 7.3 Lien avec l'architecture du projet

Le projet fil rouge suit les principes de la **Clean Architecture** : le code est rangé en trois couches (diapositive « Le projet : Flutter »).

- **domain** : les règles du métier (par exemple « un jet réussit si total ≥ dd »), sans aucune dépendance à Flutter.
- **data** : l'accès aux données (base `drift`, réseau).
- **presentation** : les écrans et leurs Cubits.

Chaque fonctionnalité a son dossier. Ainsi, on peut changer l'affichage sans toucher aux règles, et tester les règles sans lancer d'interface. Le paquet `get_it` sert à l'**injection de dépendances** : chaque pièce reçoit ce dont elle a besoin au lieu de le fabriquer elle-même. Le squelette précis fourni par l'enseignant fait foi ; les noms de dossiers ci-dessus sont ceux des diapositives.

> **À retenir.** `setState` pour un état local et simple. Cubit (paquet `flutter_bloc`) pour un état qui compte : la logique sort de l'écran et devient testable. Le choix de BLoC est un choix de projet, pas une obligation de Flutter.

---

## 8. Naviguer entre plusieurs écrans

### 8.1 L'approche de base : `Navigator`

Flutter gère les écrans comme une **pile** : on empile un nouvel écran avec `push`, on retire l'écran du dessus avec `pop` (ce que fait la flèche de retour). Voici le bouton de la page compteur qui ouvre la page de détail et lui transmet la valeur :

```dart
ElevatedButton(
  onPressed: () {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) => PageDetail(valeur: _compteur),
      ),
    );
  },
  child: const Text('Voir le détail'),
),
```

La documentation montre cette forme (`Navigator` avec `MaterialPageRoute`) et la propose, avec `go_router`, à la place des routes nommées ([docs.flutter.dev/ui/navigation](https://docs.flutter.dev/ui/navigation)). Ce code a été exécuté dans un test (section 9.3).

### 8.2 Les routes nommées et `go_router`

La documentation indique : « We don't recommend using named routes for most applications » (nous ne recommandons pas les routes nommées pour la plupart des applications), notamment parce que leur comportement n'est pas personnalisable et qu'elles ne gèrent pas les boutons « précédent » et « suivant » du navigateur. Elle oriente vers `go_router` (ou un autre paquet de routage), dont la description officielle est « un routeur déclaratif [...] prenant en charge les liens profonds », où l'on navigue par `context.go('/second')` ([navigation](https://docs.flutter.dev/ui/navigation)).

Un **lien profond** est une adresse qui ouvre directement un écran précis de l'application (`/commande/42`). Pour une application web c'est essentiel : on veut pouvoir copier l'adresse dans le navigateur. `go_router` est à la version 18.0.2 au 6 octobre 2026 ([pub.dev](https://pub.dev/packages/go_router)). **Le code `go_router` n'a pas été exécuté pour ce chapitre** ; consultez la documentation du paquet avant de l'utiliser, car son API évolue de version majeure en version majeure.

---

## 9. Tester une application Flutter

La séance 1 a montré qu'**un test est une spécification exécutable** : il dit ce que le code doit faire, et la machine le vérifie en quelques secondes. La documentation de Flutter distingue trois niveaux ([testing overview](https://docs.flutter.dev/testing/overview)) :

| Niveau | Ce qu'il teste | Vitesse | Exemple |
|---|---|---|---|
| **Unitaire** | Une fonction, une méthode ou une classe, isolée | Très rapide | `estReussite(12, 12)` est vrai |
| **De widget** | Un widget : son apparence et ses interactions, dans un environnement de test | Rapide | Après un clic sur « + », l'écran affiche « 1 » |
| **D'intégration** | Une application entière ou une grande partie, souvent sur un appareil réel ou un émulateur | Lent | Parcours complet : connexion, achat, confirmation |

La documentation recommande de disposer de nombreux tests unitaires et de widget, et de suffisamment de tests d'intégration pour couvrir les cas d'usage importants. On les lance avec `flutter test`.

### 9.1 Test unitaire

Le fichier `test/notions_test.dart` reprend la démonstration de la séance, avec une liste de cas sous forme de records :

```dart
import 'package:demo/notions.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('estReussite', () {
    const cas = [
      (12, 12, true),
      (11, 12, false),
      (20, 12, true),
    ];
    for (final (total, dd, attendu) in cas) {
      test('total $total contre dd $dd donne $attendu', () {
        expect(estReussite(total, dd), attendu);
      });
    }
  });
}
```

Lecture : `void main()` est le point d'entrée ; `group` regroupe des tests ; `test('nom', () { ... })` définit un test ; `expect(réel, attendu)` compare ce que le code a rendu et ce qu'on attendait. La première ligne importe la fonction à tester depuis `lib/notions.dart` ; `demo` est le nom du projet (celui de `pubspec.yaml`). Le résultat de l'exécution est « All tests passed! ».

### 9.2 Test de widget

```dart
testWidgets('le compteur passe de 0 à 1', (tester) async {
  await tester.pumpWidget(const MonApp());
  expect(find.text('0'), findsOneWidget);

  await tester.tap(find.byIcon(Icons.add));
  await tester.pump();

  expect(find.text('1'), findsOneWidget);
});
```

`testWidgets` crée un environnement de test sans écran réel. `tester.pumpWidget` affiche l'application ; `find.text('0')` cherche un widget affichant « 0 » ; `tester.tap` simule un clic ; `tester.pump()` demande à Flutter de redessiner une fois (l'équivalent du passage de `setState`). Le fichier doit importer `package:flutter/material.dart` et `package:flutter_test/flutter_test.dart`. C'est exactement le test qu'un agent produit pour vérifier un écran, et il est lisible comme un scénario.

### 9.3 Tests de navigation et de Cubit

Le test de navigation suit le même schéma, avec `pumpAndSettle()` qui attend la fin de l'animation de transition :

```dart
testWidgets('la navigation affiche la page détail', (tester) async {
  await tester.pumpWidget(const MonApp());
  await tester.tap(find.text('Voir le détail'));
  await tester.pumpAndSettle();
  expect(find.text('Valeur : 0'), findsOneWidget);
});
```

La logique d'un Cubit se teste **sans widget**, grâce au paquet `bloc_test` (ajouté en dépendance de développement par `flutter pub add dev:bloc_test` ; version 10.0.0 sur pub.dev) :

```dart
blocTest<CompteurCubit, int>(
  'incrementer émet 1',
  build: CompteurCubit.new,
  act: (cubit) => cubit.incrementer(),
  expect: () => [1],
);
```

Lecture : on construit le Cubit (`build`), on agit (`act`), et l'on vérifie la **liste des états publiés** (`expect`). Les quatre exemples de cette section (avec le test de la version Cubit de l'écran) ont tous été exécutés : 7 tests, tous verts.

### 9.4 Lire le résultat d'un test

Quand un test échoue, `flutter test` affiche trois choses : le **nom du test**, ce qui était **attendu** (`Expected`) et ce qui a été **obtenu** (`Actual`), comme dans la diapositive de la démonstration (`Expected: false`, `Actual: <true>`). Un test qui échoue pour une bonne raison est une information précieuse : il montre ce que le code ne fait pas encore.

> **À retenir.** Unitaire pour la logique, widget pour l'écran, intégration pour le parcours complet. Un agent qui écrit à la fois le code et ses propres tests ne prouve pas grand-chose : c'est à l'humain d'écrire ou au moins de relire les tests, qui disent ce qu'on attend.

---

## 10. Structure d'un projet et commandes essentielles

### 10.1 Les fichiers et dossiers à connaître

Voici la structure du projet de démonstration, après ajout de nos fichiers :

```text
demo/
├── pubspec.yaml            la carte d'identité du projet et ses dépendances
├── pubspec.lock            les versions exactes retenues (généré)
├── analysis_options.yaml   les règles de style vérifiées par l'analyseur
├── lib/                    le code de l'application
│   ├── main.dart           le point d'entrée : la fonction main()
│   ├── compteur_cubit.dart
│   ├── mise_en_page.dart
│   └── notions.dart
├── test/                   les tests
│   ├── notions_test.dart
│   └── widgets_test.dart
└── web/                    les fichiers propres à la version web
```

Le dossier `build/` (créé lors des compilations) contient les résultats et n'est pas à modifier.

**`pubspec.yaml`** est le fichier le plus important après le code. Voici un exemple typique, abrégé (le projet de démonstration a aussi `cupertino_icons` et range `bloc_test` dans `dependencies` ; ici, `bloc_test` est placé en `dev_dependencies`, comme le fait `flutter pub add dev:bloc_test`) :

```yaml
name: demo
description: "A new Flutter project."
publish_to: 'none'
version: 1.0.0+1

environment:
  sdk: ^3.13.5

dependencies:
  flutter:
    sdk: flutter
  flutter_bloc: ^9.1.1

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^6.0.0
  bloc_test: ^10.0.0
```

Il décrit le nom, la version, la version minimale de Dart (`sdk: ^3.13.5`, c'est-à-dire « 3.13.5 ou une version compatible plus récente ») et les **dépendances** : des paquets écrits par d'autres, publiés sur le dépôt [pub.dev](https://pub.dev). Les `dependencies` servent à l'application ; les `dev_dependencies` ne servent qu'au développement et aux tests. Le signe `^` autorise les mises à jour compatibles. **Attention : en YAML, l'indentation compte**, deux espaces de décalage font partie de la syntaxe, ce qui explique bien des erreurs.

**`lib/main.dart`** contient la fonction `main`, point d'entrée de toute application, qui démarre l'arbre de widgets :

```dart
void main() {
  runApp(const MonApp());
}
```

### 10.2 Organisation d'un projet « à la Clean Architecture »

Pour le projet fil rouge, le dossier `lib/` n'est pas à plat ; on y trouve en général un dossier par fonctionnalité, subdivisé en couches :

```text
lib/
└── features/
    └── quetes/
        ├── domain/          règles et modèles du métier
        ├── data/            accès aux données (base, réseau)
        └── presentation/    écrans et Cubits
```

Ceci est une **illustration** fondée sur les trois couches annoncées dans la diapositive du projet ; l'arborescence exacte dépend du squelette fourni par l'enseignant. Un nom de dossier n'a rien de magique : ce qui compte, c'est que chaque pièce soit à un endroit prévisible.

### 10.3 Les commandes à connaître

| Commande | Ce qu'elle fait |
|---|---|
| `flutter doctor` | Contrôle l'installation |
| `flutter devices` | Liste les appareils cibles (Chrome, etc.) |
| `flutter create nom` | Crée un nouveau projet |
| `flutter pub get` | Télécharge les dépendances déclarées dans `pubspec.yaml` |
| `flutter pub add paquet` | Ajoute une dépendance au projet (`dev:paquet` pour le développement) |
| `flutter run -d chrome` | Lance l'application dans Chrome |
| `flutter analyze` | Analyse statique : détecte erreurs et écarts de style sans exécuter |
| `flutter test` | Lance tous les tests du dossier `test/` |
| `dart format .` | Reformate le code selon le style officiel |
| `flutter build web` | Produit la version web destinée à la publication |
| `flutter upgrade` | Met à jour le SDK ([guide](https://docs.flutter.dev/install/upgrade)) |

L'**analyse statique** (`flutter analyze`) lit le code sans l'exécuter et signale les problèmes, selon les règles de `analysis_options.yaml`. C'est le même mécanisme que celui du « lint » de la diapositive sur l'intégration continue. Lors de la rédaction de ce chapitre, elle a signalé huit informations `avoid_print` dans le fichier d'exemples (usage de `print` dans du code de production) : ce sont des conseils de style, pas des erreurs, et l'on peut les ignorer pour un exemple pédagogique.

Les commandes d'une même séquence se combinent naturellement : `flutter analyze && flutter test` lance l'analyse puis, si elle réussit, les tests. Les agents de code travaillent beaucoup ainsi : ils modifient, lancent ces commandes, lisent la sortie et corrigent.

> **À retenir.** Trois fichiers ou dossiers pour s'orienter : `pubspec.yaml` (quoi ?), `lib/` (le code), `test/` (ce qui est attendu). Trois commandes pour vérifier : `flutter analyze`, `flutter test`, `flutter run -d chrome`.

---

## 11. Erreurs fréquentes et comment les lire

### 11.1 La méthode de lecture

Un message d'erreur est un texte structuré. On le lit toujours dans cet ordre :

1. **La première ligne** : le type et le résumé du problème (`Undefined name`, `A RenderFlex overflowed`).
2. **Le fichier et la position** : `fichier.dart:4:9` signifie « fichier, ligne 4, colonne 9 ».
3. **Le conseil** : souvent, une phrase commençant par « Try... » (« Essayez de... ») propose la correction.
4. **La pile d'appels** (*stack trace*) : la longue liste `#0 #1 #2...` qui montre le chemin parcouru. Chez un débutant, **on l'ignore** : tout ce qu'il y a d'utile est généralement dans les premières lignes et dans le nom du widget fautif.

Il faut distinguer deux grandes familles. Les **erreurs de compilation ou d'analyse** sont signalées *avant* d'exécuter, par l'éditeur (soulignement rouge) ou par `flutter analyze` : le programme ne démarre pas. Les **erreurs d'exécution** surviennent pendant que l'application tourne ; en Flutter, elles s'affichent dans la console, et dans l'application un écran rouge ou une bande jaune et noire.

### 11.2 Catalogue d'erreurs réelles

Les messages ci-dessous ont été produits en exécutant `dart analyze` sur un fichier d'essai (Dart 3.13.5) ; ils sont donnés tels quels, en anglais.

| Message (extrait) | Traduction et cause | Remède |
|---|---|---|
| `A value of type 'Null' can't be assigned to a variable of type 'String'` | On a rangé « rien » dans un texte qui n'en accepte pas (`String nom = null;`) | Autoriser null (`String?`) ou donner une vraie valeur |
| `A value of type 'String' can't be assigned to a variable of type 'int'` | Mauvais type : un texte au lieu d'un nombre (`int age = 'dix';`) | Corriger le type ou la valeur |
| `Undefined name 'nomm'` | Nom inconnu : faute de frappe ou oubli de déclaration | Corriger l'orthographe, ou ajouter la déclaration ou l'`import` |
| `The final variable 'x' can only be set once` | On modifie une variable `final` | Passer en `var`, ou créer une nouvelle variable |
| `The property 'length' can't be unconditionally accessed because the receiver can be 'null'` | Le texte peut être vide et on l'utilise sans précaution | Utiliser `?.` ou `??`, ou tester d'abord |

D'autres cas fréquents, non reproduits ici mais classiques dans la communauté (**non revérifiés** un par un) :

- **`command not found: flutter`** : le SDK n'est pas dans le PATH, ou le terminal n'a pas été relancé après l'installation (section 2.2).
- **`Target of URI doesn't exist` ou `Undefined class`** : un `import` manquant, ou une dépendance absente du `pubspec.yaml` (lancer `flutter pub get`).
- **Un écran qui ne se met pas à jour** : une valeur modifiée sans `setState` (section 5.2) ou un Cubit qui émet deux fois **le même objet** (un état doit être une nouvelle valeur).
- **Une erreur dans `pubspec.yaml`** : presque toujours une indentation incorrecte.

Pour les deux erreurs d'exécution de mise en page, voir la section 6.3.

### 11.3 Travailler avec un agent

La règle d'or : **collez le message en entier, avec le contexte**, plutôt que de le résumer. Un bon message à l'agent contient la commande lancée, la sortie complète (au moins les 20 premières lignes), et ce que vous attendiez. Le conseil du bloc « installation » du cours est identique : en cas d'échec, notez le message exact pour le tableau de suivi.

Enfin, méfiez-vous de la tentation de « tout faire taire » : si un agent corrige une erreur en supprimant un test, en mettant `!` partout ou en désactivant une règle d'analyse, il a fait disparaître le symptôme, pas le problème. C'est un point de vigilance que vous aurez à tenir pour toutes les séances.

> **À retenir.** Lire dans l'ordre : type d'erreur, fichier et ligne, conseil. Ignorer la pile d'appels. Copier le message **complet** vers l'agent. Les messages de Dart sont souvent assez précis pour contenir la solution.

---

## Glossaire du chapitre

- **Analyse statique (lint)** : lecture du code sans l'exécuter pour y détecter erreurs et écarts de style (`flutter analyze`).
- **Async / await / Future** : mécanisme pour attendre un résultat qui prend du temps (serveur, fichier) sans figer l'application.
- **BLoC** : patron qui sépare la logique de l'écran ; l'écran envoie des demandes, le gestionnaire publie des états.
- **BuildContext** : l'emplacement d'un widget dans l'arbre, utilisé pour accéder au thème, naviguer, retrouver un Cubit.
- **Classe / objet** : moule regroupant données et actions / exemplaire fabriqué avec ce moule.
- **Cubit** : la variante simple de BLoC : des fonctions qui publient un nouvel état (`emit`).
- **Dart** : le langage de programmation de Flutter.
- **Dépendance** : paquet externe dont le projet a besoin, déclaré dans `pubspec.yaml`.
- **Device (appareil)** : la cible d'exécution (`chrome`, `linux`, etc.).
- **Flutter** : cadre de développement de Google pour applications multiplateformes.
- **Fonction / méthode** : recette réutilisable / fonction attachée à une classe.
- **Hot reload (rechargement à chaud)** : mise à jour instantanée de l'application en cours, sans perdre son état.
- **Injection de dépendances** : fournir à chaque pièce ce dont elle a besoin au lieu de la laisser le fabriquer (paquet `get_it`).
- **Null / null safety** : absence de valeur / garantie du langage qui interdit d'utiliser une valeur nulle sans le prévoir (`String?`).
- **PATH** : liste des dossiers où le système cherche les commandes.
- **pubspec.yaml** : fichier de description et de dépendances d'un projet Dart ou Flutter.
- **Record** : groupe de valeurs entre parenthèses (`(12, 12, true)`).
- **SDK** : paquet contenant le cadre, le langage et les outils.
- **setState** : instruction qui signale à Flutter qu'un état a changé et qu'il faut redessiner.
- **StatefulWidget / StatelessWidget** : widget avec / sans état.
- **Test unitaire, de widget, d'intégration** : test d'une fonction, d'un widget, d'un parcours complet.
- **Widget** : brique d'interface ; tout est un widget dans Flutter.
- **Arbre de widgets** : l'emboîtement des widgets, du parent à ses enfants.

---

## Pour aller plus loin

- **Parcours d'apprentissage officiel de Flutter** : [docs.flutter.dev/learn/pathway](https://docs.flutter.dev/learn/pathway). Le meilleur point de départ pour continuer.
- **Visite guidée de Dart** : [dart.dev/language](https://dart.dev/language), et l'essai en ligne sans installation sur [dartpad.dev](https://dartpad.dev).
- **Catalogue de widgets** : [docs.flutter.dev/ui/widgets](https://docs.flutter.dev/ui/widgets).
- **Contraintes et mise en page** : [docs.flutter.dev/ui/layout/constraints](https://docs.flutter.dev/ui/layout/constraints).
- **Architecture d'application** : [docs.flutter.dev/app-architecture](https://docs.flutter.dev/app-architecture/guide).
- **Bibliothèque BLoC** : [bloclibrary.dev](https://bloclibrary.dev/).
- **Tests** : [docs.flutter.dev/testing/overview](https://docs.flutter.dev/testing/overview).
- Le dojo du formateur sur le jeu de la fourmi de Langton, avec Flutter, BDD et Clean Architecture : <https://github.com/b-fontaine/flutter_dojo_langton_ant>.
- Chapitres voisins du support : mise en pratique du craft avec Flutter (chapitre 5), outils agentiques (chapitre 6), CI/CD (chapitre 8).

---

## Points non vérifiés

- Le référencement par les moteurs de recherche des pages web Flutter (section 1.2) : consensus de praticiens, pas de source officielle consultée.
- La variable `CHROME_EXECUTABLE` (section 2.3) et les touches `r`, `R`, `q` du terminal (section 2.4) : non revérifiées en session interactive.
- L'installation automatique de l'extension Dart avec l'extension Flutter (section 2.2) : non revérifiée sur la page de l'extension.
- Le rôle de `ChangeNotifier` et `ListenableBuilder` comme outils de base (section 7.1) : non revérifié sur la documentation.
- Le lancement de Flutter dans Chrome n'a pas été rejoué dans un navigateur pour ce chapitre ; seuls l'analyse, les tests et `flutter devices` ont été exécutés.
- Le code `go_router` (section 8.2) n'a pas été exécuté.
- Les erreurs « classiques » listées à la fin de la section 11.2 ne sont pas reproduites une par une.
- L'alpha de Flutter à Google I/O en mai 2017 repose sur une source secondaire (Wikipédia).
- Le renvoi au chapitre 6 (outils agentiques) suppose que ce chapitre sera publié ; le fichier n'existait pas encore lors de la relecture.
- Les versions de paquets et d'outils (Flutter 3.47.6, Dart 3.13.5, `flutter_bloc` 9.1.1, `bloc_test` 10.0.0, `go_router` 18.0.2) sont celles du 6 octobre 2026 et évoluent vite.

---

## Sources

Documentation officielle, consultée le 6 octobre 2026 :

- Installation : <https://docs.flutter.dev/install> ; démarrage rapide : <https://docs.flutter.dev/install/quick> ; installation personnalisée : <https://docs.flutter.dev/install/custom> ; PATH : <https://docs.flutter.dev/install/add-to-path> ; mise à jour : <https://docs.flutter.dev/install/upgrade>
- FAQ Flutter (définition, plateformes, moteur de rendu, choix de Dart) : <https://docs.flutter.dev/resources/faq>
- Dart overview (compilation, rechargement à chaud, web) : <https://dart.dev/overview>
- Null safety : <https://dart.dev/null-safety>
- Contraintes de mise en page : <https://docs.flutter.dev/ui/layout/constraints>
- Gestion d'état : <https://docs.flutter.dev/data-and-backend/state-mgmt/ephemeral-vs-app>
- Guide d'architecture : <https://docs.flutter.dev/app-architecture/guide>
- Navigation : <https://docs.flutter.dev/ui/navigation>
- Tests : <https://docs.flutter.dev/testing/overview>
- Bloc (définition du Cubit, comparaison Cubit/Bloc) : <https://bloclibrary.dev/bloc-concepts/>
- Versions des paquets (API de pub.dev, 6 octobre 2026) : <https://pub.dev/packages/flutter_bloc> (9.1.1), <https://pub.dev/packages/bloc_test> (10.0.0), <https://pub.dev/packages/go_router> (18.0.2)

Histoire (sources de presse et secondaires) :

- Dart dévoilé à GOTO, octobre 2011 : <https://www.infoq.com/news/2011/10/google-dart-language/>
- Flutter 1.0, 4 décembre 2018 : <https://www.infoq.com/news/2018/12/flutter-1.0-released> et <https://flutter.dev/blog/flutter-1-0-launch-wrap-up>
- Alpha de Flutter à Google I/O, mai 2017 (source secondaire) : <https://en.wikipedia.org/wiki/Flutter_(software)>

Documents du cours (chemins locaux) :

- `cours/presentations/day-1/index.html` et `notes.html` (notions de code, TDD, projet Flutter, intégration continue)
- `cours/programme-detaille.md` (S1, blocs 5 et 6)

Vérification par exécution (poste de rédaction, Ubuntu 24.04, 6 octobre 2026) : Flutter 3.47.6 (stable), Dart 3.13.5, DevTools 2.60.0. Les exemples de code des sections 3, 5 à 9 ont été compilés, analysés (`flutter analyze`, `dart analyze`) et exécutés (`dart run`, `flutter test`, 7 tests verts). Les messages d'erreur des sections 3.6, 6.3 et 11.2 sont des sorties réelles, abrégées.
