# Master ITI : Créer avec l'IA, dialoguer avec les développeurs

Nantes Université, édition 2026. Cinq séances de 4 heures, 32 étudiants de Master orientés industrie et innovation, autour d'un projet fil rouge mené en équipe.

Ce document est le programme détaillé de la formation. Il fixe les séances, l'évaluation, la stack, le travail entre les séances, la conformité (RGPD et AI Act) et la préparation de l'enseignant. Les énoncés des trois thèmes du projet sont dans `cours/projets/themes.md` (section 9). Le module de sensibilisation à la conformité est dans `cours/conformite-ai-act-rgpd.md` (section 10).

Convention d'écriture : les identifiants de code Dart sont en `lowerCamelCase` (types en `UpperCamelCase`) et les fichiers en `snake_case` ; les noms de tables et de champs de la base sont en ASCII `snake_case` sans accent ; les textes de présentation sont accentués. Les mentions « (à vérifier) » signalent ce qui n'a pas été confirmé sur une source au moment de la rédaction.

---

## 1. Synopsis

### Objectif général

Les étudiants ne sont pas des développeurs et ne le deviendront pas. La formation vise deux compétences, qui se renforcent l'une l'autre.

1. **Échanger avec une équipe de développement.** Comprendre le vocabulaire (dépôt, branche, PR, test, CI/CD, migration, release), le cycle de vie d'un logiciel, ce que coûtent la qualité et la sécurité, et poser les bonnes questions sur les risques et les contraintes.
2. **Créer eux-mêmes, avec l'IA, un applicatif répondant à un besoin ponctuel.** Un outil jetable ou de courte durée de vie (une campagne de mesure, une saison, un trimestre), pas un produit industriel pérenne. L'IA le rend possible pour un non-développeur ; la formation apprend à le faire proprement, et surtout **à en connaître les limites**.

À la fin de la formation, chaque étudiant sait :
- expliquer en mots simples ce que fait une équipe de développement et pourquoi la qualité du code reste le facteur limitant, y compris quand on ne tape presque plus le code ;
- cadrer un agent de code (contexte, harnais, permissions, tests) pour qu'il respecte les contraintes d'un projet ;
- travailler proprement en équipe avec git et GitHub ;
- justifier ce qu'il livre : chacun peut expliquer n'importe quelle PR qu'il a ouverte ou approuvée ;
- reconnaître les limites légales et de sécurité d'un outil (RGPD, AI Act), **ne jamais le mettre en usage sans validation du RSSI** (et du DPO le cas échéant), et connaître ses droits de citoyen européen.

### Philosophie pédagogique

- **Un seul projet fil rouge.** Chaque séance ajoute un incrément visible au même dépôt. Il n'y a pas de TP jetable.
- **Apprendre en construisant, sans noyer des non-développeurs.** Les exposés restent courts et alternent avec la pratique. La formation est à dominante pratique. La théorie est volontairement courte et toujours reliée à un geste (installer, taper, commiter, relire). Les ateliers sont guidés par des fiches prêtes à copier : on n'attend pas d'eux qu'ils écrivent des fichiers de configuration de mémoire.
- **« Humans steer, agents execute. »** (formule de Ryan Lopopolo, OpenAI, 2026). L'humain fixe le cap, les contraintes et les critères d'acceptation ; l'agent exécute. Le harnais (contexte, règles, tests, permissions) est ce qui permet de lui faire confiance.
- **Comprendre ce qu'on livre.** L'IA amplifie l'expertise et les pratiques existantes, elle ne les remplace pas (Willison, « AI tools amplify existing expertise » ; rapport DORA 2025, « AI is an amplifier »). Règle d'or : chacun doit pouvoir expliquer n'importe quelle PR qu'il a ouverte ou approuvée.
- **Honnêteté sur les preuves.** L'essai contrôlé de METR (juillet 2025 ; 16 développeurs expérimentés ; 246 tâches) mesure un temps de réalisation **augmenté de 19 %**, alors que les développeurs pensaient l'avoir réduit de 20 %. L'étude a des limites (petit échantillon, outils du début de 2025, protocole revu par METR en février 2026) ; un contrepoint de Stanford évoque un gain net de l'ordre de 10 à 20 % (Denisov-Blanch ; à vérifier sur la source primaire). Conclusion pour des non-développeurs : ne pas se fier à son impression de vitesse, **mesurer** (temps estimé, temps réel, retouches dans chaque PR).
- **Le harnais avant l'autonomie.** Pas de plusieurs agents en parallèle ni d'exécution sans supervision tant que tests, règles et permissions ne sont pas en place. Chaque étudiant travaille avec **un seul agent, sur sa propre branche**.
- **La conformité n'est pas une option.** La règle d'or est posée dès S1 (aucune donnée personnelle ni confidentielle dans un prompt ni dans un dépôt public). Le RGPD est traité en S3, l'AI Act et la validation RSSI en S4, et une **fiche de conformité d'une page** fait partie du livrable et de la note (section 10).

### Public et dimensionnement

32 étudiants de Master, orientés industrie et innovation : chefs de projet, ingénieurs d'études ou de méthodes en devenir. Ils sont à l'aise avec les chiffres et la gestion de projet, pas avec le code. Git, les tests automatisés, la ligne de commande et le travail en PR sont **nouveaux** pour la plupart. Les niveaux seront hétérogènes (quelques-uns ont déjà programmé).

**Équipes de 3 à 5 étudiants.** Par défaut **8 équipes de 4**. Variante : 7 équipes (4 équipes de 5 et 3 équipes de 4). Une équipe de 3 est tolérée en cas d'absence ou d'abandon, mais n'est pas planifiée. La charge du projet ne change pas avec la taille de l'équipe : les rôles sont cumulés (3) ou complétés (5).

### Logistique à 32 : ce qui change par rapport à un petit groupe

| Sujet | Mesure |
|---|---|
| **Coaching** | 32 postes à dépanner en parallèle : un enseignant seul ne suffit pas. Prévoir **2 à 3 aides** (doctorants, étudiants de M2 ou anciens, collègues) pendant les séances S1 et S2, au moins 1 aide en S3 et 2 aides en S4, dont l'une tient une table RSSI (à demander dès maintenant ; à confirmer). Dans chaque équipe, un binôme d'entraide. |
| **Comptes et quotas Claude Code ×32** | Une décision de l'enseignant, **repoussée au lundi 5 octobre** (retour du pre-flight ; voir la checklist, section 13) : comptes ou crédits nominatifs avec plafond de dépense, suivi de consommation. **Plan de repli fixé dès maintenant** : binômes sur postes authentifiés. Le courriel pre-flight du 1er octobre annonce que les comptes seront confirmés avant le 5. **Jamais de clé d'API dans un dépôt** (les dépôts sont publics) |
| **Réseau** | 32 téléchargements lourds simultanés saturent un Wi-Fi de salle. Mesures : connexion filaire ou points d'accès supplémentaires si possible ; **échelonnement** (chaque quart de la salle démarre par un outil différent, puis échange par clé USB) ; miroir local des installeurs lourds sur clés USB ou partage réseau ; partage de connexion mobile en dernier recours |
| **Pre-flight** | Courriel envoyé le jeudi 1er octobre, retour attendu le lundi 5 octobre (section 4, S1). Il demande de créer un compte GitHub, d'installer VS Code et git, d'installer Google Chrome s'il ne l'est pas, et de **télécharger chez soi le SDK Flutter** ; WSL2 et Docker Desktop ne sont plus demandés (Docker devient optionnel). Il annonce que les comptes Claude Code seront confirmés au plus tard le lundi 5 octobre. Un étudiant sans retour est relancé individuellement |
| **Équipes et dépôts ×8** | Équipes, classement des trois thèmes et identifiants GitHub collectés **par formulaire** (identifiants GitHub dans le pre-flight, composition des équipes et classement à la fin de S1, formulaire clos le jeudi 8 octobre à 12h). L'enseignant prépare les **8 dépôts par script** (section 13) depuis le dépôt-modèle, avec protection de branche et `PROJET.md` pré-rempli par thème, et **ajoute les membres comme collaborateurs de chaque dépôt avant S2** (un seul mécanisme : pas d'invitation à l'organisation). En S2, on valide les équipes, on tire au sort en cas de litige et on libère du temps pour l'initialisation |
| **Salles** | Une salle avec tables d'équipe, vidéoprojecteur, prises en nombre suffisant (32 portables). En S5, **deux salles** (section 4) |
| **Postes** | Hypothèse : chacun vient avec son ordinateur portable personnel, avec droits d'administration (à confirmer). Sans droits d'administration, certaines installations (SDK Flutter, Docker) peuvent échouer (plan B en S1) |

---

## 2. Vue d'ensemble

| Séance | Date | Titre | Nature | Incrément du fil rouge |
|---|---|---|---|---|
| **S1** | mer. 7 oct. 2026 | Comprendre et s'équiper | Théorie et installations en alternance (installations : à prévoir large) | Aucun dépôt de projet. Bases du génie logiciel et de l'IA agentique, règle d'or comprise, poste opérationnel (Flutter compris) |
| **S2** | ven. 9 oct. 2026 | Git, configurer son agent, lancer le projet | Mise en pratique | Git pratiqué pour de bon ; Claude Code configuré ; 8 équipes validées, thèmes confirmés, dépôt cloné (squelette Flutter qui démarre : `flutter test`, `flutter run -d chrome`), `PROJET.md`, première PR relue |
| **S3** | mer. 2 déc. 2026 | Première user story, données et RGPD | Atelier | Première user story livrée en TDD et en BDD (Clean Architecture, BLoC), modèle de données drift et première migration avec test d'intégrité, début de la fiche de conformité, PR croisées (seed complet et garde d'accès par rôle : sprint ou début de S4) |
| **S4** | ven. 4 déc. 2026 | Qualité, CI/CD, sécurité, AI Act | Atelier | Test d'acceptation du clou (fichiers `.feature`), CI complète, build web publié sur GitHub Pages par chaque équipe, AI Act et passage devant le RSSI, audit croisé en 5 points ; release `v0.1` si `main` est verte |
| **Sprint** | 4 → 14 déc. | Finir le périmètre | Travail d'équipe hors séance (15 à 20 h) | Clou niveau 1 terminé, corrections de l'audit, fiche de conformité validée, tag `v1.0-rc` le lundi 14 déc. à 18h |
| **S5** | mer. 16 déc. 2026 | Retouches et soutenance | Soutenances en deux salles | Tag `v1.0`, dossier de rendu, soutenance avec démonstration et questions individuelles |

Rythme du calendrier : 2 jours entre S1 et S2, environ 8 semaines entre S2 et S3, 2 jours entre S3 et S4, 12 jours entre S4 et S5.

---

## 3. Fil conducteur pédagogique

### Progression logique

