# Master ITI : Initiation au génie logiciel moderne par la création : applications, jeux et IA assistée

## Synopsis

### 🧠 **Objectif général :**

Initier des étudiants d’ingénierie généraliste, issus d’un parcours robotique, aux **fondamentaux du génie logiciel moderne**, à travers une pédagogie par la création, l’expérimentation et l’utilisation d’**outils d’IA générative**.
L’objectif n’est pas de faire d’eux des développeurs, mais de leur permettre de comprendre les rouages d’un logiciel, de dialoguer efficacement avec des devs, et de prototyper eux-mêmes des solutions fonctionnelles grâce à des outils accessibles et puissants.

### 📅 **Durée :**

20 heures — 5 séances de 4h

---

### 🧱 **Philosophie pédagogique :**

* **Apprendre en créant** : jeux, outils métiers, interfaces
* **Éveiller la curiosité** par le jeu, l’IA et les outils modernes
* **Favoriser l’autonomie et la posture projet**
* **Montrer l’avenir** : dev augmenté, copilotes IA, outils no-code/code-assisté

---

### 🪜 **Structure de la formation :**

#### 📘 **Séance 1 – Comprendre pour créer**

* Découverte du génie logiciel, de ses enjeux et de son histoire (Craftsmanship, TDD, BDD, DDD)
* Premiers pas en Flutter avec un cas original : *la fourmi de Langton*
* Objectif : établir une première boucle de feedback positive par la réussite

#### 🎮 **Séance 2 – Créer un jeu avec Flame**

* Exploration d’un moteur de jeu 2D
* Création d’un mini Shoot them up avec logique de collisions, input, score
* Objectif : faire émerger les notions de game loop, de réactivité et d’architecture orientée jeu

#### 🤖 **Séance 3 – IA & automatisation métier**

* Création d’un outil automatisé dans Excel (VBA)
* Découverte d’outils d’IA générative comme Vercel V0 et Cursor : prototypage assisté, interface générée, prompting
* Objectif : montrer que la conception logicielle est à la portée d’un ingénieur bien outillé

#### 🛠️ **Séance 4 – Projet libre guidé**

* Projets en équipes : jeu, app ou outil généré par IA
* Utilisation libre des outils explorés : Flame, Flutter, V0, Cursor, ChatGPT, Gemini, etc.
* Coaching sur la structure, l'UX, la qualité du code et la soutenabilité des choix

#### 🎓 **Séance 5 – TD évalué : présentation & soutenance**

* Présentation orale par équipes : démo, retour d’expérience, explication technique vulgarisée
* Évaluation sur la qualité du projet, la démarche, la clarté du discours et l’investissement
* Objectif : valoriser la posture d’ingénieur “augmenté”, autonome, créatif et outillé

---

### ✅ **Compétences visées :**

* Compréhension des bases du génie logiciel moderne
* Capacité à prototyper une solution logicielle simple
* Culture générale en méthodes de développement (TDD, BDD, Craft)
* Utilisation critique d’outils d’IA pour le développement assisté
* Savoir collaborer avec des développeurs et exprimer un besoin technique

## Programme détaillé

### 📘 Séance 1 – **Comprendre pour créer**

> Objectif : poser les bases du génie logiciel moderne de manière concrète et motivante.
>

#### 🧩 Contenu :

- Introduction au **génie logiciel** : rôle, valeur, complémentarité avec ingénierie matérielle
- **Craftsmanship, TDD, BDD** et **DDD** expliqués avec leur histoire

#### 🕒 Déroulé :

1. Introduction magistrale + discussions (30 min)
2. Démo interactive TDD simple (30 min, Tests Unitaires et Gherkin)
3. Flutter setup + tutoriel guidé (2h)
4. App simple (1h) : “La fourmi de Langton”

#### 📦 Livrable :

- App Flutter fonctionnelle avec boutons, affichage, logique
- Discussion sur ce qui est bien codé ou non (Clean Code light)

---

### 🎮 Séance 2 – **Créer un jeu avec Flame**

> Objectif : expérimenter un moteur de jeu, découvrir les bases d’un moteur 2D.
>

