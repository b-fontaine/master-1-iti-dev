# Découverte du génie logiciel moderne par la création d'applications et de jeux

## Table des matières

1. [Histoire complète du Software Craftsmanship](#1-histoire-complète-du-software-craftsmanship)
2. [Principes fondamentaux du Software Craftsmanship](#2-principes-fondamentaux-du-software-craftsmanship)
3. [Rituels et pratiques importantes pour les développeurs](#3-rituels-et-pratiques-importantes-pour-les-développeurs)
4. [Matériaux de référence et aide-mémoire](#4-matériaux-de-référence-et-aide-mémoire)

---

## 1. Histoire complète du Software Craftsmanship

### 1.1 Les origines : Extreme Programming (fin des années 1990)

#### Kent Beck et la naissance de XP (1996-1999)

L'histoire du Software Craftsmanship commence véritablement avec **Kent Beck** et le projet **Chrysler Comprehensive
Compensation System (C3)** en **mars 1996**. Kent Beck, accompagné de Ward Cunningham et Ron Jeffries, développe une
nouvelle approche du développement logiciel qui deviendra **Extreme Programming (XP)**.

**Dates clés :**

- **1996** : Début du projet C3 chez Chrysler
- **1999** : Publication du livre fondateur "Extreme Programming Explained: Embrace Change" par Kent Beck
- **1999** : Première conférence XP Universe

**Principes fondateurs de XP :**

- **Test-Driven Development (TDD)** : écrire les tests avant le code
- **Pair Programming** : deux développeurs travaillant ensemble sur le même code
- **Refactoring continu** : amélioration constante de la structure du code
- **Intégration continue** : fusion fréquente des modifications
- **Simplicité** : faire la chose la plus simple qui pourrait fonctionner
- **Feedback rapide** : cycles courts et retours constants

### 1.2 Le Manifeste Agile (2001)

#### La réunion de Snowbird (février 2001)

Du **11 au 13 février 2001**, dix-sept experts du développement logiciel se réunissent à la station de ski **Snowbird**
dans l'Utah. Parmi eux : Kent Beck, Martin Fowler, Robert C. Martin (Uncle Bob), Ward Cunningham, Alistair Cockburn, et
d'autres pionniers.

**Les 17 signataires originaux :**

- Kent Beck
- Mike Beedle
- Arie van Bennekum
- Alistair Cockburn
- Ward Cunningham
- Martin Fowler
- James Grenning
- Jim Highsmith
- Andrew Hunt
- Ron Jeffries
- Jon Kern
- Brian Marick
- Robert C. Martin
- Steve Mellor
- Ken Schwaber
- Jeff Sutherland
- Dave Thomas

**Les 4 valeurs du Manifeste Agile :**

1. **Les individus et leurs interactions** plus que les processus et les outils
2. **Des logiciels opérationnels** plus qu'une documentation exhaustive
3. **La collaboration avec les clients** plus que la négociation contractuelle
4. **L'adaptation au changement** plus que le suivi d'un plan

**Les 12 principes :**

1. Satisfaire le client en livrant rapidement et régulièrement des fonctionnalités à grande valeur ajoutée
2. Accueillir positivement les changements de besoins, même tard dans le projet
3. Livrer fréquemment un logiciel opérationnel (de quelques semaines à quelques mois)
4. Les utilisateurs et les développeurs doivent travailler ensemble quotidiennement
5. Réaliser les projets avec des personnes motivées
6. La conversation en face à face est la méthode la plus efficace
7. Un logiciel opérationnel est la principale mesure d'avancement
8. Rythme de développement soutenable indéfiniment
9. Excellence technique et bonne conception renforcent l'agilité
10. La simplicité est essentielle
11. Les meilleures architectures émergent d'équipes auto-organisées
12. Réflexion régulière sur comment devenir plus efficace

### 1.3 L'émergence du Software Craftsmanship (2001-2009)

#### Les précurseurs

Entre 2001 et 2009, plusieurs figures émergent et posent les bases du mouvement Craftsmanship :

**Robert C. Martin (Uncle Bob)** :

- **2002** : Publication de "Agile Software Development: Principles, Patterns, and Practices"
- **2008** : Publication de "Clean Code: A Handbook of Agile Software Craftsmanship" - ouvrage fondamental qui
  popularise le terme "Software Craftsmanship"

**Martin Fowler** :

- **1999** : "Refactoring: Improving the Design of Existing Code"
- **2002** : "Patterns of Enterprise Application Architecture"
- Contributions continues sur son blog influent (martinfowler.com)

**Michael Feathers** :

- **2004** : "Working Effectively with Legacy Code" - guide essentiel pour améliorer le code existant

**Andrew Hunt et David Thomas** :

- **1999** : "The Pragmatic Programmer: From Journeyman to Master" - introduit la notion de développeur artisan

### 1.4 Le Manifeste du Software Craftsmanship (2009)

#### La conférence de Chicago (décembre 2008)

En **décembre 2008**, lors de la conférence **Software Craftsmanship North America** à **Libertyville, Illinois**, un
groupe de développeurs passionnés se réunit pour discuter de l'avenir du développement logiciel.

**Participants clés :**

- Micah Martin
- Paul Pagel
- Mike Sutton
- Justin Martin
- Doug Bradbury
- Corey Haines
- Et d'autres membres de la communauté 8th Light

#### Publication officielle (mars 2009)

Le **Manifeste du Software Craftsmanship** est officiellement publié en **mars 2009** sur le site
manifesto.softwarecraftsmanship.org.

**Les 4 valeurs du Manifeste du Software Craftsmanship :**

En tant qu'aspirants artisans du logiciel, nous relevons le niveau du développement professionnel en pratiquant et en
aidant les autres à apprendre :

1. **Pas seulement des logiciels opérationnels, mais aussi des logiciels bien conçus**
2. **Pas seulement l'adaptation au changement, mais aussi l'ajout constant de valeur**
3. **Pas seulement les individus et leurs interactions, mais aussi une communauté de professionnels**
4. **Pas seulement la collaboration avec les clients, mais aussi des partenariats productifs**

**Note importante :** Le manifeste ne remplace pas le Manifeste Agile, mais le complète en mettant l'accent sur l'
excellence technique.

### 1.5 Développements majeurs (2010-2015)

#### Publications influentes

**2010** :

- **"The Clean Coder: A Code of Conduct for Professional Programmers"** par Robert C. Martin
    - Définit le professionnalisme dans le développement logiciel
    - Introduit des concepts comme le courage de dire "non", l'estimation honnête, et la gestion du temps

**2011** :

- **"Software Craftsmanship: The New Imperative"** par Pete McBreen (réédition influente)
- Émergence des **Software Craftsmanship Communities** dans le monde entier

**2012** :

- **"Clean Architecture"** concepts introduits par Uncle Bob
- Première **Global Day of Coderetreat** - événement mondial de pratique délibérée

**2013** :

- **"The Software Craftsman: Professionalism, Pragmatism, Pride"** par Sandro Mancuso
    - Ouvrage de référence qui systématise les pratiques du Craftsmanship
    - Fondateur de la **London Software Craftsmanship Community (LSCC)**

**2014** :

- **"Growing Object-Oriented Software, Guided by Tests"** par Steve Freeman et Nat Pryce
- Expansion des **Coding Dojos** et **Katas** comme pratiques d'apprentissage

**2015** :

- **"The Nature of Software Development"** par Ron Jeffries
- Consolidation du mouvement DevOps comme extension naturelle du Craftsmanship

#### Conférences et événements

- **Software Craftsmanship North America** (annuelle depuis 2009)
- **SoCraTes** (Software Craftsmanship and Testing) - conférences en Europe (depuis 2011)
- **Craft Conf** à Budapest (depuis 2014)
- **NewCrafts** à Paris (depuis 2015)

### 1.6 Évolution moderne (2016-2020)

#### Intégration avec les pratiques modernes

**2016** :

- **"Clean Architecture: A Craftsman's Guide to Software Structure and Design"** par Robert C. Martin
    - Formalisation des principes architecturaux
    - Introduction des concepts SOLID à l'échelle architecturale

**2017** :

- **"Accelerate: The Science of Lean Software and DevOps"** par Nicole Forsgren, Jez Humble, Gene Kim
    - Validation scientifique des pratiques Craftsmanship
    - Corrélation entre excellence technique et performance organisationnelle

**2018** :

- **"Domain-Driven Design Distilled"** par Vaughn Vernon
- Fusion des pratiques DDD et Craftsmanship
- Émergence du **Mob Programming** comme pratique collaborative avancée

**2019** :

- **"Software Architecture: The Hard Parts"** par Neal Ford, Mark Richards, et al.
- **"Refactoring" (2ème édition)** par Martin Fowler - mise à jour avec JavaScript
- Popularisation du **Behavior-Driven Development (BDD)** avec Cucumber et Gherkin

**2020** :

- Adaptation aux pratiques de **remote work** suite à la pandémie COVID-19
- Évolution des pratiques de pair programming vers le **remote pairing**
- Explosion des outils de collaboration en ligne (VS Code Live Share, Tuple, etc.)

### 1.7 Tendances actuelles (2021-2025)

#### L'ère de l'IA et du développement augmenté

**2021** :

- **GitHub Copilot** (juin 2021) - premier assistant IA mainstream pour le code
- Débats sur l'impact de l'IA sur les pratiques Craftsmanship
- **"Modern Software Engineering"** par Dave Farley

**2022** :

- **"Tidy First?"** par Kent Beck - retour aux fondamentaux du refactoring
- Explosion des outils d'IA générative (ChatGPT, novembre 2022)
- Questionnements sur le rôle du développeur dans un monde avec IA

**2023** :

- **"Software Engineering at Google"** - pratiques à grande échelle
- Intégration massive de l'IA dans les IDEs (GitHub Copilot X, Amazon CodeWhisperer, Tabnine)
- Émergence du concept de **"AI-Augmented Craftsmanship"**
- **"The Programmer's Brain"** par Felienne Hermans - neurosciences appliquées au code

**2024** :

- **Cursor AI**, **Augment Code**, **Windsurf** - IDEs nouvelle génération
- Débats sur **TDD avec IA** : comment adapter les pratiques traditionnelles
- **"Clean Craftsmanship"** par Robert C. Martin - synthèse moderne
- Conférences sur **"Prompt Engineering for Developers"**

**2025 (tendances actuelles)** :

- **Craftsmanship 2.0** : intégration harmonieuse de l'IA dans les pratiques artisanales
- **AI Pair Programming** : l'IA comme binôme permanent
- **Prompt-Driven Development** : nouvelle discipline émergente
- Maintien des principes fondamentaux (tests, refactoring, simplicité) avec de nouveaux outils
- **Ethical AI Development** : responsabilité dans l'utilisation de l'IA
- **Sustainable Software Engineering** : prise en compte de l'impact environnemental

#### Figures influentes contemporaines

**Toujours actifs en 2025 :**

- **Robert C. Martin (Uncle Bob)** - conférences et écrits sur l'adaptation aux nouvelles technologies
- **Martin Fowler** - blog actif sur l'architecture et les pratiques modernes
- **Kent Beck** - travaux sur le refactoring et l'adaptation à l'IA
- **Sandro Mancuso** - formation et coaching en Software Craftsmanship
- **Emily Bache** - experte en refactoring et katas de code
- **Dave Farley** - Continuous Delivery et ingénierie moderne
- **Jessica Kerr** - développement de systèmes complexes et symmathesy
- **Sarah Drasner** - engineering management et excellence technique

**Nouvelles voix :**

- **Kevlin Henney** - architecture et design patterns
- **Venkat Subramaniam** - programmation fonctionnelle et polyglotte
- **Simon Brown** - architecture logicielle (C4 model)
- **Charity Majors** - observabilité et engineering culture

### 1.8 Chronologie synthétique

```
1996 ─── Projet C3 et naissance de XP (Kent Beck)
1999 ─── "Extreme Programming Explained" + "The Pragmatic Programmer"
2001 ─── Manifeste Agile (Snowbird, Utah)
2002 ─── "Agile Software Development" (Uncle Bob)
2004 ─── "Working Effectively with Legacy Code" (Michael Feathers)
2008 ─── "Clean Code" (Uncle Bob) - popularisation du terme Craftsmanship
2009 ─── Manifeste du Software Craftsmanship (Chicago)
2010 ─── "The Clean Coder" (Uncle Bob)
2011 ─── Émergence des communautés Craftsmanship mondiales
2012 ─── Global Day of Coderetreat
2013 ─── "The Software Craftsman" (Sandro Mancuso)
2014 ─── Expansion des Coding Dojos et Katas
2015 ─── Consolidation DevOps + Craftsmanship
2016 ─── "Clean Architecture" (Uncle Bob)
2017 ─── "Accelerate" - validation scientifique
2018 ─── Fusion DDD + Craftsmanship
2019 ─── Refactoring 2ème édition (Martin Fowler)
2020 ─── Adaptation au remote work
2021 ─── GitHub Copilot - début de l'ère IA
2022 ─── "Tidy First?" (Kent Beck) + ChatGPT
2023 ─── AI-Augmented Craftsmanship
2024 ─── IDEs IA nouvelle génération
2025 ─── Craftsmanship 2.0 + Sustainable Engineering
```

---

## 2. Principes fondamentaux du Software Craftsmanship

### 2.1 Logiciels bien conçus (Well-Crafted Software)

#### Au-delà du "ça marche"

Le premier principe du Craftsmanship insiste sur la différence entre un logiciel qui **fonctionne** et un logiciel *
*bien conçu**.

**Caractéristiques d'un logiciel bien conçu :**

1. **Lisibilité** :
    - Le code se lit comme de la prose
    - Les intentions sont claires sans commentaires excessifs
    - Les noms de variables, fonctions et classes sont explicites

2. **Maintenabilité** :
    - Facile à modifier sans introduire de bugs
    - Structure modulaire et découplée
    - Dépendances gérées explicitement

3. **Testabilité** :
    - Couverture de tests significative (pas juste un pourcentage)
    - Tests rapides et fiables
    - Tests qui documentent le comportement

4. **Simplicité** :
    - Pas de sur-ingénierie (YAGNI - You Aren't Gonna Need It)
    - Solutions directes aux problèmes
    - Complexité accidentelle minimisée

5. **Évolutivité** :
    - Ouvert à l'extension, fermé à la modification (Open/Closed Principle)
    - Architecture qui anticipe le changement
    - Refactoring continu pour maintenir la qualité

**Exemple concret :**

```python
# ❌ Code qui fonctionne mais mal conçu
def p(d):
    t = 0
    for i in d:
        if i['t'] == 'A':
            t += i['p'] * 0.9
        else:
            t += i['p']
    return t


# ✅ Code bien conçu
def calculate_total_price(items: list[dict]) -> float:
    """
    Calcule le prix total d'une liste d'articles.
    Applique une réduction de 10% sur les articles de type 'A'.
    """
    total = 0.0

    for item in items:
        price = item['price']
        if item['type'] == 'A':
            price = apply_discount(price, discount_rate=0.10)
        total += price

    return total


def apply_discount(price: float, discount_rate: float) -> float:
    """Applique un taux de réduction à un prix."""
    return price * (1 - discount_rate)
```

#### Les principes SOLID

Les principes SOLID, popularisés par Robert C. Martin, sont au cœur du logiciel bien conçu :

1. **S - Single Responsibility Principle (SRP)** :
    - Une classe ne devrait avoir qu'une seule raison de changer
    - Chaque module fait une chose et la fait bien

2. **O - Open/Closed Principle (OCP)** :
    - Ouvert à l'extension, fermé à la modification
    - Ajouter des fonctionnalités sans modifier le code existant

3. **L - Liskov Substitution Principle (LSP)** :
    - Les sous-types doivent être substituables à leurs types de base
    - Respect des contrats d'interface

4. **I - Interface Segregation Principle (ISP)** :
    - Plusieurs interfaces spécifiques valent mieux qu'une interface générale
    - Les clients ne doivent pas dépendre d'interfaces qu'ils n'utilisent pas

5. **D - Dependency Inversion Principle (DIP)** :
    - Dépendre d'abstractions, pas de concrétions
    - Les modules de haut niveau ne doivent pas dépendre des modules de bas niveau

### 2.2 Ajout constant de valeur (Steadily Adding Value)

#### Amélioration continue

Le deuxième principe insiste sur l'**amélioration continue** plutôt que la simple adaptation au changement.

**Pratiques clés :**

1. **Refactoring régulier** :
    - Améliorer la structure du code sans changer son comportement
    - "Laisser le code plus propre qu'on ne l'a trouvé" (Boy Scout Rule)
    - Refactoring opportuniste lors de chaque modification

2. **Dette technique gérée** :
    - Identifier et documenter la dette technique
    - Planifier son remboursement progressif
    - Ne pas laisser la dette s'accumuler indéfiniment

3. **Apprentissage continu** :
    - Veille technologique régulière
    - Expérimentation de nouvelles approches
    - Partage des connaissances avec l'équipe

4. **Feedback rapide** :
    - Tests automatisés qui s'exécutent rapidement
    - Intégration continue (CI/CD)
    - Déploiements fréquents en production

5. **Mesure de la valeur** :
    - Métriques de qualité du code (complexité cyclomatique, couplage, etc.)
    - Métriques de performance (temps de build, temps de déploiement)
    - Métriques métier (satisfaction utilisateur, taux d'adoption)

**La règle du Boy Scout :**
> "Laissez toujours le code plus propre que vous ne l'avez trouvé."
> — Robert C. Martin

### 2.3 Communauté de professionnels (Community of Professionals)

#### Au-delà de l'équipe

Le troisième principe met l'accent sur la **communauté** et le **partage de connaissances**.

**Manifestations concrètes :**

1. **Coding Dojos** :
    - Sessions de pratique délibérée en groupe
    - Katas de code pour améliorer les compétences
    - Environnement sûr pour expérimenter

2. **Code Reviews** :
    - Revue systématique du code par les pairs
    - Partage de connaissances et de bonnes pratiques
    - Amélioration collective de la qualité

3. **Pair Programming** :
    - Deux développeurs travaillant ensemble sur le même code
    - Transfert de connaissances en temps réel
    - Réduction des bugs et amélioration de la conception

4. **Mob Programming** :
    - Toute l'équipe travaille sur le même problème ensemble
    - Maximisation du partage de connaissances
    - Décisions collectives sur l'architecture

5. **Conférences et meetups** :
    - Participation aux événements de la communauté
    - Présentations et partage d'expériences
    - Networking avec d'autres professionnels

6. **Open Source** :
    - Contribution aux projets open source
    - Apprentissage des meilleures pratiques
    - Redonner à la communauté

**Mentorat et apprentissage :**

- **Apprenti → Compagnon → Maître** : progression inspirée des guildes médiévales
- Mentorat formel et informel
- Création d'une culture d'apprentissage

### 2.4 Partenariats productifs (Productive Partnerships)

#### Collaboration profonde avec les clients

Le quatrième principe va au-delà de la simple collaboration pour créer de véritables **partenariats**.

**Caractéristiques d'un partenariat productif :**

1. **Compréhension mutuelle** :
    - Les développeurs comprennent le métier
    - Les clients comprennent les contraintes techniques
    - Langage commun (Ubiquitous Language du DDD)

2. **Confiance réciproque** :
    - Transparence sur les difficultés et les risques
    - Honnêteté dans les estimations
    - Engagement mutuel sur les objectifs

3. **Co-création** :
    - Implication des clients dans la conception
    - Feedback continu et itérations rapides
    - Décisions prises ensemble

4. **Responsabilité partagée** :
    - Succès et échecs partagés
    - Objectifs communs clairement définis
    - Célébration des réussites ensemble

**Pratiques facilitant les partenariats :**

- **Example Mapping** : clarification des exigences par l'exemple
- **Three Amigos** : collaboration entre business, dev et test
- **Event Storming** : modélisation collaborative du domaine métier
- **User Story Mapping** : visualisation du parcours utilisateur

### 2.5 Excellence technique (Technical Excellence)

#### La fondation de tout le reste

L'excellence technique n'est pas un luxe, c'est une **nécessité** pour la durabilité du logiciel.

**Piliers de l'excellence technique :**

1. **Test-Driven Development (TDD)** :
    - Écrire les tests avant le code
    - Cycle Red-Green-Refactor
    - Tests comme documentation vivante

2. **Clean Code** :
    - Noms significatifs
    - Fonctions courtes et focalisées
    - Commentaires uniquement quand nécessaire
    - Formatage cohérent

3. **Architecture propre** :
    - Séparation des préoccupations
    - Indépendance des frameworks
    - Testabilité à tous les niveaux
    - Dépendances gérées explicitement

4. **Continuous Integration/Continuous Deployment (CI/CD)** :
    - Intégration fréquente du code
    - Tests automatisés à chaque commit
    - Déploiements automatisés et fréquents

5. **Monitoring et observabilité** :
    - Logs structurés et significatifs
    - Métriques de performance
    - Alertes proactives
    - Traçabilité des erreurs

### 2.6 Bonne conception (Good Design)

#### Principes de conception

1. **KISS (Keep It Simple, Stupid)** :
    - Privilégier la simplicité
    - Éviter la complexité inutile
    - Solutions directes aux problèmes

2. **DRY (Don't Repeat Yourself)** :
    - Éviter la duplication de code
    - Abstractions réutilisables
    - Single Source of Truth

3. **YAGNI (You Aren't Gonna Need It)** :
    - Ne pas implémenter de fonctionnalités spéculatives
    - Attendre d'avoir un besoin réel
    - Éviter la sur-ingénierie

4. **Separation of Concerns** :
    - Chaque module a une responsabilité claire
    - Couplage faible, cohésion forte
    - Facilite les tests et la maintenance

### 2.7 Apprentissage et pratique continus (Continuous Learning)

#### La pratique délibérée

Comme les musiciens ou les athlètes, les développeurs doivent **pratiquer** régulièrement.

**Formes de pratique :**

1. **Katas de code** :
    - Exercices répétés pour améliorer la technique
    - Focus sur la pratique, pas sur le résultat
    - Exemples : FizzBuzz, Roman Numerals, Bowling Game

2. **Coding Dojos** :
    - Sessions de pratique en groupe
    - Formats : Kata, Randori, Mob Programming
    - Environnement sûr pour expérimenter

3. **Code Retreats** :
    - Journées entières de pratique intensive
    - Même problème résolu plusieurs fois différemment
    - Focus sur les pratiques (TDD, pair programming, etc.)

4. **Lecture et veille** :
    - Livres techniques
    - Blogs et articles
    - Conférences et talks
    - Podcasts et newsletters

5. **Side Projects** :
    - Projets personnels pour expérimenter
    - Nouvelles technologies et approches
    - Portfolio de compétences

### 2.8 Fierté du travail bien fait (Pride in Workmanship)

#### L'attitude professionnelle

La fierté n'est pas de l'arrogance, c'est le **respect de son métier** et de ses utilisateurs.

**Manifestations de la fierté :**

1. **Signature du code** :
    - Chaque ligne de code reflète votre professionnalisme
    - Vous seriez fier de montrer votre code à n'importe qui
    - Responsabilité personnelle de la qualité


2. **Attention aux détails** :
    - Formatage soigné
    - Gestion des cas limites
    - Messages d'erreur utiles
    - Documentation à jour

3. **Respect des utilisateurs** :
    - Performance optimisée
    - Expérience utilisateur soignée
    - Accessibilité prise en compte
    - Sécurité et confidentialité

4. **Éthique professionnelle** :
    - Honnêteté sur les capacités et les délais
    - Refus de compromettre la qualité sous pression
    - Courage de dire "non" quand nécessaire
    - Transparence sur les problèmes

---

## 3. Rituels et pratiques importantes pour les développeurs

### 3.1 Example Mapping

#### Qu'est-ce que l'Example Mapping ?

**Example Mapping** est une technique de **clarification des exigences** développée par **Matt Wynne** (créateur de
Cucumber) en **2015**. Elle permet de transformer des user stories vagues en spécifications concrètes à travers des
exemples.

#### Objectifs

1. **Clarifier les exigences** avant de commencer le développement
2. **Identifier les zones d'incertitude** et les questions non résolues
3. **Créer une compréhension partagée** entre business, développement et test
4. **Découvrir les règles métier** cachées
5. **Préparer les tests d'acceptation** (scénarios Gherkin)

#### Participants

- **Product Owner / Business Analyst** : apporte la vision métier
- **Développeurs** : posent des questions techniques
- **Testeurs** : pensent aux cas limites et scénarios d'erreur
- **Experts métier** (optionnel) : clarifient les règles complexes

**Taille idéale :** 3-5 personnes maximum

#### Matériel nécessaire

- **Cartes de 4 couleurs** (post-its ou cartes) :
    - 🟡 **Jaune** : la User Story (1 seule carte)
    - 🔵 **Bleu** : les Règles métier
    - 🟢 **Vert** : les Exemples concrets
    - 🔴 **Rouge** : les Questions / Incertitudes

#### Processus étape par étape

**1. Préparation (5 min)** :

- Écrire la User Story sur une carte jaune
- La placer en haut de la table
- Préparer les cartes de couleur

**2. Exploration des règles (10-15 min)** :

- Le PO explique la story
- L'équipe identifie les règles métier
- Chaque règle = 1 carte bleue sous la story

**3. Illustration par exemples (15-20 min)** :

- Pour chaque règle, donner des exemples concrets
- Chaque exemple = 1 carte verte sous la règle correspondante
- Penser aux cas normaux ET aux cas limites

**4. Questions et incertitudes (5-10 min)** :

- Noter toutes les questions sur des cartes rouges
- Identifier ce qui nécessite des recherches
- Décider qui va chercher les réponses

**5. Décision (5 min)** :

- La story est-elle prête à être développée ?
- Si trop de cartes rouges → reporter
- Si trop de cartes bleues → découper la story
- Si équilibré → prêt pour le développement

#### Exemple concret : Système de réduction

**🟡 User Story :**

```
En tant que client,
Je veux bénéficier de réductions sur mes achats,
Afin d'économiser de l'argent.
```

**🔵 Règles métier :**

1. Réduction de 10% pour les clients fidèles
2. Réduction de 5% sur les achats > 100€
3. Les réductions ne sont pas cumulables

**🟢 Exemples :**

*Pour la règle 1 :*

- Client fidèle achète pour 50€ → paie 45€
- Client non-fidèle achète pour 50€ → paie 50€

*Pour la règle 2 :*

- Achat de 150€ → réduction de 7,50€
- Achat de 99€ → pas de réduction

*Pour la règle 3 :*

- Client fidèle achète pour 150€ → 10% OU 5%, pas les deux
- Quelle réduction appliquer en priorité ?

**🔴 Questions :**

- Comment définit-on un "client fidèle" ?
- Quelle réduction prioriser si non-cumulables ?
- Les réductions s'appliquent-elles avant ou après les taxes ?

#### Quand utiliser Example Mapping ?

- **Avant le Sprint Planning** : pour affiner les stories
- **Pendant le Refinement** : pour clarifier les exigences
- **Quand une story est floue** : pour la rendre concrète
- **Pour les règles métier complexes** : pour les expliciter

#### Durée recommandée

- **Maximum 25 minutes** par story
- Si plus long → la story est trop grosse ou trop complexe
- Mieux vaut plusieurs sessions courtes qu'une longue

#### Résultats attendus

1. **Scénarios Gherkin** prêts à être automatisés
2. **Compréhension partagée** de la fonctionnalité
3. **Liste de questions** à résoudre
4. **Décision** : prêt / pas prêt / à découper

#### Exemple de transformation en Gherkin

À partir de l'Example Mapping, on peut créer :

```gherkin
Feature: Réductions sur les achats

  Rule: Les clients fidèles bénéficient de 10% de réduction

    Scenario: Client fidèle effectue un achat
      Given je suis un client fidèle
      When j'achète pour 50€ de produits
      Then je paie 45€

    Scenario: Client non-fidèle effectue un achat
      Given je suis un client non-fidèle
      When j'achète pour 50€ de produits
      Then je paie 50€

  Rule: Réduction de 5% sur les achats supérieurs à 100€

    Scenario: Achat supérieur à 100€
      Given je suis un client non-fidèle
      When j'achète pour 150€ de produits
      Then je bénéficie d'une réduction de 7,50€
      And je paie 142,50€
```

### 3.2 Three Amigos (Les Trois Amigos)

#### Qu'est-ce que les Three Amigos ?

Les **Three Amigos** est une pratique de **collaboration** issue de l'**Agile** et du **BDD (Behavior-Driven
Development)**. Elle réunit trois perspectives différentes pour affiner une user story avant son développement.

#### Les trois rôles

1. **👔 Business (Product Owner / Business Analyst)** :
    - Apporte la **vision métier**
    - Définit la **valeur** de la fonctionnalité
    - Priorise les **cas d'usage**
    - Répond : "**Pourquoi** cette fonctionnalité ?"

2. **💻 Development (Développeur)** :
    - Apporte la **perspective technique**
    - Identifie les **contraintes** et **opportunités**
    - Propose des **solutions** d'implémentation
    - Répond : "**Comment** implémenter cela ?"

3. **🧪 Testing (Testeur / QA)** :
    - Apporte la **perspective qualité**
    - Pense aux **cas limites** et **scénarios d'erreur**
    - Définit les **critères d'acceptation**
    - Répond : "**Qu'est-ce qui pourrait mal se passer** ?"

#### Objectifs

1. **Compréhension partagée** de la fonctionnalité
2. **Identification précoce** des problèmes potentiels
3. **Réduction des allers-retours** pendant le développement
4. **Meilleure qualité** des spécifications
5. **Collaboration** entre les disciplines

#### Processus

**1. Préparation (avant la réunion)** :

- Le PO prépare la user story
- Partage la story avec l'équipe 24h avant
- Chacun réfléchit aux questions et scénarios

**2. Réunion (30-45 min par story)** :

**Phase 1 - Présentation (5-10 min)** :

- Le Business présente la story et sa valeur
- Contexte métier et objectifs
- Utilisateurs cibles

**Phase 2 - Questions et clarifications (10-15 min)** :

- Development pose des questions techniques
- Testing pose des questions sur les cas limites
- Tous clarifient les ambiguïtés

**Phase 3 - Exemples et scénarios (15-20 min)** :

- Création d'exemples concrets (Example Mapping)
- Identification des scénarios de test
- Rédaction des critères d'acceptation

**Phase 4 - Conclusion (5 min)** :

- Résumé de la compréhension commune
- Liste des actions à mener
- Décision : prêt ou pas prêt

#### Exemple concret : Fonctionnalité de connexion

**👔 Business :**

- "Les utilisateurs doivent pouvoir se connecter avec email et mot de passe"
- "C'est important pour la sécurité et la personnalisation"
- "On veut aussi permettre la connexion via Google"

**💻 Development :**

- "Quelle est la politique de mot de passe ? (longueur, complexité)"
- "Combien de tentatives avant blocage ?"
- "Durée de la session ?"
- "Comment gérer le 'Se souvenir de moi' ?"

**🧪 Testing :**

- "Que se passe-t-il si l'email n'existe pas ?"
- "Que se passe-t-il si le mot de passe est incorrect ?"
- "Que se passe-t-il après 3 tentatives échouées ?"
- "Comment tester la connexion Google en environnement de test ?"

**Résultat - Scénarios identifiés :**

```gherkin
Scenario: Connexion réussie
Given un utilisateur avec email "user@example.com" et mot de passe "Pass123!"
When il entre ses identifiants corrects
Then il est connecté
And il est redirigé vers le tableau de bord

Scenario: Mot de passe incorrect
Given un utilisateur avec email "user@example.com"
When il entre un mot de passe incorrect
Then il voit un message "Identifiants incorrects"
And il peut réessayer

Scenario: Blocage après 3 tentatives
Given un utilisateur a échoué 2 fois
When il échoue une 3ème fois
Then son compte est temporairement bloqué pour 15 minutes
And il reçoit un email de notification
```

#### Bonnes pratiques

1. **Limiter la durée** : maximum 45 minutes
2. **Rester focalisé** : une story à la fois
3. **Tous participent** : pas de spectateurs
4. **Documenter** : capturer les décisions et scénarios
5. **Suivre** : s'assurer que les questions sont résolues

#### Variantes

- **Two Amigos** : si pas de testeur dédié, le développeur prend ce rôle
- **Four Amigos** : ajouter un UX designer pour les fonctionnalités d'interface
- **Remote Amigos** : utiliser des outils collaboratifs en ligne (Miro, Mural)

### 3.3 Event Modeling

#### Qu'est-ce que l'Event Modeling ?

**Event Modeling** est une technique de **modélisation de systèmes** créée par **Adam Dymitruk** en **2018**. Elle
combine des éléments d'**Event Storming**, de **spécifications par l'exemple**, et de **modélisation UML** pour créer
une vue complète d'un système.

#### Objectifs

1. **Modéliser le système complet** de bout en bout
2. **Créer une compréhension partagée** entre toutes les parties prenantes
3. **Identifier les événements métier** importants
4. **Définir les interfaces utilisateur** et les flux de données
5. **Servir de spécification** pour le développement

#### Concepts clés

**1. Les Événements (Events)** :

- Représentent des **faits passés** dans le système
- Nommés au **passé** : "CommandePassée", "PaiementEffectué"
- Immuables : une fois qu'ils se sont produits, ils ne changent pas
- Couleur : **Orange**

**2. Les Commandes (Commands)** :

- Représentent des **intentions** d'action
- Nommées à l'**impératif** : "PasserCommande", "EffectuerPaiement"
- Peuvent échouer (contrairement aux événements)
- Couleur : **Bleu**

**3. Les Vues (Views/Read Models)** :

- Représentent les **données affichées** à l'utilisateur
- Construites à partir des événements
- Couleur : **Vert**

**4. Les Politiques/Règles (Policies)** :

- Réactions **automatiques** à des événements
- "Quand X se produit, alors faire Y"
- Couleur : **Violet**

#### Structure d'un Event Model

Un Event Model se lit de **gauche à droite** et de **haut en bas**, comme une bande dessinée :

```
[Vue] → [Commande] → [Événement] → [Vue] → [Commande] → ...
```

#### Processus de création

**1. Brainstorming des événements (30-60 min)** :

- Identifier tous les événements métier importants
- Les placer sur une timeline
- Pas de jugement, tout est capturé

**2. Organisation chronologique (30 min)** :

- Ordonner les événements dans le temps
- Identifier les flux principaux
- Regrouper les événements liés

**3. Ajout des commandes (30 min)** :

- Pour chaque événement, identifier la commande qui le déclenche
- Placer les commandes avant les événements

**4. Ajout des vues (30 min)** :

- Identifier les informations nécessaires pour chaque commande
- Créer les vues (écrans, rapports) qui affichent ces informations

**5. Ajout des politiques (30 min)** :

- Identifier les réactions automatiques
- Connecter les événements aux commandes automatiques

**6. Validation et raffinement (30 min)** :

- Vérifier la cohérence du modèle
- Identifier les trous et les incohérences
- Affiner les détails

#### Exemple concret : Système de commande en ligne

**Timeline des événements :**

```
1. [Vue: Catalogue]
   → [Commande: AjouterAuPanier]
   → [Événement: ArticleAjoutéAuPanier]

2. [Vue: Panier]
   → [Commande: PasserCommande]
   → [Événement: CommandePassée]

3. [Politique: NotifierEntrepôt]
   → [Commande: PréparerColis]
   → [Événement: ColisPreparé]

4. [Vue: SuiviCommande]
   → [Commande: ExpédierColis]
   → [Événement: ColisExpédié]

5. [Politique: NotifierClient]
   → [Événement: EmailEnvoyé]

6. [Vue: SuiviLivraison]
   → [Événement: ColisLivré]
```

#### Notation visuelle

```
┌─────────────┐
│    VUE      │  (Vert)
│  Catalogue  │
└─────────────┘
      ↓
┌─────────────┐
│  COMMANDE   │  (Bleu)
│ AjouterAu   │
│   Panier    │
└─────────────┘
      ↓
┌─────────────┐
│ ÉVÉNEMENT   │  (Orange)
│  ArticleAjouté │
│   AuPanier  │
└─────────────┘
      ↓
┌─────────────┐
│    VUE      │  (Vert)
│   Panier    │
└─────────────┘
```

#### Avantages de l'Event Modeling

1. **Communication** :
    - Langage visuel compréhensible par tous
    - Pas besoin de connaissances techniques
    - Facilite les discussions

2. **Spécification complète** :
    - Couvre l'UI, la logique métier, et les données
    - Sert de documentation vivante
    - Base pour les tests d'acceptation

3. **Détection précoce des problèmes** :
    - Incohérences visibles rapidement
    - Flux manquants identifiés
    - Règles métier clarifiées

4. **Facilite l'implémentation** :
    - Architecture Event-Driven naturelle
    - CQRS (Command Query Responsibility Segregation) évident
    - Event Sourcing possible

#### Outils

- **Papier et post-its** : approche traditionnelle
- **Miro / Mural** : tableaux blancs en ligne
- **EventModeling.org** : outil dédié
- **Lucidchart / Draw.io** : outils de diagrammes

#### Quand utiliser Event Modeling ?

- **Nouveaux projets** : pour définir l'architecture
- **Systèmes complexes** : pour comprendre les flux
- **Refonte** : pour modéliser l'existant et le futur
- **Communication** : pour aligner les équipes

### 3.4 Autres rituels importants

#### Pair Programming (Programmation en binôme)

**Définition :** Deux développeurs travaillent ensemble sur le même code, sur le même ordinateur.

**Rôles :**

- **Driver (Conducteur)** : écrit le code
- **Navigator (Navigateur)** : réfléchit à la stratégie, revoit le code, pense aux cas limites

**Rotation :** Changer de rôle toutes les 15-30 minutes

**Avantages :**

- Qualité du code améliorée
- Moins de bugs
- Partage de connaissances
- Onboarding des nouveaux
- Décisions de design meilleures

**Bonnes pratiques :**

- Communiquer constamment
- Respecter le rythme de l'autre
- Faire des pauses régulières
- Alterner les binômes

#### Mob Programming (Programmation en groupe)

**Définition :** Toute l'équipe travaille sur le même problème, sur le même écran.

**Rôles :**

- **Driver** : tape le code (change toutes les 10-15 min)
- **Navigators** : le reste de l'équipe guide le driver

**Avantages :**

- Connaissance partagée maximale
- Décisions collectives
- Pas de code reviews nécessaires
- Apprentissage accéléré

**Quand l'utiliser :**

- Problèmes complexes
- Décisions architecturales importantes
- Onboarding d'équipe
- Résolution de bugs critiques

#### Code Reviews (Revues de code)

**Définition :** Examen systématique du code par les pairs avant intégration.

**Objectifs :**

- Détecter les bugs
- Améliorer la qualité
- Partager les connaissances
- Maintenir les standards

**Bonnes pratiques :**

1. **Petites Pull Requests** : < 400 lignes
2. **Contexte clair** : description, liens, captures d'écran
3. **Feedback constructif** : suggérer, ne pas imposer
4. **Rapidité** : reviewer dans les 24h
5. **Automatisation** : linters, tests automatiques d'abord

**Checklist de review :**

- [ ] Le code fait-il ce qu'il est censé faire ?
- [ ] Les tests sont-ils présents et pertinents ?
- [ ] Le code est-il lisible et maintenable ?
- [ ] Y a-t-il des cas limites non gérés ?
- [ ] Les noms sont-ils explicites ?
- [ ] Y a-t-il de la duplication ?
- [ ] Les dépendances sont-elles appropriées ?

#### Retrospectives

**Définition :** Réunion régulière (fin de sprint) pour réfléchir sur le processus et s'améliorer.

**Format classique :**

1. **What went well?** (Qu'est-ce qui s'est bien passé ?)
2. **What didn't go well?** (Qu'est-ce qui ne s'est pas bien passé ?)
3. **What can we improve?** (Que pouvons-nous améliorer ?)

**Autres formats :**

- **Start, Stop, Continue** : Commencer à faire, Arrêter de faire, Continuer à faire
- **Sailboat** : Vent (ce qui nous pousse), Ancre (ce qui nous retient), Rochers (risques)
- **4Ls** : Liked, Learned, Lacked, Longed for

**Règles d'or :**

- Bienveillance et sécurité psychologique
- Focus sur le processus, pas les personnes
- Actions concrètes à la fin
- Suivi des actions du sprint précédent

#### Refinement Sessions (Affinage du backlog)

**Définition :** Réunions régulières pour préparer les user stories du prochain sprint.

**Activités :**

- Clarifier les stories
- Estimer la complexité
- Découper les grosses stories
- Identifier les dépendances
- Prioriser le backlog

**Participants :**

- Product Owner
- Équipe de développement
- Scrum Master (facilitateur)

**Durée :** 5-10% du temps du sprint (ex: 4h pour un sprint de 2 semaines)



---

## 4. Matériaux de référence et aide-mémoire

### 4.1 Résumé des principes du Software Craftsmanship (une page)

#### Les 4 valeurs du Manifeste

| Valeur                           | Signification            | Application pratique                      |
|----------------------------------|--------------------------|-------------------------------------------|
| **Logiciels bien conçus**        | Au-delà du "ça marche"   | Clean Code, SOLID, refactoring continu    |
| **Ajout constant de valeur**     | Amélioration continue    | Boy Scout Rule, dette technique gérée     |
| **Communauté de professionnels** | Partage et apprentissage | Coding Dojos, pair programming, mentoring |
| **Partenariats productifs**      | Collaboration profonde   | Example Mapping, Three Amigos, confiance  |

#### Principes techniques essentiels

**SOLID :**

- **S**ingle Responsibility : une classe, une raison de changer
- **O**pen/Closed : ouvert à l'extension, fermé à la modification
- **L**iskov Substitution : les sous-types sont substituables
- **I**nterface Segregation : interfaces spécifiques > interface générale
- **D**ependency Inversion : dépendre d'abstractions, pas de concrétions

**Autres principes :**

- **KISS** : Keep It Simple, Stupid
- **DRY** : Don't Repeat Yourself
- **YAGNI** : You Aren't Gonna Need It
- **Boy Scout Rule** : laisser le code plus propre qu'on ne l'a trouvé

#### Pratiques quotidiennes

✅ **Faire systématiquement :**

- TDD (Test-Driven Development)
- Refactoring opportuniste
- Code reviews
- Pair programming (régulièrement)
- Intégration continue
- Documentation du "pourquoi", pas du "comment"

❌ **Éviter absolument :**

- Commiter du code non testé
- Ignorer la dette technique
- Coder sans comprendre le besoin
- Optimisation prématurée
- Commentaires qui expliquent le code (le code doit s'expliquer lui-même)

### 4.2 Guide pas-à-pas : Example Mapping

#### Préparation (5 min)

```
Matériel nécessaire :
□ Post-its de 4 couleurs (jaune, bleu, vert, rouge)
□ Surface de travail (table, mur, tableau blanc)
□ Participants : PO, Dev, Testeur (3-5 personnes max)
□ Timer (25 min maximum)
```

#### Étapes

**1️⃣ Poser la User Story (1 min)**

```
┌─────────────────────────────────┐
│  🟡 USER STORY (Jaune)          │
│  En tant que [rôle]             │
│  Je veux [action]               │
│  Afin de [bénéfice]             │
└─────────────────────────────────┘
```

**2️⃣ Identifier les Règles métier (10 min)**

```
🟡 User Story
    ↓
🔵 Règle 1    🔵 Règle 2    🔵 Règle 3
```

**3️⃣ Donner des Exemples (10 min)**

```
🟡 User Story
    ↓
🔵 Règle 1
    ↓
🟢 Exemple 1.1    🟢 Exemple 1.2    🟢 Exemple 1.3
```

**4️⃣ Noter les Questions (3 min)**

```
🔴 Question 1 : Qui va chercher la réponse ?
🔴 Question 2 : Deadline pour la réponse ?
```

**5️⃣ Décider (1 min)**

```
✅ Prêt → Sprint Planning
⚠️  Trop de 🔴 → Reporter
⚠️  Trop de 🔵 → Découper
```

#### Signaux d'alerte

| Signal               | Signification          | Action                        |
|----------------------|------------------------|-------------------------------|
| > 5 cartes rouges    | Trop d'incertitudes    | Reporter la story             |
| > 8 cartes bleues    | Story trop grosse      | Découper en plusieurs stories |
| > 25 minutes         | Complexité excessive   | Revoir le scope               |
| Pas d'exemples verts | Règles trop abstraites | Demander des cas concrets     |

### 4.3 Template : Session Three Amigos

#### Avant la session

**Invitation (à envoyer 24h avant) :**

```
📅 Three Amigos Session
🕐 Durée : 30-45 min
👥 Participants : [PO], [Dev], [QA]
📋 Story : [Titre et lien]

Préparation :
- Lire la user story
- Noter vos questions
- Penser aux cas limites
```

#### Pendant la session

**Agenda (45 min) :**

| Temps     | Phase      | Activité                 | Responsable |
|-----------|------------|--------------------------|-------------|
| 0-5 min   | Intro      | Présentation de la story | PO          |
| 5-15 min  | Questions  | Clarifications           | Tous        |
| 15-35 min | Exemples   | Example Mapping          | Tous        |
| 35-40 min | Scénarios  | Rédaction Gherkin        | QA + Dev    |
| 40-45 min | Conclusion | Décision et actions      | PO          |

**Template de notes :**

```markdown
# Three Amigos - [Nom de la Story]

## Participants

- 👔 Business : [Nom]
- 💻 Dev : [Nom]
- 🧪 QA : [Nom]

## Contexte métier

[Pourquoi cette fonctionnalité ? Quelle valeur ?]

## Règles métier identifiées

1. [Règle 1]
2. [Règle 2]
3. [Règle 3]

## Scénarios d'acceptation

```gherkin
Scenario: [Nom du scénario]
  Given [contexte]
  When [action]
  Then [résultat attendu]
```

## Questions ouvertes

- [ ] [Question 1] - Responsable : [Nom] - Deadline : [Date]
- [ ] [Question 2] - Responsable : [Nom] - Deadline : [Date]

## Décision

□ Prêt pour le développement
□ Nécessite plus d'informations
□ À découper en plusieurs stories

## Actions

- [ ] [Action 1] - Responsable : [Nom]
- [ ] [Action 2] - Responsable : [Nom]

### 4.4 Notation Event Modeling

#### Symboles et couleurs

| Élément       | Couleur   | Forme     | Exemple              |
|---------------|-----------|-----------|----------------------|
| **Événement** | 🟧 Orange | Rectangle | "CommandePassée"     |
| **Commande**  | 🟦 Bleu   | Rectangle | "PasserCommande"     |
| **Vue**       | 🟩 Vert   | Rectangle | "Catalogue produits" |
| **Politique** | 🟪 Violet | Rectangle | "NotifierClient"     |
| **Acteur**    | 🟨 Jaune  | Bonhomme  | "Client", "Admin"    |

#### Conventions de nommage

**Événements (passé) :**

- ✅ "CommandePassée", "PaiementEffectué", "EmailEnvoyé"
- ❌ "PasserCommande", "EffectuerPaiement", "EnvoyerEmail"

**Commandes (impératif) :**

- ✅ "PasserCommande", "EffectuerPaiement", "EnvoyerEmail"
- ❌ "CommandePassée", "PaiementEffectué", "EmailEnvoyé"

**Vues (nom) :**

- ✅ "Catalogue", "Panier", "Historique des commandes"
- ❌ "AfficherCatalogue", "VoirPanier"

#### Template de flux

```
┌──────────┐
│  Acteur  │ (Jaune)
└────┬─────┘
     │
     ↓
┌──────────┐
│   Vue    │ (Vert) - Ce que voit l'utilisateur
└────┬─────┘
     │
     ↓
┌──────────┐
│ Commande │ (Bleu) - Action de l'utilisateur
└────┬─────┘
     │
     ↓
┌──────────┐
│Événement │ (Orange) - Ce qui s'est passé
└────┬─────┘
     │
     ↓
┌──────────┐
│ Politique│ (Violet) - Réaction automatique (optionnel)
└────┬─────┘
     │
     ↓
┌──────────┐
│ Commande │ (Bleu) - Action automatique
└────┬─────┘
     │
     ↓
┌──────────┐
│Événement │ (Orange)
└──────────┘
```

### 4.5 Checklist des pratiques Craftsmanship

#### Quotidien

**Avant de coder :**

- [ ] Je comprends le besoin métier
- [ ] J'ai clarifié les cas limites
- [ ] Je sais comment tester cette fonctionnalité
- [ ] J'ai vérifié s'il existe du code similaire

**Pendant le codage :**

- [ ] J'écris les tests en premier (TDD)
- [ ] Je fais des commits atomiques et fréquents
- [ ] Je refactore au fur et à mesure
- [ ] Je respecte les conventions du projet
- [ ] Je garde les fonctions courtes (< 20 lignes)
- [ ] Je nomme explicitement variables et fonctions

**Après le codage :**

- [ ] Tous les tests passent
- [ ] Le code est formaté automatiquement
- [ ] J'ai supprimé le code commenté
- [ ] J'ai mis à jour la documentation si nécessaire
- [ ] Je peux expliquer chaque ligne de code
- [ ] Je suis fier de montrer ce code

#### Hebdomadaire

- [ ] Participation à au moins une code review
- [ ] Session de pair programming
- [ ] Lecture d'un article technique
- [ ] Partage d'une découverte avec l'équipe
- [ ] Remboursement de dette technique

#### Mensuel

- [ ] Participation à un Coding Dojo ou Kata
- [ ] Lecture d'un chapitre de livre technique
- [ ] Contribution open source ou side project
- [ ] Rétrospective d'équipe
- [ ] Mise à jour des compétences (nouvelle techno, outil, pratique)

### 4.6 Liste de lecture recommandée

#### Fondamentaux (Must Read)

**2008** - **"Clean Code"** par Robert C. Martin

- Le livre fondateur du mouvement Craftsmanship
- Principes de code lisible et maintenable
- Exemples concrets en Java (applicable à tous les langages)

**2010** - **"The Clean Coder"** par Robert C. Martin

- Professionnalisme et éthique du développeur
- Gestion du temps et des priorités
- Comment dire "non" et estimer honnêtement

**2013** - **"The Software Craftsman"** par Sandro Mancuso

- Vision moderne du Craftsmanship
- Culture d'équipe et d'entreprise
- Carrière et évolution professionnelle

#### Pratiques techniques

**1999** - **"Refactoring"** par Martin Fowler

- Catalogue de refactorings
- Quand et comment refactorer
- Édition 2019 avec JavaScript

**2002** - **"Test Driven Development: By Example"** par Kent Beck

- Introduction au TDD
- Exemples pas-à-pas
- Philosophie du test-first

**2004** - **"Working Effectively with Legacy Code"** par Michael Feathers

- Techniques pour améliorer le code existant
- Mise en place de tests sur code legacy
- Stratégies de refactoring sécurisé

#### Architecture et design

**2016** - **"Clean Architecture"** par Robert C. Martin

- Principes architecturaux
- Indépendance des frameworks
- SOLID à l'échelle système

**2003** - **"Domain-Driven Design"** par Eric Evans

- Modélisation du domaine métier
- Ubiquitous Language
- Bounded Contexts

**2017** - **"Domain-Driven Design Distilled"** par Vaughn Vernon

- Version condensée et accessible du DDD
- Focus sur les concepts essentiels
- Exemples modernes

#### Pratiques d'équipe

**2018** - **"Accelerate"** par Nicole Forsgren, Jez Humble, Gene Kim

- Validation scientifique des pratiques DevOps
- Métriques de performance
- Culture d'équipe haute performance

**2013** - **"Continuous Delivery"** par Jez Humble et David Farley

- Pipeline de déploiement automatisé
- Tests et qualité
- Culture DevOps

#### Développement moderne

**2023** - **"The Programmer's Brain"** par Felienne Hermans

- Neurosciences appliquées au code
- Comment apprendre efficacement
- Lecture et compréhension du code

**2022** - **"Tidy First?"** par Kent Beck

- Micro-refactorings
- Quand refactorer, quand ne pas refactorer
- Approche pragmatique

**2021** - **"Modern Software Engineering"** par Dave Farley

- Ingénierie logicielle contemporaine
- Pratiques adaptées au monde moderne
- Continuous Delivery et DevOps

#### Classiques intemporels

**1999** - **"The Pragmatic Programmer"** par Andrew Hunt et David Thomas

- Conseils pratiques pour développeurs
- Philosophie du développeur artisan
- Édition 2019 mise à jour

**1994** - **"Design Patterns"** par Gang of Four

- Catalogue de patterns de conception
- Solutions réutilisables
- Référence incontournable

### 4.7 Ressources en ligne

#### Blogs et sites

- **martinfowler.com** - Martin Fowler (architecture, refactoring, patterns)
- **blog.cleancoder.com** - Robert C. Martin (craftsmanship, professionnalisme)
- **codurance.com/publications** - Sandro Mancuso et équipe (craftsmanship)
- **refactoring.guru** - Patterns et refactoring illustrés
- **exercism.org** - Exercices de code avec mentoring

#### Vidéos et conférences

- **Clean Code** (série de vidéos) - Robert C. Martin
- **GOTO Conferences** - Chaîne YouTube avec talks de qualité
- **NDC Conferences** - Conférences développeurs
- **Craft Conf** - Conférence Software Craftsmanship

#### Podcasts

- **Software Engineering Radio** - Discussions techniques approfondies
- **The Changelog** - Actualités du développement
- **Coding Blocks** - Pratiques et patterns

#### Communautés

- **Software Craftsmanship Slack/Discord** - Communautés internationales
- **Meetups locaux** - Coding Dojos, talks, networking
- **Conferences** - SoCraTes, NewCrafts, Craft Conf

---

## Conclusion

Le **Software Craftsmanship** n'est pas une mode passagère, c'est une **philosophie professionnelle** qui a évolué sur
plus de 25 ans. Des origines avec Kent Beck et Extreme Programming en 1996, jusqu'aux pratiques modernes intégrant l'IA
en 2025, les principes fondamentaux restent les mêmes :

✨ **Excellence technique**
✨ **Amélioration continue**
✨ **Communauté et partage**
✨ **Partenariats productifs**

Les **rituels** comme Example Mapping, Three Amigos, et Event Modeling ne sont pas des processus bureaucratiques, mais
des **outils de collaboration** qui créent une compréhension partagée et réduisent les erreurs coûteuses.

En tant qu'ingénieur, même si vous ne devenez pas développeur professionnel, comprendre ces principes vous permettra
de :

- **Dialoguer efficacement** avec les équipes de développement
- **Prototyper** vos propres solutions avec qualité
- **Évaluer** la qualité d'un logiciel
- **Contribuer** aux décisions techniques

Le Craftsmanship, c'est avant tout une **attitude** : la fierté du travail bien fait, le respect des utilisateurs, et
l'engagement envers l'excellence. C'est cette attitude qui fait la différence entre un code qui fonctionne et un code
dont on peut être fier.

---

**"Any fool can write code that a computer can understand. Good programmers write code that humans can understand."**
— Martin Fowler

**"The only way to go fast, is to go well."**
— Robert C. Martin
