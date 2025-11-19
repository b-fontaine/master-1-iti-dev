# La fourmi de Langton - Dojo de programmation Flutter

## 1. Introduction à la fourmi de Langton

### Qu'est-ce que la fourmi de Langton ?

La **fourmi de Langton** (Langton's Ant en anglais) est un automate cellulaire bidimensionnel créé par **Christopher Langton** en **1986**. Il s'agit d'un système simple mais fascinant qui démontre comment des règles élémentaires peuvent générer des comportements complexes et imprévisibles.

### Les règles de fonctionnement

La fourmi de Langton évolue sur une grille composée de cases qui peuvent être de deux couleurs : **blanche** ou **noire**. La fourmi se déplace selon des règles très simples :

1. **Si la fourmi est sur une case blanche** :
   - Elle tourne de 90° vers la **droite**
   - Elle inverse la couleur de la case (la case devient noire)
   - Elle avance d'une case

2. **Si la fourmi est sur une case noire** :
   - Elle tourne de 90° vers la **gauche**
   - Elle inverse la couleur de la case (la case devient blanche)
   - Elle avance d'une case

Ces règles peuvent se résumer par l'acronyme **"RL"** (Right-Left) : à droite sur blanc, à gauche sur noir.

### Pourquoi cet automate a-t-il été créé ?

Christopher Langton a créé cet automate dans le cadre de ses recherches sur la **vie artificielle** et l'étude de la **complexité émergente**. Son objectif était de démontrer comment des règles simples et déterministes peuvent produire des comportements apparemment chaotiques, puis structurés.

L'un des aspects les plus remarquables de la fourmi de Langton est qu'après environ 10 000 itérations de mouvement apparemment aléatoire, elle entre dans un cycle répétitif appelé **"autoroute"** (highway), où elle construit indéfiniment une structure diagonale. Ce phénomène illustre parfaitement le concept d'**ordre émergeant du chaos**.

## 2. Le concept de dojo de programmation

### Qu'est-ce qu'un coding dojo ?

Un **coding dojo** (ou dojo de programmation) est un exercice de programmation collaboratif et pédagogique inspiré des dojos d'arts martiaux. C'est un espace d'apprentissage où les développeurs se réunissent pour pratiquer et améliorer leurs compétences techniques dans un environnement bienveillant et sans pression.

### Les objectifs d'un coding dojo

Les principaux objectifs d'un coding dojo sont :

- **Apprentissage par la pratique** : apprendre en codant plutôt qu'en écoutant passivement
- **Amélioration continue** : développer ses compétences techniques de manière progressive
- **Partage de connaissances** : échanger des bonnes pratiques et des techniques entre participants
- **Expérimentation** : tester de nouvelles approches dans un cadre sécurisé
- **Développement piloté par les tests** : pratiquer le TDD (Test-Driven Development)

## 3. Présentation du dojo Flutter

### Un dojo créé pour la formation Flutter

J'ai créé ce dojo spécifiquement pour la formation Flutter que j'anime. Il s'agit d'un exercice pratique qui permet d'apprendre Flutter à travers un projet concret et progressif, tout en découvrant les concepts fondamentaux du développement mobile.

### Repository GitHub

Le code source et les instructions complètes du dojo sont disponibles sur GitHub :

**🔗 [https://github.com/b-fontaine/flutter_dojo_langton_ant](https://github.com/b-fontaine/flutter_dojo_langton_ant)**

### Objectif pédagogique

L'objectif principal de ce dojo est de **commencer par développer les tout premiers tests unitaires**. Cette approche permet de :

1. **Comprendre la logique métier** avant de s'attaquer à l'interface utilisateur
2. **Pratiquer le TDD** (Test-Driven Development) dès le début
3. **Structurer le code** de manière testable et maintenable
4. **Valider le comportement** de la fourmi avant de la visualiser
5. **Progresser étape par étape** en ajoutant des fonctionnalités de manière incrémentale

### Pourquoi la fourmi de Langton pour apprendre Flutter ?

Ce projet est idéal pour une formation Flutter car il combine :

- **Logique algorithmique simple** : les règles sont faciles à comprendre et à implémenter
- **Visualisation graphique** : permet de découvrir les widgets Flutter pour l'affichage
- **Gestion d'état** : nécessite de comprendre comment gérer l'état de l'application
- **Animation** : offre l'opportunité d'explorer les animations et les mises à jour d'interface
- **Tests unitaires** : la logique métier se prête parfaitement aux tests

### Déroulement du dojo

Le dojo se déroule en plusieurs étapes :

1. **Phase 1 - Tests unitaires** : écrire les tests pour la logique de la fourmi
2. **Phase 2 - Implémentation** : coder la logique métier pour faire passer les tests
3. **Phase 3 - Interface** : créer l'interface utilisateur avec Flutter
4. **Phase 4 - Animation** : ajouter l'animation et l'interactivité
5. **Phase 5 - Améliorations** : optimiser et ajouter des fonctionnalités (vitesse, reset, etc.)

---

**Prêt à commencer ?** Rendez-vous sur le repository GitHub pour démarrer le dojo ! 🚀