#### 🧩 Contenu :

- En quoi le monde du jeu vidéo est-il moteur sur l’ensemble de l’industrie du développement ?
- Introduction à Flame : logique de game loop, sprites, input
- Création d’un jeu simple :
    - Shoot them up

#### 🕒 Déroulé :

1. Présentation du moteur et des concepts (30 min)
2. Setup du projet + premier affichage (30 min)
3. Ajout de logique et sprites (2h)
4. Ajout de sons, effets ou scores (1h)

#### 📦 Livrable :

- Petit jeu fonctionnel
- Comportement réactif (input → action)
- Code documenté / présentation orale rapide

---

### 🤖 Séance 3 – **IA & automatisation métier**

> Objectif : montrer que même sans être développeur, on peut tirer parti du logiciel.
>

#### 🧩 Contenu :

- VBA (1h30) : créer un outil dans Excel
    - Générer des données aléatoires, ajouter des boutons, appliquer des formules
- IA no-code (2h30) :
    1. **Introduction aux IA génératives pour le dev (30 min)**
        - Différence entre IA copilote et IA autonome
        - Présentation de **V0.dev** (interface UI → code) et **Cursor.dev** (IDE AI-first)
        - Cas d’usage pour ingénieur non-dev : spec → interface → proto fonctionnel
    2. **Atelier V0.dev : interface auto-générée (1h30)**
        - Brief : créer l’interface d’un **simulateur de mesure**, d’un **gestionnaire de stocks**, ou d’un **outil de
          suivi**
        - Étapes :
            - Rédiger un prompt structuré (“Create a dashboard for X with a table, filters, etc.”)
            - Personnaliser les composants (UI)
            - Exporter le code en React/Tailwind (lecture commentée)
        - Discussion : lisibilité du code généré, potentiel, limites
    3. **Débriefing / discussion (30 min)**
        - Comparaison : dev classique vs dev guidé par IA
        - Risques, biais, supervision humaine
        - Vers une nouvelle posture : ingénieur = **chef d’orchestre des IA** ?

#### 📦 Livrables :

- Fichier Excel automatisé
- Application vibe codée déployable

---

### 🛠️ Séance 4 – **Projet libre guidé**

> Objectif : créer un mini-projet par petits groupes de 3 ou 4 personnes,
> choisir un angle (jeu, app)
>

#### 🧩 Contenu :

- Les élèves choisissent un projet :
    - Mini-app Flutter (ex : simulateur de panne, assistant de mesure)
    - Jeu simple Flame (ex : runner, puzzle, dodge)
- Coaching technique, aide à l’organisation, conseils UX

#### 🕒 Déroulé :

1. Définition des équipes projets (membres, nom d’équipe, projets)
2. Sprint 0 : Ideation avec des outils IA et validation du projet (1h30) :
    - Vercel v0 / Magic Patterns
    - Cursor / Augment Code
    - ChatGPT / Codex
    - Gemini CLI
3. Sprint 2 : ajout fonctionnalités, tests (1h30)
4. Retours, échanges sur la qualité des produits générés et présentation des risques associés (30min)

#### 📦 Livrables :

- Prototype fonctionnel (ou très avancé)
- Documentation courte + présentation à préparer

---

### 🎓 Séance 5 – **TD évalué : présentation & soutenance**

> Objectif : évaluer les acquis par la démonstration et l’explication.
>

#### 🧩 Contenu :

- Présentation des projets par équipe (8 à 10 minutes par équipe, Gamma autorisé) :
    - Démo du prototype
    - Intention de design / choix techniques
    - Retour d’expérience
- Évaluation par grille (voir plus bas)

#### 📦 Grille d’évaluation :

| Critère                    | Note /20 |
|----------------------------|----------|
| Fonctionnalité du projet   | /5       |
| Qualité du code / logique  | /5       |
| Présentation & explication | /5       |
| Ambition / originalité     | /3       |
| Travail d’équipe / effort  | /2       |

#### 🕒 Déroulé :

1. Finalisation des projets et préparation des présentations (2h)
2. Présentations des projets équipe par équipe (1h30)
3. Debrief (30min)
