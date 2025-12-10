# 3.4 Mise en Pratique : Vibe Coding avec un Agent IA

## 🚀 Bienvenue dans le futur du développement

Vous avez découvert les agents IA, les techniques de prompting, et les outils comme Gemini et Antigravity. Il est temps
de passer à l'action !

Aujourd'hui, vous allez vivre une expérience unique : **créer une application web complète en quelques heures**, non pas
en écrivant chaque ligne de code vous-même, mais en **collaborant avec une intelligence artificielle**.

> "Le meilleur code est celui que vous n'avez pas à écrire." — Jeff Atwood

Cette session n'est pas un exercice de programmation traditionnel. C'est une exploration de ce que signifie **être
développeur à l'ère de l'IA agentique**. Votre rôle ? Être le chef d'orchestre. L'IA sera votre orchestre.

---

## 🎯 Objectifs de la session

À la fin de cette demi-journée, vous aurez :

1. **Expérimenté le "vibe coding"** — une nouvelle façon de développer où vous guidez l'IA par la conversation
2. **Créé une application web fonctionnelle** — déployable et utilisable
3. **Développé votre intuition** pour le prompting efficace en contexte de développement
4. **Compris les forces et limites** des agents IA pour le développement logiciel

---

## 👥 Organisation : 4 équipes, 4 visions

### Formation des équipes

Vous allez travailler en **équipes de 4-5 personnes**. Chaque équipe choisira un projet parmi les 10 propositions
ci-dessous.

**Règle importante** : Deux équipes ne peuvent pas choisir le même projet. Premier arrivé, premier servi !

### Rôles suggérés dans l'équipe

| Rôle            | Responsabilité                                              |
|-----------------|-------------------------------------------------------------|
| **Pilote IA**   | Interagit directement avec l'agent, formule les prompts     |
| **Co-pilote**   | Suggère des améliorations aux prompts, vérifie la cohérence |
| **Testeur**     | Teste l'application en continu, identifie les bugs          |
| **Documenteur** | Note les prompts efficaces, capture les apprentissages      |

Alternez les rôles toutes les 30-45 minutes pour que chacun expérimente !

---

## 🛠️ L'environnement : Google Antigravity

### Qu'est-ce qu'Antigravity ?

**Antigravity** est la plateforme de développement "agent-first" de Google Labs. Contrairement aux IDE traditionnels
avec de l'IA en complément, Antigravity place l'agent IA au centre de l'expérience : vous conversez, l'agent code.

