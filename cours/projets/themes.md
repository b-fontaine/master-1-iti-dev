# Les trois thèmes du projet fil rouge

## Pile technique du projet

Les trois thèmes se construisent avec la même pile, détaillée dans `cours/programme-detaille.md` (séances, outils, CI) :

- **Application Flutter (Dart)**, exécutée par défaut dans **Chrome** (`flutter run -d chrome`). Le bureau (Windows, macOS, Linux) est optionnel ; la chaîne Android peut rester en rouge dans `flutter doctor` (non requise).
- **Clean Architecture** : couches `domain` (entités, règles métier pures, cas d'usage, interfaces de repositories), `data` (implémentations, drift, parseur CSV) et `presentation` (écrans, BLoC/Cubit). Une feature = un dossier.
- **Injection de dépendances avec `get_it`** : les repositories, les cas d'usage et les sources non déterministes (hasard, horloge) s'enregistrent dans `get_it` et se remplacent par des fakes en test.
- **Gestion d'état avec `flutter_bloc`** (BLoC et Cubit).
- **Persistance avec `drift` (SQLite)** et migrations versionnées (`schemaVersion` et stratégie de migration, test d'intégrité sur base en mémoire).
- **TDD** (`flutter_test`, `bloc_test`, `mocktail`) **et BDD** avec `bdd_widget_test` : les scénarios sont écrits en Gherkin français (Soit / Quand / Alors) dans des fichiers `.feature`, qui génèrent des tests widget via `build_runner`. (à vérifier : `bdd_widget_test` documente les mots-clés `Feature` / `Scenario` / `Given` / `When` / `Then` ; la prise en charge d'un Gherkin français n'est pas confirmée. À tester dans le squelette avant S2 ; sinon, mots-clés anglais avec des textes d'étapes en français.)
- **Commandes de référence** : `flutter pub get`, `flutter test`, `flutter test --coverage`, `flutter analyze`, `dart format`, `dart run build_runner build --delete-conflicting-outputs`, `flutter run -d chrome`, `flutter build web`. Verrouillage des dépendances : `pubspec.lock` (versionné) ; la version de Flutter est notée dans le README (et le `pubspec`).
- **Livraison** : build web publié par GitHub Actions sur **GitHub Pages** (analyse, tests avec couverture, détection de secrets `gitleaks`, audit des dépendances pub, build web, déploiement). **GitHub Pages est public** : données fictives uniquement, et tout ce qui est dans un build web Flutter est public (aucun secret dans l'application).
- **Conventions de nommage** : les identifiants des énoncés ci-dessous (`pv_actuels`, `jet_d20`, `temps_ouverture_min`...) sont donnés en snake_case ; en Dart on les écrit en lowerCamelCase (`pvActuels`, `jetD20`, `tempsOuvertureMin`, Effective Dart), et drift génère les colonnes SQL en snake_case. Les codes de motif (`personnage_a_terre`, `voeux_insuffisants`...) sont des valeurs sérialisées, portées côté Dart par des `enum`.

## Idée directrice

Trois logiciels qui ne se ressemblent pas sont proposés. Chaque équipe en choisit **un seul** et le construit tout au long de la formation.

Le public est composé d'étudiants de Master orientés **industrie et innovation**. Ce ne sont pas des développeurs. Le projet vise deux objectifs :

1. **Échanger avec une équipe de développement** : parler de règles métier, de tests, de cycle de vie, de qualité, de risques et de contraintes avec un vocabulaire commun.
2. **Créer eux-mêmes, avec l'IA, un applicatif répondant à un besoin ponctuel** : un outil de courte durée de vie, qui sert pendant une campagne, une saison, un projet ou un trimestre, puis qui est archivé. Ce n'est pas un produit industriel pérenne, et les étudiants doivent en connaître les limites.

Les trois thèmes :

- **A, un carnet de campagne de jeu de rôle** : une fiche de personnage évolue à chaque quête (dés, points de vie, expérience, niveaux). La difficulté est un **état qui progresse** et un hasard que l'on doit savoir injecter pour tester.
- **B, un calcul de TRS/OEE d'atelier** : à partir d'événements de production, on calcule un indicateur de performance. La difficulté est **l'arithmétique des temps et des unités**.
- **C, une répartition de sujets de projet** : des étudiants classent leurs vœux et le logiciel les affecte selon une priorité et des capacités. La difficulté est **un algorithme d'affectation déterministe**, à expliquer à chaque étudiant.

### Organisation des équipes

- 32 étudiants, en équipes de **3 à 5 personnes** : par défaut 8 équipes de 4 ; 7 équipes sont possibles (4 de 5 et 3 de 4).
- Chaque équipe classe les thèmes par préférence, avec un **maximum de 3 équipes par thème**. Répartition visée : **8 équipes : 3-3-2 ; 7 équipes : 3-2-2 ou 3-3-1. Tirage au sort si un thème dépasse 3 candidats.** Le thème C demande plus de travail de conformité (décision d'affectation, art. 22 RGPD) : c'est un élément à connaître pour choisir en connaissance de cause. Deux équipes sur un même thème construisent chacune leur propre dépôt, sans partage de code.
- La charge du projet ne change pas avec la taille de l'équipe : une équipe de 3 cumule des rôles, une équipe de 5 ajoute un rôle de soutien (voir la rubrique « Rôles dans l'équipe » de chaque thème).

### Stack commune

Le dépôt-modèle fourni par l'enseignant impose la pile décrite plus haut (« Pile technique du projet ») et contient : un squelette Flutter (structure en couches, `get_it` configuré, un BLoC d'exemple, un test unitaire, un fichier `.feature` d'exemple, une CI minimale `flutter analyze` + `flutter test`), ainsi qu'un `CLAUDE.md` et un document d'architecture réutilisables d'un projet à l'autre (structure Clean Architecture, injection `get_it`, conventions BLoC, discipline TDD et BDD). Les rôles de chaque thème sont protégés par une **garde d'accès dans la couche domain** (use case ou service `RequireRole`) avec un test de refus ; il n'y a pas d'authentification réelle, seulement un utilisateur courant fictif associé à l'un des deux rôles du thème (à confirmer dans le dépôt-modèle). Aucun secret ne va dans le dépôt ni dans l'application (un fichier `.env` éventuel est ignoré par git). Les dépôts sont **publics**, dans l'organisation GitHub de la formation, et les builds web sont publics sur GitHub Pages : c'est une raison de plus de n'y mettre aucune donnée réelle.

Docker, Rust et Antigravity sont des outils « utiles plus tard » : ils ne font pas partie de la pile des projets ni de leur livraison.

L'**import CSV est obligatoire dans le socle commun** : le cœur de chaque thème importe un seul fichier CSV (choisi avec `file_picker`, taille maximale, rejet motivé, parseur dans la couche data), et cet import se fait pendant le sprint, pas en S3. L'export CSV est souhaitable ; les autres formats sont des extensions. Les faits sur les dérives des agents de code (pièges) renvoient au cours sur le harnais : les thèmes n'y reviennent pas.

### Règle d'or et conformité (RGPD et AI Act)

**Règle d'or, valable dès la S1 : aucune donnée personnelle ni confidentielle dans un prompt, ni dans un dépôt public.** Toutes les données des projets sont fictives (seed à graine fixe).

La conformité a une double fonction dans la formation :

- **Connaître les limites de leurs propres projets** : un outil temporaire reste soumis au RGPD (règlement (UE) 2016/679) dès qu'il traite des données personnelles, et peut relever du règlement (UE) 2024/1689 (AI Act) selon son usage. **Toute mise en usage réel doit être validée par le RSSI (et le DPO le cas échéant).**
- **Connaître leurs droits de citoyens européens** : accès (art. 15 RGPD), rectification (art. 16), effacement (art. 17), limitation (art. 18), portabilité (art. 20), opposition (art. 21), protection contre la décision entièrement automatisée (art. 22, garanties de l'art. 22(3), considérant 71), information et transparence (art. 12 à 14, dont la « logique sous-jacente » aux art. 13(2)(f), 14(2)(g) et 15(1)(h)), droit d'introduire une réclamation auprès de la CNIL (art. 77) ; pour l'AI Act, droit à l'explication d'une décision individuelle fondée sur un système à haut risque (art. 86, à vérifier dans son champ exact).

Chaque thème contient une rubrique « Conformité (RGPD et AI Act) ». Le détail pédagogique est dans le module `cours/conformite-ai-act-rgpd.md`.

**Fiche de conformité par projet**, tenue dans le dépôt à **un seul chemin**, `docs/fiche_conformite.md`, selon le **gabarit à 13 rubriques** du module `cours/conformite-ai-act-rgpd.md` (§ 6.1), que ce fichier ne remplace pas. Les 13 rubriques : 1 finalité ; 2 données traitées ; 3 personnes concernées ; 4 base légale ou justification « données fictives » (art. 6 RGPD) ; 5 durée de conservation ; 6 hébergement et sous-traitants, dont le **fournisseur de modèle d'IA** ; 7 ce qui part dans les prompts ; 8 décision automatisée (art. 22) et humain dans la boucle ; 9 niveau de risque AI Act ; 10 droits des personnes ; 11 mesures ; 12 risques résiduels et limites d'usage ; 13 validation du RSSI. Deux ajouts propres à la formation : un champ **« rôle AI Act : fournisseur ou déployeur ? »** et, à la rubrique 9, une case de classement **« hors champ / minimal / obligations de transparence (art. 50) / haut risque / interdit »**.

- **Aucun nom civil, aucune adresse de courriel dans la fiche** (les dépôts sont publics) : on écrit « équipe n° X », les identifiants GitHub de l'équipe et « RSSI (rôle) ».
- **Calendrier** : début de la fiche en S3 (livrable de fin de séance), v1 déposée en PR le **8 décembre**, réponse du RSSI **avant le 11 décembre**, mise à jour avant la soutenance.
- **Portée d'un « go »** : un « go » du RSSI vaut uniquement pour le périmètre pédagogique à données fictives ; tout passage à des données réelles impose une nouvelle fiche et une nouvelle validation.

**Choix à préciser par l'enseignant** : le RSSI est soit **simulé par l'enseignant**, soit **tenu par le RSSI de l'établissement** (invité en S4). Le **passage devant le RSSI** se fait en S4 sur **3 tables en parallèle**, **10 à 12 min par équipe** (environ 4 min de présentation, 5 de questions, 2 de décision provisoire), avec un jeu de rôle intégré à ce dispositif. Avec 8 équipes réparties en 3, 3 et 2 par table, cela représente 3 passages successifs de 12 min au plus par table, soit 36 min, plus 4 min de rotation et de consignes : bloc de 40 min en S4. En S4, le brouillon de fiche est présenté et discuté ; la v1 déposée le 8 décembre est ensuite validée ou refusée avec des demandes de correction, la réponse écrite arrivant pendant le sprint. Il s'agit de **sensibilisation, pas d'avis juridique** : la validation revient au RSSI et au DPO.

### Trame des séances (rappel)

| Séance | Date | Contenu | Lien avec le projet |
|---|---|---|---|
| S1 | mer. 7 octobre 2026 | théorie et installations | aucun travail sur le projet |
| S2 | ven. 9 octobre 2026 | git, configuration de Claude Code, initialisation | équipes et thèmes collectés avant S2 (formulaire, identifiants GitHub), dépôts préparés par l'enseignant, validation et tirage au sort si litige, `PROJET.md` pré-rempli, première PR, premiers éléments du harnais |
| S3 | mer. 2 décembre 2026 | travail à plusieurs, premier TDD | remise en route, première user story en TDD et en BDD, modèle drift, migration et test d'intégrité, RGPD, début de la fiche de conformité, PR croisées (le seed complet et les rôles glissent au sprint ou au début de S4). Livrable de fin de S3, identique pour les trois thèmes : « première règle verte, modèle et migrations fusionnés, début de `docs/fiche_conformite.md` commité ». |
| S4 | ven. 4 décembre 2026 | tests d'acceptation, CI/CD, sécurité, conformité | tests d'acceptation du clou, CI, publication du build web de chaque équipe sur GitHub Pages par GitHub Actions, AI Act, passage devant le RSSI (3 tables, 10 à 12 min par équipe), audit croisé en 5 points (installation à froid, CI, secrets, rôles, fiche), activité de rupture entre les exposés (jamais plus de 30 min d'exposé continu) ; la v1 de la fiche est déposée en PR le 8 décembre |
| Sprint | 12 jours | finir le périmètre | import CSV, tableau de bord, clou |
| S5 | mer. 16 décembre 2026 | gel, retouches, soutenance | 8 équipes de 4 en 4 h |

Il y a environ huit semaines entre S2 et S3 : la remise en route de 30 min en début de S3 est donc indispensable. Entre S3 et S4, une seule tâche facultative d'1 h au maximum est proposée ; S4 ne suppose pas le CRUD terminé. Dans chaque thème, les découpages de S3 et de S4 distinguent « indispensable en séance » et « peut glisser dans le sprint ».

### Tableau chiffré de comparaison

| Critère | A Carnet de campagne | B TRS d'atelier | C Répartition de sujets |
|---|---|---|---|
| Entités (tables drift) | 5 (classe, personnage, campagne, quete, resolution) | 5 (poste, quart, ordre_fabrication, declaration_production, arret) | 5 (enseignant, sujet, etudiant, voeu, affectation) |
| Règles distinctes du niveau 1 | 6 | 6 | 6 |
| Cas d'acceptation | 7 | 8 | 7 |
| Motifs de rejet d'import | 5 | 5 | 5 |
| Vues du tableau de bord | 4 | 4 | 4 |
| Charge estimée du clou niveau 1 avec l'agent et le TDD | ≈ 3 h | ≈ 3 h | ≈ 3 h |
| Charge d'équipe du périmètre complet (sprint compris) | 15 à 20 h | 15 à 20 h | 15 à 20 h |
| Lignes de démo | ≈ 700 | ≈ 3 000 | ≈ 600 |
| Type de difficulté | Hasard injecté, état qui évolue | Unités et arrondis | Ordre de priorité, cas de bord |
| Piège d'agent | Dés en dur dans la règle | Unités mélangées | Données réelles collées |
| Sensibilité conformité | faible (pseudonymes de joueurs) | moyenne (postes, quarts, salariés possibles) | élevée (étudiants, décision d'affectation) |

Équilibrage : A a peu de calcul mais un état à faire évoluer (niveaux, PV, plafonds). B a peu d'états mais des calculs à faire au bon format (temps, cadences, arrondis, changement d'heure). C a peu de calcul mais beaucoup de cas de bord (bornes de vœux, capacités, statuts). Les estimations de charge n'ont pas été chronométrées avec de vrais étudiants : elles sont à confirmer lors de la première promotion.

---

## Thème A · Les Marches de Cendrelune : le carnet de campagne du maître de jeu

- **Pitch** : sur les Marches de Cendrelune, frontière brumeuse où les cartes mentent et où les auberges ferment tôt, un club de jeu de rôle mène depuis trois saisons une campagne à douze joueurs. Les fiches de personnage sont sur des feuilles volantes, les jets de dés dans la mémoire du maître de jeu, et personne ne sait plus pourquoi la voleuse est niveau 4 alors que le guerrier est resté niveau 2. Vous forgez le **carnet de campagne** : fiches de personnage, quêtes, résolution d'une quête par un jet de d20, dégâts en points de vie, expérience et montée de niveau, avec un journal que l'on peut relire et contester.
- **Commanditaire (fictif) et besoin** : Gaspard Hallier, maître de jeu du club (personnage fictif), ingénieur le jour et conteur le soir. Il veut que chaque quête se résolve de façon équitable et reproductible : mêmes dés, mêmes conséquences. Il veut retrouver l'historique de chaque personnage, voir qui est à terre et qui approche d'un niveau, et que les joueurs ne modifient que leur propre fiche.
- **Besoin ponctuel** :
  - *Pourquoi un outil de courte durée de vie suffit* : le carnet sert le temps d'une campagne (une saison). Quand la campagne s'arrête, les fiches n'ont plus d'usage : un outil jetable, bien testé, remplace avantageusement les feuilles volantes sans devenir un logiciel à maintenir.
  - *Ce qui reste obligatoire même pour un outil jetable* : la règle de résolution testée (sinon les joueurs contestent), le contrôle d'accès (un joueur ne modifie pas la fiche d'un autre), le README pour relancer l'outil, et aucune donnée réelle dans le dépôt public.
  - *Désactivation et archivage* : à la fin de la campagne, export du journal en CSV, archivage du dépôt (lecture seule) et arrêt du service ; les pseudonymes de joueurs sont supprimés ou anonymisés au plus tard à cette date.
- **Données manipulées** :
  - Entités (5) : `classe` (code, nom, pv_niveau_1, gain_pv_par_niveau, bonus_force, bonus_ruse, bonus_magie, bonus_foi), `personnage` (nom, classe_code, niveau, xp, pv_actuels, proprietaire), `campagne` (titre, saison), `quete` (campagne, titre, competence, dd, danger, xp_recompense, statut), `resolution` (personnage, quete, jet_d20, total, issue, pv_perdus, xp_gagnes, niveau_avant, niveau_apres).
  - Relations : une campagne a plusieurs quêtes ; une résolution lie un personnage à une quête ; un personnage appartient à une classe et à un joueur (`proprietaire`, identifiant de connexion). Les PV maximum ne sont pas stockés : ils se calculent (classe et niveau), ce qui évite les incohérences.
  - Volumes : 4 classes, 60 personnages, 3 campagnes, 30 quêtes, environ 600 résolutions.
  - Seed : script à graine fixe ; noms de personnages fictifs assemblés à partir de syllabes ; jamais de noms de personnes réelles.
- **Rôles applicatifs** : `maitre_de_jeu` (crée quêtes, résout, corrige) et `joueur` (lit tout, modifie uniquement la fiche dont il est `proprietaire`).
- **Rôles dans l'équipe** (la charge du projet ne change pas) :
  - *3 membres* : **gardien produit et conformité** (`PROJET.md`, cas d'acceptation, fiche de conformité) ; **gardien des données** (modèle, migrations, seed, import CSV) ; **gardien du harnais et de la CI** (`CLAUDE.md`, hooks, permissions, GitHub Actions, test d'architecture sur le hasard).
  - *4 membres* : les trois rôles ci-dessus, avec un **gardien conformité** distinct (fiche, pseudonymisation, contact avec le RSSI).
  - *5 membres* : les quatre rôles, plus un **gardien de la démonstration** (README testé à froid, jeu de données de soutenance, scénario du « wow »).
  - Dans tous les cas, chacun relit au moins une PR d'un autre.
- **MVP** (5 user stories à piocher pour `PROJET.md`, 3 à 5 retenues) :
  1. En tant que maître de jeu, je crée un personnage d'une classe donnée, avec ses PV de niveau 1.
  2. Je publie une quête (compétence testée, difficulté, danger, récompense).
  3. Je résous une quête pour un personnage en saisissant le jet de d20 et j'obtiens l'issue, les PV perdus et l'expérience.
  4. Je consulte la fiche d'un personnage avec son historique de résolutions.
  5. Je vois quels personnages sont à terre et lesquels vont monter de niveau.
  - **Pour aller plus loin** : (1) le hasard produit par l'application quand le maître de jeu ne saisit pas de jet : une interface de source de hasard (domain), implémentée dans la couche data, injectée avec `get_it` et remplacée par un fake en test (graine journalisée, jet rejouable) ; (2) événements de campagne (embuscade, pluie de cendres) qui modifient la difficulté d'une quête ; (3) export de la fiche au format texte pour impression.
- **Règle métier « clou »** : résolution d'une quête par un personnage, fonction pure Dart `resoudre(personnage, quete, jetD20)` sans accès au hasard ni à la base (elle vit dans la couche domain).
  - **Niveau 1 (obligatoire, ≈ 3 h)** : ordre d'application des sous-règles, valeurs figées.

    | classe | bonus force | bonus ruse | bonus magie | bonus foi | PV niveau 1 | gain de PV par niveau |
    |---|---|---|---|---|---|---|
    | guerrier | 5 | 1 | 0 | 0 | 30 | 10 |
    | voleur | 1 | 5 | 0 | 0 | 22 | 8 |
    | mage | 0 | 1 | 5 | 1 | 16 | 6 |
    | pretre | 1 | 0 | 1 | 5 | 24 | 8 |

    | niveau | 1 | 2 | 3 | 4 | 5 (maximum) |
    |---|---|---|---|---|---|
    | XP minimum (borne incluse) | 0 | 100 | 300 | 600 | 1000 |

    1. **Personnage à terre** : si `pv_actuels` vaut 0, la résolution est refusée (erreur `personnage_a_terre`), sans jet consommé ni modification.
    2. **Jets critiques** : `jet_d20` doit être un entier entre 1 et 20 inclus. 20 est une réussite critique et 1 un échec critique, quel que soit le total. Ce test précède la comparaison à la difficulté.
    3. **Total et réussite** : `total = jet_d20 + bonus_de_la_classe_pour_la_competence_de_la_quete + niveau`. Réussite si `total >= dd` (borne incluse).
    4. **Dégâts** : réussite (critique ou non) : 0 PV perdu ; échec : `danger` PV perdus ; échec critique : `2 × danger`. Les PV sont plancher à 0 (jamais négatifs) ; à 0, le personnage est à terre.
    5. **Expérience** : réussite : `xp_recompense` ; réussite critique : `xp_recompense × 3 ~/ 2` (division entière, opérateur `~/` de Dart) ; échec ou échec critique : `xp_recompense ~/ 4`. Le personnage à terre gagne aussi l'expérience.
    6. **Niveau** : le niveau est le plus grand `n` tel que XP ≥ seuil (tableau ci-dessus), plafonné à 5 ; l'XP continue de cumuler au-delà du plafond. Chaque niveau gagné ajoute `gain_pv_par_niveau` aux PV maximum et aux `pv_actuels`, sauf si le personnage est à terre après les dégâts (aucun PV gagné). Plusieurs niveaux peuvent être gagnés d'un coup. PV maximum = `pv_niveau_1 + (niveau − 1) × gain_pv_par_niveau`.
  - **Niveau 2 (bonus, plafonné à 1 point)** : avantage et désavantage. Quand la quête porte un modificateur, deux jets sont fournis : on garde le plus haut (avantage) ou le plus bas (désavantage) avant d'appliquer les règles ci-dessus. Le 20 et le 1 se jugent sur le jet retenu.
  - **Cas de test d'acceptation** (7) :

    | # | Entrée | Sortie attendue |
    |---|---|---|
    | 1 | guerrier niveau 1, XP 0, PV 30/30 ; quête force, dd 17, danger 6, xp 100 ; jet 11 | total 17 ≥ 17 : réussite ; 0 PV perdu ; XP 100 ; niveau 2 ; PV 40/40 |
    | 2 | même personnage et même quête ; jet 10 | total 16 < 17 : échec ; 6 PV perdus ; PV 24/30 ; XP 25 ; niveau 1 |
    | 3 | guerrier niveau 5, XP 1000, PV 70/70 ; quête force, dd 5, danger 6, xp 100 ; jet 1 | échec critique malgré total 11 ≥ 5 ; 12 PV perdus ; PV 58/70 ; XP 1025 ; niveau 5 |
    | 4 | mage niveau 1, XP 0, PV 16/16 ; quête force, dd 40, danger 8, xp 100 ; jet 20 | réussite critique ; 0 PV perdu ; XP 150 ; niveau 2 ; PV 22/22 |
    | 5 | voleur niveau 1, XP 0, PV 5/22 ; quête ruse, dd 10, danger 6, xp 100 ; jet 3 | total 9 < 10 : échec ; PV plancher à 0 ; `a_terre` vrai ; XP 25 ; niveau 1 |
    | 6 | personnage à 0 PV ; n'importe quelle quête ; jet 12 | erreur `personnage_a_terre`, aucune modification |
    | 7 | pretre niveau 1, XP 50, PV 24/24 ; quête foi, dd 10, danger 4, xp 400 ; jet 10 | total 10 + 5 + 1 = 16 ≥ 10 : réussite ; 0 PV perdu ; XP 50 + 400 = 450 ; niveau 3 (deux niveaux gagnés) ; PV maximum 24 + 2 × 8 = 40 ; PV 40/40 |

    Ces cas sont écrits par le gardien produit en S4 sous forme de fichiers `.feature` Gherkin (français, à vérifier : voir la pile ci-dessus) dans `test/acceptance/` (tests widget générés par `bdd_widget_test` avec `dart run build_runner build --delete-conflicting-outputs`), avant le code de l'agent sur les sous-règles restantes (celle de S3 est déjà couverte par ses propres tests).
- **Première user story et sous-règle isolée (BDD)** : la sous-règle isolée de S3 (le total, règle 3) s'écrit comme un scénario `.feature` en français, sans changer les valeurs (jet 11, guerrier de niveau 1, quête de force, dd 17, comme au cas 1) :

    ```gherkin
    Fonctionnalité: Résolution d'une quête
      Scénario: total d'un jet pour un guerrier de niveau 1
        Soit un guerrier de niveau 1
        Et une quête de compétence "force" avec une difficulté de 17
        Quand le jet de d20 est 11
        Alors le total est 17
        Et la quête est réussie
    ```
- **Import/export** : import CSV des personnages, fichier choisi avec `file_picker`, parseur dans la couche data (colonnes `nom`, `classe_code`, `niveau`, `xp`, `pv_actuels`, `proprietaire`), avec rapport de lignes rejetées. Motifs de rejet précis :
  1. `classe_inconnue` (hors des 4 classes) ;
  2. `niveau_hors_bornes` (hors de 1 à 5) ou XP inférieure au seuil du niveau déclaré ;
  3. `pv_incoherents` (`pv_actuels` supérieur aux PV maximum calculés, ou négatif) ;
  4. `nom_en_double` (au sein du fichier ou de la base) ;
  5. `colonnes_manquantes` ou fichier de plus de 200 Ko.

  Export : journal de campagne en CSV (une ligne par résolution).
- **Tableau de bord (4 vues)** : (1) fiche de personnage (niveau, XP restante avant le niveau suivant, PV actuels et maximum) ; (2) journal de campagne chronologique, filtrable par quête ; (3) état de la compagnie (personnages à terre, PV, niveau) ; (4) taux de réussite par classe et par compétence.
- **Contrainte de harnais et piège d'agent** :
  - Piège : le hasard en dur. Pour faire passer un test rouge, l'agent glisse `Random().nextInt(20) + 1` dans la règle, ou fixe une graine (`Random(42)`), ou remplace le dé par une constante : les tests deviennent verts par hasard, ou ne prouvent plus rien. À documenter comme cas d'erreur d'agent (voir le cours sur le harnais).
  - Harnais : règle `CLAUDE.md` « le domaine ne tire jamais de hasard ni ne lit l'horloge ; les jets arrivent en paramètre » ; test d'architecture (`flutter test`) qui lit les fichiers des dossiers `domain/` et échoue si `dart:math` y est importé (la source de hasard est une interface du domaine, enregistrée dans `get_it` et remplacée par un fake en test) ; dossier `test/acceptance/**` protégé par des permissions `deny` sur `Edit` et `Write` dans `.claude/settings.json`, par `CODEOWNERS` et par la consigne `CLAUDE.md` « un test qui échoue n'est jamais corrigé en modifiant le test » ; hook `PostToolUse` sur `Edit|Write` qui lance `flutter test`.
- **Conformité (RGPD et AI Act)** (voir `cours/conformite-ai-act-rgpd.md`) :
  - *Données traitées* : pseudonymes de joueurs (champ `proprietaire`, identifiant de connexion), noms de personnages fictifs, historique de résolutions. Le `proprietaire` est un lien vers une personne identifiable (même par pseudonyme) : c'est une **donnée personnelle**.
  - *Personnes concernées* : les joueurs du club (et le maître de jeu, via son compte).
  - *Finalité* : tenir la fiche et l'historique d'une campagne de jeu, de façon équitable et reproductible. Rien d'autre (pas de profilage des joueurs, pas de classement public des « meilleurs joueurs » sans accord).
  - *Durée de conservation proposée* : la durée de la campagne ; suppression ou anonymisation des pseudonymes à la clôture (par exemple 30 jours après la dernière séance de jeu) ; le journal anonymisé peut être archivé.
  - *Ce qui doit rester fictif* : tous les joueurs et tous les noms de personnages du dépôt et des démonstrations ; aucun courriel ni identifiant réel dans le seed.
  - *Niveau de risque AI Act probable* : **risque minimal ou hors champ** : la résolution est une règle déterministe sans effet sur des droits ou des opportunités réels (à vérifier). L'art. 4 du règlement (UE) 2024/1689, après l'omnibus, prévoit que les fournisseurs et déployeurs prennent des mesures pour favoriser la maîtrise de l'IA de leurs personnels et des personnes qui utilisent des systèmes d'IA en leur nom (à vérifier sur EUR-Lex) ; l'équipe qui construit l'outil avec une IA est concernée par cette culture de l'IA. Si l'équipe ajoutait un texte généré par IA vers les joueurs (extension), la transparence de l'art. 50 serait à examiner (à vérifier).
  - *Mesures concrètes dans l'application* : pseudonymes uniquement ; journal technique sans nom de joueur (identifiants numériques) ; un joueur ne voit et ne modifie que sa fiche ; **obligatoires** : mention d'information visible (art. 13) et cas d'usage de suppression documenté d'un joueur et de ses données (droit à l'effacement, art. 17) ; **en extension** : export des données du joueur (accès et portabilité, art. 15 et 20). Ces mesures sont incluses dans les 15 à 20 h de charge d'équipe.
  - *Contenu attendu de la fiche de conformité* : les 13 rubriques du gabarit de `docs/fiche_conformite.md` (voir plus haut), avec en particulier la case « hors champ » ou « minimal » justifiée, le rôle AI Act (fournisseur ou déployeur) et la durée de conservation ; **présentée au RSSI en S4, v1 déposée le 8 décembre, réponse avant le 11 décembre**. Un « go » ne vaut que pour le périmètre pédagogique à données fictives ; toute mise en usage réel avec de vrais joueurs impose une nouvelle fiche et une nouvelle validation.
- **Sécurité et données** :
  1. **OWASP, contrôle d'accès défaillant** : un joueur ne peut modifier que ses fiches. Un test d'autorisation vérifie qu'une modification de la fiche d'un autre joueur est refusée (erreur d'accès refusé), y compris en passant l'identifiant d'un autre personnage au cas d'usage. Le contrôle vit dans la couche domain (garde `RequireRole` et vérification du propriétaire), pas dans l'interface : masquer un bouton ne protège rien.
  2. **Validation des entrées** : l'import borne chaque champ, refuse les fichiers de plus de 200 Ko et les caractères de contrôle ; aucune valeur importée n'est concaténée dans du SQL brut (pas de `customSelect` ni de `customStatement` construit par concaténation avec drift).
- **Découpage par séance** :
  - S1 : théorie et installations ; pas de travail sur le projet.
  - S2 : les équipes et le classement des thèmes sont collectés par formulaire à la fin de S1 ou dans le pre-flight (identifiants GitHub inclus) ; l'enseignant prépare les 8 dépôts depuis le modèle (squelette Flutter, `CLAUDE.md` et document d'architecture fournis) et ajoute les membres comme collaborateurs de chaque dépôt (pas d'invitation à l'organisation) avant S2 ; en S2, on valide les équipes, on tire au sort en cas de litige et on libère du temps pour l'initialisation ; `PROJET.md` fourni pré-rempli pour le thème A (vision, 3 à 5 user stories), à relire et compléter ; première PR relue par un coéquipier ; `main` protégée (PR obligatoire, 1 approbation) ; premiers éléments du harnais (`CLAUDE.md` minimal, première permission).
  - S3 (4 h) : **indispensable en séance** : remise en route de 30 min en début de séance (`git pull`, `flutter pub get`, `flutter test`, lancement de l'agent) ; première user story en TDD et en BDD (scénario Gherkin, voir « Première user story et sous-règle isolée ») sur une seule sous-règle isolée, `bonus_de_classe` et le total (règle 3), avec un repository en mémoire (fake), ni dégâts, ni XP, ni niveau ; tables drift, première migration (`schemaVersion`) et test d'intégrité sur base en mémoire ; bloc RGPD ; début de la fiche de conformité (rubriques 1 à 5 : finalité, données, personnes concernées, base légale ou justification « données fictives », durée) ; PR croisées entre équipes (paires de même thème tolérées en S3). **Peut glisser dans le sprint ou au début de S4** : seed complet, rôles (`maitre_de_jeu`, `joueur`) avec la garde `RequireRole` (couche domain) et test de refus. **Livrable de fin de S3** : « première règle verte, modèle et migrations fusionnés, début de `docs/fiche_conformite.md` commité ». Si l'équipe est en retard, le seed et les rôles passent en premier au sprint.
  - S4 (4 h) : **indispensable en séance** : le gardien produit écrit les 7 cas d'acceptation avant le code de l'agent sur les sous-règles restantes ; CI verte ; publication du build web sur GitHub Pages par chaque équipe (analyse, tests avec couverture, `gitleaks`, audit des dépendances pub, build web, déploiement ; données fictives uniquement) ; seed et rôles s'ils ont glissé (contrôle d'accès) ; passage devant le RSSI (3 tables en parallèle, 10 à 12 min par équipe, jeu de rôle intégré) ; audit croisé réduit à 5 points (installation à froid : `git clone`, `flutter pub get`, `flutter test`, `flutter run -d chrome` ; CI verte, obligatoire, avec audit des dépendances ; secrets : `gitleaks`, rien dans le dépôt ni dans le bundle web, `.env` ignoré ; rôles : garde testée ; fiche de conformité) ; les paires de même thème sont évitées en S4. **Plan B** : si la publication sur GitHub Pages bloque (réglages du dépôt, droits), l'équipe montre son build local (`flutter run -d chrome`) et termine la publication au sprint. **Peut glisser dans le sprint** : publication GitHub Pages si elle n'est pas terminée, release v0.1, contrôles d'accès fins au-delà du minimum. S4 ne suppose pas le CRUD terminé, et un exposé continu ne dépasse pas 30 min : on le coupe par une activité (quiz ou cas à classer).
  - Sprint de 12 jours : finir le périmètre : import CSV des personnages, journal, tableau de bord, export, cas d'acceptation non encore verts à la fin de S4, README testé à froid, bonus éventuel.
  - S5 : gel (tag `v1.0-rc` le lundi 14 décembre à 18 h), retouches bloquantes, soutenance.
- **Livrable minimum viable** : création de personnage, résolution d'une quête avec les règles 1 à 6, fiche avec historique, contrôle d'accès, CI verte, import CSV des personnages, fiche de conformité déposée et soumise au RSSI. Sans le journal filtrable, l'export ni les vues 3 et 4.
- **Effet « wow » pour la soutenance** : le jury lance de vrais dés et dicte les jets ; l'équipe les saisit, la fiche change en direct (PV, XP, montée de niveau), puis le jury demande de rejouer le même jet et obtient le même résultat, grâce à une règle sans hasard interne.

---

## Thème B · Ligne 4 : le TRS de l'atelier de câblage

- **Pitch** : sur le site d'un fabricant fictif de sous-ensembles électroniques, la ligne 4 assemble des cartes de commande avec une cellule cobot de vissage, une station de vision et un îlot de brasage sélectif. Chaque quart, un opérateur déclare à la main ses pièces, ses rebuts et ses arrêts, et le responsable recalcule le TRS (taux de rendement synthétique, ou OEE en anglais) dans un tableur. Le résultat change d'un jour à l'autre selon celui qui compte. Vous construisez l'outil qui calcule le TRS de façon **reproductible** à partir des événements de production, le décompose (disponibilité, performance, qualité) et montre où le temps se perd.
- **Commanditaire (fictif) et besoin** : Hélène Gaudry, responsable amélioration continue (personnage fictif), ingénieure d'exploitation. Elle veut un TRS par poste et par quart, la même formule pour tout le monde, la répartition des pertes par cause pour orienter la maintenance, et la certitude que le nouveau quart de nuit lors du changement d'heure est compté correctement.
- **Besoin ponctuel** :
  - *Pourquoi un outil de courte durée de vie suffit* : l'amélioration continue travaille par campagnes de mesure (par exemple un trimestre d'observation de la ligne 4 avant un investissement). L'outil remplace le tableur le temps de cette campagne ; il n'a pas vocation à devenir un MES.
  - *Ce qui reste obligatoire même pour un outil jetable* : la formule testée et identique pour tous (sinon les chiffres ne sont pas comparables), les unités explicites, un README pour relancer l'outil, aucun secret dans le dépôt, et aucune donnée réelle d'usine dans un dépôt public.
  - *Désactivation et archivage* : à la fin de la campagne de mesure, export CSV des TRS, archivage du dépôt et arrêt du service ; les données de quarts (même agrégées) ne sont pas conservées plus longtemps que la décision qu'elles ont éclairée.
- **Données manipulées** :
  - Entités (5) : `poste` (code, nom, ligne), `quart` (poste, debut_utc, fin_utc), `ordre_fabrication` (numero_of, produit, quantite_lancee, temps_cycle_ideal_s, issu de la gamme), `declaration_production` (quart, ordre_fabrication, pieces_produites, pieces_rebutees), `arret` (quart, debut_utc, fin_utc, categorie, commentaire, ticket_gmao).
  - Relations : un quart appartient à un poste et porte plusieurs déclarations (une par OF traité) et plusieurs arrêts. Les catégories planifiées sont `pause`, `maintenance_preventive` et `etalonnage`. Les catégories non planifiées sont `panne`, `changement_serie`, `attente_matiere` et `micro_arret` (convention de l'énoncé).
  - Volumes : 6 postes, 90 quarts par poste, environ 3 000 déclarations et arrêts en tout.
  - Seed : générateur à graine fixe, produits fictifs (cartes, capteurs, boîtiers), temps de cycle de 20 à 60 s, un quart de nuit du 24 au 25 octobre 2026 inclus. Les horodatages sont stockés en UTC.
- **Rôles applicatifs** : `responsable` (lecture, import, export, correction) et `operateur` (déclare uniquement sur les quarts de son poste).
- **Rôles dans l'équipe** (la charge du projet ne change pas) :
  - *3 membres* : **gardien produit et conformité** (`PROJET.md`, glossaire, cas d'acceptation, fiche de conformité) ; **gardien des données** (modèle, migrations, seed, import CSV, fuseaux et UTC) ; **gardien du harnais et de la CI** (`CLAUDE.md`, hooks, test d'architecture sur les unités, GitHub Actions).
  - *4 membres* : les trois rôles ci-dessus, avec un **gardien conformité** distinct (fiche, anonymisation des opérateurs, contact avec le RSSI).
  - *5 membres* : les quatre rôles, plus un **gardien de la démonstration** (README testé à froid, jeu de données du quart de nuit chaotique, scénario du « wow »).
  - Dans tous les cas, chacun relit au moins une PR d'un autre.
- **MVP** (5 user stories à piocher) :
  1. En tant que responsable, je décris les postes et je crée les quarts.
  2. Je saisis un OF avec son temps de cycle idéal.
  3. Je déclare les pièces produites et rebutées d'un quart, et ses arrêts.
  4. Je consulte le TRS d'un poste pour un quart, avec sa décomposition.
  5. Je vois les causes d'arrêt classées par minutes perdues.
  - **Pour aller plus loin** : (1) partie commune entre arrêt planifié et non planifié comptée comme planifiée ; (2) cible de TRS par ligne et alerte ; (3) export au format d'un rapport de quart ; (4) import CSV des arrêts (`poste`, `debut_utc`, `fin_utc`, `categorie`, `commentaire`, `ticket_gmao`), avec les motifs `arret_chevauchant` (deux arrêts du même poste qui se recouvrent) et `fin_avant_debut` (ou catégorie inconnue).
- **Règle métier « clou »** : fonction pure Dart `calculerTrs(quart, declarations, arrets)`. Les durées sont en minutes, les temps de cycle en secondes (suffixes `Min` et `S` obligatoires dans le code, par exemple `tempsOuvertureMin` et `tempsCycleIdealS`, ou le type `Duration`).
  - **Niveau 1 (obligatoire, ≈ 3 h)** : l'OEE se calcule sur les valeurs exactes (entiers et fractions ; un paquet de rationnels ou de décimaux comme `rational` ou `decimal` est possible, à vérifier ; pas de `double`) ; seul l'affichage arrondit à 0,1 point de pourcentage, demi vers le haut.
    1. **Durée du quart** : `temps_ouverture_min = (fin_utc − debut_utc)` en minutes réelles, calculée à partir des horodatages UTC (`DateTime` UTC, différence en `Duration`). Aucune constante de 480.
    2. **Arrêts** : chaque arrêt est tronqué aux bornes du quart avant tout calcul. Un arrêt hors quart compte 0.
    3. **Disponibilité** : `temps_requis_min = temps_ouverture_min − arrêts planifiés` ; `temps_marche_min = temps_requis_min − arrêts non planifiés` ; `D = temps_marche_min / temps_requis_min`.
    4. **Performance** : `temps_utile_min = Σ (pieces_produites × temps_cycle_ideal_s) / 60` sur toutes les déclarations ; `P = min(1, temps_utile_min / temps_marche_min)`. Plafond à 100 % et drapeau `performance_plafonnee` vrai si le plafond a joué.
    5. **Qualité** : `Q = (pieces_produites − pieces_rebutees) / pieces_produites`.
    6. **OEE** : `OEE = D × P × Q`. Cas dégénérés : `temps_requis_min = 0` donne « non calculable » (aucune valeur, aucune exception) ; `temps_marche_min = 0` donne D = P = 0 ; `pieces_produites = 0` donne Q = 0 ; dans ces cas l'OEE vaut 0.
  - **Niveau 2 (bonus, plafonné à 1 point)** : la partie de temps où un arrêt planifié et un arrêt non planifié se recouvrent est comptée comme planifiée, et les arrêts de même catégorie qui se chevauchent sont fusionnés avant le calcul. Diagramme de Pareto des causes d'arrêt.
  - **Cas de test d'acceptation** (8, valeurs affichées arrondies à 0,1 point) :

    | # | Entrée | Sortie attendue |
    |---|---|---|
    | 1 | quart de 480 min, aucun arrêt ; cycle 30 s ; 900 produites dont 9 rebutées | D 100,0 % ; P 93,8 % (93,75 arrondi vers le haut) ; Q 99,0 % ; OEE 92,8 % |
    | 2 | quart de 480 min ; pause 30 min ; panne 45 min + changement de série 15 min ; cycle 60 s ; 330 produites dont 33 rebutées | temps requis 450, marche 390 ; D 86,7 % ; P 84,6 % ; Q 90,0 % ; OEE 66,0 % |
    | 3 | quart du mardi 6 octobre 2026, 06:00 à 14:00 heure de Paris ; panne de 13:30 à 14:30 ; cycle 20 s ; 1 200 produites, 0 rebut | arrêt tronqué à 30 min ; D 93,8 % ; P 88,9 % ; Q 100,0 % ; OEE 83,3 % |
    | 4 | quart de 480 min, aucun arrêt ; cycle 30 s ; 1 000 produites dont 50 rebutées | temps utile 500 min > 480 : P plafonnée à 100,0 %, `performance_plafonnee` vrai ; Q 95,0 % ; OEE 95,0 % |
    | 5 | quart de 480 min ; attente matière 60 min ; OF 1 : cycle 30 s, 400 produites dont 4 rebutées ; OF 2 : cycle 45 s, 200 produites dont 20 rebutées | marche 420 ; D 87,5 % ; temps utile 350 min ; P 83,3 % ; Q 96,0 % ; OEE 70,0 % |
    | 6 | quart de 480 min, dont 480 min d'arrêt planifié | « non calculable », sans exception |
    | 7 | quart de 480 min ; panne de 480 min ; 0 pièce | D 0,0 % ; P 0,0 % ; Q 0,0 % ; OEE 0,0 % |
    | 8 | nuit du 24 au 25 octobre 2026, de 22:00 (heure d'été) à 06:00 (heure d'hiver), soit 20:00Z à 05:00Z ; aucun arrêt ; cycle 30 s ; 1 000 produites dont 10 rebutées | durée 540 min ; D 100,0 % ; P 92,6 % ; Q 99,0 % ; OEE 91,7 % |

    Ces cas sont écrits par le gardien produit en S4 sous forme de fichiers `.feature` Gherkin (français, à vérifier : voir la pile ci-dessus) dans `test/acceptance/` (tests widget générés par `bdd_widget_test` avec `dart run build_runner build --delete-conflicting-outputs`), avant le code de l'agent sur les sous-règles restantes. Le cas 8 est le seul test du changement d'heure du thème : il est pertinent ici parce que le temps d'ouverture est une durée réelle.
- **Première user story et sous-règle isolée (BDD)** : la disponibilité (règles 2 et 3), sans déclaration ni performance, s'écrit comme un scénario `.feature` en français, sans changer les valeurs (cas 2 : quart de 480 min, pause 30 min, panne 45 min, changement de série 15 min) :

    ```gherkin
    Fonctionnalité: Calcul de la disponibilité d'un quart
      Scénario: disponibilité avec un arrêt planifié et deux arrêts non planifiés
        Soit un quart de 480 minutes
        Et un arrêt planifié "pause" de 30 minutes
        Et un arrêt non planifié "panne" de 45 minutes
        Et un arrêt non planifié "changement_serie" de 15 minutes
        Quand je calcule la disponibilité
        Alors le temps requis est de 450 minutes
        Et le temps de marche est de 390 minutes
        Et la disponibilité affichée est 86,7 %
    ```
- **Import/export** : un seul import CSV dans le cœur, celui des déclarations de production (`poste`, `quart_debut_utc`, `numero_of`, `pieces_produites`, `pieces_rebutees`), fichier choisi avec `file_picker` et parseur dans la couche data ; les arrêts se saisissent par formulaire (l'import des arrêts est une extension). Motifs de rejet précis :
  1. `quantite_invalide` (pièces produites ou rebutées non entières ou négatives) ;
  2. `declaration_en_double` (même quart et même OF deux fois dans le fichier ou déjà en base) ;
  3. `poste_inconnu` ;
  4. `rebuts_superieurs_produites` ;
  5. `quart_inconnu` (horodatage invalide ou sans quart correspondant), `colonnes_manquantes` ou fichier de plus de 200 Ko.

  Export : TRS par poste et par quart en CSV, avec neutralisation des cellules dangereuses.
- **Tableau de bord (4 vues)** : (1) OEE par poste et par quart avec D, P et Q ; (2) répartition des minutes d'arrêt par catégorie et par cause (Pareto) ; (3) avancement des OF (pièces bonnes contre quantité lancée) ; (4) arrêts de type `panne` sans `ticket_gmao`, à régulariser.
- **Contrainte de harnais et piège d'agent** :
  - Piège : les unités mélangées. L'agent divise des secondes par des minutes sans convertir : la performance est 60 fois trop élevée, puis le plafond à 100 % **masque** l'erreur en affichant partout 100 %. Il peut aussi ajouter des `* 60` ou des `/ 3600` éparpillés. À documenter comme cas d'erreur d'agent (voir le cours sur le harnais).
  - Harnais : règle `CLAUDE.md` « toute durée est en minutes entières (suffixe `Min`), tout temps de cycle en secondes (suffixe `S`), la conversion vit dans `lib/core/unites.dart` » ; test d'architecture (`flutter test`) qui lit les sources des dossiers `domain/` et échoue si les littéraux `60` ou `3600` apparaissent ailleurs que dans `unites.dart` ; `test/acceptance/**` protégé par permissions `deny`, `CODEOWNERS` et la consigne `CLAUDE.md` « un test qui échoue n'est jamais corrigé en modifiant le test » ; hook `PostToolUse` qui lance `flutter test` ; `flutter analyze` dans la CI.
- **Conformité (RGPD et AI Act)** (voir `cours/conformite-ai-act-rgpd.md`) :
  - *Données traitées* : postes, quarts, déclarations de production, arrêts avec commentaire libre. Une donnée de poste ou de quart devient **personnelle** dès qu'elle permet d'identifier ou d'évaluer un salarié (poste tenu par une seule personne, commentaire nominatif, compte `operateur`). Un TRS par quart peut en pratique évaluer indirectement une équipe ou un opérateur.
  - *Personnes concernées* : les opérateurs et les responsables de la ligne (comptes utilisateurs, et salariés dont le travail est mesuré).
  - *Finalité* : mesurer et améliorer le rendement des équipements pendant une campagne. **Pas** l'évaluation individuelle des salariés : cette finalité est exclue de l'énoncé.
  - *Durée de conservation proposée* : la durée de la campagne de mesure, puis suppression ou agrégation par poste et par semaine (par exemple 3 mois maximum pour les données par quart).
  - *Ce qui doit rester fictif* : le site, les postes, les produits, les OF, les opérateurs et les tickets GMAO ; aucun export réel d'un MES ou d'un atelier dans le dépôt public.
  - *Niveau de risque AI Act probable* : **minimal ou hors champ** pour un calcul déterministe. La vigilance porte sur le domaine de l'emploi et de la gestion des travailleurs (annexe III, point 4 du règlement (UE) 2024/1689 : systèmes d'IA destinés à l'attribution de tâches ou à la surveillance et l'évaluation de salariés) : si l'on ajoutait un jour une analyse par IA des performances individuelles, le système pourrait devenir **à haut risque** (à vérifier). **Dialogue social** : en entreprise réelle, la mise en place d'un outil de mesure de l'activité des salariés suppose d'informer et de consulter le CSE (art. L. 2312-38 du Code du travail (à vérifier), moyens de contrôle de l'activité des salariés) : à mentionner dans la fiche comme un point à examiner avant toute mise en usage.
  - *Mesures concrètes dans l'application* : agrégation par poste et par quart, jamais par personne ; **aucun identifiant d'opérateur n'est stocké dans les données métier** (seul le compte de connexion existe) ; aucun nom dans le commentaire d'arrêt : le contrôle est une **consigne affichée dans le formulaire**, complétée par une **revue en audit croisé** des commentaires de la base de démonstration ; journal technique sans nom ; neutralisation des cellules CSV à l'export ; validation humaine : le TRS est un indicateur d'aide à la décision, pas une sanction automatique. Ces mesures sont incluses dans les 15 à 20 h de charge d'équipe.
  - *Contenu attendu de la fiche de conformité* : les 13 rubriques du gabarit de `docs/fiche_conformite.md`, avec en particulier la distinction « équipement ou personne » dans les données, le rôle AI Act (fournisseur ou déployeur), la mention du CSE, la durée de conservation ; **présentée au RSSI en S4, v1 déposée le 8 décembre, réponse avant le 11 décembre**. Un « go » ne vaut que pour le périmètre pédagogique à données fictives ; toute mise en usage réel impose une nouvelle fiche et une nouvelle validation.
- **Sécurité et données** :
  1. **OWASP, injection** : le champ `commentaire` est du texte libre exporté en CSV : toute cellule commençant par `=`, `+`, `-` ou `@` est préfixée d'une apostrophe à l'export (injection de formule). Toutes les requêtes passent par drift (requêtes typées ou variables liées), jamais par du SQL brut concaténé (`customSelect`, `customStatement`).
  2. **Aucun secret dans le dépôt** : aucun secret n'est embarqué dans l'application (tout ce qui est dans un build web Flutter est public) ; un fichier `.env` éventuel est ignoré ; `gitleaks` en CI, et un test échoue si un fichier `.env` ou une clé apparaît dans `git ls-files`.
- **Découpage par séance** :
  - S1 : théorie et installations ; pas de travail sur le projet.
  - S2 : les équipes et le classement des thèmes sont collectés par formulaire à la fin de S1 ou dans le pre-flight (identifiants GitHub inclus) ; l'enseignant prépare les 8 dépôts depuis le modèle (squelette Flutter, `CLAUDE.md` et document d'architecture fournis) et ajoute les membres comme collaborateurs de chaque dépôt (pas d'invitation à l'organisation) avant S2 ; en S2, on valide les équipes, on tire au sort en cas de litige et on libère du temps pour l'initialisation ; `PROJET.md` fourni pré-rempli pour le thème B (vision, 3 à 5 user stories), à relire et compléter, avec le glossaire d'équipe ; première PR relue par un coéquipier ; `main` protégée (PR obligatoire, 1 approbation) ; premiers éléments du harnais (`CLAUDE.md` minimal, première permission).
  - S3 (4 h) : **indispensable en séance** : remise en route de 30 min en début de séance (`git pull`, `flutter pub get`, `flutter test`, lancement de l'agent) ; première user story en TDD et en BDD (scénario Gherkin, voir « Première user story et sous-règle isolée ») sur une seule sous-règle isolée, la disponibilité (règles 2 et 3) sur des entrées simples, sans déclaration ni performance, avec un repository en mémoire (fake) ; tables drift, première migration (`schemaVersion`) et test d'intégrité sur base en mémoire ; bloc RGPD ; début de la fiche de conformité (rubriques 1 à 5 : finalité, données, personnes concernées, base légale ou justification « données fictives », durée) ; PR croisées entre équipes (paires de même thème tolérées en S3). **Peut glisser dans le sprint ou au début de S4** : seed complet, rôles (`responsable`, `operateur`) avec la garde `RequireRole` (couche domain) et test de refus. **Livrable de fin de S3** : « première règle verte, modèle et migrations fusionnés, début de `docs/fiche_conformite.md` commité ». Si l'équipe est en retard, le seed et les rôles passent en premier au sprint.
  - S4 (4 h) : **indispensable en séance** : le gardien produit écrit les 8 cas d'acceptation avant le code de l'agent sur les sous-règles restantes ; CI verte ; publication du build web sur GitHub Pages par chaque équipe (analyse, tests avec couverture, `gitleaks`, audit des dépendances pub, build web, déploiement ; données fictives uniquement) ; seed et rôles s'ils ont glissé ; passage devant le RSSI (3 tables en parallèle, 10 à 12 min par équipe, jeu de rôle intégré) ; audit croisé réduit à 5 points (installation à froid : `git clone`, `flutter pub get`, `flutter test`, `flutter run -d chrome` ; CI verte, obligatoire, avec audit des dépendances ; secrets : `gitleaks`, rien dans le dépôt ni dans le bundle web, `.env` ignoré ; rôles : garde testée ; fiche de conformité) ; les paires de même thème sont évitées en S4. **Plan B** : si la publication sur GitHub Pages bloque (réglages du dépôt, droits), l'équipe montre son build local (`flutter run -d chrome`) et termine la publication au sprint. **Peut glisser dans le sprint** : publication GitHub Pages si elle n'est pas terminée, release v0.1, export CSV. S4 ne suppose pas le CRUD terminé, et un exposé continu ne dépasse pas 30 min : on le coupe par une activité (quiz ou cas à classer).
  - Sprint de 12 jours : finir le périmètre : CRUD postes, quarts, OF, déclarations et arrêts, import CSV des déclarations, quatre vues, cas d'acceptation non encore verts à la fin de S4, README testé à froid, bonus éventuel.
  - S5 : gel (tag `v1.0-rc` le lundi 14 décembre à 18 h), retouches bloquantes, soutenance.
- **Livrable minimum viable** : quart, déclaration, arrêts, TRS avec les règles 1 à 6 sur le cas nominal et les cas dégénérés, vue 1, CI verte, fiche de conformité déposée et soumise au RSSI. L'import CSV des déclarations fait partie du socle obligatoire ; sans Pareto et sans test du changement d'heure si l'équipe est en retard (mais le cas 8 reste écrit).
- **Effet « wow » pour la soutenance** : l'équipe importe le CSV de déclarations d'un quart de nuit chaotique, saisit ses arrêts, affiche le TRS et son Pareto, puis le jury modifie une durée d'arrêt : l'OEE et la répartition des pertes changent aussitôt. Le cas du 24 au 25 octobre montre qu'une nuit peut durer 9 heures.
- **Mini-glossaire** :
  - **OF** (ordre de fabrication) : instruction de produire une quantité d'un produit sur un poste.
  - **Gamme** : liste ordonnée des opérations d'un produit avec leurs temps standards, dont le temps de cycle idéal.
  - **OEE / TRS** : disponibilité × performance × qualité.
  - **Étalonnage** : vérification et réglage d'un moyen de mesure ou de contrôle par rapport à un étalon ; arrêt planifié dans ce thème.
  - **GMAO** : logiciel de gestion de la maintenance ; ici une simple référence de ticket dans `ticket_gmao`.
  - **MES** : système d'exécution de la fabrication, source des événements de production ; ici les fichiers CSV importés.
  - **CSE** : comité social et économique, instance de représentation du personnel en France (art. L. 2312-38 du Code du travail (à vérifier) pour l'information et la consultation sur les moyens de contrôle de l'activité des salariés).

---

## Thème C · Vœux de projet : répartir les sujets de projet équitablement

> **Projet fictif : aucune donnée ni intégration réelle avec Nantes Université.** Tous les étudiants sont des pseudonymes (`etu_001`, `etu_002`...), tous les sujets et enseignants sont inventés. Aucune donnée réelle, même partielle, n'entre dans le dépôt.

- **Pitch** : chaque année, un département fictif de formation d'ingénieurs propose une trentaine de sujets de projet à quatre-vingts étudiants. Chacun classe ses vœux, et la répartition se fait à la main en une soirée, avec des tableurs, des mécontents et aucune explication. Vous construisez l'outil qui répartit les sujets selon des règles connues à l'avance, montre à chaque étudiant pourquoi il a obtenu tel sujet, et à l'équipe pédagogique quels sujets sont trop peu choisis.
- **Commanditaire (fictif) et besoin** : Gwenaëlle Hérault, responsable des projets d'un département fictif (personnage fictif). Elle veut une répartition **équitable et reproductible** : mêmes vœux, même résultat. Elle veut voir les étudiants non affectés avec le motif, repérer les sujets sous-peuplés, et pouvoir refaire la répartition après correction d'un vœu.
- **Besoin ponctuel** :
  - *Pourquoi un outil de courte durée de vie suffit* : la répartition a lieu une fois par an, en quelques jours. L'outil sert le temps d'une campagne de vœux, puis il est archivé jusqu'à l'année suivante (où l'on repart d'un nouveau dépôt ou d'une base vidée).
  - *Ce qui reste obligatoire même pour un outil jetable* : l'algorithme testé et déterministe, l'explication individuelle de chaque résultat, la protection des données (la plus sensible des trois thèmes), la validation humaine de la répartition avant publication, et un README pour relancer l'outil.
  - *Désactivation et archivage* : après la publication des résultats et le délai de réclamation (par exemple 30 jours), suppression des vœux et des rangs ; seules des statistiques agrégées (satisfaction par vœu) peuvent être conservées. Le service est arrêté.
- **Données manipulées** :
  - Entités (5) : `enseignant` (pseudonyme), `sujet` (titre, enseignant, capacite_min, capacite_max, parcours_requis facultatif), `etudiant` (pseudonyme, rang, parcours), `voeu` (etudiant, sujet, ordre), `affectation` (etudiant, sujet, ordre_du_voeu_obtenu, motif si non affecté).
  - Relations : un étudiant a 3 à 5 vœux ordonnés vers des sujets distincts ; un sujet a un enseignant ; une affectation lie un étudiant à un sujet ou porte un motif de non-affectation. `rang` est un classement fictif et unique (1 = prioritaire). `parcours` prend les valeurs `robotique`, `vision` ou `systemes`.
  - Volumes : 80 étudiants, 30 sujets, 10 enseignants, environ 400 vœux.
  - Seed : script à graine fixe ; pseudonymes numérotés, titres de sujets fictifs, jamais de vrais noms ni de vraie liste de classement.
- **Rôles applicatifs** : `gestionnaire` (importe, lance la répartition, corrige) et `etudiant` (lit uniquement son propre vœu et son propre résultat).
- **Rôles dans l'équipe** (la charge du projet ne change pas) :
  - *3 membres* : **gardien produit et conformité** (`PROJET.md`, cas d'acceptation, fiche de conformité, explication des décisions) ; **gardien des données** (modèle, migrations, seed fictif, import CSV, scan des données réelles) ; **gardien du harnais et de la CI** (`CLAUDE.md`, hooks, permissions, test de scan, GitHub Actions).
  - *4 membres* : les trois rôles ci-dessus, avec un **gardien conformité** distinct (fiche, art. 22 RGPD, AI Act, contact avec le RSSI).
  - *5 membres* : les quatre rôles, plus un **gardien de la démonstration** (README testé à froid, jeu de 80 étudiants fictifs, scénario du « wow »).
  - Dans tous les cas, chacun relit au moins une PR d'un autre.
- **MVP** (5 user stories à piocher) :
  1. En tant que gestionnaire, je crée les sujets avec leurs capacités.
  2. J'importe les étudiants (pseudonymes, rang, parcours) et leurs vœux.
  3. Je lance la répartition et j'obtiens les affectations.
  4. Je vois pour chaque étudiant non affecté le motif précis.
  5. En tant qu'étudiant, je consulte mon résultat et le rang du vœu obtenu.
  - **Pour aller plus loin** : (1) un second tour pour les sujets sous-peuplés (voir niveau 2) ; (2) simulation « et si ce vœu changeait ? » ; (3) export du résultat par sujet pour l'enseignant ; (4) import CSV des sujets (`titre`, `enseignant`, `capacite_min`, `capacite_max`, `parcours_requis`), avec le motif `capacite_incoherente` (`capacite_min` supérieur à `capacite_max`, ou nul).
- **Règle métier « clou »** : fonction pure Dart `repartir(sujets, etudiants, voeux)` (couche domain).
  - **Niveau 1 (obligatoire, ≈ 3 h)** : ordre d'application des sous-règles.
    1. **Validation préalable** (bornes) : chaque étudiant a de **3 à 5 vœux inclus**, distincts, vers des sujets existants. Moins de 3 vœux : l'étudiant n'est pas traité et reçoit le motif `voeux_insuffisants`. Plus de 5 : de même, l'étudiant n'est pas traité et reçoit le motif `trop_de_voeux` (les autres étudiants sont traités normalement). Seul `rang_en_double` bloque tout : deux étudiants de même rang provoquent une erreur globale et la répartition ne démarre pas.
    2. **Priorité** : les étudiants sont traités par rang croissant (1 d'abord). Le rang est le seul critère de départage.
    3. **Filtre de parcours** : si un sujet a un `parcours_requis`, il est ignoré pour tout étudiant d'un autre parcours (le vœu est écarté, sans être compté comme complet et sans erreur).
    4. **Capacité** : chaque étudiant reçoit son vœu de plus petit `ordre` dont le sujet a encore une place libre (effectif < `capacite_max`).
    5. **Non-affectation** : si aucun vœu n'est satisfiable, l'étudiant reçoit le motif `tous_voeux_complets` (vœux compatibles avec son parcours, mais tous complets) ; si tous ses vœux sont écartés par le filtre de parcours, il reçoit le motif `aucun_voeu_compatible`.
    6. **Statut de sujet** : après répartition, un sujet est `confirme` si son effectif est ≥ `capacite_min` (borne incluse), `sous_effectif` s'il est inférieur (y compris 0).
  - **Niveau 2 (bonus, plafonné à 1 point)** : un second tour unique : les sujets `sous_effectif` sont fermés ; leurs étudiants et les non-affectés rejouent, dans l'ordre des rangs, avec les places restantes des sujets confirmés.
  - **Jeu de référence du cas 1** :

    | sujet | capacite_min | capacite_max | parcours_requis |
    |---|---|---|---|
    | J1 | 1 | 1 | aucun |
    | J2 | 1 | 2 | aucun |
    | J3 | 1 | 1 | robotique |
    | J4 | 2 | 2 | aucun |

    | étudiant | rang | parcours | vœux dans l'ordre |
    |---|---|---|---|
    | etu_001 | 1 | robotique | J1, J2, J3 |
    | etu_002 | 2 | robotique | J1, J3, J2 |
    | etu_003 | 3 | vision | J3, J1, J4 |
    | etu_004 | 4 | vision | J1, J3, J2 |
    | etu_005 | 5 | vision | J2, J4 |

  - **Cas de test d'acceptation** (7) :

    | # | Entrée | Sortie attendue |
    |---|---|---|
    | 1 | jeu de référence ci-dessus | etu_001 : J1 (vœu 1) ; etu_002 : J3 (vœu 2) ; etu_003 : J4 (vœu 3, J3 ignoré pour son parcours) ; etu_004 : J2 (vœu 3) ; etu_005 : non affecté, `voeux_insuffisants`. Statuts : J1, J2, J3 `confirme` ; J4 `sous_effectif` (1 sur 2) |
    | 2 | J5 (capacité 1) est le vœu 1 de etu_010 (rang 7) et de etu_011 (rang 6) ; J6 (capacité 2) est leur vœu 2 | etu_011 obtient J5 ; etu_010 obtient J6 (vœu 2) |
    | 3 | étudiant du parcours vision, vœux J3 (parcours_requis robotique, libre), J1 (libre), J2 | affecté à J1 (vœu 2) : J3 est sauté malgré ses places libres |
    | 4 | trois étudiants ayant respectivement 3, 2 et 6 vœux | 3 vœux : traité ; 2 vœux : non traité, `voeux_insuffisants` ; 6 vœux : non traité, `trop_de_voeux` ; aucune erreur globale, la répartition a lieu pour les autres étudiants |
    | 5 | étudiant de rang 9, vœux J1, J2, J3, tous déjà à capacité maximale | non affecté, `tous_voeux_complets`. Second jeu : étudiant de parcours vision dont les 3 vœux sont des sujets de parcours robotique : non affecté, `aucun_voeu_compatible` |
    | 6 | deux sujets de `capacite_min` 2 : l'un avec 2 étudiants, l'autre avec 1 | le premier `confirme` (borne incluse), le second `sous_effectif` |
    | 7 | deux étudiants de rang 3 | erreur `rang_en_double`, aucune affectation produite |

    Ces cas sont écrits par le gardien produit en S4 sous forme de fichiers `.feature` Gherkin (français, à vérifier : voir la pile ci-dessus) dans `test/acceptance/` (tests widget générés par `bdd_widget_test` avec `dart run build_runner build --delete-conflicting-outputs`), avant le code de l'agent sur les sous-règles restantes.
- **Première user story et sous-règle isolée (BDD)** : la priorité par rang (règle 2), sur des entrées simples sans capacité ni filtre de parcours, s'écrit comme un scénario `.feature` en français, sans changer les valeurs (rangs du cas 2 : etu_010 de rang 7, etu_011 de rang 6) :

    ```gherkin
    Fonctionnalité: Répartition des sujets
      Scénario: les étudiants sont traités par rang croissant
        Soit un étudiant "etu_010" de rang 7
        Et un étudiant "etu_011" de rang 6
        Quand je lance la répartition
        Alors "etu_011" est traité avant "etu_010"
    ```
- **Import/export** : un seul import CSV dans le cœur, celui des étudiants et de leurs vœux (CSV séparé par virgule, une ligne par étudiant : `pseudonyme`, `rang`, `parcours`, `voeux`, champ entre guillemets, titres de sujets séparés par `|` dans l'ordre), avec rapport ligne par ligne (fichier choisi avec `file_picker`, parseur dans la couche data) ; les sujets se créent par formulaire (leur import est une extension). Motifs de rejet précis :
  1. `pseudonyme_invalide` (format différent de `etu_` suivi de trois chiffres : tout nom, courriel ou identifiant réel est refusé) ;
  2. `rang_en_double` ;
  3. `sujet_inconnu` (vœu vers un sujet inexistant) ;
  4. `voeu_en_double` (même sujet deux fois pour un étudiant) ;
  5. `parcours_inconnu` (hors de `robotique`, `vision` et `systemes`) ou `colonnes_manquantes` ; tout fichier de plus de 200 Ko ou d'un type autre que CSV est refusé.

  Export : répartition en CSV (pseudonyme, sujet, ordre du vœu obtenu) et sauvegarde JSON.
- **Tableau de bord (4 vues)** : (1) remplissage des sujets (effectif, capacités, statut) ; (2) « mon résultat » pour l'étudiant (sujet obtenu, rang du vœu, explication) ; (3) non-affectés par motif ; (4) répartition de la satisfaction (combien ont obtenu leur 1er, 2e, 3e vœu ou plus).
- **Contrainte de harnais et piège d'agent** :
  - Piège : les données réelles collées. Pour « rendre les tests réalistes », l'agent colle une vraie liste de classement, des noms d'étudiants ou de vrais courriels trouvés dans un document ou en ligne. Une fois commités dans un dépôt public, ils ne se retirent plus. À documenter comme cas d'erreur d'agent (voir le cours sur le harnais).
  - Harnais : règle `CLAUDE.md` « aucune donnée réelle, tous les étudiants sont `etu_NNN` » ; test Dart (`flutter test`) qui scanne les fichiers versionnés (`git ls-files`) et échoue si un fichier `.csv`, `.xlsx` ou `.json` de données se trouve hors de `seed/`, ou si une adresse de courriel apparaît dans `seed/` ou `test/` ; tout asset déclaré dans `pubspec.yaml` part dans le build web public, donc seul le seed fictif peut y figurer ; dossier `data/local/` ignoré par git pour les essais ; permissions `deny` sur `test/acceptance/**` (plus `CODEOWNERS` et la consigne `CLAUDE.md` « un test qui échoue n'est jamais corrigé en modifiant le test ») et hook `PostToolUse` qui lance `flutter test` ; le test de scan et `gitleaks` tournent aussi dans la CI.
- **Conformité (RGPD et AI Act)** (voir `cours/conformite-ai-act-rgpd.md`) :
  - *Données traitées* : pseudonymes d'étudiants, rang (classement), parcours, vœux, affectations et motifs de non-affectation. Dans un cas réel, le rang et les vœux sont des **données personnelles** (et le rang peut révéler des résultats scolaires) ; la table de correspondance pseudonyme-identité resterait hors application.
  - *Personnes concernées* : les étudiants (et, à un degré moindre, les enseignants).
  - *Finalité* : affecter des sujets de projet selon des règles connues à l'avance et expliquer chaque résultat. Aucune réutilisation du rang ou des vœux pour un autre usage (orientation, notation, prédiction).
  - *Durée de conservation proposée* : jusqu'à la fin du délai de réclamation après publication (par exemple 30 jours) ; ensuite suppression des vœux et des rangs, conservation éventuelle de statistiques agrégées.
  - *Ce qui doit rester fictif* : tous les étudiants (`etu_NNN`), les rangs, les sujets, les enseignants et le département ; jamais de vraie liste, même partielle ; jamais de courriel.
  - *Niveau de risque AI Act probable* : **domaine de l'éducation et de la formation professionnelle, à discuter** : l'annexe III, point 3 du règlement (UE) 2024/1689 cite notamment les systèmes d'IA destinés à déterminer l'accès, l'admission ou l'**affectation** de personnes à des établissements ou à des formations. L'affectation à un sujet de projet interne n'est pas forcément l'affectation visée par le texte, et un algorithme purement déterministe n'est peut-être pas un « système d'IA » au sens de l'art. 3, point 1 : c'est précisément le point à discuter avec le RSSI (à vérifier). La prudence consiste à traiter l'outil **comme s'il était à haut risque** dans la démarche (transparence, supervision humaine, journalisation, explication) : c'est une **démarche de précaution pédagogique, pas une qualification juridique**.
  - *RGPD, décision automatisée* : l'art. 22 donne à la personne le droit de ne pas faire l'objet d'une décision fondée exclusivement sur un traitement automatisé produisant des effets juridiques ou l'affectant de manière significative, et de demander une intervention humaine, d'exprimer son point de vue et de contester la décision (à vérifier selon l'effet réel d'un sujet de projet). L'information sur la « logique sous-jacente » relève des art. 13(2)(f), 14(2)(g) et 15(1)(h), les garanties de l'art. 22(3) (intervention humaine, point de vue, contestation) et l'explication individuelle du considérant 71. La validation humaine effective du gestionnaire avant publication est ce qui peut écarter la qualification de décision exclusivement automatisée (à vérifier, et à faire discuter par le RSSI ou le DPO). D'où le dispositif ci-dessous.
  - *Mesures concrètes dans l'application* : pseudonymisation de bout en bout ; journal technique **sans pseudonyme ni vœu** ; **explication de la décision** pour chaque étudiant (vue « mon résultat » : quel vœu, pourquoi les précédents n'ont pas été obtenus, règle appliquée) ; **validation humaine** obligatoire par le gestionnaire avant publication : un **champ de statut `brouillon` / `publie`** du résultat est obligatoire, la correction d'un vœu et la nouvelle répartition restant possibles en extension ; motif de non-affectation toujours affiché ; règles publiées avant la collecte des vœux (une page statique suffit). Ces mesures sont incluses dans les 15 à 20 h de charge d'équipe ; le thème C demande davantage de travail de conformité que A et B.
  - *Contenu attendu de la fiche de conformité* : les 13 rubriques du gabarit de `docs/fiche_conformite.md`, avec en particulier l'analyse art. 22, le niveau de risque AI Act argumenté avec ses réserves, le rôle AI Act (fournisseur ou déployeur), la durée de conservation des vœux et des rangs ; **présentée au RSSI (et au DPO) en S4, v1 déposée le 8 décembre, réponse avant le 11 décembre**. Un « go » ne vaut que pour le périmètre pédagogique à données fictives ; toute mise en usage réel impose une nouvelle fiche et une nouvelle validation.
- **Sécurité et données** :
  1. **OWASP, envoi de fichier non maîtrisé** : le CSV envoyé est limité à 200 Ko, vérifié par extension et contenu (UTF-8 texte), lu en mémoire (octets fournis par `file_picker`, à vérifier selon la plateforme) et jamais enregistré sous le nom fourni par l'utilisateur ; le nom de fichier n'est jamais utilisé comme chemin.
  2. **Minimisation et données fictives** : uniquement des pseudonymes, aucun texte libre ; les journaux n'écrivent ni pseudonyme ni vœu ; la correspondance entre pseudonyme et identité réelle, s'il en fallait une, resterait hors application et hors dépôt.
- **Découpage par séance** :
  - S1 : théorie et installations ; pas de travail sur le projet.
  - S2 : les équipes et le classement des thèmes sont collectés par formulaire à la fin de S1 ou dans le pre-flight (identifiants GitHub inclus) ; l'enseignant prépare les 8 dépôts depuis le modèle (squelette Flutter, `CLAUDE.md` et document d'architecture fournis) et ajoute les membres comme collaborateurs de chaque dépôt (pas d'invitation à l'organisation) avant S2 ; en S2, on valide les équipes, on tire au sort en cas de litige et on libère du temps pour l'initialisation ; `PROJET.md` fourni pré-rempli pour le thème C (vision, 3 à 5 user stories), à relire et compléter ; première PR relue par un coéquipier ; `main` protégée (PR obligatoire, 1 approbation) ; premiers éléments du harnais (`CLAUDE.md` minimal avec la règle « aucune donnée réelle », première permission).
  - S3 (4 h) : **indispensable en séance** : remise en route de 30 min en début de séance (`git pull`, `flutter pub get`, `flutter test`, lancement de l'agent) ; première user story en TDD et en BDD (scénario Gherkin, voir « Première user story et sous-règle isolée ») sur une seule sous-règle isolée, la priorité par rang (règle 2), sur des entrées simples sans capacité ni filtre de parcours, avec un repository en mémoire (fake) ; tables drift, première migration (`schemaVersion`) et test d'intégrité sur base en mémoire ; bloc RGPD ; début de la fiche de conformité (rubriques 1 à 5 : finalité, données, personnes concernées, base légale ou justification « données fictives », durée) ; PR croisées entre équipes (paires de même thème tolérées en S3). **Peut glisser dans le sprint ou au début de S4** : seed complet, rôles (`gestionnaire`, `etudiant`) avec la garde `RequireRole` (couche domain) et test de refus. **Livrable de fin de S3** : « première règle verte, modèle et migrations fusionnés, début de `docs/fiche_conformite.md` commité ». Si l'équipe est en retard, le seed et les rôles passent en premier au sprint.
  - S4 (4 h) : **indispensable en séance** : le gardien produit écrit les 7 cas d'acceptation avant le code de l'agent sur les sous-règles restantes ; CI verte ; publication du build web sur GitHub Pages par chaque équipe (analyse, tests avec couverture, `gitleaks`, audit des dépendances pub, build web, déploiement ; données fictives uniquement) ; seed et rôles s'ils ont glissé ; contrôle du téléversement ; analyse de l'art. 22 ; passage devant le RSSI (3 tables en parallèle, 10 à 12 min par équipe, jeu de rôle intégré) ; audit croisé réduit à 5 points (installation à froid : `git clone`, `flutter pub get`, `flutter test`, `flutter run -d chrome` ; CI verte, obligatoire, avec audit des dépendances ; secrets : `gitleaks`, rien dans le dépôt ni dans le bundle web, `.env` ignoré ; rôles : garde testée ; fiche de conformité) ; les paires de même thème sont évitées en S4. **Plan B** : si la publication sur GitHub Pages bloque (réglages du dépôt, droits), l'équipe montre son build local (`flutter run -d chrome`) et termine la publication au sprint. **Peut glisser dans le sprint** : publication GitHub Pages si elle n'est pas terminée, release v0.1. S4 ne suppose pas le CRUD terminé, et un exposé continu ne dépasse pas 30 min : on le coupe par une activité (quiz ou cas à classer).
  - Sprint de 12 jours : finir le périmètre : CRUD sujets et étudiants, import CSV des étudiants et de leurs vœux, quatre vues, cas d'acceptation non encore verts à la fin de S4, explications par étudiant, README testé à froid, bonus éventuel.
  - S5 : gel (tag `v1.0-rc` le lundi 14 décembre à 18 h), retouches bloquantes, soutenance.
- **Livrable minimum viable** : création des sujets, import des étudiants et de leurs vœux, répartition avec les règles 1 à 5, affichage des affectations et des motifs, explication par étudiant, rôles de base, statut `brouillon` / `publie`, CI verte, fiche de conformité déposée et soumise au RSSI. Sans statut de sujet, sans vue de satisfaction ni export.
- **Effet « wow » pour la soutenance** : l'équipe répartit 80 étudiants en quelques secondes, puis le jury change le rang de deux étudiants : le résultat change et l'outil explique pourquoi chacun a obtenu son sujet. L'écran des sujets `sous_effectif` montre ce qu'il resterait à arbitrer.