1. **Bloc « fondations » (S1 + S2, à 2 jours d'écart).** S1 donne les repères (pourquoi le craft, comment l'IA s'insère dans le cycle de développement, ce qu'est un test, ce qu'est le cloud) et équipe chaque poste (Flutter compris). S2 met les mains dans le clavier : git pour de bon, configuration de l'agent, puis lancement du projet. L'écart de 2 jours permet de terminer les installations sans perdre le fil.
2. **Le trou de 8 semaines.** Nous ne le combattons pas par du travail lourd : nous le préparons. Le dépôt (`CLAUDE.md`, `JOURNAL.md`, CI minimale, tag `s2-fin`) sert de mémoire du projet, et S3 commence par une vraie remise en route (section 5).
3. **Bloc « ingénierie d'équipe » (S3 + S4, à 2 jours d'écart).** S3 : première user story en TDD et en BDD, architecture en couches, données (modèle, migrations), RGPD, git en équipe. S4 : confiance et mise en usage (test d'acceptation indépendant, CI, publication du build web sur GitHub Pages, sécurité, AI Act, passage devant le RSSI, audit croisé).
4. **Sprint et soutenance (S5).** Finir, geler, prouver. On évalue ce que l'équipe et chacun comprennent.

### Pourquoi cet ordre

- La théorie précède la pratique de seulement deux jours : le vocabulaire (dépôt, commit, harnais, contexte) est réutilisé tout de suite en S2.
- Le git de base est en S2 (pas en S1, où les installations pèsent déjà lourd) ; S3 l'approfondit à plusieurs.
- Le RGPD vient avec les données (S3), l'AI Act et la validation RSSI avec la sécurité et la mise en usage (S4) : on ne qualifie un risque que sur un outil qui existe.
- Le sprint de 12 jours laisse du temps d'intégration et de réponse du RSSI avant le gel.

### Concepts clés et où ils sont vus

Légende : **I** = introduit, **A** = approfondi et pratiqué, **É** = évalué. Case vide : non traité dans la séance.

| Concept | S1 | S2 | S3 | S4 | S5 |
|---|---|---|---|---|---|
| Craft (histoire, pourquoi) | **I** | | | | É |
| Notions de code et TDD | **I** | A | **A** | A | É |
| Architecture propre, injection de dépendances, BLoC | | **I** | **A** | A | É |
| BDD (scénarios Gherkin, `bdd_widget_test`) | | | **I, A** | A (clou) | É |
| IA dans le SDLC (modèles, effort, harnais, contexte, cache, spec-driven) | **I** | **A** | A | A | É |
| Git de base (commit, branche, PR, conflit) | | **I, A** | A | | É |
| Git en équipe (revue croisée, conflits) | | A | **A** | A (audit) | É |
| Configuration de l'agent (CLAUDE.md, permissions, hooks, skills, MCP, plugins) | | **I, A** | A | A | É |
| Données (modèle, migrations, intégrité ; seed) | | | **I, A** | A (seed) | É |
| RGPD et droits des personnes | I (règle d'or) | | **I, A** | A (fiche) | É |
| AI Act et validation RSSI | | | | **I, A** | É |
| Qualité, test d'acceptation indépendant | | | I | **I, A** | É |
| CI/CD dans le cloud | I | | | **A** | É |
| Sécurité (secrets, injection, prompt injection, accès) | I (secrets) | I (permissions) | | **I, A** (dont rôles) | É |
| Travail en équipe (rôles, décisions, traçabilité) | | **I** | **A** | A | É |

---

## 4. Les cinq séances

**Principe de lecture : des blocs pondérés, pas un minutage.** On ne connaît ni le débit de parole de l'enseignant, ni les élèves, ni leur propension à poser des questions et à interrompre : le déroulé de chaque séance est donc une **liste ordonnée logiquement de blocs**, sans horaire ni durée. Chaque bloc porte un **niveau de poids**, qui dit quoi protéger et quoi sacrifier quand le rythme l'impose. Les pauses se placent au fil de la séance, selon la fatigue du groupe. Seule exception : le budget indicatif par équipe de la soutenance (S5), qui sert à dimensionner les salles et le jury, pas à minuter la séance.

**Échelle de poids** (définie ici une fois, rappelée en légende au début de chaque séance) :

| Poids | Sens |
|---|---|
| **Indispensable** | Le cœur de la séance : à ne pas sacrifier. |
| **Important** | À traiter sauf contrainte forte. |
| **Pratique** | Utile et appréciable : à traiter si le rythme le permet, ou à donner en ressource. |
| **Moins utile** | Peut sauter sans regret, ou être laissé en lecture. |

Chaque bloc indique aussi sa **nature** : exposé, démonstration, atelier, installation ou discussion. Un bloc contient parfois des éléments de poids différents : le poids du bloc est alors précisé élément par élément. Pour chaque séance, la rubrique **« Si la séance prend du retard »** donne ce qui se coupe en premier (dans l'ordre moins utile, puis pratique), et la rubrique **« Peut glisser »** ce qui est déjà prévu pour le sprint ou la séance suivante.

*À ne pas confondre :* la liste d'outils « indispensable » / « utile plus tard » de S1 classe des logiciels à installer, pas des blocs de séance.

**Rôles d'équipe** (à partir de S2, définis par thème dans `cours/projets/themes.md`) :
- 3 membres : **gardien produit et conformité** (`PROJET.md`, cas d'acceptation, fiche de conformité) ; **gardien des données** (modèle, migrations, seed) ; **gardien du harnais et de la CI** (`CLAUDE.md`, permissions, GitHub Actions).
- 4 membres : les trois rôles ci-dessus, avec un **gardien conformité** distinct (fiche, pseudonymisation, contact avec le RSSI).
- 5 membres : les quatre rôles, plus un **gardien de la démonstration** (README testé à froid, jeu de données de soutenance).
- Dans tous les cas, chacun relit au moins une PR d'un autre.

---

### Séance 1 : Comprendre et s'équiper (mer. 7 oct.)

**Principe.** La séance **alterne théorie et installations**, sans minutage. Les installations pèsent lourd dans cette séance : **à prévoir large**. Elles sont réparties en cinq blocs, intercalés entre les exposés. Les installations lourdes (SDK Flutter en priorité, puis Docker, Rust, Antigravity) sont **lancées pendant les exposés** : un téléchargement qui tourne pendant qu'on écoute ne coûte pas de temps de séance, si bien que le temps réel d'installation dépasse ce que les blocs laissent voir. Il n'y a **aucun travail sur le dépôt du projet** : l'objectif est un poste prêt et un vocabulaire commun. Le support est un diaporama étoffé (environ 76 diapos) ; les trois thèmes du projet n'y sont pas présentés (support à part).

**Objectifs d'apprentissage.** La séance poursuit deux objectifs. À la fin de la séance, l'étudiant :
1. a acquis les **connaissances théoriques sur les bases du génie logiciel et de l'IA agentique** :
   - situe neuf jalons de l'histoire du génie logiciel (de la crise du logiciel de 1968 à Git, la livraison continue et DORA, en passant par la dette technique, XP et le TDD, l'Agile, le Domain-Driven Design, le BDD et le craft) et dit pourquoi le craft répond à des problèmes récurrents ;
   - lit un test simple (en Dart) et explique le cycle « test rouge, code vert, refactor » (TDD) ;
   - distingue petit et grand modèle (SLM, LLM), les types de modèles, le niveau d'effort, l'IA embarquée (edge AI), et explique ce qu'est un harnais, le contexte, le cache de prompt et le spec-driven development ;
   - explique ce que sont l'intégration continue et la livraison continue (CI/CD) dans le cloud ;
   - énonce la **règle d'or** : aucune donnée personnelle ni confidentielle dans un prompt ni dans un dépôt public ;
2. dispose d'un **poste opérationnel pour démarrer un projet**. **Indispensable** (pour S2) : git et GitHub (`gh`), VS Code, Claude Code (avec Claude Desktop), Flutter (`flutter doctor`, `flutter test` sur le projet d'exemple, `flutter run -d chrome`). **Utile plus tard** (peut glisser en S2 ou S4 sans bloquer) : Docker, Rust, Antigravity.

**Prérequis et matériel.** Retours du pre-flight (voir « Logistique propre à S1 » plus bas), miroir local des installeurs (SDK Flutter en premier), fiches d'installation par système, projet Flutter d'exemple (copie du squelette du dépôt-modèle, à produire, section 13), tableau de suivi des postes tenu au tableau par l'enseignant, diaporama étoffé (environ 76 diapos), aides présentes (section 1).

**Légende des poids :** **Indispensable** = ne pas sacrifier ; **Important** = sauf contrainte forte ; **Pratique** = si le rythme le permet, ou en ressource ; **Moins utile** = peut sauter ou rester en lecture.

**Déroulé (ordre logique des blocs).**

**Bloc 1. Accueil** · **Indispensable** · discussion
- *Contenu.* Objectifs de la formation (échanger avec une équipe de développement, créer un outil ponctuel avec l'IA, connaître les limites), calendrier, organisation de la séance, tableau de suivi des postes tenu au tableau par l'enseignant (une ligne par étudiant). **Affichage dès ce premier bloc de la liste « indispensable » (git + GitHub, VS Code, Claude Code avec Claude Desktop, Flutter) et « utile plus tard » (Docker, Rust, Antigravity).**
- *Intention.* Poser le cadre et les attentes, et prévenir dès le départ que Docker, Rust et Antigravity peuvent glisser sans bloquer S2.

**Bloc 2. Installation 1 : pre-flight et lancement des téléchargements lourds** · **Indispensable** pour le contrôle du pre-flight et le SDK Flutter ; **Pratique** pour le lancement des autres téléchargements lourds · installation
- *Contenu.* Contrôle des retours du pre-flight (compte GitHub, VS Code, git, Chrome, SDK Flutter téléchargé). Lancement **immédiat** des téléchargements lourds restants, échelonnés par quart de salle : **SDK Flutter en priorité**, puis Docker Desktop (optionnel, virtualisation à activer au besoin), Rust (`rustup`), Antigravity. Les outils « utiles plus tard » passent après les indispensables.
- *Intention.* Faire tourner les téléchargements en arrière-plan le plus tôt possible : pendant que ça télécharge, on passe à l'exposé.

**Bloc 3. Histoire du craft : neuf jalons** · **Important** · exposé
- *Contenu.* (1) 1968 : crise du logiciel et naissance du terme « software engineering » (conférence OTAN) (à vérifier). (2) 1975-1986 : Brooks (*The Mythical Man-Month*, 1975 ; « No Silver Bullet », 1986) (à vérifier). (3) 1992 : la dette technique (Ward Cunningham) (à vérifier). (4) 1996-2002 : Extreme Programming et TDD (Kent Beck ; *Test-Driven Development by Example*, 2002) (à vérifier). (5) 2001 : Manifeste Agile (à vérifier). (6) 2003 : Domain-Driven Design (Eric Evans), qui inspire les couches de l'architecture du projet (à vérifier). (7) 2006 : BDD (Dan North, « Introducing BDD »), qui inspire les scénarios du projet (à vérifier). (8) 2001-2009 : le mouvement du craft et le Manifeste Software Craftsmanship (2009) (à vérifier). (9) 2005-2018 : Git (Torvalds, 2005), livraison continue et recherche DORA (à vérifier). Prolongement, hors des neuf jalons : 2025-2026, vibe coding (Karpathy, février 2025), augmented coding (Beck, 25 juin 2025), agentic engineering (Willison, 2025-2026). Fil rouge : on lit plus de code qu'on n'en écrit, donc la qualité compte plus, pas moins. *Les dates sont des repères classiques absents des dossiers sources : vérifier chacune avant de diffuser le diaporama.*
- *Intention.* Donner à un non-développeur le sens de « c'est testé, relu, versionné » et montrer que le craft répond à des problèmes récurrents.

**Bloc 4. Installation 2 : GitHub et Claude Code (avec Claude Desktop)** · **Indispensable** · installation
- *Contenu.* `gh auth login` (ou connexion GitHub dans VS Code, sans clé SSH) ; extension Claude Code dans VS Code ; installation de Claude Desktop ; connexion au compte ou crédit fourni ; premier `claude` lancé dans un dossier vide. Réglage de l'identité git : `git config user.email <id>+<login>@users.noreply.github.com` (les dépôts seront publics). Les téléchargements lourds continuent en arrière-plan.
- *Intention.* Obtenir les outils nécessaires dès S2 et protéger l'identité des étudiants dans des dépôts publics.

**Bloc 5. Quelques notions de code et le TDD** · **Indispensable** · exposé puis démonstration
- *Contenu.* D'abord le strict minimum pour lire un code : variable, fonction, condition, boucle, fichier, ligne de commande. Puis démonstration en direct avec l'agent, en Dart, sur une petite fonction `estReussite(int total, int dd)` : un test qui échoue (rouge), par exemple `test('réussite si total égal au dd', () { expect(estReussite(12, 12), isTrue); });` lancé avec `flutter test`, le code minimal qui le fait passer (vert), puis un test paramétré par une liste de cas et un nettoyage (refactor).
- *Intention.* Message : **un test, c'est une spécification exécutable** ; quand on ne sait pas lire le code, on peut lire les tests.

**Bloc 6. Installation 3 : Flutter** · **Indispensable** · installation
- *Contenu.* `flutter doctor` (Chrome suffit : la chaîne Android peut rester en rouge, elle n'est pas requise ; le bureau Windows, macOS ou Linux est optionnel, et sous Windows il demanderait Visual Studio : ne pas l'imposer) ; `flutter test` sur le projet d'exemple fourni ; `flutter run -d chrome`. Binômes d'entraide ; les aides circulent. Les échecs durables sont notés sur le tableau de suivi et traités au bloc de rattrapage ou en S2.
- *Intention.* Que chaque poste lance une application Flutter dans Chrome et un test : c'est la base de tout le projet fil rouge.

**Bloc 7. Les modèles d'IA** · **Important** · exposé
- *Contenu.* SLM (petits modèles de langage) et LLM (grands modèles) : taille, coût, vitesse, confidentialité. Types de modèles (généralistes, spécialisés code, raisonnement, multimodaux). **Niveau d'effort ou de raisonnement** : plus de réflexion donne souvent de meilleures réponses mais coûte plus de temps et de jetons (la commande exacte dépend de la version de l'outil, à vérifier). **Edge AI** : exécuter un modèle sur son poste ou sur un équipement, avec l'intérêt de la confidentialité (les données ne partent pas) et la limite de la puissance.
- *Intention.* Savoir choisir un modèle et un niveau d'effort en connaissant les compromis coût, vitesse et confidentialité.

**Bloc 8. L'agent et son environnement** · **Indispensable** · exposé
- *Contenu.* **Harnais** : un agent est un modèle plus un harnais (instructions, outils, permissions, tests). **Gestion de contexte** : la fenêtre de contexte est limitée, plus elle grossit plus l'agent perd le fil (context rot), d'où sessions courtes et un fichier d'instructions court (`CLAUDE.md`). **Cache de prompt** : la partie stable du début de la conversation est relue à tarif réduit tant qu'elle ne change pas (durée de vie courte : 5 minutes ou 1 heure selon l'offre, **à vérifier avant diffusion**) ; conséquence : ne pas réécrire sans cesse le début. **Spec-driven development** : écrire la spécification (l'intention et les critères d'acceptation) avant de demander le code, la spécification devenant le document de référence. Exemples d'outils : GitHub spec-kit, BMAD, AI-DLC d'AWS (voir `cours/sources/spec-driven.md` et `cours/sources/ai-dlc.md`). **Une diapo-synthèse d'une page** (« agent = modèle + harnais ») résume les quatre notions ; renvoi explicite à la pratique de S2, où tout est repris.
- *Intention.* Donner le modèle mental qui sert à toute la suite (S2 à S4) : l'agent, c'est le modèle et son harnais.

**Bloc 9. Installation 4 : Docker, Rust, Antigravity et test de fin** · **Indispensable** pour les lignes git, claude et flutter du test de fin ; les lignes docker et rustc sont **Pratique** ; la partie Antigravity est **Moins utile** · installation
- *Contenu.* `docker run hello-world` (Docker Desktop, optionnel) ; `rustc --version` et `cargo --version` ; extensions VS Code utiles (Dart et Flutter). **Test de fin** : `git --version`, `claude --version`, `flutter --version`, `flutter doctor`, puis `docker --version`, `rustc --version` et ouverture d'Antigravity. Chaque étudiant coche sa ligne du tableau de suivi. Antigravity : second environnement agentique, pour comparer (connexion et quotas à vérifier).
- *Intention.* Vérifier l'état réel de chaque poste, et laisser de côté sans regret Docker, Rust et le second outil si le temps manque.

**Bloc 10. CI/CD dans le cloud** · **Important** · exposé
- *Contenu.* Intégration continue : à chaque modification, une machine distante lance automatiquement les contrôles (analyse, tests). Livraison et déploiement continus : si c'est vert, le logiciel est publié automatiquement. Les mots à connaître : pipeline, runner, workflow, artefact (par exemple un build web), environnement (test, production). Illustration : un workflow GitHub Actions affiché à l'écran, une pastille verte et une rouge. Approfondi en S4 (CI complète, publication sur GitHub Pages).
- *Intention.* Donner le vocabulaire nécessaire à un échange avec une équipe de développement ; l'approfondissement vient en S4.

**Bloc 11. Teaser conformité : la règle d'or** · **Indispensable** · exposé
- *Contenu.* Pourquoi : tout texte envoyé dans un prompt part chez un tiers, souvent hors UE ; les dépôts de la formation sont publics, donc tout ce qui y entre est publié. Règle : **aucune donnée personnelle ni confidentielle dans un prompt ni dans un dépôt public** ; données fictives uniquement ; aucune clé ni mot de passe dans le dépôt. Annonce : S3 (RGPD), S4 (AI Act et validation RSSI), fiche de conformité d'une page évaluée. Chacun signe oralement la règle d'or.
- *Intention.* Faire de la règle d'or un réflexe avant tout usage de l'agent.

**Bloc 12. Installation 5 : rattrapage** · **Indispensable** pour git, VS Code, Claude Code et Flutter ; **Pratique** pour le reste · installation
- *Contenu.* Traitement des postes encore en rouge sur le tableau de suivi, par ordre de priorité : git, VS Code, Claude Code, Flutter (indispensables en S2), puis Docker, Rust, Antigravity (utiles plus tard). Postes sans solution : binôme sur le poste d'un voisin en S2, rendez-vous de dépannage pendant l'écart de deux jours.
- *Intention.* Arriver en S2 avec un poste opérationnel, ou un plan de rattrapage explicite.

**Bloc 13. Clôture** · **Indispensable** · discussion
- *Contenu.* Consignes de S2, **lancement du formulaire d'équipes** (composition de l'équipe de 3 à 5, identifiants GitHub, et côté formulaire seulement, classement des trois thèmes ; à remplir avant le jeudi 8 octobre à 12h), rappel de la règle d'or. Les thèmes ne sont pas présentés en séance : leurs énoncés font l'objet d'un support à part (`cours/projets/themes.md`), transmis avec le formulaire (modalité à confirmer).
- *Intention.* Préparer S2 : le formulaire conditionne la création des dépôts.

**Si la séance prend du retard (ordre de coupe, du moins utile au plus utile ; à poids égal, on coupe dans l'ordre listé).**
1. La partie Antigravity du bloc 9 (Moins utile).
2. Les lignes Docker et Rust du bloc 9 (Pratique) : à finir en S2 ou en S4, ou à la maison avec les fiches.
3. Dans le bloc 6, si `flutter doctor` ou le premier lancement de l'application sont lents : exiger d'abord `flutter doctor` sans erreur sur Chrome et `flutter test` ; `flutter run -d chrome` peut se finir au bloc 12 ou au bloc 1 de S2 (le poste est déclaré vert pour S2 dès `flutter test`).
4. Dans les exposés, alléger le bloc 7 (modèles d'IA) et le bloc 10 (CI/CD, repris en S4) en les donnant en partie comme ressource.
5. Le bloc 3 (histoire du craft, Important) se condense en une diapo plutôt qu'il ne saute, en gardant 1968, 1992, 1996-2002 (TDD) et 2006 (BDD), les cinq autres jalons étant donnés en ressource.

Ne se sacrifient jamais : l'accueil, les installations indispensables (git, VS Code, `gh`, Claude Code, Flutter), les notions de code et le TDD, le bloc « agent et environnement », la règle d'or, le rattrapage et la clôture avec le formulaire d'équipes.

**Peut glisser.** Docker, Rust et Antigravity glissent en S2 ou en S4 sans bloquer (déjà prévu). L'approfondissement de la CI/CD est de toute façon repris en S4.

**Livrable de fin de séance.** Un poste opérationnel (tableau de suivi tout au vert pour git, VS Code, GitHub, Claude Code, Flutter) et, pour chaque étudiant, la règle d'or comprise. L'enseignant dispose de la liste des postes à dépanner.

**Definition of done.**
- Chaque étudiant a `git`, VS Code, `gh` (ou connexion GitHub de VS Code), Claude Code et Flutter fonctionnels : `claude` répond dans un dossier vide, `flutter doctor` ne signale rien de bloquant pour Chrome, `flutter test` passe et `flutter run -d chrome` démarre le projet d'exemple (au plus tard au bloc 1 de S2).
- Docker, Rust et Antigravity sont installés, ou les échecs sont listés avec un plan de rattrapage.
- L'adresse noreply de GitHub est configurée (`git config user.email`).
- La règle d'or a été énoncée et reformulée par la salle.

**Logistique propre à S1 (32 postes).**
- **Pre-flight envoyé le jeudi 1er octobre, retour le lundi 5 octobre** : créer un compte GitHub, installer VS Code et `git`, installer Google Chrome s'il ne l'est pas, vérifier le système (Windows, macOS ou Linux, droits d'administration), **télécharger chez soi le SDK Flutter** et, si possible, les autres installeurs lourds (Rust, Antigravity, et Docker Desktop, désormais optionnel : plusieurs centaines de Mo, parfois plus d'un Go chacun, à vérifier), et renvoyer l'**identifiant GitHub** avec une capture de `git --version`. WSL2 et Docker Desktop ne sont plus demandés. Le courriel annonce que les comptes Claude Code seront confirmés au plus tard le lundi 5 octobre, que les dépôts seront publics (nom, PR et commits visibles) et rappelle la règle d'or.
- **Miroir local** des installeurs lourds (SDK Flutter en premier ; clés USB ou partage réseau), testé à froid. **Plan B** si l'installation échoue : binôme sur un poste fonctionnel, espace de développement dans le cloud préparé par l'enseignant (à vérifier), ou installation différée.
- **Aides** : 2 à 3 personnes en dépannage (section 1). Fiches d'installation par système, rédigées et testées à l'avance.
- Salle : réseau testé à charge réelle, prises en nombre suffisant, vidéoprojecteur. Diaporama étoffé (environ 76 diapos).

---

### Séance 2 : Git, configurer son agent, lancer le projet (ven. 9 oct.)

**Principe.** Trois temps : (1) **git pour de bon**, au clavier, dans un dépôt d'essai ; (2) **configuration de Claude Code**, individuelle, avec des fiches prêtes à copier ; (3) **initialisation des projets fil rouge** : validation des équipes et des thèmes, dépôt, `PROJET.md`, première PR relue. Les équipes et le classement des thèmes ont été **collectés par formulaire** (fin de S1, clos le jeudi 8 octobre à 12h) ; les huit dépôts sont **déjà créés par script** par l'enseignant (section 13), avec `PROJET.md` pré-rempli par thème, et les membres y sont **déjà ajoutés comme collaborateurs**. La séance valide, tire au sort en cas de litige et libère du temps pour l'initialisation.

**Objectifs d'apprentissage.** À la fin de la séance, l'étudiant :
1. réalise un cycle git complet au clavier : `init`, `add`, `commit`, `log`, branche, `push`, PR, et résout un conflit de fusion simple ;
2. configure Claude Code : `CLAUDE.md`, permissions (autoriser, refuser), mode plan, skill, hooks, plugins, MCP, sous-agents, et sait citer un cadre de travail de type spec-kit ;
3. explique pourquoi une consigne dans le prompt ne suffit pas et pourquoi une permission configurée si ;
4. fait partie d'une équipe validée, a un thème confirmé selon la procédure, et dispose d'un dépôt cloné et fonctionnel (`flutter test` vert, application lancée dans Chrome) ;
5. a contribué à `PROJET.md` et à une première PR relue par un coéquipier et fusionnée.
6. situe où ranger quoi dans le projet (couches de la Clean Architecture, injection de dépendances, BLoC) grâce au `CLAUDE.md` et au document d'architecture fournis.

**Matériel et prérequis.**
- Dépôts des 8 équipes créés par script avec les membres ajoutés comme collaborateurs, réglages de protection testés, `PROJET.md` pré-rempli par thème (section 13) ; rappel aux étudiants d'accepter l'invitation de collaborateur avant S2.
- Contexte réutilisable fourni par l'enseignant dans le dépôt-modèle (`CLAUDE.md` et `docs/ARCHITECTURE.md`, à produire, section 13), relu avant S2.
- Fiche git (une page), fiche de configuration de Claude Code (extraits à copier), checklist de PR en 5 lignes, résultats du formulaire d'équipes.
- Syntaxe des permissions, hooks et skills vérifiée sur la version de Claude Code utilisée.
- 2 aides au moins (git et configuration sont des moments de blocage fréquents).

**Légende des poids :** **Indispensable** = ne pas sacrifier ; **Important** = sauf contrainte forte ; **Pratique** = si le rythme le permet, ou en ressource ; **Moins utile** = peut sauter ou rester en lecture.

**Déroulé (ordre logique des blocs).**

**Bloc 1. Retour sur S1** · **Important** · discussion
- *Contenu.* Dépannage des installations restantes (liste du tableau de suivi) et des invitations de collaborateur non acceptées. Rappel de la règle d'or. Un exercice éclair : « qu'est-ce qu'on ne met jamais dans un prompt ? ».
- *Intention.* Repartir sur des postes fonctionnels et ancrer la règle d'or avant de toucher au dépôt.

**Bloc 2. Git, le modèle mental** · **Indispensable** · exposé et démonstration
- *Contenu.* Dépôt, commit (une photo du projet avec un message), branche, fusion, dépôt distant (`remote`), PR (demande de relecture et de fusion), conflit. Démonstration en direct : `git init`, `git add`, `git commit`, `git switch -c`, `git log --oneline`.
- *Intention.* Donner le vocabulaire et l'image mentale avant la pratique au clavier.

**Bloc 3. Git au clavier, en binômes, dans un dépôt d'essai** · **Indispensable** · atelier
- *Contenu.* Fiche guidée : (1) `git init` et premier commit ; (2) modifier un fichier, `git diff`, `git add`, commit avec un message soigné ; (3) créer une branche, commiter, fusionner ; (4) créer le dépôt d'essai sur GitHub, `git push`, ouvrir une PR, la faire relire par son binôme et la fusionner ; (5) **conflit volontaire** : chacun modifie la même ligne sur une branche, fusion, résolution à la main dans VS Code. Chaque étudiant tape ses commandes (l'agent peut expliquer, pas faire à la place). Vérification par l'aide ou l'enseignant : chacun a produit au moins 3 commits et résolu un conflit.
- *Intention.* Faire pratiquer le cycle complet, y compris le conflit, pour que git cesse d'être abstrait.

**Bloc 4. Configurer Claude Code** · **Indispensable** · exposé et démonstration
- *Contenu.* Démonstration commentée des briques : `CLAUDE.md` (court, utile : commandes, conventions, interdits) ; **permissions** (autoriser ou refuser des actions ; cas Replit de juillet 2025 : l'agent a supprimé une base de production pendant un gel du code, un gel écrit dans le prompt est une demande, pas une contrainte) ; mode plan ; **hooks** (une commande lancée automatiquement, par exemple le contrôle de style) ; **skills** (une procédure réutilisable) ; **plugins** ; **MCP** (brancher un outil externe, avec la réserve que chaque serveur MCP est du code et des échanges avec un tiers : à valider avant usage) ; **sous-agents** ; commandes de gestion du contexte et du modèle (`/clear`, `/compact`, `/model` : à vérifier selon la version). Élément de poids moindre : un **framework de type spec-kit** à titre d'exemple, de la spécification au plan puis aux tâches (**Pratique** ; installation et syntaxe à vérifier) .
- *Intention.* Montrer que la confiance dans un agent vient de la configuration (permissions, hooks) et non des consignes écrites dans le prompt.

**Bloc 5. Atelier de configuration, individuel, dans le dépôt d'essai** · **Indispensable** · atelier
- *Contenu.* Fiche de configuration fournie (extraits à copier). Étapes dans l'ordre : (1) générer un `CLAUDE.md` avec `/init`, puis le réduire à l'essentiel (**Indispensable**) ; (2) `.claude/settings.json` avec des refus (lecture de `.env`, `rm -rf`, `git push --force`) ; **test** : demander à l'agent de lire `.env` et constater le refus (**Indispensable**) ; (3) un premier skill simple, par exemple « écrire un message de commit conforme » (modèle fourni) (**Important**) ; (4) installer un plugin et brancher un serveur MCP de documentation (choix de l'enseignant, à vérifier), puis discuter ce qui part vers un tiers (**Pratique**). Le cadre de type spec-kit n'est montré qu'en démonstration (pas d'atelier). La syntaxe des réglages peut varier d'une version à l'autre (à vérifier avant la séance).
- *Intention.* Que chaque étudiant constate lui-même qu'une permission configurée est effectivement respectée.

**Bloc 6. La pile du projet et le contexte fourni** · **Important** · exposé
- *Contenu.* La pile du projet fil rouge : application Flutter en Clean Architecture (couches domain, data et presentation ; une feature = un dossier), injection de dépendances avec `get_it`, gestion d'état avec `flutter_bloc` (BLoC et Cubit), TDD avec `flutter_test`, `bloc_test` et `mocktail`, BDD avec `bdd_widget_test` (scénarios Gherkin en français dans des fichiers `.feature`). Visite guidée du `CLAUDE.md` et de `docs/ARCHITECTURE.md` fournis par l'enseignant : ils sont réutilisables d'un projet à l'autre et servent de premier contexte à l'agent. Rappel : outil ponctuel, données fictives, règle d'or, fiche de conformité, calendrier ; le thème C demande plus de travail de conformité (les trois thèmes sont présentés dans un support à part). Pas de questions techniques de détail : elles viennent en atelier.
- *Intention.* Que chaque étudiant sache où ranger quoi dans le projet et pourquoi l'agent doit respecter cette structure. Peut se réduire à la lecture commentée du `CLAUDE.md` si le rythme l'impose.

**Bloc 7. Validation des équipes et des thèmes** · **Indispensable** · discussion
- *Contenu.* Les équipes (de 3 à 5, 8 équipes de 4 par défaut ; 7 équipes de 4 ou 5 si l'effectif l'impose) et les thèmes résultent du formulaire, avec une attribution provisoire faite par l'enseignant : (1) chaque équipe confirme sa composition et son thème ; (2) **répartition visée : 8 équipes : 3-3-2 ; 7 équipes : 3-2-2 ou 3-3-1, avec au plus 3 équipes par thème ; tirage au sort si un thème dépasse 3 candidats**, la perdante passant à son choix suivant (le dépôt est alors renommé avec `gh repo rename` et son `PROJET.md` remplacé, ce qui est rapide) ; (3) les équipes sont **numérotées par thème** (8 équipes : 01 à 03 : A ; 04 à 06 : B ; 07 et 08 : C) : cette numérotation sert aux appariements de S3 et S4 ; (4) attribution des rôles d'équipe ; (5) chaque étudiant vérifie qu'il voit son dépôt (invitation de collaborateur acceptée).
- *Intention.* Fixer une fois pour toutes équipes, thèmes, numéros et rôles, dont dépendent les appariements de S3 et S4.

**Bloc 8. Initialisation du projet** · **Indispensable** · atelier
- *Contenu.* Dans l'ordre : (1) cloner le dépôt de l'équipe (déjà créé depuis le modèle), `flutter pub get`, `dart run build_runner build --delete-conflicting-outputs` (les fichiers générés ne sont pas versionnés), `flutter test` vert, `flutter run -d chrome`, lire le `CLAUDE.md` et `docs/ARCHITECTURE.md` fournis ; (2) compléter `PROJET.md`, **fourni pré-rempli pour le thème** (vision en 5 lignes et user stories proposées) : l'équipe en retient 3 à 5, ajuste le texte et décide (`PROJET.md` est un document, pas du code : l'agent aide à rédiger) ; (3) branche, commit, PR rédigée avec le modèle de PR du dépôt (résumé, ce que l'agent a proposé et ce que j'ai refusé, temps estimé, temps réel, retouches) ; (4) relecture par un coéquipier avec la checklist de 5 lignes, fusion (merge commit), puis **vérification que la protection de `main` est active** : l'étudiant tente un push direct et constate le refus ; (5) marge de dépannage pour les postes en difficulté. L'enseignant contrôle chaque dépôt.
- *Intention.* Que chaque équipe dispose d'un dépôt qui tient debout, d'un `PROJET.md` décidé collectivement et d'une première PR relue.

**Bloc 9. Restitution flash et consignes** · **Important** · discussion
- *Contenu.* Chaque équipe annonce en une phrase son thème et sa première user story. Consignes : travail entre les séances (section 5), pose du tag `s2-fin` et état courant en tête de `JOURNAL.md` (cinq lignes, par le gardien du harnais).
- *Intention.* Clore la séance par un engagement d'équipe et préparer la reprise après le long intervalle. La restitution orale peut se faire par écrit si le rythme l'impose, les consignes restent indispensables.

**Si la séance prend du retard (ordre de coupe, du moins utile au plus utile).**
1. La démonstration du framework de type spec-kit et l'étape 4 de l'atelier de configuration, plugin et MCP (Pratique) : à donner en ressource.
2. La présentation de la pile (bloc 6), réduite à la lecture commentée du `CLAUDE.md`, et la restitution flash orale (bloc 9), remplacée par un écrit.
3. L'étape 3 de l'atelier de configuration (skill).

Ne se sacrifient jamais : git au clavier, le test du refus de lecture de `.env`, la validation des équipes, la première PR relue avec la protection de `main` vérifiée, la visite de l'exemple `.feature` et du test de BLoC du squelette.

**Peut glisser.** Aucun report n'est prévu de façon systématique ; ce qui n'est pas terminé est noté dans `JOURNAL.md` et repris à la remise en route de S3.

**Livrable de fin de séance.** Pour chaque étudiant : un dépôt d'essai avec au moins 3 commits et un conflit résolu, un `CLAUDE.md` et des permissions testées. Pour chaque équipe : un dépôt public cloné et fonctionnel, `PROJET.md` complété, une PR relue et fusionnée, `main` protégée, état courant dans `JOURNAL.md`, tag `s2-fin`.

**Definition of done.**
- Chaque étudiant a fait au moins un commit, une PR et résolu un conflit de fusion.
- La demande de lecture de `.env` est **refusée** par la configuration de l'agent.
- Chaque équipe a un thème confirmé (3 équipes au plus par thème), un dépôt dans l'organisation, un accès en écriture pour chaque membre (collaborateur du dépôt), et `main` contient la première PR relue par un autre que l'auteur.
- La protection de `main` (PR obligatoire avec 1 approbation, sans contournement par les administrateurs) est active et vérifiée.
- `flutter test` passe et `flutter run -d chrome` démarre l'application sur le dépôt cloné de chaque membre.

---

### Séance 3 : Première user story, données et RGPD (mer. 2 déc.)

**Pourquoi ce thème.** Après 8 semaines de coupure, il faut du concret rapidement. La séance livre la première vraie fonctionnalité (en TDD et en BDD), pose les données qui survivent au code, et ouvre le volet RGPD : on ne choisit pas un champ ou une table sans se demander si l'on traite des données personnelles.

**Objectifs d'apprentissage.** À la fin de la séance, l'étudiant :
1. reprend un projet dormant en suivant une checklist de remise en route ;
2. livre une première user story en TDD et en BDD avec son agent, et la fait relire ;
3. relit la PR d'une autre équipe avec une checklist, et résout un conflit réel ;
4. modélise un domaine en entités et relations, écrit une migration drift, et vérifie l'intégrité des données sur une base en mémoire ;
5. distingue donnée personnelle, base légale, durée de conservation, sous-traitant ; connaît ses droits (accès, rectification, effacement, etc.) ; remplit les premières rubriques de la fiche de conformité.

**Matériel et prérequis.**
- Dépôts en état de marche (smoke test et micro-livrable, section 5).
- Checklist de revue de PR et de remise en route, gabarit de fiche de conformité à 13 rubriques (`cours/conformite-ai-act-rgpd.md`, section 6.1).
- 1 aide au moins, et l'enseignant qui circule en priorité dans les équipes en difficulté.

**Légende des poids :** **Indispensable** = ne pas sacrifier ; **Important** = sauf contrainte forte ; **Pratique** = si le rythme le permet, ou en ressource ; **Moins utile** = peut sauter ou rester en lecture.

**Déroulé (ordre logique des blocs).**

**Bloc 1. Remise en route** · **Indispensable** · atelier
- *Contenu.* Dans l'ordre : (1) checklist (`git pull`, `flutter pub get`, `flutter analyze`, `flutter test`, relire `JOURNAL.md` et `CLAUDE.md`, vérifier la version de Claude Code, l'accès et les quotas) (**Indispensable**) ; (2) quiz éclair de 5 questions sur S1 et S2 (**Pratique**) ; (3) point d'équipe bref (où on en est, qui tient quel rôle ; les rôles sont confirmés) (**Important**).
- *Intention.* Sortir de la coupure de 8 semaines : un dépôt qui démarre, un agent qui répond, des rôles clairs.

**Bloc 2. Git en équipe** · **Important** · exposé et démonstration
- *Contenu.* Petites PR, branches courtes, relecture (quoi regarder, comment commenter, checklist), pourquoi les conflits arrivent et comment les résoudre. Démonstration courte : deux branches qui modifient le même fichier, conflit, résolution. Willison : « Don't file pull requests with code you haven't reviewed yourself ». Les paires d'équipes pour la revue croisée sont annoncées. **8 équipes** : 01–04, 02–05, 03–06, 07–08. **7 équipes** : 01–04, 02–05, 03–06, et l'équipe 07 rejoint la paire 01–04 en trio circulaire (07 relit 01, 01 relit 04, 04 relit 07). Les paires de même thème (07–08) sont **tolérées en S3** ; elles sont évitées en S4.
- *Intention.* Donner les règles de la revue croisée avant de la pratiquer, et faire comprendre que les conflits sont normaux.

**Bloc 3. Première user story en TDD et en BDD** · **Indispensable** · atelier
- *Contenu.* Démonstration de 10 minutes par l'enseignant avant l'atelier : on lance le `.feature` d'exemple du squelette, on montre le test généré et le test du BLoC d'exemple. Pour une sous-règle de domaine, les steps appellent directement le use case sans monter d'écran (à vérifier avec `bdd_widget_test`). Chaque équipe prend la première user story de `PROJET.md` et la livre avec l'agent, en TDD et en BDD : (1) demander un plan (mode plan) et le critiquer ; (2) écrire ou faire relire d'abord le **scénario Gherkin en français** dans un fichier `.feature` (`bdd_widget_test` ; `dart run build_runner build --delete-conflicting-outputs` génère le test widget), puis les **tests unitaires d'abord** (use case, Cubit ou BLoC avec `bloc_test` et `mocktail`) : rouge, puis code vert, puis nettoyage ; (3) respecter la Clean Architecture et l'injection `get_it` du squelette : use case dans la couche domain, **stockage en mémoire via un repository fake** derrière l'interface du domain (pas de base de données à ce stade), BLoC ou Cubit testé avec `bloc_test` (l'écran est Pratique en S3 et peut glisser au sprint) ; (4) vérifier que l'agent ne « triche » pas (test ou scénario supprimé, désactivé, assoupli, hasard en dur) ; (5) PR avec le modèle du dépôt. Le thème fixe la première user story et une première sous-règle isolée (voir `cours/projets/themes.md`). Chaque étudiant, avec son agent, travaille sur sa branche. Le dépôt-modèle fixe si les fichiers générés par `build_runner` sont versionnés (décision : **non versionnés**, pour éviter les conflits de fusion ; `build_runner` est lancé par la CI et par la commande de démarrage, donc `flutter test` sur un clone frais suppose d'avoir lancé `dart run build_runner build --delete-conflicting-outputs` avant).
- *Intention.* Vivre le TDD avec un agent et apprendre à repérer un test « triché ».

**Bloc 4. RGPD en une page** · **Indispensable** · exposé
- *Contenu.* Basé sur `cours/conformite-ai-act-rgpd.md`, sections 2, 4 et 5. Le RGPD, règlement (UE) 2016/679, applicable depuis le 25 mai 2018. Donnée personnelle (art. 4), principes (art. 5 : finalité, **minimisation**, **limitation de la conservation**), bases légales (art. 6), sous-traitants (art. 28) et transferts : **le fournisseur du modèle d'IA reçoit tout ce qui est dans un prompt**, violation de données (notification dans les 72 heures, art. 33). **Un outil temporaire n'échappe pas au RGPD.**
- *Intention.* Poser les notions qui servent à qualifier un projet, dont le fait qu'un prompt est un transfert vers un tiers.

**Bloc 5. Vos droits de citoyen européen** · **Indispensable** (l'exercice de courriel reste **Moins utile**) · exposé et discussion
- *Contenu.* §5 du module : être informé (art. 13 et 14), accès (art. 15), rectification (art. 16), effacement (art. 17), limitation (art. 18), portabilité (art. 20), opposition (art. 21), pas de décision uniquement automatisée (art. 22), réclamation auprès de la CNIL (art. 77) ; délai de réponse d'un mois, prolongeable (art. 12). Élément de poids moindre : l'exercice de courriel de demande d'accès (§5 du module), **Moins utile** en séance, qui peut être laissé en lecture ou donné en tâche facultative entre S3 et S4.
- *Intention.* Que chacun sache exercer ses droits : c'est l'un des deux buts du module de conformité.

**Bloc 6. Test en 4 questions et qualification des données du thème** · **Indispensable** · atelier
- *Contenu.* Le **test en 4 questions** appliqué à son thème (y a-t-il des données sur des personnes réelles ? l'outil aide-t-il à décider pour quelqu'un ? les données ou prompts sortent-ils vers un tiers ? l'outil sera-t-il utilisé hors de l'équipe ?) et qualification des données du thème (thème A : identifiant de joueur ; thème B : postes et quarts, sans identifiant d'opérateur ; thème C : étudiants et décision d'affectation).
- *Intention.* Passer de la notion à l'application sur son propre projet.

**Bloc 7. Début de la fiche de conformité** · **Indispensable** · atelier
- *Contenu.* Complétion de `docs/fiche_conformite.md` (fourni dans le dépôt-modèle, gabarit à 13 rubriques), remplissage des rubriques 1 à 5 (finalité, données, personnes concernées, base légale ou justification « données fictives », durée de conservation et date de suppression) ; **aucun nom civil ni courriel dans la fiche** (« équipe n° X », identifiants GitHub) ; PR relue par un coéquipier. *Sensibilisation, pas avis juridique : la validation revient au RSSI et au DPO.*
- *Intention.* Obtenir dès S3 un premier document de conformité commité, qui sera complété jusqu'au passage devant le RSSI.

**Bloc 8. Les données** · **Indispensable** · exposé et démonstration
- *Contenu.* Entités, relations, clés primaires et étrangères, contraintes. SQLite et **drift** (en une phrase : on déclare les tables en Dart, `build_runner` génère le code d'accès typé), **migrations versionnées** (`schemaVersion` et stratégie de migration `MigrationStrategy` avec `onUpgrade`, à vérifier sur la version de drift utilisée) : pourquoi on ne modifie jamais une base à la main. Démonstration : l'agent ajoute une table avec une migration et un test ; deux pièges (l'agent « corrige » un test en modifiant les données ; deux branches qui incrémentent chacune `schemaVersion` entrent en conflit). Règle ajoutée à `CLAUDE.md` : **une seule migration à la fois, coordonnée par le gardien des données**.
- *Intention.* Comprendre que les données survivent au code et savoir pourquoi les migrations sont explicites.

**Bloc 9. Modéliser et implémenter** · **Indispensable** · atelier
- *Contenu.* D'abord un modèle sur papier (entités, relations, contraintes), validé en passant par l'enseignant ou une aide. Puis, avec l'agent : tables drift des entités du thème rangées dans la couche data, **première migration** et **test d'intégrité sur base en mémoire** (insertion orpheline rejetée ; les clés étrangères doivent être activées explicitement avec SQLite, à vérifier avec drift), le tout fusionné par PR relue. Les rubriques de la fiche touchant aux données sont notées en commentaire dans `docs/fiche_conformite.md`. **Le seed complet et la garde d'accès par rôle (`RequireRole` dans la couche domain, avec test de refus) ne sont pas demandés en S3** (**Pratique**, ils glissent).
- *Intention.* Livrer un modèle de données propre et prouver l'intégrité par un test.

**Bloc 10. Revue croisée entre équipes** · **Indispensable** · atelier
- *Contenu.* Chaque équipe relit par commentaires sur GitHub une PR de l'équipe jumelée (au moins une PR par équipe, auteur présent pour expliquer à voix haute). L'approbation qui débloque la fusion vient d'un coéquipier de l'auteur (les équipes jumelées n'ont pas d'accès en écriture ; variante à vérifier).
- *Intention.* Pratiquer la revue entre équipes et l'explication orale de sa propre PR.

**Bloc 11. Bilan** · **Important** · discussion
- *Contenu.* `JOURNAL.md` et `CLAUDE.md` mis à jour (règles de données), état de la fiche de conformité, vérification du **livrable de fin de S3**, consignes pour S4 (une seule tâche facultative d'1 h au plus, voir section 5).
- *Intention.* Consolider l'état du projet pour la reprise et préparer S4.

**Si la séance prend du retard (ordre de coupe, du moins utile au plus utile).**
1. L'écran Flutter de la première user story (le BLoC et son test restent).
2. L'exercice de courriel de demande d'accès (bloc 5, Moins utile) et le quiz éclair (bloc 1, Pratique).
3. Le seed complet, puis les rôles (garde `RequireRole`) : une équipe en retard les abandonne en premier, mais **garde la migration et le test d'intégrité**.
4. Ne pas entamer les rubriques 6 et 7 de la fiche de conformité (déjà prévues au sprint) ; au besoin, réduire les rubriques 4 et 5 à une phrase chacune.

Ne se sacrifient jamais : remise en route, première user story en TDD et en BDD sur la sous-règle isolée du thème, modèle de données avec première migration et test d'intégrité, RGPD (dont les droits des personnes) et début de la fiche, PR croisées.

**Peut glisser dans le sprint ou au début de S4.** Seed complet, garde d'accès `RequireRole` avec test de refus, rubriques 6 et 7 de la fiche, exercice de courriel de demande d'accès (§5 du module).

**Livrable de fin de séance (identique pour les trois thèmes).** **Première règle verte, modèle et migrations fusionnés, début de `docs/fiche_conformite.md` commité.** Détail : première user story livrée (scénario `.feature`, tests, code, PR relue), modèle de données (schéma, première migration, test d'intégrité), `docs/fiche_conformite.md` commité (rubriques 1 à 5), au moins une PR relue par une autre équipe.

**Definition of done.**
- Sur une base en mémoire vide, le schéma se crée et les migrations se rejouent sans erreur (test), avec une seule migration à la fois ; `flutter test` est vert (le seed complet est attendu pendant le sprint ou au début de S4).
- Un test prouve qu'une insertion orpheline est rejetée.
- Chaque étudiant a ouvert une PR (même petite) et relu celle d'un autre.
- **Aucune donnée personnelle réelle dans le dépôt, la fiche existe et indique « données fictives » avec une justification, sans nom civil ni courriel.**
- La fiche de conformité est commitée (rubriques 1 à 5) et a été relue par un coéquipier.

---

### Séance 4 : Qualité, CI/CD, sécurité, AI Act et validation RSSI (ven. 4 déc.)

**Pourquoi ce thème.** Une fois que le code et les données existent, la question devient : peut-on faire confiance à ce qu'on livre, et peut-on le mettre en usage ? Trois réponses complémentaires : des **garde-fous automatiques** (CI), un **test d'acceptation écrit par un humain avant le code de l'agent** (pour éviter le self-grading, où le même agent écrit le code et ses tests), et un **passage devant le RSSI** qui qualifie les risques (RGPD, AI Act, sécurité, hébergement) avant toute mise en usage. **S4 ne suppose pas le CRUD terminé** : elle repart de l'état de S3 (première règle verte, modèle et migrations fusionnés) et reprend d'abord ce qui a glissé (rôles, seed).

**Objectifs d'apprentissage.** À la fin de la séance, l'étudiant :
1. explique pourquoi « les tests passent » ne prouve pas que « le code est correct » quand le même agent écrit code et tests ;
2. traduit les cas d'acceptation de son thème en scénarios `.feature` (test automatisé) écrits avant le code ;
3. explique une chaîne CI/CD (contrôles, build web, déploiement sur GitHub Pages) et ce qu'implique une publication publique (tout ce qui est dans un build web est public, donc aucun secret) ;
4. repère cinq risques courants de sécurité (secrets, injection, validation des entrées, dépendances, contrôle d'accès) et le risque de prompt injection ;
5. se demande d'abord si son projet est un système d'IA (art. 3, point 1 de l'AI Act), le classe (hors champ, minimal, obligations de transparence (art. 50), haut risque, interdit), nomme son rôle (fournisseur ou déployeur) et présente sa fiche de conformité à un RSSI (go, go sous conditions, no-go) ;
6. audite le dépôt d'une autre équipe sur cinq points.

**Matériel et prérequis.**
- Dépôts de S3 avec modèle de données et fiche commencée.
- Workflow GitHub Actions modèle (`flutter analyze`, `flutter test --coverage`, audit des dépendances pub, gitleaks épinglé, `flutter build web`, déploiement GitHub Pages) testé à l'avance sur un dépôt de l'organisation, avec GitHub Pages activé (à vérifier) ; aucun compte de service cloud ni démonstration de déploiement par l'enseignant.
- Cartes de cas (10) et grille go/no-go imprimées ; checklist d'audit en 5 points ; plan des 3 tables.
- **RSSI désigné** (enseignant ou RSSI de l'établissement, choix à faire avant S3, section 10), **trois intervenants pour les trois tables** (second et troisième à confirmer ; à défaut, étudiants volontaires) et réponse écrite avant le 11 décembre.
- 2 aides en S4, dont l'une tient une table RSSI.

**Légende des poids :** **Indispensable** = ne pas sacrifier ; **Important** = sauf contrainte forte ; **Pratique** = si le rythme le permet, ou en ressource ; **Moins utile** = peut sauter ou rester en lecture.

**Déroulé (ordre logique des blocs).**

**Bloc 1. Point d'équipe** · **Important** · discussion
- *Contenu.* PR ouvertes, blocages, état de la CI et de la fiche. Annonce des appariements d'audit et des tables du passage devant le RSSI (plus bas).
- *Intention.* Repartir de l'état réel de chaque équipe.

**Bloc 2. Reprise de S3 : rôles et seed** · **Indispensable** pour les rôles ; **Important** pour le seed réduit ; **Pratique** pour la suite · atelier
- *Contenu.* Les équipes à qui ils manquent branchent les **rôles** sur la garde d'accès `RequireRole` (couche domain) avec un test de refus (priorité : l'audit en dépend), puis un **seed reproductible fictif** de taille réduite ; le seed complet peut finir dans le sprint. Les équipes à jour avancent (relecture des PR ouvertes, début du CRUD de l'entité principale). Aucune équipe n'est censée avoir terminé le CRUD.
- *Intention.* Mettre à niveau les équipes sans bloquer celles qui sont à jour.

**Bloc 3. Qualité avec les agents** · **Important** · exposé
- *Contenu.* La revue humaine devient le goulot d'étranglement ; le **self-grading** (« Don't grade your own exam ») ; le test d'acceptation indépendant : écrit avant, par une autre main que celle qui code, avec des valeurs recopiées de l'énoncé. Une diapo de repères chiffrés avec leurs limites (GitClear, CodeScene : études d'éditeurs, à lire avec recul).
- *Intention.* Justifier le test d'acceptation indépendant qui suit.

**Bloc 4. Test d'acceptation du clou** · **Indispensable** · atelier
- *Contenu.* Le gardien produit traduit le tableau des cas d'acceptation du thème (`cours/projets/themes.md`) en fichier(s) `.feature` (Gherkin en français) dans `test/acceptance/`, **avant** que l'agent n'écrive le code correspondant ; `bdd_widget_test` génère les tests widget avec `dart run build_runner build --delete-conflicting-outputs`. Valeurs attendues recopiées du tableau (jamais calculées par l'agent), relues ligne à ligne par un second membre, committées en rouge sur une branche dédiée, PR en brouillon jusqu'à ce que tous les cas soient verts. Extraits fournis à copier et à fusionner : une règle `deny` d'édition sur `test/acceptance/**`, la consigne `CLAUDE.md` « un test qui échoue n'est jamais corrigé en modifiant le test », et un fichier `CODEOWNERS` pour ce dossier. La suite du clou (environ 3 h de travail d'équipe) se fait pendant le sprint.
- *Intention.* Éviter le self-grading : l'humain fixe les attendus, l'agent doit les satisfaire.

**Bloc 5. CI/CD en pratique** · **Important** · exposé et démonstration
- *Contenu.* Rappel de S1. Un workflow GitHub Actions lu ligne à ligne. Le pipeline cible : `dart run build_runner build --delete-conflicting-outputs` (fichiers générés non versionnés), `flutter analyze`, `flutter test --coverage`, audit des dépendances pub (outil à vérifier), détection de secrets (gitleaks), `flutter build web`, puis déploiement sur GitHub Pages. **Chaque équipe publie sa version web** ; l'enseignant ne démontre aucun déploiement. Rappels RGPD et sécurité : GitHub Pages est public, donc données fictives uniquement ; **tout ce qui est dans un build web Flutter est public** (code, ressources, constantes), donc aucun secret et aucun mot de passe réel dans l'application.
- *Intention.* Faire comprendre la chaîne complète et ce qu'implique une publication publique sur le web.

**Bloc 6. CI complète, protection de `main` et publication sur GitHub Pages** · **Indispensable** pour la CI et la protection de `main` ; **Important** pour la publication · atelier
- *Contenu.* Dans l'ordre : (1) compléter le workflow à partir du fichier fourni (`dart run build_runner build --delete-conflicting-outputs`, `flutter analyze`, `flutter test --coverage`, audit des dépendances pub, gitleaks en binaire épinglé, `fetch-depth: 0`) et le rendre obligatoire dans la protection de `main` ; (2) ajouter le build web (`flutter build web`, avec l'option de chemin de base `--base-href` si le site est servi sous le nom du dépôt, à vérifier) et le déploiement, activer GitHub Pages sur le dépôt et vérifier l'URL publiée ; (3) contrôler que le bundle publié ne contient ni secret ni donnée réelle. **Plan B si Pages ou Actions posent problème : build web local et démonstration avec `flutter run -d chrome`, publication terminée dans le sprint.**
- *Intention.* Que les garde-fous automatiques soient réellement en place et obligatoires.

**Bloc 7. Sécurité** · **Important** · exposé et démonstration
- *Contenu.* Pratique de l'OWASP Top 10 : injection SQL (avec drift, pas de SQL brut concaténé : `customSelect` et `customStatement` reçoivent des variables liées, jamais du texte assemblé), validation des entrées, contrôle d'accès défaillant (la garde `RequireRole` du domain est testée ; une application web purement cliente reste contournable depuis le navigateur, donc elle ne protège aucune donnée réelle), secrets (un secret qui fuit se **révoque**, on ne se contente pas de le supprimer ; rien de secret dans un build web), dépendances vulnérables. Import CSV (obligatoire, fait pendant le sprint : `file_picker`, taille maximale, encodage, rejet motivé, parseur dans la couche data) et export CSV (injection de formule : cellules commençant par `=`, `+`, `-` ou `@`). **Prompt injection** et principe de précaution sur les capacités de l'agent. Démonstration : l'agent introduit un `customSelect` construit par concaténation, on le trouve, on écrit le test qui le reproduit, puis le correctif.
- *Intention.* Donner les réflexes de sécurité essentiels et montrer le cycle « trouver, reproduire par un test, corriger ».

**Bloc 8. L'AI Act en une page** · **Indispensable** · exposé
- *Contenu.* Règlement (UE) 2024/1689 (§3 du module). **Étape 0 : est-ce un système d'IA ?** (art. 3, point 1) ; un calcul de TRS ou un algorithme d'affectation déterministe peut être hors champ, mais le RGPD s'applique toujours. Approche par les risques : interdit (art. 5), haut risque (art. 6 et annexe III), obligations de transparence (art. 50), minimal. Rôles **fournisseur et déployeur** (art. 3) : une équipe qui met un outil à disposition de tiers peut devenir fournisseur. **Maîtrise de l'IA (art. 4)** : les fournisseurs et déployeurs prennent des mesures pour favoriser la maîtrise de l'IA de leurs personnels et des personnes qui utilisent des systèmes d'IA en leur nom (formulation modifiée par l'omnibus, à vérifier sur EUR-Lex) ; elle justifie cette formation. Droit à l'explication (art. 86). Calendrier : le règlement (UE) 2026/1744, publié au JO le 24 juillet 2026 et en vigueur le 27 juillet 2026 (à vérifier), a **reporté** une partie des obligations de haut risque ; on raisonne dès maintenant avec prudence. Le fait que l'outil soit temporaire ne change pas la qualification : l'usage décide.
- *Intention.* Donner la grille de classement que l'atelier suivant applique.

**Bloc 9. Atelier de classification (§8.1 du module)** · **Indispensable** · atelier et discussion
- *Contenu.* Dix cartes de cas (un chatbot, un outil qui trie des CV, un tableau de TRS par poste, une application qui répartit des stagiaires, une détection d'émotions des opérateurs, etc.). Travail par équipe : étape 0 « est-ce un système d'IA ? », puis hors champ, minimal, obligations de transparence (art. 50), haut risque ou interdit, et données personnelles en jeu ; puis mise en commun (les cartes ambiguës sont réservées à cette discussion) ; puis synthèse de l'enseignant, qui sert à corriger les cartes. Chaque équipe reporte seule, dans la **rubrique 9 de la fiche (rôle fournisseur ou déployeur et case de classement)**, un classement provisoire de son projet pendant l'observation du passage devant le RSSI, et le RSSI le discute ; la rubrique 8 (art. 22) est discutée devant le RSSI.
- *Intention.* Apprendre à classer, puis appliquer le raisonnement à son propre projet.

**Bloc 10. Passage devant le RSSI, en jeu de rôle (§6.2 et §8.2 du module)** · **Indispensable** · atelier en jeu de rôle
- *Forme.* **Trois tables en parallèle**, un RSSI par table (l'enseignant, le RSSI de l'établissement s'il est invité, un second intervenant ou une aide, à confirmer ; à défaut, un étudiant volontaire muni de la grille go/no-go). Les équipes passent à tour de rôle devant leur table (rotation), le jeu de rôle est intégré au passage.
- *Contenu.* Chaque équipe présente le brouillon de sa fiche, répond aux questions du RSSI (« où partent les prompts ? », « qui peut contester ? », « que se passe-t-il à la fin de vie de l'outil ? ») et reçoit une décision provisoire (go, go sous conditions, no-go). Tables à 8 équipes (3-3-2) : table 1 : 01, 04, 07 ; table 2 : 02, 05, 08 ; table 3 : 03, 06. Chaque table fait au plus 3 passages. Les équipes qui ne passent pas observent au moins un autre passage avec la grille go/no-go, ou avancent l'audit croisé. La réponse écrite et datée du RSSI suit sur la v1 de la fiche, avant le 11 décembre. *Sensibilisation, pas avis juridique.*
- *Intention.* Mettre chaque équipe en situation de défendre son choix devant le RSSI qui validera la mise en usage.

**Bloc 11. Audit croisé entre équipes, en 5 points** · **Indispensable** · atelier
- *Contenu.* Checklist ci-dessous. Chaque équipe audite le dépôt public d'une équipe d'un **autre thème** (8 équipes : anneau X audite Y : 01→04, 04→07, 07→02, 02→05, 05→08, 08→03, 03→06, 06→01) ; chaque équipe audite une équipe et est auditée par une autre. Les constats sont ouverts en **issues GitHub** priorisées ; chaque équipe corrige un constat reçu (en commençant par un test qui le reproduit) pendant le sprint.
- *Intention.* Regarder un dépôt avec l'œil d'un tiers et alimenter le backlog du sprint.

**Bloc 12. Bilan et consignes du sprint** · **Important** · discussion
- *Contenu.* Backlog final priorisé en essentiel, souhaitable et abandonné (issues de l'audit incluses), règles du gel (section 5), rappel de la date de dépôt de la fiche en PR (mardi 8 décembre à 18h). Tag `v0.1` et release GitHub avec notes si `main` est verte (**Pratique** ; sinon dans le sprint).
- *Intention.* Ouvrir le sprint avec un périmètre décidé.

**Bloc 13. Quiz de 8 questions du module (§8.3)** · **Moins utile** · discussion
- *Contenu.* Quiz de contrôle des notions de conformité.
- *Intention.* Autoévaluation : peut sauter, ou être donné en ressource ou fait pendant le sprint.

**Si la séance prend du retard (ordre de coupe, du moins utile au plus utile).**
1. Le quiz de 8 questions (bloc 13, Moins utile).
2. La release `v0.1` (Pratique).
3. Le seed complet : une équipe en retard l'abandonne après la release, et garde un seed réduit s'il existe.
4. Le bloc 3 (qualité avec les agents) et le bloc 7 (sécurité) se condensent ; le bloc 5 (CI/CD en pratique) se réduit à la lecture du workflow fourni.

Ne se sacrifient jamais : le test d'acceptation en rouge, la CI verte et obligatoire sur `main`, le build web construit, les rôles (garde `RequireRole`, avec le seed s'il a glissé), l'atelier de classification, le passage devant le RSSI, l'audit croisé en 5 points.

**Peut glisser dans le sprint.** Seed complet, publication sur GitHub Pages si elle a bloqué en séance, release `v0.1`, quiz de 8 questions du module (§8.3), suite du clou.

**Appariements si 7 équipes** (3 équipes A : 01 à 03 ; 2 équipes B : 04 et 05 ; 2 équipes C : 06 et 07) : anneau 01→04, 04→02, 02→06, 06→03, 03→05, 05→07, 07→01. Chaque équipe audite une équipe d'un autre thème et est auditée une fois (aucune paire de même thème). Tables du passage devant le RSSI (3-2-2) : table 1 : 01, 04, 06 ; table 2 : 02, 05 ; table 3 : 03, 07. Les paires de même thème sont tolérées en S3 mais évitées en S4.

**Checklist d'audit croisé, en 5 points** (une page fournie ; ne signaler que ce qui existe dans le dépôt). *Pour des non-développeurs, chaque point est formulé avec la commande ou l'écran à regarder.*
- **Installation à froid** : `git clone`, `flutter pub get`, `dart run build_runner build --delete-conflicting-outputs`, `flutter test`, `flutter run -d chrome` selon le `README` : l'application démarre en moins de 10 minutes.
- **CI** : la pastille est verte sur `main` ; la CI est obligatoire pour fusionner ; l'audit des dépendances pub sans alerte non traitée ; le déploiement sur GitHub Pages fonctionne.
- **Secrets** : aucun secret dans le dépôt ni dans l'historique (rapport gitleaks) ni dans le bundle web publié, `.env` ignoré, `.env.example` présent.
- **Rôles** : chaque cas d'usage sensible passe par la garde d'accès `RequireRole` (couche domain) ; un test vérifie le refus.
- **Fiche** : `docs/fiche_conformite.md` existe, sans nom civil ni courriel, cohérente avec ce que fait l'application (durée de conservation et fin de vie, mesures propres au thème : mention d'information et suppression en A, consigne sur les commentaires en B, statut `brouillon` / `publie` en C).

Renvoyés au sprint, hors des cinq points : entrées et sorties (pas de SQL brut concaténé avec drift, c'est-à-dire pas de `customSelect` ni de `customStatement` construits par concaténation ; validation des entrées), import CSV (`file_picker`, taille maximale, rejet motivé) et export CSV (neutralisation des formules), `pubspec.lock` versionné.

**Livrable de fin de séance.** Test d'acceptation du clou (fichiers `.feature`) en rouge dans une PR brouillon ; règle `deny`, consigne `CLAUDE.md` et `CODEOWNERS` fusionnés ; CI complète obligatoire sur `main` protégée ; build web publié sur GitHub Pages par l'équipe ; rôles en place ; brouillon de fiche de conformité (rubriques 1 à 5, classement et rôle AI Act provisoires à la rubrique 9 ; la rubrique 8 (art. 22) est discutée devant le RSSI) présenté au RSSI ; audit reçu (issues) ; release `v0.1` si `main` est verte.

**Definition of done.**
- Le workflow CI s'exécute à chaque PR et bloque la fusion en cas d'échec.
- Aucune PR fusionnée sans relecture par quelqu'un d'autre que l'auteur ; toutes les PR sont fusionnées par merge commit.
- Un test d'acceptation (fichier `.feature`) a été écrit avant le code qu'il vérifie (valeurs recopiées, relu par un second membre) et `test/acceptance/**` est protégé.
- Le contrôle de secrets en CI est vert.
- La version web de l'équipe est publiée sur GitHub Pages (ou le plan B est documenté).
- Chaque équipe est passée devant le RSSI, a **posé la question « système d'IA ? »**, proposé un classement AI Act et un rôle, et connaît la date de dépôt de la v1 (8 décembre).
- Chaque équipe a audité une équipe et reçu un audit.

---

### Séance 5 : Retouches et soutenance (mer. 16 déc.)

**Principe du rendu.** Le **tag `v1.0-rc` et le dossier de rendu sont déposés le lundi 14 décembre à 18h**, pour que les évaluateurs lisent les dépôts avant la séance. Le matin de S5, seuls des correctifs bloquants sont autorisés avant le tag final `v1.0`.

**Objectifs d'apprentissage.** À la fin de la séance, l'étudiant :
1. gèle un périmètre et livre une version stable (`v1.0`), en assumant ce qui est laissé de côté ;
2. présente une démonstration en direct, chronométrée et robuste (avec plan de secours) ;
3. explique les choix de son équipe (données, qualité, conformité) en s'appuyant sur l'historique git et la fiche ;
4. répond à des questions individuelles sur une PR de son équipe et sur la compréhension du projet ;
5. porte un regard critique sur son usage de l'IA et sur les limites de son outil (à ne pas utiliser pour...), chiffres à l'appui.

**Matériel et prérequis.**
- Deux salles avec vidéoprojecteur, chronomètre visible, fiches d'observation, **fiches de notation pré-remplies par étudiant**, grille de notation et échelle de compréhension orale imprimées.
- Deux évaluateurs, chacun avec un second évaluateur ou un observateur par salle (à confirmer avant le 4 décembre ; à défaut, format dégradé à une salle, ci-dessous). Lecture des dépôts le mardi 15 décembre ; les PR tirées au sort sont communiquées aux étudiants ce jour-là avant 9h, soit au moins 24 h avant le premier passage. Ordre de passage tiré au sort à l'avance ; machine de secours par salle.

### Format de la soutenance (contrainte de logistique)

Cette section décrit une **contrainte d'organisation** (32 étudiants, un jury), pas un déroulé de parole ni un minutage de la séance. Les chiffres sont des **ordres de grandeur à ajuster** selon les équipes et les évaluateurs.

**Deux salles en parallèle.** Avec 8 équipes de 4, une seule salle impose une succession de soutenances trop longue pour laisser de la place aux retouches, au gel et à la clôture. Un format raccourci à une salle réduit fortement l'oral individuel, qui pèse 4 points sur 20 : **non recommandé**, gardé comme format dégradé (voir plus bas). On retient **deux salles parallèles de 4 équipes chacune**, avec dans chaque salle **un évaluateur et un second évaluateur ou observateur** (l'enseignant, et en face un collègue, un professionnel invité, le RSSI de l'établissement pour la partie conformité, un assistant ou un doctorant : **à confirmer avant le 4 décembre**). L'observateur chronomètre et note les écarts ; l'évaluateur dispose d'une **fiche de notation pré-remplie par étudiant** (équipe, étudiant, PR tirée au sort, échelle de compréhension de 0 à 4 pour les deux questions). Les étudiants restent dans la salle de leurs quatre équipes : ils forment le public et remplissent les fiches d'évaluation par les pairs. Une **courte séance de calibrage des évaluateurs** précède les passages.

**Budget indicatif par équipe** (organisation, à ajuster) : de l'ordre de **30 minutes pour une équipe de 4** et **34 minutes pour une équipe de 5**, selon la formule « une partie commune d'une dizaine de minutes + quatre minutes de questions par étudiant + une transition de quatre minutes ». La partie commune comprend une démonstration en direct, un passage « sous le capot » (harnais, une décision sur les données, un moment de l'historique git, mesures temps estimé et réel) et un point de conformité (fiche, avis du RSSI, limites d'usage). Les questions individuelles sont au nombre de deux par étudiant (voir section 7).

**Affectation aux salles.** 8 équipes : salle 1 : équipes 01, 03, 05, 07 ; salle 2 : 02, 04, 06, 08.

**Variante 7 équipes (4 équipes de 5 et 3 de 4).** Même formule de budget. Affectation indicative (équipes de 5 : 01, 03, 05 et 07 ; équipes de 4 : 02, 04 et 06, à ajuster selon les effectifs réels) :
- **Salle 1 (4 équipes : 4, 4, 4, 5)** : 02, 04, 06 puis 01. C'est la salle la plus chargée : elle tient sans marge, il ne faut pas laisser les passages déborder.
- **Salle 2 (3 équipes : 5, 5, 5)** : 03, 05 et 07. Elle garde une marge qui absorbe les dépassements et sert au calibrage final des notes.
- Si les passages de la salle 1 prennent du retard, la plénière de fin de séance est raccourcie d'autant.

**Format dégradé si le second évaluateur est absent** (une salle, un seul évaluateur) : budget réduit, de l'ordre de **20 minutes par équipe** (démonstration brève, « sous le capot » et conformité très courts, trois minutes de questions par étudiant). **La plénière est remplacée par un retour d'expérience écrit** (questionnaire en ligne). Ce format est **dégradé** : la compréhension orale (4 points) est alors évaluée sur une durée plus courte par étudiant (question 1 brève, question 2 très brève) par un seul évaluateur, sans observateur ; le barème ne change pas, mais l'enseignant le **signale aux étudiants** (dossier de notes et note d'oral marqués « format dégradé ») et relit les notes extrêmes à partir des fiches pré-remplies.

**Légende des poids :** **Indispensable** = ne pas sacrifier ; **Important** = sauf contrainte forte ; **Pratique** = si le rythme le permet, ou en ressource ; **Moins utile** = peut sauter ou rester en lecture.

**Déroulé (8 équipes de 4, deux salles ; ordre logique des blocs).**

**Bloc 1. Briefing** · **Important** · discussion
- *Contenu.* Affectation aux salles (salle 1 : équipes 01, 03, 05, 07 ; salle 2 : 02, 04, 06, 08), ordre de passage, format, critères.
- *Intention.* Que chacun sache où il passe, dans quel ordre et selon quels critères.

**Bloc 2. Retouches bloquantes** · **Important** · atelier
- *Contenu.* Correctifs de bugs bloquants, documentation, mise à jour de la fiche de conformité (dont la réponse du RSSI), finition. Aucune nouvelle fonctionnalité. Dernier passage de la CI.
- *Intention.* Livrer une version stable : seuls les correctifs bloquants sont autorisés.

**Bloc 3. Gel du code** · **Indispensable** · atelier
- *Contenu.* Tag `v1.0`. À partir de là, on ne pousse plus.
- *Intention.* Figer ce qui sera évalué ; le tag `v1.0` est posé avant le premier passage.

**Bloc 4. Répétition technique et calibrage des évaluateurs** · **Indispensable** pour le calibrage des évaluateurs ; **Important** pour la répétition technique · atelier
- *Contenu.* Répétition technique par les équipes, chacune vérifiant sa démonstration dans sa salle (affichage, jeu de données de secours, plan B enregistré). En parallèle, calibrage des évaluateurs (échelle de compréhension de 0 à 4 appliquée à deux exemples de réponses, fiches de notation pré-remplies, rôle de l'observateur).
- *Intention.* Éviter la panne technique le jour J et harmoniser la notation. Le calibrage est **Indispensable** côté évaluateurs ; la répétition peut se faire en équipe avant la séance si besoin.

**Bloc 5. Soutenances** · **Indispensable** · soutenances (deux salles en parallèle)
- *Contenu.* Passage de chaque équipe selon le format ci-dessus : démonstration en direct, « sous le capot », conformité, puis questions individuelles. Une pause entre deux séries de passages, au moment le moins gênant.
- *Intention.* Évaluer ce que l'équipe et chacun comprennent, preuves à l'appui.

**Bloc 6. Fiches d'évaluation par les pairs et harmonisation des notes** · **Indispensable** pour les fiches des pairs (1 point de la note) ; **Important** pour l'harmonisation entre évaluateurs · atelier
- *Contenu.* Fiches d'évaluation par les pairs remplies par les étudiants ; les évaluateurs harmonisent leurs notes entre eux (second calibrage).
- *Intention.* Recueillir l'évaluation des pairs et garantir l'équité de la notation entre les deux salles.

**Bloc 7. Retour d'expérience collectif (plénière)** · **Pratique** · discussion
- *Contenu.* Ce qui a marché, ce qui a échoué, ce que je ferais autrement ; l'IA, les limites, la conformité ; ce que je dirais à une équipe de développement.
- *Intention.* Prendre du recul sur l'ensemble de la formation. Peut être remplacé par le questionnaire en ligne.

**Bloc 8. Clôture** · **Important** · discussion
- *Contenu.* Consignes pour la suite (questionnaire de fin de formation en ligne, notes).
- *Intention.* Clore la formation proprement.

**Si la séance prend du retard (ordre de coupe, du moins utile au plus utile).**
1. La plénière (bloc 7, Pratique), remplacée par le questionnaire en ligne.
2. Le bloc 2 (retouches) : s'en tenir aux seuls correctifs bloquants, et ne pas déborder sur le gel.
3. La répétition technique (bloc 4), faite en équipe avant la séance ou pendant le passage de l'équipe précédente.
4. La clôture (bloc 8), réduite aux consignes essentielles.

Ne se sacrifient jamais : le gel et le tag `v1.0`, les soutenances avec leurs deux questions individuelles, les fiches d'évaluation par les pairs. Si les passages d'une salle prennent du retard, on raccourcit la plénière avant de toucher à un passage.

**Peut glisser.** Le retour d'expérience collectif (par questionnaire en ligne) et la communication des notes après la séance. L'étudiant absent le jour de la soutenance est interrogé dans les 15 jours avec la même trame (section 7).

**Livrable de fin de séance.** Tag `v1.0`, dossier de rendu à jour (section 7) et soutenance passée.

**Definition of done.**
- `v1.0-rc` est déposé le lundi 14 décembre à 18h ; `v1.0` est taguée avant le premier passage le jour de S5 ; la CI est verte sur les deux tags ; le `README` testé à froid (`git clone`, `flutter pub get`, `flutter run -d chrome`) permet de lancer l'application en moins de 10 minutes, et la version web publiée sur GitHub Pages est accessible.
- La fiche de conformité est complète (13 rubriques) et contient la **réponse du RSSI** datée (go, go sous conditions avec actions, ou no-go assumé avec les raisons).
- Chaque étudiant a répondu à **deux questions individuelles** : une sur une PR tirée au sort communiquée le 15 décembre, une de compréhension.
- `JOURNAL.md` est à jour et les PR portent leur section « ce que l'agent a proposé, ce que j'ai refusé » et leurs temps.

---

## 5. Travail entre les séances

Principe : **cadré, chiffré et limité.** Les étudiants ont d'autres cours. Le travail de la formation se fait en séance, sauf le sprint de 12 jours avant S5, qui est requis.

| Intervalle | Ce qu'on demande | Statut |
|---|---|---|
| **S1 → S2** (2 jours) | Terminer les installations restantes (rendez-vous de dépannage possible), dont `flutter doctor` et `flutter run -d chrome` sur le projet d'exemple. Relire la règle d'or. Consulter les thèmes (`cours/projets/themes.md`, support à part transmis avec le formulaire, modalité à confirmer), **remplir le formulaire d'équipes avant le jeudi 8 octobre à 12h** (composition, classement des thèmes, identifiant GitHub) et accepter l'invitation de collaborateur reçue par courriel | Recommandé ; formulaire requis |
| **S2 → S3** (environ 8 semaines) | Voir ci-dessous. **Micro-livrable obligatoire, échéance le vendredi 27 novembre à 18h** | Cadré, avec un point obligatoire |
| **S3 → S4** (2 jours) | **Une seule tâche, facultative, d'1 h au maximum** : au choix, fusionner les PR ouvertes et corriger les tests rouges, ou relire la fiche de conformité, ou rédiger en cinq lignes un courriel de demande d'accès (art. 15 RGPD) à un service que l'on utilise (à ne pas envoyer, sauf si l'on le souhaite vraiment). **S4 ne suppose pas le CRUD terminé** | Facultatif |
| **S4 → S5** (12 jours) | Sprint : voir ci-dessous | **Requis** |

### Le trou de 8 semaines : ne pas perdre le fil

Le risque principal est l'oubli : les étudiants reviennent le 2 décembre sans plus savoir comment le projet se lance. Six parades.

1. **Le dépôt sert de mémoire.** À la fin de S2, chaque équipe pose le tag `s2-fin` et écrit l'état courant en tête de `JOURNAL.md` (où on en est, prochaine étape, commandes clés, décisions prises). `CLAUDE.md` et les tests font le reste.
2. **Ne figer que ce qui peut l'être.** Les dépendances sont figées par `pubspec.lock` (versionné) et la version de Flutter est notée dans le `README` et dans `pubspec.yaml` (contrainte d'environnement, à vérifier) ; pas de `flutter upgrade` pendant la pause sans raison. Claude Code et les modèles changent en 8 semaines : le courriel de reprise demande de **noter la version de Claude Code et de relire les permissions**. La syntaxe des réglages peut varier (à vérifier).
3. **CI minimale dès le début, signal à distance.** Le dépôt-modèle fournit un workflow minimal (`flutter analyze` et `flutter test`), actif dès S2 ; l'enseignant voit à distance quelles équipes ont un dépôt qui tient debout.
4. **Smoke test de l'enseignant, vers le vendredi 20 novembre.** L'enseignant clone à froid chaque dépôt (8 dépôts : une heure au plus), lance `flutter pub get` et `flutter test`, et ouvre une issue dans les dépôts qui ne démarrent pas.
5. **Micro-livrable obligatoire (10 minutes), échéance le vendredi 27 novembre à 18h.** Chaque étudiant exécute la checklist de reprise sur un nouveau clone (cloner, `flutter pub get`, `dart run build_runner build --delete-conflicting-outputs`, `flutter test`, `flutter run -d chrome`, lancer Claude Code, relire `CLAUDE.md`) et dépose une capture d'écran dans l'issue « reprise » de son équipe. Non noté ; relance individuelle le lundi 30 novembre.
6. **Rappels de l'enseignant.** Courriel du **lundi 16 novembre** (annonce de l'échéance et checklist), du **mardi 24 novembre** (dernier rappel), échéance le vendredi 27 novembre, relance individuelle le lundi 30 novembre. Rappel dans le courriel : **ne rien mettre de personnel dans le dépôt, même pour tester** (règle d'or).

En S3, le premier bloc est une **remise en route** réelle : l'enseignant prévoit du temps de dépannage et un quiz éclair sur S1 et S2.

### Le sprint de 12 jours avant S5

- **Objectif** : terminer le périmètre décidé en S4 (clou niveau 1 avec son test d'acceptation vert, éléments souhaitables retenus), corriger les constats de l'audit croisé, **finaliser la fiche de conformité et obtenir la réponse du RSSI**, stabiliser.
- **Charge d'équipe : environ 15 à 20 heures**, soit 4 à 5 heures par étudiant (équipe de 4). Répartition indicative : périmètre restant après S4 environ 9 à 12 h (estimations de conception, non chronométrées, établies avant le passage à Flutter et Clean Architecture, à recalibrer au smoke test du 20 novembre ; **import CSV obligatoire, seed complet et CRUD s'ils ne sont pas terminés**) ; corrections d'audit 3 h ; fiche, documentation et répétition 3 à 5 h. **Les mesures de conformité propres à chaque thème (mention d'information et script de suppression en A ; consigne affichée sur les commentaires en B ; statut `brouillon` / `publie` en C) sont incluses dans ces 15 à 20 h**, elles ne s'y ajoutent pas.
- **Backlog priorisé** : essentiel, souhaitable, **abandonné**. L'équipe décide explicitement de ce qu'elle abandonne. Chaque thème fournit un « livrable minimum viable ». Si l'équipe est en retard, le CRUD se limite à la création et à la lecture, et le seed complet cède avant l'import CSV.
- **Calendrier** : **mardi 8 décembre à 18h**, fiche de conformité v1 déposée en PR (« demande de validation RSSI ») ; **mercredi 9 décembre**, point d'étape asynchrone (issue de 5 lignes ; l'enseignant répond) ; **vendredi 11 décembre**, réponse du RSSI et **gel des fonctionnalités au soir** (ensuite : correctifs, documentation, préparation de la démonstration) ; **lundi 14 décembre à 18h**, tag `v1.0-rc` et dossier de rendu.
- **Répétition de la démonstration** avant S5 : une fois, en équipe, avec chronomètre.
- **Règle de prudence** : ne pas commencer un gros chantier au dernier moment.

---

## 6. Compétences visées

À l'issue de la formation, l'étudiant est capable de :

1. **Dialoguer avec une équipe de développement** : employer le vocabulaire (dépôt, branche, PR, test, CI/CD, migration, release), comprendre un cycle de vie et poser les bonnes questions sur la qualité, les risques et les contraintes.
2. **Situer** les pratiques du génie logiciel dans leur histoire et justifier le rôle du craft face à l'IA.
3. **Utiliser git et GitHub** : historique propre, commits lisibles, branches, PR, revue, résolution de conflits simples.
4. **Piloter un agent de code** : découper une demande, utiliser le mode plan, contrôler le contexte, choisir un modèle et un niveau d'effort, décider quand arrêter et repartir de zéro.
5. **Construire un harnais** : rédiger `CLAUDE.md`, configurer permissions, hooks, skills, plugins et MCP, s'appuyer sur la spécification (spec-driven) et faire respecter à l'agent l'architecture du projet (Clean Architecture, injection de dépendances, BLoC) décrite dans `CLAUDE.md`.
6. **Pratiquer le TDD et le BDD** avec un agent (scénarios Gherkin en français) et repérer un test « triché » ou trop faible.
7. **Modéliser des données** : schéma, contraintes, migrations, jeux de données fictifs, tests d'intégrité.
8. **Assurer la qualité et sécuriser** : revue de code, CI, test d'acceptation indépendant, gestion des secrets, contrôle d'accès, principes contre les injections, prise de conscience de la prompt injection.
9. **Livrer** : livraison reproductible, CI/CD dans le cloud, publication d'un build web, documentation d'installation testée à froid.
10. **Connaître les limites légales et organisationnelles** : appliquer la règle d'or, qualifier un projet au regard du RGPD et de l'AI Act, rédiger une fiche de conformité, **faire valider par le RSSI** avant toute mise en usage.
11. **Connaître ses droits de citoyen européen** : accès, rectification, effacement, limitation, portabilité, opposition, décision automatisée, information, réclamation auprès de la CNIL, explication (AI Act, art. 86), et savoir comment les exercer.
12. **Travailler en équipe** : rôles, décisions tracées, revue croisée, organisation d'un sprint court.
13. **Rendre compte** : présenter une démonstration, expliquer des choix, assumer et documenter l'usage de l'IA, porter un regard critique en s'appuyant sur des mesures.

---

## 7. Évaluation

### Grille sur 20 : 14 points collectifs et 6 points individuels

| Critère | Points | Ce qu'on regarde | Support |
|---|---|---|---|
| **Fonctionnalité** | 3 | Le produit fonctionne en démonstration live et couvre le socle obligatoire (section 8) ; le clou niveau 1 est noté sur la **réussite des cas d'acceptation publiés** dans l'énoncé du thème (cas verts sur cas totaux), pas sur l'appréciation ; les user stories annoncées sont livrées | Démonstration, `PROJET.md`, résultat de `test/acceptance/` |
| **Process git et équipe** | 2 | Commits petits et lisibles, PR relues, issues, branches courtes, pas de push direct, traçabilité des décisions ; TDD visible (commit de test avant le code) ; **deux cas d'erreur d'agent documentés** dans les PR (étiquette `erreur-agent`), contrôlés en soutenance | Dépôt GitHub |
| **Harnais et tests** | 2 | `CLAUDE.md` utile et à jour, permissions (dont `test/acceptance/**` protégé), hooks, tests pertinents (unitaires, intégrité, scénarios BDD, acceptation), aucun test supprimé ou assoupli | Dépôt |
| **Données et conformité** | 3 | **1 point données** : modèle cohérent, contraintes, migrations rejouables, seed fictif reproductible, tests d'intégrité. **2 points conformité** : fiche de conformité complète et honnête (13 rubriques), justification du niveau de risque AI Act, mesures réellement présentes dans l'application (accès par rôle testé, mesures propres au thème, durée de conservation), le rôle AI Act (fournisseur ou déployeur) et la case de classement justifiés, **réponse du RSSI datée** et suites données aux conditions, limites d'usage écrites | Dépôt, `docs/fiche_conformite.md`, soutenance |
| **Qualité, sécurité et livraison** | 3 | CI verte sur le tag, audit croisé traité (issues priorisées, constats corrigés ou justifiés), `README` testé à froid en moins de 10 minutes, aucun secret (contrôle en CI), build web publié sur GitHub Pages (ou plan B documenté), tests dédiés sur l'import CSV (obligatoire) et sur l'export CSV s'il est livré | Dépôt, CI, issues |
| **Soutenance** | 1 | Clarté, respect du temps, démonstration maîtrisée, plan de secours, compilation des mesures (temps estimé, réel, retouches) | Soutenance |
| **Compréhension orale** (individuel) | 4 | **Deux questions posées à chaque étudiant**, notées sur l'échelle ci-dessous | Questions individuelles |
| **Contribution vérifiée** (individuel) | 2 | 1 point : lecture de **3 PR tirées au sort** parmi celles que l'étudiant a ouvertes ou approuvées ; 1 point : évaluation par les pairs | Dépôt, fiches |
| **Total** | **20** | 14 collectifs et 6 individuels | |

Vérification : 3 + 2 + 2 + 3 + 3 + 1 = 14 ; 4 + 2 = 6 ; 14 + 6 = 20.

**Échelle de compréhension orale (0 à 4).** Chaque question est notée de 0 à 4, la note est la moyenne des deux questions arrondie au demi-point. La question 1, préparée à l'avance sur une PR communiquée 24 h avant, porte l'essentiel de la note ; la question 2 vérifie la compréhension sur le vif (elle peut porter sur une règle du thème, un cas d'erreur d'agent, la fiche de conformité ou les droits d'une personne concernée).
- **0** : ne reconnaît pas la PR ou le projet, aucune explication.
- **1** : lit à voix haute sans dire pourquoi.
- **2** : explique ce que fait la PR et pourquoi, mais ne sait pas prévoir les conséquences d'un changement.
- **3** : explique, prévoit les conséquences d'une modification (« que se passe-t-il si je supprime cette ligne ? ») et repère un risque.
- **4** : en plus, propose un test ou une alternative argumentée, relie le travail aux règles du thème, aux données ou à la conformité, et nomme une limite. L'explication est faite **en langage clair**, comme à un chef de projet.

Repères pour la notation :
- **Plafonnement, annoncé en S1 et rappelé en S2** : si la contribution d'un étudiant est jugée nulle (aucune PR ouverte ou approuvée de façon substantielle, évaluation des pairs concordante), ses notes collectives sont plafonnées à **10 sur 14**. Le plafond ne sanctionne pas l'usage de l'IA : il vise l'étudiant qui profite du travail des autres, ou de l'agent, sans rien comprendre.
- **Bonus du clou niveau 2** : plafonné à 1 point, il s'ajoute à la note collective avant plafonnement : note collective finale = min(14, collectif + bonus) ; puis, si la contribution est jugée nulle, min(10, note collective finale).
- **Évaluation par les pairs** (1 point) : chaque étudiant note les autres membres de son équipe de 0 à 2 sur trois questions fixes. Pour chaque étudiant noté, on calcule **la somme des trois notes donnée par chaque évaluateur (0 à 6)**, puis **la médiane de ces sommes sur les évaluateurs**, convertie ainsi : **0 point si la médiane vaut 0 à 2, 0,5 point si elle vaut 3 à 4, 1 point si elle vaut 5 à 6**. Les fiches restent confidentielles.
- **Transparence de l'usage de l'IA** : prise en compte dans « Process git et équipe ». Un usage caché ou des cas d'erreur inventés sont sanctionnés, un usage franc ne l'est jamais.
- Les contributions sont vérifiées par la **lecture de PR tirées au sort et l'évaluation par les pairs**, non par un décompte de commits.
- **Un projet qui met des données réelles dans le dépôt ou dans un prompt** perd les points de conformité correspondants ; un secret commité est un incident à traiter (révocation) et à documenter.

### Format de la soutenance

- **Budget indicatif par équipe** (ordre de grandeur d'organisation, détaillé dans la section « Format de la soutenance » de S5) : une démonstration en direct sur un scénario choisi par l'équipe, un passage « sous le capot », un point de conformité (fiche, avis du RSSI, limites d'usage), puis les questions individuelles. Deux salles en parallèle, 4 équipes par salle (variante à 7 équipes : 4 et 3 équipes, voir S5), **un évaluateur et un second évaluateur ou observateur par salle** (à confirmer avant le 4 décembre), une **fiche de notation pré-remplie par étudiant** et un **calibrage** des évaluateurs avant les passages. **Si le second évaluateur est absent** : format dégradé à une salle, à budget réduit par équipe (voir S5) ; la note de compréhension orale est alors établie sur une durée plus courte par étudiant et par un seul évaluateur, ce qui est signalé aux étudiants comme un format dégradé.
- **Démonstration en direct**, avec plan de secours (démonstration enregistrée et jeu de données de secours, à utiliser seulement en cas de panne). Une démonstration enregistrée sans plan B live est pénalisée.
- **Questions individuelles** : **chaque étudiant reçoit deux questions**, avec la même trame pour tous. Question 1 (la plus longue) : une PR tirée au sort parmi celles qu'il a ouvertes ou approuvées, dont la taille atteint le seuil de **20 lignes modifiées hors fichiers générés** (à défaut, sa plus grosse PR), **communiquée 24 h avant** (le 15 décembre avant 9h). Question 2 (brève) : une question de compréhension.
- **Absent** : l'équipe passe normalement ; l'étudiant absent le jour de la soutenance est interrogé dans les 15 jours avec la même trame.
- **Dossier de rendu** (tag `v1.0-rc` le lundi 14 décembre à 18h, puis `v1.0` le matin de S5) : dépôt à jour, `README` d'installation, `CLAUDE.md`, `docs/ARCHITECTURE.md` (une page : composants, modèle de données, décisions), `docs/fiche_conformite.md` (avec réponse du RSSI), `JOURNAL.md`, et les PR avec leurs sections de suivi.

### Règles d'usage de l'IA

**L'usage de l'IA est autorisé et encouragé** : c'est l'objet de la formation. Il est encadré par cinq règles, chacune rattachée à un critère mesurable.

1. **Transparence** (« Process git et équipe »). Chaque PR contient une section « ce que l'agent a proposé, ce que j'ai refusé » et trois lignes de suivi (temps estimé, temps réel, retouches). L'étiquette `erreur-agent` retrouve les cas d'erreur. Les commits générés avec l'agent peuvent porter un trailer `Co-Authored-By`. Ce suivi sert à apprendre, pas à punir.
2. **Responsabilité** (« Compréhension orale »). L'étudiant qui ouvre ou approuve une PR en est responsable et doit pouvoir l'expliquer. « C'est l'agent qui l'a écrit » n'est pas une réponse recevable.
3. **Intégrité** (« Harnais et tests » et « Qualité, sécurité et livraison »). Interdits : désactiver ou supprimer un test pour le faire passer, copier le code d'une autre équipe sans le dire.
4. **Esprit critique** (« Process git et équipe »). Au moins **deux cas** documentés où l'équipe a repéré une erreur de l'agent et ce qu'elle en a fait.
5. **Confidentialité et conformité** (« Données et conformité »). **Aucune donnée personnelle ni confidentielle dans un prompt ni dans un dépôt public ; aucun secret dans le dépôt ; aucun outil mis en usage réel sans validation du RSSI.**

---

## 8. Stack, dépôt-modèle, socle commun et règles du jeu

### Décisions arrêtées

- **Dépôts GitHub publics** dans une organisation de la formation (Actions gratuites, protection de branche). **Aucun secret jamais dans le dépôt, aucune donnée réelle.**
- **Un dépôt-modèle** fourni par l'enseignant ; **8 dépôts créés par script** avant S2 (section 13), membres ajoutés **comme collaborateurs de chaque dépôt** (un seul mécanisme d'accès : pas d'invitation à l'organisation).
- **Git** : `gh auth login` ou connexion GitHub de VS Code. PR relue par un coéquipier dès S2 ; `main` protégée (PR obligatoire avec 1 approbation) ; CI obligatoire à partir de S4. **Merge commit seul**.
- **Horodatages** : stockés en UTC, affichés en Europe/Paris (passage à l'heure d'hiver : nuit du 24 au 25 octobre 2026, testé seulement là où le thème le demande).
- **Pile du projet : Flutter.** Les outils indispensables sont git + GitHub, VS Code, Claude Code (avec Claude Desktop) et Flutter ; Docker, Rust et Antigravity sont « utiles plus tard » et ne sont pas imposés au projet. Le dépôt-modèle fournit un squelette Flutter et un contexte réutilisable (`CLAUDE.md`, `docs/ARCHITECTURE.md`), ce qui permet à des non-développeurs d'aller vite et à l'enseignant de coacher 8 équipes sur une seule pile. **Cible d'exécution par défaut : Chrome** (`flutter run -d chrome`) ; le bureau est optionnel ; la chaîne Android peut rester en rouge dans `flutter doctor`. Toute autre cible est à discuter avec l'enseignant avant la fin de S2 (le coaching y serait limité).
- **Livraison : GitHub Pages.** Chaque équipe publie sa version web par GitHub Actions ; l'enseignant ne démontre aucun déploiement. GitHub Pages est public : données fictives uniquement, et tout ce qui est dans un build web Flutter est public (aucun secret dans l'application).

### Stack

| Domaine | Choix | Justification |
|---|---|---|
| Langage et environnement | **Dart et Flutter** (SDK installé en S1) ; dépendances verrouillées dans `pubspec.lock` (versionné) ; version de Flutter notée dans le `README` et dans `pubspec.yaml` | Un seul langage et un seul outil à coacher ; le verrouillage aide pendant la pause de 8 semaines |
| Cible d'exécution | **Chrome** (`flutter run -d chrome`) ; bureau optionnel | Aucune chaîne native à installer : sous Windows, le bureau demanderait Visual Studio, qu'on n'impose pas |
| Architecture | **Clean Architecture** : couches domain, data et presentation, une feature = un dossier | Sépare la règle métier de l'interface et des données ; donne à l'agent un cadre à respecter |
| Injection de dépendances | **get_it** | Simple, adapté au squelette ; permet de remplacer un repository par un fake dans les tests |
| État de l'interface | **flutter_bloc** (BLoC et Cubit) | Logique testable sans interface, conventions claires pour l'agent |
| Données | **drift (SQLite)** avec migrations versionnées (`schemaVersion` et stratégie de migration), base en mémoire pour les tests | Migrations explicites, requêtes typées. Clés étrangères à activer explicitement ; configuration de drift sur le web fournie par le squelette (à vérifier sur les versions installées) |
| Tests (TDD) | **flutter_test**, **bloc_test**, **mocktail** ; couverture avec `flutter test --coverage` | Standard de l'écosystème, adapté au TDD |
| Tests (BDD) | **bdd_widget_test** : scénarios Gherkin en français dans des fichiers `.feature`, tests widget générés par `build_runner` | Rend les cas d'acceptation lisibles par des non-développeurs ; les `.feature` du clou sont dans `test/acceptance/` |
| Qualité | **`flutter analyze`** et **`dart format`** | Outils fournis avec le SDK, se branchent dans un hook |
| Sécurité | **gitleaks** et audit des dépendances pub en CI (S4) ; aucun secret dans l'application | Détection de secrets sur l'historique complet (`fetch-depth: 0`), binaire de version épinglée ; outil d'audit des dépendances pub à vérifier |
| CI/CD | **GitHub Actions** ; **`flutter build web`** publié sur **GitHub Pages** par chaque équipe | Gratuit sur dépôt public (quotas à vérifier). Workflow minimal (`flutter analyze`, `flutter test`) dès le modèle, complet en S4 |
| Rôles | **Garde d'accès `RequireRole`** dans la couche domain, utilisateur courant simulé fourni par le squelette (deux rôles de démonstration) | Les étudiants branchent leurs rôles. Ce n'est pas une sécurité réelle : l'application web est publique, sans secret ni mot de passe |
| Import et export CSV | **file_picker**, parseur dans la couche data | Taille maximale, rejet motivé ; neutralisation des formules à l'export |
| Commandes | `flutter pub get` ; `flutter test` ; `flutter test --coverage` ; `flutter analyze` ; `dart format` ; `dart run build_runner build --delete-conflicting-outputs` ; `flutter run -d chrome` ; `flutter build web` | Fonctionne sous Windows, macOS et Linux sans outil supplémentaire (pas de `make`) |
| Docker | **Optionnel** (utile plus tard) | Plus de conteneur dans le parcours : la publication passe par GitHub Pages |
| Agent | **Claude Code dans VS Code** (avec Claude Desktop ; Antigravity en comparaison) | Outil de la formation |

### Contenu du dépôt-modèle

**À produire par l'enseignant** : `pubspec.yaml` et `pubspec.lock` figés (version de Flutter notée) ; squelette Flutter en couches (domain, data, presentation ; une feature = un dossier) avec `get_it` configuré, un BLoC d'exemple, un test unitaire et un fichier `.feature` d'exemple (`bdd_widget_test`), une base drift d'exemple (une table, `schemaVersion` 1, clés étrangères activées, test d'intégrité sur base en mémoire, configuration web qui fonctionne avec `flutter run -d chrome` ; à vérifier sur les versions retenues), un utilisateur courant simulé à deux rôles et une garde `RequireRole` d'exemple avec son test de refus, un dossier `test/acceptance/` vide, toutes les dépendances du socle (drift, file_picker, build_runner, bdd_widget_test, bloc_test, mocktail) déjà déclarées et figées dans `pubspec.lock` ; configuration `flutter analyze` ; workflow GitHub Actions minimal (`flutter analyze` et `flutter test`) ; `CLAUDE.md` de départ avec `.claude/settings.json` (refus de lecture de `.env`) et `docs/ARCHITECTURE.md` (structure Clean Architecture, injection `get_it`, conventions BLoC, discipline TDD et BDD : le **contexte réutilisable** d'un projet à l'autre) ; `.gitignore` qui ignore `.env` ; `.env.example` ; `JOURNAL.md` (en-tête « État courant ») ; `PROJET.md` (version **pré-remplie par thème** : vision et user stories proposées, copiée dans chaque dépôt par le script selon le thème) ; `docs/fiche_conformite.md` (gabarit en 13 rubriques du module, avec le champ « rôle AI Act : fournisseur ou déployeur ? » et la case de classement « hors champ / minimal / obligations de transparence (art. 50) / haut risque / interdit » ; aucun nom civil ni courriel) ; modèle de PR (`.github/pull_request_template.md`). Testé à froid sur Windows, macOS et Linux avant S2 (`flutter pub get`, `flutter test`, `flutter run -d chrome`).

### Socle commun (identique pour tous les thèmes)

Le détail des thèmes (cas d'acceptation chiffrés, « clou » à deux niveaux, « livrable minimum viable ») est dans `cours/projets/themes.md`.

**Obligatoire :**
- Au moins **4 entités liées** dans une base SQLite gérée par drift (les thèmes en définissent 5), avec migrations versionnées et test d'intégrité sur base en mémoire.
- Un **CRUD** sur l'entité principale, avec des écrans Flutter branchés sur des BLoC (exécutés dans Chrome).
- **Deux rôles** d'utilisateurs, branchés sur la garde d'accès `RequireRole` (couche domain), avec test de refus.
- La règle métier **« clou » niveau 1**, avec ses scénarios d'acceptation (`.feature`) écrits avant le code de l'agent et le résultat mesuré sur les cas publiés.
- Un **seed** reproductible (données fictives).
- Un **import CSV** : **un seul fichier CSV par thème**, fait pendant le sprint, (`file_picker`, parseur dans la couche data), avec taille maximale et rejet motivé (les motifs de rejet sont dans `cours/projets/themes.md`). Si l'équipe est en retard, le CRUD se limite à la création et à la lecture, et le seed complet cède avant l'import CSV.
- Les **mesures de conformité du thème** (A : mention d'information et script de suppression documenté ; B : aucun identifiant d'opérateur dans les données métier, consigne affichée sur les commentaires ; C : statut `brouillon` / `publie` avec validation humaine avant publication), incluses dans les 15 à 20 h.
- Des **tests** (unitaires, BDD, intégrité, acceptation), une **CI** verte, la version web publiée sur GitHub Pages, un `README` testé à froid.
- La **fiche de conformité** complète et la réponse du RSSI.

**Souhaitable** (à sacrifier dans cet ordre en cas de retard) : export CSV (avec la neutralisation des formules vue en S4), tableau de bord, clou niveau 2 (bonus plafonné à 1 point).

### Règles du jeu

1. **Pas de code non relu.** Toute PR est relue par quelqu'un d'autre que l'auteur, avant fusion.
2. **On comprend ce qu'on livre.** Chacun peut expliquer n'importe quelle PR qu'il a ouverte ou approuvée.
3. **Commits petits et lisibles**, merge commit uniquement : le commit de test précède le code dans l'historique.
4. **`main` est protégée.** Pas de push direct, PR obligatoire avec 1 approbation ; à partir de S4, CI verte obligatoire.
5. **Jamais de secrets dans le dépôt** (clés d'API, mots de passe, jetons). Le dépôt est public : nom, PR et commits y sont visibles, d'où l'adresse noreply de GitHub.
6. **Données fictives uniquement.** Aucune donnée personnelle réelle (étudiants, salariés, camarades), ni dans le dépôt, ni dans un prompt.
7. **On ne triche pas avec les tests.** Pas de test supprimé, désactivé ou assoupli. `test/acceptance/**` n'est modifié que par un humain, dans une PR relue.
8. **Agent sous contrôle.** Permissions par défaut ; pas de mode « sans confirmation » sur sa machine personnelle ; actions destructrices refusées par configuration ; un agent par étudiant, sur sa propre branche.
9. **`CLAUDE.md` est maintenu.** Toute règle apprise y est ajoutée.
10. **Aucune mise en usage réelle sans validation du RSSI.** Cette règle s'applique dès qu'un outil sort de la formation, même s'il est temporaire.

---

## 9. Le projet fil rouge : les trois thèmes

Les énoncés complets sont dans `cours/projets/themes.md` : mise en situation, besoin ponctuel (pourquoi un outil de courte durée suffit, ce qui reste obligatoire, désactivation et archivage), données, rôles, user stories, règle métier « clou » avec cas d'acceptation, conformité, découpage par séance, livrable minimum viable.

| Thème | Mise en situation | Difficulté propre | Sensibilité conformité |
|---|---|---|---|
| **A** · Les Marches de Cendrelune | Carnet de campagne d'un club de jeu de rôle (fiches, quêtes au d20, points de vie, expérience, niveaux) | État qui évolue, hasard injecté | Faible (pseudonymes de joueurs) |
| **B** · Ligne 4 | TRS (OEE) d'un atelier de câblage à partir des événements de production | Unités, arrondis, changement d'heure | Moyenne (postes, quarts ; aucun identifiant d'opérateur stocké) |
| **C** · Vœux de projet | Répartition de sujets de projet selon les vœux classés d'étudiants | Algorithme d'affectation déterministe, cas de bord | Élevée (étudiants, décision d'affectation) |

Les trois thèmes ont la même charge estimée (15 à 20 h d'équipe, à calibrer lors de cette première promotion), **mesures de conformité comprises**. Le thème C demande plus de travail de conformité ; un thème sensible n'est pas plus difficile : il est plus formateur pour la conformité.

**Procédure de choix (formulaire, puis validation en S2).**
1. **Maximum 3 équipes par thème.** Répartition visée : **8 équipes : 3-3-2 ; 7 équipes : 3-2-2 ou 3-3-1. Tirage au sort si un thème dépasse 3 candidats.**
2. Chaque équipe classe ses trois thèmes dans le **formulaire** clos le jeudi 8 octobre à 12h. L'enseignant attribue d'abord les premiers choix, de façon provisoire, et prépare les dépôts.
3. En S2, on **valide** ; s'il y a litige, **tirage au sort** entre les équipes concernées, les équipes non retenues passant à leur choix suivant.
4. Les équipes sont **numérotées par thème** (8 équipes : A : 01 à 03 ; B : 04 à 06 ; C : 07 et 08 ; 7 équipes : A : 01 à 03 ; B : 04 et 05 ; C : 06 et 07) ; la numérotation sert aux appariements de S3 et de S4.
5. Deux équipes sur un même thème construisent chacune leur propre dépôt, sans partage de code (le code d'un dépôt public est visible : c'est une raison de plus de s'en tenir à la règle d'intégrité).

---

## 10. Conformité : AI Act, RGPD et validation RSSI

Le module de référence est `cours/conformite-ai-act-rgpd.md` (sensibilisation, pas avis juridique). Il poursuit un **double but** : connaître les **limites de ses projets** (et toujours faire valider par le RSSI) et connaître ses **droits de citoyen européen**.

| Moment | Contenu | Livrable |
|---|---|---|
| **S1** | Règle d'or : aucune donnée personnelle ni confidentielle dans un prompt ni dans un dépôt public | Règle comprise |
| **S3** (bloc RGPD) | RGPD (règlement (UE) 2016/679) : principes, bases légales, sous-traitants (dont le fournisseur de modèle), violation de données ; **droits** (art. 12 à 22, réclamation art. 77) ; test en 4 questions ; début de la fiche | `docs/fiche_conformite.md`, rubriques 1 à 5, commité (livrable de fin de S3) |
| **S4** (exposé AI Act, atelier de classification, passage devant le RSSI) | AI Act (règlement (UE) 2024/1689) : étape 0 « système d'IA ? », niveaux de risque, rôles fournisseur et déployeur, art. 4, 50, 86 ; classification de son projet ; passage devant le RSSI sur 3 tables en parallèle (un RSSI par table, rotation des équipes), jeu de rôle intégré | Brouillon présenté, classement et rôle provisoires (rubriques 8 et 9) ; v1 déposée en PR le 8 décembre |
| **Sprint** | Rubriques 6, 7 et 10 à 12 avant la v1 du 8 décembre ; réponse du RSSI avant le 11 décembre (rubrique 13) ; mise à jour avant le gel | Fiche complète |
| **S5** | Fiche présentée dans la partie conformité de la soutenance et évaluée dans « Données et conformité » | Dossier de rendu |

**Fiche de conformité.** Une page par projet, tenue dans le dépôt à **un seul chemin**, `docs/fiche_conformite.md`, selon le **gabarit en 13 rubriques** du module (§6.1) : finalité, données traitées, personnes concernées, base légale ou justification « données fictives », durée de conservation et date de suppression, hébergement et sous-traitants dont le fournisseur de modèle d'IA, ce qui part dans les prompts, décision automatisée, **rôle AI Act (fournisseur ou déployeur) et classement** (case unique : hors champ, minimal, obligations de transparence (art. 50), haut risque, interdit), exercice des droits, mesures, risques résiduels et limites d'usage, validation du RSSI datée. `cours/projets/themes.md` renvoie à ce même gabarit et à ce même chemin.
- **Aucun nom civil, aucune adresse de courriel** dans la fiche (les dépôts sont publics) : « équipe n° X », identifiants GitHub, « RSSI (rôle) ».
- **Calendrier** : début en S3 (commité en fin de séance), passage devant le RSSI en S4, **v1 en PR le mardi 8 décembre, réponse du RSSI avant le vendredi 11 décembre**.
- **Portée d'un « go »** : il vaut uniquement pour le périmètre pédagogique à données fictives ; tout passage à des données réelles impose une nouvelle fiche et une nouvelle validation.

**Le RSSI : choix de l'enseignant, avant S3.** Soit le RSSI est **simulé par l'enseignant** (déroulé identique, ton réaliste, no-go possible), soit il est **tenu par le RSSI de l'établissement** (invité en S4 ou répondant par écrit aux PR). Le passage de S4 ayant lieu sur **3 tables en parallèle**, il faut trois intervenants ou, à défaut, des étudiants volontaires munis de la grille. Dans tous les cas : critères go et no-go du module (section 6.2), réponse écrite et datée dans la PR, absence de réponse = no-go par défaut.

**Points d'attention pour les thèmes** (mesures incluses dans les 15 à 20 h). A : identifiant de joueur (donnée personnelle) ; **mention d'information et script de suppression documenté obligatoires**, export des données du joueur en extension. B : **aucun identifiant d'opérateur stocké dans les données métier** (seul le compte de connexion existe) ; contrôle des commentaires libres par une consigne affichée et une revue en audit croisé ; suivi individuel de la performance à qualifier (annexe III, point 4, à discuter ; consultation des représentants du personnel dans un contexte réel, à vérifier). C : décision d'affectation (art. 22 RGPD) ; **champ de statut `brouillon` / `publie` obligatoire** : la validation humaine effective avant publication est ce qui peut écarter la qualification de décision exclusivement automatisée (à vérifier avec le RSSI ou le DPO) ; éducation (annexe III, point 3), droit à l'explication ; « traiter comme si haut risque » est une **démarche de précaution pédagogique, pas une qualification juridique**. Le thème C demande plus de travail de conformité.

**Droits de citoyen, mode d'emploi** (rappelé en S3, tableau complet dans le module, section 5) : s'adresser au responsable de traitement ou à son DPO, par écrit daté ; réponse sous un mois (prolongeable) ; à défaut, réclamation gratuite auprès de la CNIL.

**Calendrier de l'AI Act** : le module consigne un état au 1er octobre 2026, avec plusieurs dates marquées « à vérifier » (omnibus numérique sur l'IA, report du haut risque). Le règlement modificatif est le règlement (UE) 2026/1744, publié au JO le 24 juillet 2026 et en vigueur le 27 juillet 2026 (à vérifier sur EUR-Lex). **Art. 4** après l'omnibus : les fournisseurs et déployeurs prennent des mesures pour favoriser la maîtrise de l'IA de leurs personnels et des personnes qui utilisent des systèmes d'IA en leur nom (à vérifier sur EUR-Lex). L'enseignant revérifie le texte avant de diffuser (checklist, section 13).

---

## 11. Risques et parades

| Risque | Signaux | Parades |
|---|---|---|
| **S1 saturée** (trop de théorie et trop d'installations) | Retard cumulé, postes indispensables encore en rouge à l'approche du rattrapage | Théorie priorisée par niveaux de poids ; installations en 5 blocs ; téléchargements lancés pendant les exposés (SDK Flutter en priorité) ; rattrapage au bloc 12 ; ce qui n'est pas indispensable (Docker, Rust, Antigravity) peut glisser en S2 ou S4 |
| **Réseau saturé à 32 postes** | Téléchargements lents, délais d'expiration | Pre-flight avec téléchargement chez soi ; miroir local sur clés USB ; échelonnement par quart de salle ; points d'accès supplémentaires ; partage de connexion mobile |
| **Quotas et coûts de Claude Code ×32** | Quota épuisé en séance, compte partagé interdit, dépassement de budget | Décision au plus tard le lundi 5 octobre (retour du pre-flight) ; plan de repli fixé dès maintenant (binômes sur postes authentifiés) ; plafond de dépense par étudiant et suivi ; sessions courtes (`/clear`), mode plan ; Antigravity en second outil (à vérifier) |
| **Installations ratées** | Droits d'administration manquants, antivirus, espace disque (SDK Flutter volumineux), `flutter doctor` en rouge sur Chrome | Pre-flight avec capture ; fiches par système ; 2 à 3 aides ; priorisation (git, VS Code, Claude Code et Flutter d'abord) ; plan B (binôme, espace de développement cloud, à vérifier) |
| **Écarts de niveau d'un public non développeur** | Certains perdus dès `git`, d'autres s'ennuient | Équipes mixtes ; fiches prêtes à copier ; binômes d'entraide ; l'enseignant et les aides circulent surtout dans les équipes fragiles ; exercices à difficulté croissante (conflit, hooks en option) |
| **Séances S2, S3 et S4 trop denses pour des non-développeurs** | Postes encore en échec en S2, seed et rôles non faits en S3, passage devant le RSSI qui déborde en S4 | Équipes, thèmes et dépôts préparés avant S2 ; S3 allégée (seed complet et rôles reportés) ; S4 avec publication GitHub Pages guidée et plan B local, audit en 5 points et pondération des blocs (indispensable, important, pratique, moins utile) et rubriques « si la séance prend du retard » et « peut glisser » dans chaque séance ; entre S3 et S4, une seule tâche facultative d'1 h |
| **Vibe coding sans comprendre** | PR énormes, étudiant incapable d'expliquer, tests écrits par l'agent après le code | Règle « chacun explique sa PR » ; PR petites ; revue croisée avec explication orale ; TDD et BDD en S3 ; test d'acceptation indépendant en S4 ; deux questions individuelles par étudiant (4 points) |
| **Projet hors périmètre RGPD** | Une équipe veut des données réelles de camarades, d'une entreprise, ou déployer pour de vrais utilisateurs | Règle d'or dès S1 ; test en 4 questions en S3 ; fiche et validation RSSI avant tout usage réel ; no-go par défaut ; données réelles = perte de points de conformité, pas de dérogation |
| **Fuite de secrets ou de données dans un dépôt public** | Clé d'API, courriel réel, capture avec noms dans un commit | Règle « jamais de secrets », `.env` ignoré et refusé à la lecture par l'agent, gitleaks en CI, aucun secret dans l'application (tout build web est public) ; **révoquer** un secret qui a fui, même après suppression du commit ; signaler au RSSI comme un incident (art. 33 RGPD : 72 heures s'il y a des données personnelles) |
| **RSSI indisponible ou en retard** | Pas de réponse le 11 décembre | Désignation avant S3 ; réponse par écrit dans la PR ; remplaçant prévu (enseignant) ; pas de réponse = no-go par défaut, l'équipe documente l'attente |
| **Publication web exposée (GitHub Pages)** | Données réelles ou secret dans le bundle, URL publique | Données fictives uniquement ; aucun secret dans l'application ; gitleaks et contrôle du build ; garde `RequireRole` présentée comme pédagogique, pas comme sécurité réelle ; publication désactivée après la soutenance |
| **GitHub Pages ou Actions indisponible ou mal configuré** | Publication impossible, mauvais chemin de base, page blanche | Activation de Pages vérifiée sur un dépôt test avant S4 ; plan B local (`flutter build web`, `flutter run -d chrome`) ; la publication peut finir dans le sprint |
| **Équipes déséquilibrées, passager clandestin** | Un seul fait tout, ou un absent bloque | Rôles explicites ; lecture de 3 PR tirées au sort ; évaluation par les pairs ; plafonnement à 10/14 annoncé ; point d'équipe à chaque début de séance |
| **Oubli pendant les 8 semaines** | Séance 3 absorbée par la remise en route | `JOURNAL.md`, tag `s2-fin`, `pubspec.lock`, CI minimale, smoke test du 20 novembre, rappels des 16 et 24 novembre, micro-livrable du 27 novembre, remise en route en ouverture de S3 |
| **Dérive de version de Claude Code ou des modèles** | Un réglage ne marche plus | Noter la version de Claude Code et celle de Flutter, relire les permissions ; syntaxe à vérifier avant S2 et S3 |
| **Actions destructrices de l'agent** | Suppression, push forcé | Permissions refusant ces actions dès S2 ; sauvegarde par git ; cas Replit ; pas de mode sans confirmation |
| **Test qui valide ses propres défauts (self-grading)** | Suite verte mais règle fausse | Test d'acceptation écrit par le gardien produit avant le code, valeurs recopiées, protégé par `deny`, `CODEOWNERS` et CI |
| **Pièges drift, SQLite et migrations** | Contrainte non vérifiée, deux branches qui incrémentent `schemaVersion`, fichiers générés en conflit, base web mal configurée | Réglages fournis par le squelette (clés étrangères activées, base en mémoire pour les tests, configuration web, à vérifier) ; test d'insertion orpheline exigé ; une seule migration à la fois ; règle de versionnement des fichiers générés fixée dans le dépôt-modèle |
| **Pile Flutter et Clean Architecture trop lourde pour des non-développeurs** | Code mal rangé, agent qui contourne les couches, `build_runner` lent ou en échec | Squelette, `CLAUDE.md` et `docs/ARCHITECTURE.md` fournis (à produire) ; une feature = un dossier ; la structure est donnée en contexte à l'agent ; question de revue « dans quelle couche ? » ; commandes de référence sur une fiche |
| **Soutenance à deux salles** | Retard dans une salle, second évaluateur absent, fatigue et erreurs de notation | Second évaluateur ou observateur confirmé avant le 4 décembre ; fiche de notation pré-remplie par étudiant ; calibrage des évaluateurs ; chronomètre visible ; transitions prévues entre équipes ; lecture préalable des dépôts ; plan B : format à une salle, à budget réduit par équipe (dégradé, signalé aussi pour la note d'oral, section 4) |
| **Panne le jour de la soutenance** | Démonstration qui plante | Plan B enregistré ; jeu de données de secours ; répétition technique en S5 ; machine de secours |
| **Confiance excessive dans les chiffres** | « L'IA nous rend 10 fois plus rapides » | Sources présentées avec leurs conflits d'intérêts ; mesure de leur propre usage (temps estimé, réel, retouches) |
| **Dérive de périmètre** | Trop de fonctionnalités, rien de fini | Socle limité ; clou en deux niveaux ; backlog priorisé ; gel le 11 décembre |

---

## 12. Ressources

Les sources sont en anglais ; le titre exact est indiqué. Pour des non-développeurs, les lectures sont données comme approfondissement facultatif.

### Craft, posture et IA (S1)
- Kent Beck, « Augmented Coding: Beyond the Vibes » (Substack *Tidy First?*, 25 juin 2025).
- Simon Willison, « Vibe engineering » (7 octobre 2025, mis à jour le 23 février 2026) et guide *Agentic Engineering Patterns* (2026).
- Sandro Mancuso (Codurance), « Software Craftsmanship in the AI Era » (9 février 2026). *Éditeur : source à lire avec ce recul.*
- Étude METR (juillet 2025, arXiv 2507.09089), avec ses limites.
- Jalons de l'histoire du craft (dates à vérifier) : Fred Brooks, *The Mythical Man-Month* ; Ward Cunningham (dette technique, 1992) ; Kent Beck, *Test-Driven Development by Example* ; Eric Evans, *Domain-Driven Design* (2003) ; Dan North, « Introducing BDD » (2006) ; Manifestes Agile et Software Craftsmanship.
- Dossiers de synthèse du dépôt : `cours/sources/craft.md`, `cours/sources/agentic-engineering.md`, `cours/sources/ai-dlc.md`, `cours/sources/spec-driven.md`. **Écrits pour un autre public (un CTO) : à filtrer avant de les distribuer.**

### Contexte, harnais et configuration (S2)
- Anthropic, « Effective context engineering for AI agents » (29 septembre 2025).
- Ryan Lopopolo (OpenAI), « Harness engineering: leveraging Codex in an agent-first world » (11 février 2026). *Contenu d'éditeur.*
- Birgitta Böckeler (Thoughtworks), « Harness engineering for coding agent users » (martinfowler.com, 2 avril 2026).
- Incident Replit (juillet 2025), AI Incident Database n° 1152 (à vérifier : numéro issu d'un dossier de synthèse, non confirmé sur la base elle-même).
- Documentation officielle de Claude Code (permissions, hooks, skills, plugins, MCP, sous-agents, mode plan).
- Dépôt GitHub spec-kit (cadre de spec-driven development ; à vérifier) ; format `AGENTS.md` et spécification Agent Skills (agentskills.io).
- Documentation officielle de git (*Pro Git*, git-scm.com) et de GitHub (Docs).

### Données, équipe, qualité, sécurité et CI/CD (S3, S4)
- Willison, « Don't file pull requests with code you haven't reviewed yourself ».
- Rapport DORA 2025 (Google).
- Documentation de Flutter, Dart, `flutter_bloc`, `get_it`, drift, `bdd_widget_test`, `bloc_test`, `mocktail`, GitHub Actions et GitHub Pages (syntaxe exacte à vérifier avant S2) ; Robert C. Martin, *Clean Architecture*.
- OWASP Top 10 (version courante).
- Sur la « lethal trifecta » : billets de Simon Willison et Martin Fowler (référence exacte à vérifier).

### Conformité (S3, S4, S5)
- RGPD, règlement (UE) 2016/679 : https://eur-lex.europa.eu/eli/reg/2016/679/oj
- AI Act, règlement (UE) 2024/1689 : https://eur-lex.europa.eu/eli/reg/2024/1689/oj
- Commission européenne, cadre réglementaire de l'IA et calendrier : https://digital-strategy.ec.europa.eu/en/policies/regulatory-framework-ai
- AI Act Service Desk de la Commission : https://ai-act-service-desk.ec.europa.eu (à vérifier)
- CNIL, exercer ses droits et réclamation : https://www.cnil.fr (rubriques « Besoin d'aide » et « Plaintes ») ; modèles de courriers.
- CNIL, rubrique « Intelligence artificielle » : https://www.cnil.fr/fr/intelligence-artificielle (à vérifier) ; CNIL, analyse d'impact (AIPD) et liste des traitements concernés (à vérifier).
- Comité européen de la protection des données (lignes directrices, dont décision automatisée) : https://www.edpb.europa.eu
- Règlement (UE) 2026/1744 modifiant le règlement (UE) 2024/1689, publié au JO le 24 juillet 2026, en vigueur le 27 juillet 2026 : lien à récupérer sur EUR-Lex (à vérifier).
- Module du dépôt : `cours/conformite-ai-act-rgpd.md`. **Avant diffusion, revérifier le texte de l'omnibus numérique sur l'IA sur EUR-Lex et les liens ci-dessus.**

### Pour l'enseignant (approfondir)
- Cyrille Martraire, *Software Craft*, 2e édition (Dunod, 2025).
- Martin Fowler, « Expert Generalists ».
- Énoncés du projet : `cours/projets/themes.md`.

---

## 13. Checklist enseignant (interne, ne pas diffuser aux étudiants)

**Préparation pour 32 étudiants.** À cocher avant le 7 octobre sauf indication.

- [ ] **Comptes Claude Code ×32 et quotas** : décider **au plus tard le lundi 5 octobre** (retour du pre-flight) du mode d'accès (comptes ou crédits nominatifs avec plafond de dépense, suivi de consommation ; conditions de l'offre et du fournisseur à vérifier, dont conservation des données, usage pour l'entraînement et localisation, qui alimentent la fiche de conformité). **Plan de repli déjà fixé** : binômes sur postes authentifiés. Le courriel pre-flight du 1er octobre annonce que les comptes seront confirmés avant le 5. Interdit : une clé d'API dans un dépôt.
- [ ] **Antigravity** : vérifier connexion et quotas pour 32 comptes (à vérifier).
- [ ] **Organisation GitHub de la formation**, dépôts publics : création, Actions activées. **Un seul mécanisme d'accès : les étudiants sont ajoutés comme collaborateurs de chaque dépôt, sans invitation à l'organisation** (identifiants GitHub reçus avec le pre-flight) ; permissions de base de l'organisation sur « aucune ».
- [ ] **Formulaire d'équipes** (lancé à la fin de S1, clos le jeudi 8 octobre à 12h) : composition, classement des trois thèmes, identifiants GitHub. Attribution provisoire par l'enseignant le jeudi après-midi, dépôts préparés avant S2.
- [ ] **Dépôt-modèle** (contenu en section 8, **à produire**), cloné puis lancé à froid sur Windows, macOS et Linux (`flutter pub get`, `flutter test`, `flutter run -d chrome`) ; **trois versions pré-remplies de `PROJET.md`** (une par thème).
- [ ] **Squelette Flutter du dépôt-modèle (à produire)** : structure en couches (domain, data, presentation ; une feature = un dossier), `get_it` configuré, un BLoC d'exemple avec son test, un test unitaire, un fichier `.feature` d'exemple (`bdd_widget_test`, génération par `build_runner`), une base drift d'exemple (une table, `schemaVersion` 1, clés étrangères activées, test d'intégrité sur base en mémoire, configuration web qui fonctionne avec `flutter run -d chrome` ; à vérifier sur les versions retenues), un utilisateur courant simulé à deux rôles et une garde `RequireRole` d'exemple avec son test de refus, un dossier `test/acceptance/` vide, toutes les dépendances du socle (drift, file_picker, build_runner, bdd_widget_test, bloc_test, mocktail) déjà déclarées et figées dans `pubspec.lock`, `pubspec.lock` versionné, version de Flutter notée, CI minimale (`flutter analyze` et `flutter test`), puis le workflow complet de S4 (couverture, audit des dépendances pub, gitleaks, build web, déploiement GitHub Pages ; syntaxe de l'action de déploiement à vérifier). Fichiers générés par `build_runner` non versionnés (recommandé) : `build_runner` est lancé par la CI et par la commande de démarrage. Testé à froid avant le 7 octobre.
- [ ] **Contexte réutilisable (à produire)** : `CLAUDE.md` et `docs/ARCHITECTURE.md` décrivant la structure Clean Architecture, l'injection `get_it`, les conventions BLoC, la discipline TDD et BDD ; réutilisable d'un projet à l'autre, fourni dans le dépôt-modèle comme premier élément de contexte pour l'agent.
- [ ] **Projet Flutter d'exemple pour S1 (à produire)** : copie du squelette, `flutter test` vert et `flutter run -d chrome` fonctionnel, mis à disposition des étudiants (dépôt public ou archive sur le miroir local).
- [ ] **Support à part pour les thèmes (à produire)** : présentation des trois thèmes A, B et C, transmise avec le formulaire d'équipes (modalité à confirmer).
- [ ] **Script de création des 8 dépôts** (à tester sur un dépôt test, appels à vérifier sur l'organisation), à lancer avant S2 avec la liste des équipes :

```bash
#!/usr/bin/env bash
# usage : ./creer-depots.sh <organisation> <modele> <equipes.csv>
# equipes.csv : un membre par ligne, "numero_equipe,login_github" (ex. 01,monlogin)
set -euo pipefail
ORG="$1"; MODELE="$2"; EQUIPES="$3"
for i in 01 02 03 04 05 06 07 08; do
  REPO="$ORG/equipe_$i"
  gh repo create "$REPO" --public --template "$ORG/$MODELE"
  # la création depuis un modèle est asynchrone : attendre l'existence de main
  for essai in $(seq 1 30); do
    gh api "repos/$REPO/branches/main" >/dev/null 2>&1 && break
    sleep 2
  done
  gh api "repos/$REPO/branches/main" >/dev/null   # échoue (set -e) si main n'existe toujours pas
  gh api -X POST "repos/$REPO/labels" -f name="erreur-agent" -f color="d73a4a" \
    -f description="Erreur de l'agent repérée et documentée"
  gh api -X PATCH "repos/$REPO" -F allow_merge_commit=true -F allow_squash_merge=false \
    -F allow_rebase_merge=false -F delete_branch_on_merge=true
  gh api -X PUT "repos/$REPO/branches/main/protection" --input - <<'JSON'
{
  "required_status_checks": null,
  "enforce_admins": true,
  "required_pull_request_reviews": { "required_approving_review_count": 1 },
  "restrictions": null
}
JSON
done
# ajout des membres comme collaborateurs de chaque dépôt (avant S2, sur la liste reçue)
tr -d '\r' < "$EQUIPES" | while IFS=, read -r num login; do
  gh api -X PUT "repos/$ORG/equipe_$num/collaborators/$login" -f permission="push"
done
# puis, pour chaque dépôt : copier la version de PROJET.md du thème (A, B ou C) et la commiter
```

  Les invitations de collaborateur doivent être acceptées par les étudiants (rappel par courriel avant S2). En cas de litige résolu en S2, renommer le dépôt (`gh repo rename`) et remplacer `PROJET.md`. En S4, relancer la protection avec le contrôle de CI requis et la relecture des propriétaires du code.
- [ ] **Pre-flight envoyé le jeudi 1er octobre** (retour le lundi 5 octobre, relances individuelles) : demander un compte GitHub, VS Code, git, Google Chrome (s'il n'est pas installé) et le **téléchargement chez soi du SDK Flutter** (WSL2 et Docker Desktop ne sont plus demandés), les identifiants GitHub, et annoncer que les comptes Claude Code seront confirmés au plus tard le lundi 5 octobre. Miroir local d'installeurs sur clés USB (SDK Flutter en premier), fiches d'installation par système, liste « indispensable » / « utile plus tard » prête pour le premier bloc de S1.
- [ ] **Assistants** : demander 2 à 3 aides pour S1 et S2, 1 pour S3 et 2 pour S4 (dont l'une tient une table RSSI) ; un second évaluateur ou observateur par salle pour S5 (confirmer avant le 4 décembre ; sinon format dégradé).
- [ ] **RSSI** : choisir le mode (simulé par l'enseignant ou RSSI de l'établissement) **avant S3** ; prévoir trois intervenants pour les trois tables de S4 (à défaut, étudiants volontaires) ; en cas de RSSI de l'établissement, fixer sa venue en S4 ou son mode de réponse écrite avant le 11 décembre.
- [ ] **Réseau et salle** : test à charge réelle (32 téléchargements), points d'accès supplémentaires, prises, vidéoprojecteur ; deux salles réservées pour S5.
- [ ] **GitHub Pages pour S4** : vérifier sur un dépôt test l'activation de Pages (source GitHub Actions), le workflow de déploiement, le chemin de base du build web et les conditions de l'offre pour un dépôt public (à vérifier) ; chercher si l'activation peut se faire par `gh api` dans le script de création (à vérifier), sinon à la main ; plan B local prêt ; rappeler : données fictives, aucun secret dans le bundle.
- [ ] **Conformité** : revérifier sur EUR-Lex l'omnibus numérique sur l'IA (règlement (UE) 2026/1744), la formulation de l'art. 4 et les dates de l'AI Act, les liens CNIL, et le chiffre Stanford (Denisov-Blanch, 10 à 20 %) ; vérifier la durée de vie du cache de prompt avant le diaporama de S1.
- [ ] **Syntaxe** des permissions, hooks, skills, plugins et MCP vérifiée sur la version de Claude Code utilisée ; outil spec-kit essayé à froid ; noms de paquets et d'options (Flutter, `bdd_widget_test`, drift, audit des dépendances pub) vérifiés sur les versions retenues.
- [ ] **Documents** : diaporama S1 (environ 76 diapos), fiche git, fiche de configuration, checklist de PR, de revue, de reprise, d'audit, gabarit et cartes de cas de conformité, grille go/no-go, échelle de compréhension orale, fiche de pairs, fiche d'observation, **fiches de notation pré-remplies par étudiant**, plan des tables du passage devant le RSSI, formulaire d'équipes.
- [ ] **Calendrier** : smoke test vers le 20 novembre ; courriels des 16 et 24 novembre ; échéance du 27 novembre, relance du 30 ; fiche v1 déposée le 8 décembre ; point d'étape le 9 ; réponse du RSSI et gel le 11 ; `v1.0-rc` le 14 à 18h ; lecture des dépôts et communication des PR le 15 avant 9h.