**Accès** : [labs.google/antigravity](https://labs.google/antigravity) (vous l'avez déjà installé !)

### Pourquoi Antigravity ?

- ✅ **Agent-first** — L'IA n'est pas un assistant, c'est votre co-développeur principal
- ✅ **Gemini 3 PRO intégré** — Le modèle le plus avancé de Google
- ✅ **Preview en temps réel** — Voyez instantanément le résultat de chaque modification
- ✅ **Déploiement en un clic** — Partagez votre app avec une URL publique
- ✅ **Contexte persistant** — L'agent comprend l'ensemble de votre projet

### Interface clé

| Zone         | Description                               |
|--------------|-------------------------------------------|
| **Chat**     | Votre conversation avec l'agent Gemini    |
| **Code**     | Les fichiers générés/modifiés par l'agent |
| **Preview**  | L'aperçu live de votre application        |
| **Terminal** | Pour les commandes si besoin              |

---

## 🎨 Le "Vibe Coding" : Une nouvelle philosophie

### Qu'est-ce que le Vibe Coding ?

Le terme "vibe coding" a été popularisé par Andrej Karpathy (ex-Tesla, OpenAI). L'idée est simple :

> **Vous décrivez ce que vous voulez, l'IA code. Vous itérez par la conversation.**

Ce n'est pas "l'IA fait tout". C'est une **collaboration** où :

- Vous apportez la **vision**, la **créativité**, le **jugement**
- L'IA apporte la **vélocité**, la **connaissance technique**, l'**exécution**

### Les clés du succès

1. **Commencez simple** — Un MVP minimal, puis itérez
2. **Soyez spécifique** — "Ajoute un bouton bleu en haut à droite" > "Améliore l'UI"
3. **Testez souvent** — Après chaque changement, vérifiez que ça marche
4. **Acceptez l'imperfection** — L'objectif est d'apprendre, pas la perfection
5. **Documentez vos prompts** — Les bons prompts sont réutilisables

### Exemple de conversation type

```
👤 Vous : Crée une application Flutter Web simple avec un compteur.
          Un bouton + pour incrémenter, un bouton - pour décrémenter.
          Style moderne avec Material Design.

🤖 Agent : [Génère le code Dart/Flutter]

👤 Vous : Super ! Maintenant ajoute une animation quand le nombre change.
          Et empêche le compteur d'aller en dessous de 0.

🤖 Agent : [Modifie le code]

👤 Vous : Le bouton - devrait être grisé quand on est à 0.

🤖 Agent : [Ajoute la logique]
```

---

## 📋 Les 10 Projets

Chaque projet est conçu pour être réalisable en **3-4 heures** avec l'aide d'un agent IA. Ils couvrent des domaines
variés pour montrer la polyvalence de l'approche.

---

### 🎵 Projet 1 : "SoundMood" — Générateur d'ambiances sonores

**Domaine** : Bien-être / Productivité

Créez une application web qui génère des ambiances sonores personnalisées pour la concentration, la relaxation ou la
créativité.

**Fonctionnalités clés :**

- Mixer plusieurs sons d'ambiance (pluie, café, forêt, feu de cheminée...)
- Contrôle individuel du volume de chaque son
- Presets d'ambiances (Focus, Relax, Sleep, Create)
- Timer Pomodoro intégré avec notifications
- Sauvegarde des mix personnalisés en local

**Stack suggérée** : Flutter Web, package audioplayers, SharedPreferences

---

### 🌱 Projet 2 : "CarbonLens" — Calculateur d'empreinte numérique

**Domaine** : Environnement / Sensibilisation

Une application qui estime l'empreinte carbone de vos activités numériques quotidiennes.

**Fonctionnalités clés :**

- Questionnaire interactif sur les habitudes (streaming, emails, cloud...)
- Visualisation graphique de l'empreinte par catégorie
- Comparaisons parlantes ("équivalent à X km en voiture")
- Conseils personnalisés pour réduire son impact
- Partage des résultats sur les réseaux sociaux

**Stack suggérée** : Flutter Web, package fl_chart, données statiques JSON

---

### 🎮 Projet 3 : "QuizDuel" — Jeu de culture générale multijoueur local

**Domaine** : Gaming / Social

Un jeu de quiz où 2-4 joueurs s'affrontent sur le même écran, chacun avec sa zone de l'écran.

**Fonctionnalités clés :**

- Mode "hot seat" : chaque joueur a sa zone tactile/clavier
- Catégories variées (science, histoire, pop culture, sport...)
- Système de points avec bonus de rapidité
- Animations de victoire/défaite
- Tableau des scores persistant

**Stack suggérée** : Flutter Web, package http pour API de quiz externe (Open Trivia DB), SharedPreferences

---

### 🎨 Projet 4 : "PixelCollab" — Tableau blanc collaboratif pixelisé

**Domaine** : Art / Communauté

Une toile pixelisée où chaque visiteur peut colorier un pixel, créant une œuvre collective.

**Fonctionnalités clés :**

- Grille de pixels cliquables (32x32 minimum)
- Palette de couleurs sélectionnable
- Historique des dernières modifications
- Export de l'œuvre en image PNG
- Mode "timelapse" pour voir l'évolution

**Stack suggérée** : Flutter Web, CustomPainter pour le canvas, SharedPreferences (ou Firebase pour le temps réel)

---

### 📚 Projet 5 : "StoryForge" — Générateur d'histoires interactives

**Domaine** : Éducation / Créativité

Une application qui crée des histoires "dont vous êtes le héros" avec des choix qui influencent la suite.

**Fonctionnalités clés :**

- Interface de lecture immersive avec typographie soignée
- Choix multiples à chaque étape de l'histoire
- Plusieurs fins possibles selon les décisions
- Thèmes variés (fantasy, sci-fi, mystère, aventure)
- Sauvegarde de la progression

**Stack suggérée** : Flutter Web, structure de données en arbre (JSON), SharedPreferences

---

### 💪 Projet 6 : "FitFlow" — Générateur de séances d'entraînement

**Domaine** : Santé / Fitness

Une application qui génère des séances d'entraînement personnalisées selon le temps disponible et l'équipement.

**Fonctionnalités clés :**

- Sélection du temps disponible (10, 20, 30, 45 min)
- Choix de l'équipement (aucun, haltères, bandes élastiques...)
- Génération aléatoire d'exercices avec GIFs/illustrations
- Timer intégré avec annonces vocales (Web Speech API)
- Historique des séances complétées

**Stack suggérée** : Flutter Web, package flutter_tts pour la synthèse vocale, base d'exercices en JSON

---

### 🗺️ Projet 7 : "LocalHero" — Carte des initiatives locales

**Domaine** : Impact social / Communauté

Une carte interactive pour découvrir et partager les initiatives solidaires de votre quartier.

**Fonctionnalités clés :**

- Carte interactive avec marqueurs (Leaflet.js)
- Catégories : jardins partagés, repair cafés, boîtes à livres, etc.
- Fiche détaillée pour chaque lieu (horaires, contact, photos)
- Formulaire pour proposer un nouveau lieu
- Filtres par catégorie et distance

**Stack suggérée** : Flutter Web, package flutter_map, données en JSON (ou Supabase)

---

### 🎭 Projet 8 : "MoodBoard" — Tableau d'inspiration dynamique

**Domaine** : Design / Créativité

Un outil pour créer des moodboards visuels en glissant-déposant des images, couleurs et textes.

**Fonctionnalités clés :**

- Drag & drop d'éléments sur un canvas libre
- Import d'images par URL ou upload
- Palette de couleurs extractible depuis les images
- Ajout de notes et annotations
- Export en image haute résolution

**Stack suggérée** : Flutter Web, widgets Draggable et DragTarget, CustomPainter

---

### 🔮 Projet 9 : "DecisionDice" — Assistant de prise de décision

**Domaine** : Productivité / Fun

Une application ludique pour aider à prendre des décisions difficiles avec différentes méthodes.

**Fonctionnalités clés :**

- Roue de la fortune personnalisable
- Matrice de décision pondérée (critères + notes)
- Mode "pile ou face" avec animation 3D
- Tirage aléatoire avec suspense
- Historique des décisions prises

**Stack suggérée** : Flutter Web, animations avec AnimationController, CustomPainter pour la roue

---

### 🌍 Projet 10 : "LangBridge" — Flashcards de vocabulaire contextuel

**Domaine** : Éducation / Langues

Une application de flashcards qui enseigne le vocabulaire dans son contexte d'utilisation réel.

**Fonctionnalités clés :**

- Cartes recto-verso avec mot, traduction et phrase d'exemple
- Système de répétition espacée (algorithme simple)
- Catégories thématiques (voyage, travail, quotidien...)
- Prononciation audio (Web Speech API)
- Statistiques de progression

**Stack suggérée** : Flutter Web, package flutter_tts pour la synthèse vocale, SharedPreferences

---

## ⏱️ Planning de la session

| Durée      | Phase         | Activité                                           |
|------------|---------------|----------------------------------------------------|
| **15 min** | Lancement     | Formation des équipes, choix des projets           |
| **30 min** | Exploration   | Prise en main de l'environnement, premiers prompts |
| **90 min** | Sprint 1      | Développement du MVP (fonctionnalités de base)     |
| **15 min** | Pause         | ☕                                                  |
| **75 min** | Sprint 2      | Améliorations, polish, fonctionnalités bonus       |
| **30 min** | Démos         | Chaque équipe présente son projet (5-7 min/équipe) |
| **15 min** | Rétrospective | Partage des apprentissages, meilleurs prompts      |

---

## 🎤 Format des démos finales

Chaque équipe dispose de **5-7 minutes** pour présenter :

1. **Le projet** (30 sec) — Qu'avez-vous créé ?
2. **Démo live** (2-3 min) — Montrez l'application en action
3. **Coulisses** (2 min) — Partagez vos meilleurs prompts et vos galères
4. **Apprentissages** (1 min) — Qu'avez-vous appris sur le vibe coding ?

---

## 💡 Conseils pour réussir

### Prompts qui marchent bien

```
✅ "Crée un widget Flutter pour [X] avec les paramètres suivants : [liste]"
✅ "Ajoute une validation au formulaire : email requis, mot de passe min 8 caractères"
✅ "Refactorise ce code pour séparer la logique métier de l'affichage avec un Provider"
✅ "Corrige ce bug : quand je clique sur [X], il se passe [Y] au lieu de [Z]"
```

### Prompts à éviter

```
❌ "Fais-moi une belle app" (trop vague)
❌ "Améliore tout" (pas de direction claire)
❌ "Pourquoi ça marche pas ?" (sans contexte ni code)
```

### Quand l'IA se trompe

1. **Reformulez** — Essayez une autre façon de demander
2. **Décomposez** — Demandez une chose à la fois
3. **Donnez du contexte** — "Dans le fichier X, fonction Y..."
4. **Montrez un exemple** — "Je veux quelque chose comme [exemple]"

---

## 📝 Fiche de suivi d'équipe

Utilisez cette structure pour documenter votre session :

```markdown
# Équipe : [Nom de l'équipe]

# Projet : [Nom du projet choisi]

## Membres

- [Nom 1] — Rôle actuel :
- [Nom 2] — Rôle actuel :
- [Nom 3] — Rôle actuel :
- [Nom 4] — Rôle actuel :

## Prompts efficaces

1. "[Prompt qui a bien marché]"
2. "[Autre prompt efficace]"

## Difficultés rencontrées

- [Problème 1] → Solution : [Comment résolu]
- [Problème 2] → Solution : [Comment résolu]

## Fonctionnalités réalisées

- [ ] Fonctionnalité 1
- [ ] Fonctionnalité 2
- [ ] Fonctionnalité 3

## Apprentissages clés

- [Ce qu'on a appris sur le vibe coding]
```

---

## 🏆 Critères d'évaluation (informels)

Ce n'est pas une compétition, mais voici ce qui impressionne :

| Critère            | Description                                  |
|--------------------|----------------------------------------------|
| **Fonctionnalité** | L'app fait ce qu'elle promet                 |
| **Créativité**     | Idées originales, touches personnelles       |
| **Collaboration**  | Bonne dynamique d'équipe, rotation des rôles |
| **Apprentissage**  | Capacité à partager les leçons apprises      |
| **Résilience**     | Gestion des bugs et des impasses             |

---

## 🚀 C'est parti !

Vous avez maintenant toutes les clés en main. Rappelez-vous :

> **L'objectif n'est pas de créer l'application parfaite, mais d'explorer une nouvelle façon de développer.**

Soyez curieux. Expérimentez. Échouez vite, apprenez vite. Et surtout, **amusez-vous** !

L'avenir du développement logiciel se construit aujourd'hui, et vous en faites partie.

---

*"The best way to predict the future is to invent it."* — Alan Kay
