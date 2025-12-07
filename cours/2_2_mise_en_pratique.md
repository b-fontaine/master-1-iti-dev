# 2.2 Mise en Pratique : Conception d'un Simulateur de Drone/Rover Autonome

Après avoir vu les bases de Flame, passons aux choses sérieuses. Nous allons construire un simulateur de Rover autonome. 

Pourquoi ce sujet ? Parce que le développement de jeu vidéo partage énormément d'ADN avec la robotique et l'informatique embarquée.

1.  **Le Game Loop vs La Boucle de Contrôle** : `update(dt)` dans Flame, c'est exactement votre boucle `while(true)` sur un microcontrôleur. C'est du temps réel.
2.  **ECS (Entity Component System) vs Modularité Hardware** : Un robot est un assemblage de modules (châssis, moteurs, capteurs). Dans Flame, une `Entity` est une coquille vide à laquelle on ajoute des `Component` (Movement, Fuel, Lidar). C'est la même philosophie de composition.
3.  **La Physique** : `flame_forge2d` (basé sur Box2D) nous permet d'appliquer de vraies forces physiques, frottements et collisions, comme dans le monde réel.

---

## 1. Le Cœur du Réacteur : La Boucle de Jeu (Game Loop)

Dans un système embarqué, vous lisez les capteurs, vous calculez la commande, et vous actionnez les moteurs.
Dans un jeu, c'est pareil :

```dart
@override
void update(double dt) {
  // 1. SENSE : Lire les inputs ou l'état des composants
  // 2. THINK : Mettre à jour l'IA ou la physique
  // 3. ACT : Rendu graphique (géré automatiquement par render)
}
```

**Règle d'or** : On ne met pas tout le code dans le `update` du jeu. On délègue aux composants. Le `GameWidget` est notre chef d'orchestre, mais ce sont les musiciens (les composants) qui jouent.

## 2. L'Architecture Orientée Composants (FCS)

L'héritage excessif est l'ennemi (`class SuperRobot extends Robot extends Vehicle extends Object`... non !).
Nous allons utiliser la **composition**.

Notre Rover sera une Entité simple. Ses capacités seront des Composants :

-   `MovementComponent` : Applique les forces pour bouger.
-   `FuelComponent` : Gère la batterie/le carburant.
-   `LidarComponent` : Gère la "vision".

C'est le **Principe de Responsabilité Unique (SRP)**. Si je veux un robot immobile mais qui scanne, j'enlève juste le `MovementComponent`. Flexibilité totale.

## 3. Simulation Sensorielle : Le Raycasting

C'est ici que ça devient intéressant pour la robotique. Comment le robot "voit-il" les murs ?
En réalité, un LIDAR envoie des lasers. Dans notre simulation, nous allons utiliser le **Raycasting**.

Le moteur physique nous permet de lancer un rayon d'un point A à un point B et de récupérer le premier obstacle touché. Utile pour :
-   Les capteurs de distance.
-   La ligne de vue (Line of Sight).
-   Les armes de tir instantané (Hitscan).

Nous dessinerons ces rayons en utilisant le `debugMode` de Flame ou en surchargeant `render` pour visualiser ce que le robot perçoit.

## 4. L'Interface de Télémétrie (La Puissance de Flutter)

C'est là que Flutter brille par rapport à Unity ou Godot pour ce type d'application.
L'UI dans les moteurs de jeux est souvent complexe. Ici, nous avons Flutter !

Nous allons créer un **Dashboard (HUD)** avec des Widgets Flutter standards (Column, Text, Stack) qui se superposent au jeu (`Overlay`).
Nous utiliserons **Riverpod** (ou Provider) pour faire remonter l'état du jeu (vitesse, batterie, distance obstacle) vers l'interface Flutter, de manière réactive.

## 5. Logique de Contrôle : State Machines

Comment gérer le comportement du drone ?
-   *Si batterie < 10% aller charger*
-   *Si obstacle à < 1m, tourner*
-   *Sinon, avancer*

Si on fait ça avec des `if/else`, on crée un "Spaghetti Code Monster".
Nous allons utiliser une **Machine à États Finis (FSM)**.

Le drone sera toujours dans un état donné : `Idle`, `Patrol`, `Alert`, `ReturnToBase`.
Chaque état définit ce que le drone fait et quand il change d'état (les transitions). C'est le pattern **State**, indispensable en IA de jeu comme en robotique.

---

### Au boulot !

Nous allons commencer par créer le projet et mettre en place la physique.
