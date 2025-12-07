# 2.3 Autres Exemples de Projets Flutter

Après avoir construit notre simulateur de rover, explorons deux autres projets qui illustrent différentes facettes du développement Flutter. Ces exemples vous montreront comment les concepts que nous avons appris s'appliquent à des contextes variés.

---

## 1. Space Rogue - Un Jeu Complet avec Flame

**Dépôt GitHub :** [https://github.com/b-fontaine/space_rogue](https://github.com/b-fontaine/space_rogue)

**Démo en ligne :** [https://space-rogue.benoitfontaine.fr/](https://space-rogue.benoitfontaine.fr/)

### 1.1 Description du Projet

**Space Rogue** est un jeu vidéo de type *rogue-like* spatial développé avec Flutter et le moteur Flame. Inspiré par les exemples de la documentation officielle de Flame, ce projet démontre comment créer un jeu complet avec gestion des ennemis, des collisions et des animations.

### 1.2 Technologies Utilisées

| Technologie | Rôle |
|-------------|------|
| **Flutter** | Framework UI cross-platform |
| **Flame** | Moteur de jeu 2D |
| **Firebase Hosting** | Déploiement web |
| **GitHub Actions** | CI/CD automatisé |

### 1.3 Architecture du Projet

```
lib/
├── main.dart           # Point d'entrée
├── game/               # Logique principale du jeu (FlameGame)
└── components/         # Composants du jeu (joueur, ennemis, projectiles)
```

**Points clés de l'architecture :**

1. **Séparation Game/Components** : La logique du jeu est isolée dans `game/`, tandis que les entités individuelles sont dans `components/`. C'est le même pattern que notre simulateur de rover.

2. **Architecture modulaire** : Chaque composant (joueur, ennemi, projectile) gère son propre comportement et affichage, facilitant l'extension du jeu.

### 1.4 Concepts Clés Démontrés

#### La Boucle de Jeu (Game Loop)

Comme dans notre simulateur, Space Rogue utilise la boucle `update(dt)` pour :
- Mettre à jour les positions des entités
- Détecter les collisions
- Gérer les animations

#### Gestion des Collisions

Le jeu implémente un système de collision pour :
- Les projectiles touchant les ennemis
- Le joueur évitant les obstacles
- Les power-ups collectés

#### Gestion des Assets

```dart
// Chargement des sprites et sons
await images.load('player_ship.png');
await images.load('enemy_sprite.png');
```

Le projet montre comment organiser et charger efficacement les ressources graphiques et sonores.

### 1.5 Lien avec le Cours

| Concept du Cours | Application dans Space Rogue |
|------------------|------------------------------|
| Game Loop (2.2 §1) | Boucle principale du jeu |
| Architecture Composants (2.2 §2) | Séparation player/enemies/projectiles |
| Gestion d'état | Score, vies, niveau |
| Déploiement | Firebase Hosting + GitHub Actions |

### 1.6 Points Forts à Retenir

1. **Gameplay complet** : Contrairement à notre simulateur éducatif, Space Rogue est un jeu jouable avec un objectif clair.

2. **Déploiement automatisé** : Le projet utilise GitHub Actions pour déployer automatiquement sur Firebase Hosting.

3. **Cross-platform** : Fonctionne sur Web, iOS, Android, macOS, Windows et Linux.

---

## 2. Blackball Competitions - Application Métier avec Firebase

**Dépôt GitHub :** [https://github.com/b-fontaine/blackball-competitions](https://github.com/b-fontaine/blackball-competitions)

### 2.1 Description du Projet

**Blackball Competitions** est une application professionnelle de gestion de compétitions de billard entre deux équipes. Elle permet de :
- Créer des équipes avec un nombre variable de joueurs
- Générer automatiquement les matchs (round-robin)
- Suivre les scores en temps réel sur plusieurs appareils
- Exporter les résultats (PDF, impression)

### 2.2 Technologies Utilisées

| Technologie | Rôle |
|-------------|------|
| **Flutter** | Framework UI cross-platform |
| **Flutter BLoC** | Gestion d'état prédictible |
| **Firebase Firestore** | Base de données temps réel |
| **Equatable** | Comparaison d'objets immutables |
| **PDF/Printing** | Export des résultats |

### 2.3 Architecture du Projet

```
lib/
├── main.dart
├── firebase_options.dart
├── bloc/                    # Gestion d'état BLoC
│   ├── competition_bloc.dart
│   ├── competition_event.dart
│   └── competition_state.dart
├── models/                  # Modèles de données
│   ├── competition.dart
│   ├── match.dart
│   ├── player.dart
│   └── team.dart
├── screens/                 # Écrans de l'application
│   ├── competition_join_screen.dart
│   ├── team_setup_screen.dart
│   └── competition_screen.dart
├── services/                # Logique métier
│   ├── firebase_competition_service.dart
│   ├── match_generator_service.dart
│   └── storage_service.dart
├── widgets/                 # Widgets réutilisables
│   ├── match_card.dart
│   └── score_board.dart
└── l10n/                    # Internationalisation
```

### 2.4 Le Pattern BLoC en Détail

Contrairement à Riverpod utilisé dans notre simulateur, ce projet utilise **BLoC** (Business Logic Component) :

```dart
// Événements (actions utilisateur)
abstract class CompetitionEvent {}
class CreateCompetition extends CompetitionEvent { ... }
class UpdateScore extends CompetitionEvent { ... }
class UndoLastScore extends CompetitionEvent { ... }

// États (résultats des actions)
abstract class CompetitionState {}
class CompetitionInitial extends CompetitionState {}
class CompetitionInProgress extends CompetitionState { ... }
class CompetitionCompleted extends CompetitionState { ... }
```

**Flux de données :**
```
UI → Event → BLoC → State → UI (rebuild)
```

### 2.5 Synchronisation Temps Réel avec Firebase

L'une des fonctionnalités les plus impressionnantes est la synchronisation multi-appareils :

```dart
// Écoute des changements en temps réel
FirebaseFirestore.instance
    .collection('competitions')
    .doc(competitionId)
    .snapshots()
    .listen((snapshot) {
      // Mise à jour automatique de l'état
      emit(CompetitionInProgress(competition: snapshot.data()));
    });
```

**Gestion des conflits :**
- Utilisation de **transactions Firebase** pour les mises à jour concurrentes
- Fallback vers le stockage local en mode hors-ligne

### 2.6 Algorithme de Génération des Matchs

Le service `match_generator_service.dart` implémente un algorithme intelligent :

1. **Génération Round-Robin** : Chaque joueur de l'équipe A affronte chaque joueur de l'équipe B exactement une fois.

2. **Optimisation de l'ordre** : Un algorithme glouton équilibre le temps de repos entre les matchs consécutifs d'un même joueur.

```dart
// Pseudo-code de l'algorithme
List<Match> generateMatches(Team teamA, Team teamB) {
  // 1. Générer toutes les combinaisons
  final combinations = teamA.players
      .expand((a) => teamB.players.map((b) => Match(a, b)))
      .toList();

  // 2. Optimiser l'ordre pour maximiser le repos
  return optimizeMatchOrder(combinations);
}
```

### 2.7 Modèles Immutables avec Equatable

Tous les modèles utilisent `Equatable` pour la comparaison par valeur :

```dart
class Player extends Equatable {
  final String id;
  final String name;

  const Player({required this.id, required this.name});

  @override
  List<Object?> get props => [id, name];

  // Sérialisation JSON
  Map<String, dynamic> toJson() => {'id': id, 'name': name};
  factory Player.fromJson(Map<String, dynamic> json) =>
      Player(id: json['id'], name: json['name']);
}
```

**Pourquoi l'immutabilité ?**
- Prédictibilité de l'état
- Facilite le debugging
- Compatible avec BLoC qui compare les états

### 2.8 Lien avec le Cours

| Concept du Cours | Application dans Blackball |
|------------------|----------------------------|
| Gestion d'état (2.2 §10) | BLoC au lieu de Riverpod |
| Architecture modulaire | Séparation bloc/models/services/screens |
| Sérialisation JSON | Sauvegarde/chargement des compétitions |
| Tests unitaires | Tests de l'algorithme de génération |

---

## 3. Comparaison des Deux Projets

| Aspect | Space Rogue | Blackball Competitions |
|--------|-------------|------------------------|
| **Type** | Jeu vidéo | Application métier |
| **Moteur** | Flame | Flutter standard |
| **État** | Interne au jeu | BLoC + Firebase |
| **Temps réel** | Game loop (60 FPS) | Firebase Firestore |
| **Complexité UI** | Sprites/Animations | Widgets Material |
| **Offline** | Natif | Fallback local |

### 3.1 Quand Utiliser Flame vs Flutter Standard ?

**Utilisez Flame quand :**
- Vous avez besoin d'une boucle de jeu (60 FPS)
- Vous gérez des sprites et animations complexes
- Vous avez besoin de physique (collisions, forces)
- Le rendu est principalement graphique

**Utilisez Flutter standard quand :**
- L'interface est principalement des formulaires/listes
- Vous avez besoin d'intégrations backend (Firebase, API)
- L'application est orientée données
- L'accessibilité est importante

---

## 4. Exercices Suggérés

### Exercice 1 : Analyser Space Rogue
1. Clonez le dépôt et exécutez le jeu
2. Identifiez les composants principaux
3. Ajoutez un nouveau type d'ennemi

### Exercice 2 : Étendre Blackball Competitions
1. Étudiez le flux BLoC (Event → State)
2. Ajoutez une fonctionnalité de statistiques par joueur
3. Implémentez l'export CSV

### Exercice 3 : Combiner les Approches
Créez une application qui utilise :
- Flame pour une visualisation interactive (ex: tableau de scores animé)
- BLoC pour la gestion d'état
- Firebase pour la synchronisation

---

## 5. Ressources Complémentaires

- **Documentation Flame** : [https://docs.flame-engine.org/](https://docs.flame-engine.org/)
- **Documentation BLoC** : [https://bloclibrary.dev/](https://bloclibrary.dev/)
- **Firebase pour Flutter** : [https://firebase.google.com/docs/flutter](https://firebase.google.com/docs/flutter)
- **Equatable** : [https://pub.dev/packages/equatable](https://pub.dev/packages/equatable)

---

## Conclusion

Ces deux projets illustrent la polyvalence de Flutter :

1. **Space Rogue** montre que Flutter + Flame peut rivaliser avec des moteurs de jeu traditionnels pour créer des expériences ludiques complètes.

2. **Blackball Competitions** démontre que Flutter excelle aussi pour les applications métier avec synchronisation temps réel et architecture robuste.

Les concepts fondamentaux restent les mêmes :
- **Composition** plutôt qu'héritage
- **Séparation des responsabilités** (UI / Logique / Données)
- **État immutable** pour la prédictibilité
- **Tests** pour la fiabilité

Que vous construisiez un jeu ou une application d'entreprise, ces principes vous guideront vers un code maintenable et extensible.
