# Chapitre 2 · La soutenance d'équipe : démonstration, « sous le capot », conformité

*Séance 5 « Retouches et soutenance » · Master ITI, Nantes Université, 2026-2027. Chapitre à lire avant ou après la séance. Les commandes git et `flutter test` ont été exécutées le 27 novembre 2026 sous Linux (git 2.53.0, Flutter 3.50.1, Dart 3.14.0), sur une copie du dépôt-modèle placée hors du dépôt du cours, avec un dépôt distant local : rien n'a été écrit sur GitHub ; quelques commandes `gh` ont été essayées en lecture seule sur le dépôt du cours (gh 2.100.0), pas sur un dépôt d'équipe. Aucune soutenance n'a été jouée : le déroulement décrit est celui du programme.*

Ce chapitre accompagne les blocs 4 (répétition technique) et 5 (soutenances) de la séance, et la répétition chronométrée que votre équipe fait avant de venir. Il traite la **partie commune** du passage : ce que l'équipe montre ensemble, avant les questions posées à chacun. Le programme en fixe le contenu en trois temps : une démonstration en direct, un passage « sous le capot », un point de conformité. Pour chaque temps, le chapitre dit ce que le programme demande, quel critère de la grille il nourrit et quelle preuve le montre, sans jamais vous demander de lire du code devant le jury. L'exemple suivi est le dépôt `equipe_04`, du thème B (le TRS de la ligne 4). L'oral individuel et le calcul de la note sont au chapitre 3.

## Ce que vous allez retenir

- Le budget d'un passage est un **ordre de grandeur d'organisation**, pas un minutage : de l'ordre de 30 minutes pour une équipe de 4, 34 pour une équipe de 5. La partie commune tient en **une dizaine de minutes** ; le programme ne dit pas comment la répartir.
- La partie commune a **trois temps**, dans cet ordre : démonstration en direct, « sous le capot » (harnais, une décision sur les données, un moment de l'historique git, mesures), conformité (fiche, avis du RSSI, limites d'usage).
- La démonstration est **en direct**, sur un scénario que l'équipe choisit, avec des **données fictives**. La démonstration enregistrée et le jeu de données de secours ne servent **qu'en cas de panne** ; une démonstration enregistrée sans plan B live est pénalisée.
- Le critère « Soutenance » vaut **1 point**. La soutenance sert aussi de preuve à d'autres critères collectifs : « Fonctionnalité », « Données et conformité », et les deux cas `erreur-agent` de « Process git et équipe ».
- Les **mesures** se compilent à partir des trois lignes « Suivi » de vos PR (temps estimé, temps réel, retouches). On présente des chiffres relevés, pas une impression.
- Le **regard critique** se dit avec ces chiffres et avec la rubrique 12 de la fiche : ce que vos mesures montrent, ce qu'elles ne montrent pas, et ce pour quoi votre outil ne doit pas être utilisé.
- On **répète une fois, en équipe, avec chronomètre** avant la séance, puis on vérifie la technique dans la salle (affichage, jeu de données de secours, plan B enregistré).

---

## 1. Pourquoi ce chapitre

Tout ce que vous allez montrer existe déjà dans votre dépôt. Ce chapitre ne vous apprend aucun geste technique nouveau : il vous aide à choisir quoi montrer, dans quel ordre, et avec quelle preuve. Ce qui a été vu ailleurs n'est pas redit :

- **Mesurer plutôt que croire** : l'essai de METR (chapitre 3 de la séance 1, section 3.2) et les trois questions à poser devant un chiffre (même chapitre, sections 3.1 et 8).
- **Les trois lignes de suivi et la section « ce que l'agent a proposé, ce que j'ai refusé »** : chapitre 3 de la séance 2, sections 9.2 et 9.3 ; un exemple rempli au chapitre 2 de la séance 3, section 9.3.
- **L'étiquette `erreur-agent`** : chapitre 3 de la séance 2, section 9.3 ; chapitre 1 de la séance 3, section 4.4 ; reconnaître un agent qui triche, chapitre 2 de la séance 3, section 8.
- **Le passage devant le RSSI, sa décision et la rubrique 13** : chapitre 4 de la séance 4, sections 7 à 10.
- **La version web publiée** : chapitre 2 de la séance 4, sections 5.3 et 5.4 ; le plan B de publication, même chapitre, section 9.
- **Le gel, les tags `v1.0-rc` et `v1.0`, le dossier de rendu** : chapitre 1 de cette séance.

Le programme donne à la soutenance cette intention (bloc 5) : **« Évaluer ce que l'équipe et chacun comprennent, preuves à l'appui. »** Les évaluateurs ont lu votre dépôt la veille. La soutenance ne sert donc pas à leur réciter le `README` : elle sert à montrer que l'outil fonctionne, que vous savez pourquoi il est fait ainsi, et que vous connaissez ses limites.

> **À retenir.** Vous ne préparez pas un discours, vous choisissez des preuves : un écran qui fonctionne, un test vert, une PR, une rubrique de la fiche.

---

## 2. Le dispositif

### 2.1 Une contrainte d'organisation, pas un minutage

Le programme prévient, mot pour mot :

> *Programme, « Format de la soutenance ».* Cette section décrit une **contrainte d'organisation** (32 étudiants, un jury), pas un déroulé de parole ni un minutage de la séance. Les chiffres sont des **ordres de grandeur à ajuster** selon les équipes et les évaluateurs.

Tous les chiffres de cette section sont à lire ainsi. Le programme ne dit pas qui conduit le passage.

### 2.2 Deux salles, un ordre tiré au sort

Avec 8 équipes de 4, le programme retient **deux salles parallèles de 4 équipes chacune** : salle 1, équipes 01, 03, 05, 07 ; salle 2, équipes 02, 04, 06, 08. L'équipe `equipe_04` passe donc en salle 2. Dans chaque salle, le programme prévoit :

- **un évaluateur et un second évaluateur ou observateur** (à confirmer, voir « Points non vérifiés ») : « L'observateur chronomètre et note les écarts » ;
- pour l'évaluateur, une **fiche de notation pré-remplie par étudiant** (équipe, étudiant, PR tirée au sort, échelle de compréhension de 0 à 4 pour les deux questions) ;
- un vidéoprojecteur, un **chronomètre visible**, une **machine de secours** et, imprimées, des fiches d'observation, la grille de notation et l'échelle de compréhension orale.

L'ordre de passage est **tiré au sort à l'avance**. Il vous est donné au briefing (bloc 1), avec l'affectation aux salles, le format et les critères. Vous ne choisissez donc pas votre place. Conseil de ce chapitre : préparez-vous comme si vous passiez en premier.

### 2.3 Le budget indicatif par équipe

La formule du programme, mot pour mot :

> *Programme, « Format de la soutenance ».* **Budget indicatif par équipe** (organisation, à ajuster) : de l'ordre de **30 minutes pour une équipe de 4** et **34 minutes pour une équipe de 5**, selon la formule « une partie commune d'une dizaine de minutes + quatre minutes de questions par étudiant + une transition de quatre minutes ».

| Taille de l'équipe | Partie commune | Questions individuelles | Transition | Ordre de grandeur (programme) |
|---|---|---|---|---|
| 4 étudiants | une dizaine de minutes | 4 × 4 minutes | 4 minutes | 30 minutes |
| 5 étudiants | une dizaine de minutes | 5 × 4 minutes | 4 minutes | 34 minutes |

La partie commune ne change pas avec la taille de l'équipe, et les questions individuelles prennent plus de la moitié du passage (deux questions par étudiant : chapitre 3, section 2). Le programme ne donne **aucune répartition** de la dizaine de minutes entre la démonstration, le « sous le capot » et la conformité. Ce chapitre n'en invente pas : c'est votre répétition chronométrée qui vous dira ce qui tient (section 10.1). Le programme ne chiffre pas non plus le cas d'une équipe de 3 (tolérée, non planifiée).

### 2.4 La variante à 7 équipes et le format dégradé

Si la promotion compte 7 équipes (4 équipes de 5 et 3 équipes de 4), la formule est la même. L'affectation est **indicative**, « à ajuster selon les effectifs réels » ; `equipe_04` y passe en salle 1, celle qui n'a pas de marge :

| Salle | Équipes | Ce qu'en dit le programme |
|---|---|---|
| Salle 1 (4 équipes : 4, 4, 4, 5) | 02, 04, 06 puis 01 | « C'est la salle la plus chargée : elle tient sans marge, il ne faut pas laisser les passages déborder. » |
| Salle 2 (3 équipes : 5, 5, 5) | 03, 05 et 07 | « Elle garde une marge qui absorbe les dépassements et sert au calibrage final des notes. » |

Si le second évaluateur est absent, le programme prévoit un **format dégradé** : une seule salle, un seul évaluateur, et un budget réduit, de l'ordre de **20 minutes par équipe**. Le programme précise entre parenthèses : démonstration brève, « sous le capot » et conformité très courts, trois minutes de questions par étudiant. Le barème ne change pas, et l'enseignant vous signale que le format est dégradé. Ce que cela change pour l'oral et pour la note est au chapitre 3, section 11. Conséquence proposée par ce chapitre : sachez dire l'essentiel de chaque temps en très peu de mots.

### 2.5 Le public

Vous restez dans votre salle pendant les quatre passages : « Les étudiants restent dans la salle de leurs quatre équipes : ils forment le public et remplissent les fiches d'évaluation par les pairs. » Ces fiches portent sur **les membres de votre propre équipe** (chapitre 3, section 9) ; le programme les place à la fois pendant les passages et au bloc 6 : l'enseignant dit quand les remplir (chapitre 3, section 12). Ce que vous pouvez faire d'utile pendant les passages des autres est en section 11.3.

> **À retenir.** Deux salles, un ordre tiré au sort. Une dizaine de minutes en commun, quatre minutes de questions par étudiant, quatre minutes de transition : des ordres de grandeur, « à ajuster selon les équipes et les évaluateurs ».

---

## 3. La partie commune en trois temps

Le programme fixe le contenu de la partie commune, mot pour mot :

> *Programme, « Format de la soutenance ».* La partie commune comprend une démonstration en direct, un passage « sous le capot » (harnais, une décision sur les données, un moment de l'historique git, mesures temps estimé et réel) et un point de conformité (fiche, avis du RSSI, limites d'usage).

| Temps | Objectif de la séance qu'il sert | Où c'est préparé |
|---|---|---|
| 1. Démonstration en direct | Objectif 2 : « présente une démonstration en direct, chronométrée et robuste (avec plan de secours) » | Sections 4 et 5 |
| 2. « Sous le capot » | Objectif 3 : « explique les choix de son équipe (données, qualité, conformité) en s'appuyant sur l'historique git et la fiche » | Sections 6 et 7 |
| 3. Point de conformité | Objectifs 3 et 5 | Sections 8 et 9 |

Le critère **« Soutenance »** vaut **1 point** sur 20. La grille dit ce qu'on y regarde : **« Clarté, respect du temps, démonstration maîtrisée, plan de secours, compilation des mesures (temps estimé, réel, retouches) »**. Mais la soutenance sert aussi de **support** à d'autres critères collectifs :

| Critère (points) | Ce que la soutenance apporte, d'après la grille | Temps concerné |
|---|---|---|
| **Fonctionnalité** (3) | « Le produit fonctionne en démonstration live et couvre le socle obligatoire » ; support : « Démonstration, `PROJET.md`, résultat de `test/acceptance/` » | Démonstration |
| **Process git et équipe** (2) | « deux cas d'erreur d'agent documentés dans les PR (étiquette `erreur-agent`), contrôlés en soutenance » | « Sous le capot » |
| **Données et conformité** (3) | Support : « Dépôt, `docs/fiche_conformite.md`, soutenance » | Conformité |
| **Soutenance** (1) | Support : « Soutenance » | Les trois temps |

Les deux autres critères collectifs, « Harnais et tests » et « Qualité, sécurité et livraison », ont pour support le dépôt, la CI et les issues : les évaluateurs les lisent avant la séance. Le « sous le capot » vous donne l'occasion de les expliquer, pas de les établir. La grille entière est détaillée au chapitre 3, section 8. Un point à garder en tête : le clou niveau 1 est noté « sur la **réussite des cas d'acceptation publiés** dans l'énoncé du thème (cas verts sur cas totaux), pas sur l'appréciation ». Une belle démonstration ne remplace pas un cas rouge.

> **À retenir.** Le point « Soutenance » se gagne sur la tenue du passage ; les points de fonctionnalité et de conformité se gagnent sur ce que le passage **montre**.

---

## 4. La démonstration en direct

### 4.1 Un scénario choisi par l'équipe

Le programme parle d'« une démonstration en direct sur un scénario choisi par l'équipe ». Un **scénario de démonstration** est une suite d'actions faites à l'écran, dans un ordre et avec des données décidés à l'avance. L'énoncé de chaque thème propose un point fort, sous le titre « Effet « wow » pour la soutenance » (`cours/projets/themes.md`) :

| Thème | Ce que propose l'énoncé |
|---|---|
| **A** | L'équipe présente son comptoir en une minute, puis le jury « lit la lune » : il dicte un éclat de 1 à 20, la fiche du passeur change en direct. Le jury fait rejuger la même nuit et obtient le même résultat. |
| **B** (exemple suivi) | L'équipe importe le CSV de déclarations d'un quart de nuit chaotique, saisit ses arrêts, affiche le TRS et son Pareto, puis le jury modifie une durée d'arrêt : le TRS et la répartition des pertes changent aussitôt. |
| **C** | L'équipe répartit 80 étudiants en quelques secondes, puis le jury change le rang de deux étudiants : le résultat change et l'outil explique pourquoi chacun a obtenu son sujet. |

Ces propositions supposent un périmètre complet. Adaptez-les à ce que contient réellement `v1.0` : pour le thème B, le « livrable minimum viable » de l'énoncé se passe du Pareto si l'équipe est en retard. Ne montrez que ce qui est livré, et dites ce qui a été abandonné (chapitre 1, section 3) : l'objectif 1 demande de livrer « en assumant ce qui est laissé de côté ».

### 4.2 Ce que la démonstration doit montrer

Le critère « Fonctionnalité » regarde trois choses : le produit fonctionne en démonstration live, il couvre le **socle obligatoire** (programme, section 8), et « les user stories annoncées sont livrées ».

**Proposition, au-delà du programme** : un tableau pour vérifier que votre scénario touche chaque élément du socle qui se voit à l'écran. La colonne de droite est écrite pour le thème B.

| Élément du socle (programme) | Ce qui peut se voir en démonstration (proposition, thème B) |
|---|---|
| Un CRUD sur l'entité principale, avec des écrans | Créer un quart, le retrouver dans la liste, le corriger |
| Deux rôles, branchés sur la garde `RequireRole` | Passer du rôle `responsable` au rôle `operateur` et constater ce que le second ne peut pas faire |
| La règle « clou » niveau 1 | Saisir un cas publié de l'énoncé et lire le résultat attendu à l'écran |
| Un seed reproductible (données fictives) | Les données présentes à l'ouverture de l'application |
| Un import CSV, avec rejet motivé | Importer le fichier de démonstration ; montrer une ligne rejetée et son motif |
| Les mesures de conformité du thème | La consigne « aucun nom » affichée dans le formulaire des arrêts |

Pour le clou, prenez un **cas d'acceptation publié** : le jury a l'énoncé et peut comparer. Exemple, cas 2 du thème B : quart de 480 min ; pause 30 min ; panne 45 min et changement de série 15 min ; cycle 60 s ; 330 produites dont 33 rebutées. L'écran doit afficher D 86,7 % ; P 84,6 % ; Q 90,0 % ; TRS 66,0 % (l'énoncé écrit « OEE », le nom anglais du TRS).

Le reste du socle ne se montre pas dans l'application (migrations, tests d'intégrité, CI verte, `README` testé à froid) : ces preuves sont dans le dépôt. Le résultat de `test/acceptance/` fait partie du support du critère : la sortie de `flutter test test/acceptance` se lit comme au chapitre 1 de la séance 4, section 8 (pour le thème B, `+8: All tests passed!` quand les huit cas sont verts). Le programme ne dit pas si cette sortie se montre pendant le passage ; la montrer une fois, au moment du « sous le capot », est une proposition de ce chapitre.

### 4.3 Des données fictives, y compris ce que vous tapez

La règle d'or vaut pendant la soutenance : « Un projet qui met des données réelles dans le dépôt ou dans un prompt perd les points de conformité correspondants » (chapitre 3, section 10). Les données de la démonstration viennent du **seed** (fictif, à graine fixe) et du fichier CSV fictif de votre équipe. Application de la règle proposée par ce chapitre : ce que vous **saisissez devant le jury** est fictif aussi. Pour le thème B, ne tapez aucun nom dans un commentaire d'arrêt : c'est ce que votre consigne affichée interdit.

### 4.4 Où tourne la démonstration

Le programme ne dit pas sur quelle machine ni par quelle voie l'application est lancée. Vous connaissez deux voies depuis la séance 4 :

| Voie | Ce qu'il faut | Référence |
|---|---|---|
| La **version web publiée** sur GitHub Pages | Un navigateur et le réseau | Chapitre 2 de la séance 4, section 5.3 |
| L'application lancée sur un poste de l'équipe (`flutter run -d chrome`) | Un poste où le projet est installé et à jour | `README` de votre dépôt ; chapitre 2 de la séance 4, section 9 |

Trois faits comptent pour choisir, et pour préparer l'autre voie comme secours :

- **La base de données vit dans le navigateur.** Le `docs/ARCHITECTURE.md` du dépôt-modèle (section 7) l'écrit : « Chaque visiteur a sa propre base, vide au départ : c'est le rôle du seed. » Les données que vous voyez dans le navigateur de votre poste ne sont donc pas celles qu'affichera un autre poste, ni un autre navigateur. Essayez votre scénario **sur la machine et dans le navigateur du jour J**.
- **La version publiée peut avoir une dizaine de minutes de retard** après une fusion dans `main` (chapitre 2 de la séance 4, section 5.4). Si un correctif bloquant a été fusionné au bloc 2, la preuve de publication est le contrôle `publication` vert, pas l'écran.
- **Ce qui est évalué est `v1.0`** : le gel fige ce qui sera évalué (bloc 3). Sur un poste de l'équipe, après `git status` (branche `main`, copie de travail propre), vérifiez que vous êtes sur le commit tagué :

```bash
git describe --tags
```

```text
v1.0
```

Si elle répond autre chose (sur la copie, `v1.0-rc-2-g5d2e30f` : deux commits après `v1.0-rc`), le tag `v1.0` n'a pas encore été reçu sur ce poste : faites d'abord `git pull`, puis relancez la commande (rejoué : elle répond alors `v1.0`). Si elle ne répond toujours pas `v1.0`, reprenez le chapitre 1, section 9. **Proposition, au-delà du programme** : faire la démonstration par la voie que vous avez répétée, et garder l'autre prête. Aucune des deux n'a été essayée pour ce chapitre dans les conditions d'une salle.

> **Attention.** Rien ne change dans le dépôt après le gel : « À partir de là, on ne pousse plus. » Préparer la démonstration, c'est ouvrir des onglets et vérifier des données, pas corriger.

> **À retenir.** Un scénario décidé à l'avance, sur un cas publié de l'énoncé, avec des données fictives, joué sur `v1.0` et essayé sur la machine du jour J.

---

## 5. Le plan de secours

### 5.1 Ce que dit le programme

Mot pour mot (programme, section 7, « Format de la soutenance ») :

> **Démonstration en direct**, avec plan de secours (démonstration enregistrée et jeu de données de secours, à utiliser seulement en cas de panne). Une démonstration enregistrée sans plan B live est pénalisée.

Le programme y revient ailleurs : le bloc 4 fait vérifier « affichage, jeu de données de secours, plan B enregistré » ; le matériel prévoit une « machine de secours par salle ». Il emploie « plan B » en deux sens : « plan B enregistré » désigne la démonstration enregistrée, « plan B live » la capacité à montrer l'application en direct. (Le plan B de la séance 4 était autre chose : celui de la publication.) Deux conséquences :

- la démonstration enregistrée est un **secours**, pas la démonstration : elle ne sort qu'en cas de panne ;
- lecture de ce chapitre, la phrase du programme étant peu claire : arriver avec un enregistrement **seul**, sans pouvoir montrer l'application en direct, est pénalisé. Le programme ne chiffre pas cette pénalité, et ne dit pas comment le jury constate un plan de secours qui n'a pas servi, alors que le critère « Soutenance » le regarde.

### 5.2 Les trois pièces

| Pièce | Ce que c'est | Qui la fournit |
|---|---|---|
| **Démonstration enregistrée** | Une vidéo de votre scénario, jouée en entier, avec les données fictives | L'équipe |
| **Jeu de données de secours** | De quoi remettre l'application dans un état connu et rejouer le scénario | L'équipe |
| **Machine de secours** | Un poste disponible dans chaque salle | L'organisation de la séance |

**Le jeu de données de secours.** Le programme ne le définit pas davantage. **Proposition, au-delà du programme** : il se compose de ce que votre scénario consomme, c'est-à-dire le seed à graine fixe, qui redonne toujours le même état de départ, et le fichier CSV fictif que vous importez devant le jury. Vérifiez que vous savez **repartir de zéro** : une base vide, le seed, l'import, l'écran attendu. C'est ce parcours qui vous sauve si une manipulation abîme les données, ou si vous changez de machine. Rappel du chapitre 2 de la séance 4 (sections 6.3 et 11) : un fichier de données déclaré comme ressource de l'application part dans le build web public ; il doit être fictif.

**La démonstration enregistrée.** Le programme ne dit ni comment enregistrer, ni avec quel outil, et aucune méthode n'a été essayée pour ce chapitre. **Proposition, au-delà du programme**, sans outil désigné : enregistrez l'écran pendant la répétition ; n'y laissez voir que des données fictives et rien de personnel (messagerie, autres onglets, notifications) ; gardez le fichier hors du dépôt, à un endroit qui ne dépend pas du réseau ; vérifiez qu'il se lit sur le poste de démonstration. Si vous devez vous en servir, un membre le commente à voix haute.

**La machine de secours.** Elle est dans la salle ; le programme ne dit pas ce qui y est installé. Ce qui est sûr : la version publiée ne demande qu'un navigateur et le réseau, et la base d'un navigateur qui n'a jamais ouvert votre application est vide au départ (section 4.4). Votre parcours « repartir de zéro » y est donc le premier geste.

### 5.3 Quelle panne, quel relais

**Proposition, au-delà du programme** : décider à l'avance ce qui prend le relais, et **qui** prononce « on bascule ». Le programme ne dit pas si le chronomètre s'arrête pendant une panne ; conseil de ce chapitre : préparez-vous comme s'il continuait.

| Ce qui tombe en panne | Ce qui prend le relais |
|---|---|
| Les données sont abîmées en cours de démonstration | Le jeu de données de secours : repartir de l'état connu |
| La voie choisie ne répond plus (réseau, ou application locale) | L'autre voie de la section 4.4, préparée à l'avance |
| Le poste de l'équipe | La machine de secours de la salle, avec la version publiée et le jeu de données de secours |
| Plus rien ne permet de montrer l'application en direct | La démonstration enregistrée, commentée à voix haute |

> **À retenir.** En direct d'abord. L'enregistrement et le jeu de données de secours ne sortent qu'en cas de panne, et un enregistrement sans plan B live est pénalisé.

---

## 6. « Sous le capot »

« Sous le capot », c'est ce que l'écran de l'application ne montre pas : comment vous avez travaillé, et pourquoi l'outil est fait ainsi. Le programme en donne quatre éléments. Notez les mots : **une** décision, **un** moment. On ne fait pas le tour du dépôt, on choisit. Le quatrième élément, les mesures, demande un travail de compilation : il a sa section (section 7).

### 6.1 Le harnais

Le **harnais** est ce qui encadre l'agent : contexte, règles, tests, permissions (programme, philosophie pédagogique). Vous l'avez construit en séance 2 (chapitre 2 de la séance 2 : `CLAUDE.md` en section 4, permissions en section 5, hooks en section 7) et complété en séance 4 (les trois verrous de `test/acceptance/`, chapitre 1 de la séance 4, section 9). Ce qui se montre, sans lire de code :

| Pièce du harnais | La preuve observable |
|---|---|
| `CLAUDE.md` « utile et à jour » | Une règle ajoutée en cours de projet, et la PR qui l'a ajoutée (règle du jeu n° 9 : « Toute règle apprise y est ajoutée ») |
| Les permissions, dont `test/acceptance/**` protégé | Le refus de l'agent quand on lui demande d'écrire dans ce dossier (chapitre 1 de la séance 4, section 9.1) |
| Les tests | La dernière ligne de `flutter test`, et la pastille verte du dernier commit de `main` |
| Le test d'architecture de votre thème | Thème B : le test qui échoue si un `60` ou un `3600` apparaît dans `domain/` ailleurs que dans `unites.dart` (énoncé du thème) |

**Proposition, au-delà du programme** : montrez **une** règle du harnais qui a réellement arrêté quelque chose, de préférence celle qui est née d'un de vos cas `erreur-agent` (section 7.4).

### 6.2 Une décision sur les données

Vos décisions sont écrites à trois endroits du dépôt : la rubrique « Décisions de l'équipe » de `PROJET.md` (date, ce qui est décidé, qui a décidé, pourquoi), la rubrique « Décisions et apprentissages » de `JOURNAL.md`, et `docs/ARCHITECTURE.md`, pièce du dossier de rendu (« une page : composants, modèle de données, décisions » ; chapitre 1, section 4.4).

**Proposition, au-delà du programme** : présenter la décision en quatre points. Exemple pour le thème B, **rédigé pour ce chapitre** à partir de l'énoncé :

| Point | Ce que l'équipe dit |
|---|---|
| La décision | Aucun identifiant d'opérateur n'est stocké dans les données métier ; le TRS est agrégé par poste et par quart. |
| Ce qui a été écarté | Une colonne « opérateur » dans la table des déclarations, qui aurait permis un TRS par personne. |
| Pourquoi | La finalité exclut l'évaluation individuelle des salariés. |
| La preuve | La liste des tables et de leurs colonnes, sans colonne d'opérateur, lue dans le modèle de données de `docs/ARCHITECTURE.md` ; la rubrique 2 de la fiche ; la ligne datée de `PROJET.md`. |

Le modèle, les migrations et les tests d'intégrité sont au chapitre 4 de la séance 3 (sections 3, 5 et 6) ; leur place dans la fiche, au même chapitre, section 8. Une décision sur les données touche presque toujours la conformité : c'est un bon pont vers le troisième temps.

### 6.3 Un moment de l'historique git

Un « moment », c'est un endroit précis de l'historique qui raconte comment vous avez travaillé. Quelques moments possibles (liste proposée par ce chapitre), tous vus dans les séances précédentes :

| Moment | Ce qu'il montre | Référence |
|---|---|---|
| Un commit de test **avant** le commit de code | Le TDD est visible dans l'historique | Chapitre 2 de la séance 3, section 9.1 |
| Le test d'acceptation du clou commité rouge, puis rendu vert | Le test a précédé le code | Chapitre 1 de la séance 4, sections 7.4 et 8 |
| Un constat de l'audit croisé, son issue, la PR qui le corrige | L'audit a été traité | Chapitre 3 de la séance 4, section 9.3 |
| La PR « demande de validation RSSI » et la réponse écrite | La trace de la validation | Chapitre 4 de la séance 4, sections 9.3 et 10 |
| Une PR étiquetée `erreur-agent` | Une erreur repérée, et ce que vous en avez fait | Section 7.4 |

Le plus simple est de le montrer **sur GitHub** : la page de la PR, son onglet des commits, sa description. Deux commandes donnent la même chose dans un terminal ; elles ne font que lire. Les sorties viennent de la copie de vérification, dont l'historique ne compte que trois commits. D'abord l'historique récent, avec les fusions dessinées :

```bash
git log --oneline --graph -5
```

```text
*   5d2e30f Merge pull request #42 from equipe/correctif/titre-ecran
|\
| * 65cc4fd fix: corrige le titre de l'écran d'accueil
|/
* b53f271 Dépôt d'équipe créé depuis le modèle
```

La branche du correctif part de `main`, porte un commit, puis revient dans `main` par un commit de fusion : c'est le dessin d'une PR fusionnée. Ensuite, ce qu'un commit a changé, sans ouvrir aucun fichier :

```bash
git show --stat --format='%h %ad %s' --date=short 65cc4fd
```

```text
65cc4fd 2026-11-27 fix: corrige le titre de l'écran d'accueil

 README.md | 2 ++
 1 file changed, 2 insertions(+)
```

On lit l'identifiant du commit, sa date, son message, puis les fichiers touchés et le nombre de lignes. Pour l'histoire d'un seul fichier, `git log --oneline -- docs/fiche_conformite.md` liste les commits qui l'ont modifié (sur la copie, une seule ligne : `b53f271 Dépôt d'équipe créé depuis le modèle` ; sur votre dépôt, une ligne par étape de la fiche).

Choisissez votre moment **avant** la séance et notez le numéro de la PR : chercher dans l'historique devant le jury consomme votre dizaine de minutes.

> **À retenir.** Une règle du harnais qui a servi, une décision sur les données avec sa preuve, un moment de l'historique choisi à l'avance, et vos mesures.

---

## 7. Compiler les mesures

### 7.1 D'où viennent les mesures

Depuis la séance 2, chaque PR s'ouvre avec le modèle `.github/pull_request_template.md`. Sa rubrique « Suivi » compte trois lignes :

```text
## Suivi
- Temps estimé :
- Temps réel :
- Retouches (ce que j'ai dû corriger ou redemander) :
```

C'est ce que demande la première règle d'usage de l'IA du programme, **Transparence** (citée en entier au chapitre 3, section 7) : ce suivi « sert à apprendre, pas à punir ». La raison a été donnée en séance 1 : des développeurs expérimentés pensaient avoir gagné du temps avec l'IA, la mesure disait le contraire (chapitre 3 de la séance 1, section 3.2). D'où la conclusion du programme : « ne pas se fier à son impression de vitesse, **mesurer** ».

### 7.2 Relever les trois lignes, PR par PR

Le critère « Soutenance » regarde la « compilation des mesures (temps estimé, réel, retouches) ». Compiler, c'est rassembler en un seul tableau ce qui est éparpillé dans les PR.

*Où regarder.* Sur GitHub, l'onglet « Pull requests » de votre dépôt, en affichant les PR fermées ; puis la description de chaque PR fusionnée. Chacun peut aussi lister les PR fusionnées qu'il a ouvertes :

```bash
gh pr list --state merged --author "@me"
```

La commande répond une ligne par PR : numéro, titre, branche, état, date. Elle a été essayée en lecture seule sur le dépôt du cours, pas sur un dépôt d'équipe.

*Ce que vous notez.* Pour chaque PR : son numéro, le temps estimé, le temps réel, les retouches. Proposition de ce chapitre : chacun relève ses propres PR, un membre rassemble, et ce relevé se fait avant la séance, pas au bloc 4.

### 7.3 Le tableau, et ce qu'on en dit

Le programme ne fixe pas la forme de la compilation. **Proposition, au-delà du programme** : une ligne par PR, et un total. L'exemple ci-dessous reprend les deux PR **d'exemple** des séances 2 et 3 (chapitre 3 de la séance 2, section 9.2 ; chapitre 2 de la séance 3, section 9.3). Ces chiffres ont été rédigés pour les chapitres : ce ne sont pas des mesures.

| PR (exemple) | Temps estimé | Temps réel | Retouches |
|---|---|---|---|
| Stories retenues dans `PROJET.md` | 30 min | 45 min | 2 |
| Première user story, la disponibilité | 1 h 30 | 2 h | 2 |
| **Total** | **2 h** | **2 h 45** | **4** |

Sur ces deux lignes d'exemple, le temps réel dépasse l'estimation de 45 minutes, soit environ 38 %. Avec vos vraies PR, trois phrases suffisent devant le jury : le constat (« sur nos N PR mesurées, nous avions estimé tant, nous avons mis tant ») ; où est l'écart, et ce qui s'y est passé (c'est là que la ligne « Retouches » sert) ; ce que le chiffre ne dit pas (section 9).

Deux règles d'honnêteté, **proposées par ce chapitre** dans l'esprit du programme (« Honnêteté sur les preuves ») :

- **Une PR sans mesure reste sans mesure.** Dites combien de PR sont mesurées sur combien. Ne reconstituez rien après coup : un temps que personne n'a noté se dit « non mesuré ».
- **Un total n'est pas une preuve de vitesse.** Vous avez estimé vous-mêmes, sur un petit nombre de tâches : dites-le.

### 7.4 Les deux cas `erreur-agent`

Le critère « Process git et équipe » demande « **deux cas d'erreur d'agent documentés** dans les PR (étiquette `erreur-agent`), contrôlés en soutenance ». C'est la quatrième règle d'usage de l'IA, **Esprit critique** : « Au moins **deux cas** documentés où l'équipe a repéré une erreur de l'agent et ce qu'elle en a fait. »

*Les retrouver.* Sur GitHub, dans l'onglet « Pull requests », le filtre par étiquette, avec `erreur-agent`. Ou :

```bash
gh pr list --state all --label erreur-agent
```

Sur le dépôt du cours, qui n'a pas cette étiquette, la commande a répondu une liste vide, sans erreur. Sur votre dépôt, vous devez voir une ligne par PR étiquetée ; ce résultat n'a pas été observé pour ce chapitre.

*Les présenter.* Pour chaque cas, trois points (proposition de ce chapitre), que la PR contient déjà à la ligne « Proposé et refusé » de sa description :

| Point | Exemple pour le thème B (piège décrit par l'énoncé) |
|---|---|
| Ce que l'agent a fait | Il a divisé des secondes par des minutes sans convertir : la performance était 60 fois trop élevée, et le plafond à 100 % masquait l'erreur. |
| Comment vous l'avez repéré | Par une preuve : un cas d'acceptation rouge, une valeur affichée à 100 % partout, un test modifié dans la liste des fichiers de la PR. |
| Ce que vous en avez fait | Modification refusée, correction demandée, règle ajoutée à `CLAUDE.md`, test d'architecture ajouté. |

L'énoncé de chaque thème décrit un piège, avec la mention « À documenter comme cas d'erreur d'agent » : la lune en dur (A), les unités mélangées (B), les données réelles collées (C). Vos deux cas peuvent être ceux-là ou d'autres ; ce qui compte est qu'ils soient **arrivés**.

Le programme ne dit pas comment ces cas sont « contrôlés en soutenance ». Une chose est écrite : la question 2 de l'oral individuel « peut porter sur une règle du thème, un cas d'erreur d'agent, la fiche de conformité ou les droits d'une personne concernée ». Conseil de ce chapitre : que **chaque membre** sache raconter les deux cas, pas seulement celui qui les a vécus (chapitre 3, section 6).

> **Attention.** « Un usage caché ou des cas d'erreur inventés sont sanctionnés, un usage franc ne l'est jamais » (programme, repères pour la notation). Si vous n'avez qu'un cas documenté, présentez-en un. N'en fabriquez pas un second.

> **À retenir.** Les mesures se relèvent dans les PR, avant la séance. Deux cas `erreur-agent`, chacun avec ce que l'agent a fait, la preuve qui l'a révélé et ce que vous en avez fait.

---

## 8. Le point de conformité : la fiche, l'avis du RSSI, les limites d'usage

Le programme (section 10) annonce : en séance 5, la fiche est « présentée dans la partie conformité de la soutenance » et évaluée dans « Données et conformité ». Ce critère vaut 3 points, dont 2 pour la conformité. La definition of done exige une fiche « complète (13 rubriques) » qui contient « la **réponse du RSSI** datée (go, go sous conditions avec actions, ou no-go assumé avec les raisons) ».

### 8.1 La fiche

N'en lisez pas les treize rubriques. La grille dit ce qu'elle cherche ; chaque attente se montre par une rubrique ou par un écran (correspondance proposée par ce chapitre).

| Ce que regarde la grille (2 points conformité) | Ce que vous montrez |
|---|---|
| « fiche de conformité complète et honnête (13 rubriques) » | `docs/fiche_conformite.md` sur `main`, à l'état de `v1.0` |
| « le rôle AI Act (fournisseur ou déployeur) et la case de classement justifiés » | La rubrique 9, dont la justification commence par l'étape 0 : « est-ce un système d'IA ? » (chapitre 4 de la séance 4, section 6.2) |
| « mesures réellement présentes dans l'application (accès par rôle testé, mesures propres au thème, durée de conservation) » | Les tests de refus verts (ci-dessous) ; la mesure de votre thème à l'écran ; la rubrique 5 |
| « **réponse du RSSI datée** et suites données aux conditions » | La rubrique 13, et les PR qui lèvent chaque condition (section 8.2) |
| « limites d'usage écrites » | La rubrique 12 (section 8.3) |

**L'accès par rôle testé** se prouve par des tests de refus (chapitre 4 de la séance 4, section 7.2) :

```bash
flutter test --plain-name "refuse"
```

Sur la copie du dépôt-modèle, avec ses deux rôles de démonstration, la sortie est (chemins raccourcis) :

```text
00:00 +0: test/features/jets/domain/usecases/vider_historique_test.dart: refuse au joueur de vider l’historique, sans rien effacer
00:01 +1: test/core/domain/roles/require_role_test.dart: refuse l’accès à un joueur
00:01 +2: test/core/data/base_de_donnees_test.dart: la base refuse un jet de valeur 0
00:01 +3: All tests passed!
```

C'est la dernière ligne qui compte. Le filtre porte sur le **nom** des tests : la troisième ligne est un test d'intégrité de la base, pas un test de rôle. Sur votre dépôt, les titres portent les rôles de votre thème (`responsable` et `operateur` pour le thème B).

**Les mesures propres au thème** se voient dans l'application : la mention d'information et la suppression documentée (A), la consigne « aucun nom » dans le formulaire des arrêts (B), le statut `brouillon` ou `publie` et la vue « mon résultat » (C). Si votre démonstration les a déjà montrées, rappelez-le en une phrase.

### 8.2 L'avis du RSSI

La **rubrique 13** porte la réponse écrite du RSSI : date, décision, conditions (chapitre 4 de la séance 4, section 9.3). Cette réponse était attendue au plus tard une semaine avant la séance 5, soit le **vendredi 22 janvier 2027**. Ce que vous dites dépend de la décision :

| Décision écrite | Ce que vous présentez |
|---|---|
| **Go** | La date, et la portée : un « go » vaut « uniquement pour le périmètre pédagogique à données fictives » |
| **Go sous conditions** | Chaque condition, et pour chacune l'action faite : l'issue, la PR, la date (chapitre 4 de la séance 4, section 9.2) |
| **No-go** | Les raisons : la definition of done parle d'un « no-go assumé avec les raisons » |
| **Pas de réponse** | « Sans réponse, la décision est **no-go** par défaut » (module de conformité, section 6.2) ; l'équipe documente l'attente et ne présente pas le silence comme un accord |

Lecture de ce chapitre, à confirmer par l'enseignant : un no-go assumé n'est pas un échec de soutenance, puisque la grille note une fiche « complète et honnête » et des « suites données aux conditions », pas l'obtention d'un go. Le RSSI se désigne par son **rôle**, jamais par un nom, dans la fiche comme à l'oral. Le programme envisage que le RSSI de l'établissement soit l'un des seconds évaluateurs « pour la partie conformité » (à confirmer ; voir « Points non vérifiés »).

### 8.3 Les limites d'usage

La **rubrique 12** de la fiche a pour titre : *Risques résiduels et limites d'usage (« n'utilisez pas cet outil pour... »)*. Elle reprend et complète la rubrique « Ce que l'outil ne fera pas / limites » de votre `PROJET.md`. Pour le thème B, le `PROJET.md` fourni contient par exemple :

- « Le TRS est un indicateur d'aide à la décision, pas une sanction automatique. » ;
- « Une mise en usage réelle demanderait une nouvelle fiche de conformité, une nouvelle validation du RSSI et l'information-consultation du CSE. »

Dites vos limites telles qu'elles sont écrites. C'est la matière du regard critique (section 9).

> **Attention.** Ce cours est une **sensibilisation, pas un avis juridique**. On présente un classement **argumenté**, avec ses réserves ; on n'affirme pas une qualification juridique (chapitre 4 de la séance 4, section 7.4).

> **À retenir.** Trois objets : la fiche (rubriques 9, 12 et 13, et les mesures visibles dans l'application), la décision écrite du RSSI et ce que vous en avez fait, les limites d'usage dites telles qu'elles sont écrites.

---

## 9. Le regard critique

L'objectif 5 de la séance, mot pour mot : l'étudiant **« porte un regard critique sur son usage de l'IA et sur les limites de son outil (à ne pas utiliser pour...), chiffres à l'appui »**. Le programme ne lui réserve pas un quatrième temps : la partie commune en a trois. Lecture de ce chapitre : il peut passer **dans** les deux derniers, les mesures du « sous le capot » pour l'usage de l'IA, les limites d'usage du point de conformité pour l'outil. Il peut aussi venir dans les questions individuelles ou dans la plénière du bloc 7.

### 9.1 Sur votre usage de l'IA, chiffres à l'appui

Vos chiffres sont ceux de la section 7. Le programme vous met en garde contre l'excès qu'il nomme « Confiance excessive dans les chiffres » (« L'IA nous rend 10 fois plus rapides »), et lui oppose la « mesure de leur propre usage » (section 11). Appliquez à vos propres chiffres les trois questions de la séance 1 (chapitre 3 de la séance 1, sections 3.1 et 8) ; les réponses de la colonne de droite sont proposées par ce chapitre :

| Question | Appliquée à vos mesures |
|---|---|
| Qui a mesuré ? | Vous-mêmes, sur votre propre travail |
| Corrélation ou cause ? | Vous n'avez pas fait les mêmes tâches sans agent : vos chiffres ne disent pas si l'agent vous a fait gagner du temps |
| Quel contexte ? | Des non-développeurs, un projet neuf, un petit nombre de PR, un agent et des modèles d'une date donnée |

Vos mesures **peuvent** dire : l'écart entre ce que vous pensiez mettre et ce que vous avez mis, les tâches qui ont demandé le plus de retouches, les erreurs que votre harnais a arrêtées et celles qu'un humain a dû voir. Elles **ne peuvent pas** dire que l'IA accélère ou ralentit en général : « l'impression de vitesse n'est pas la vitesse ».

Si la question vous inquiète : un usage franc de l'IA n'est jamais sanctionné, et le plafonnement « ne sanctionne pas l'usage de l'IA » (programme, repères pour la notation ; chapitre 3, sections 7 et 10).

### 9.2 Sur les limites de votre outil

Trois sortes de limites, toutes déjà écrites quelque part :

- **Les limites d'usage** : la rubrique 12 de votre fiche (section 8.3).
- **Les limites de construction**, établies pour tous les projets. La garde `RequireRole` est testée, mais « une application web purement cliente reste contournable depuis le navigateur, donc elle ne protège aucune donnée réelle » (programme, séance 4, bloc 7 ; chapitre 3 de la séance 4, section 2.3). Tout ce qui est dans le build web est public. L'outil a une date de fin (rubrique 5).
- **Ce que l'équipe a laissé de côté** : la colonne « abandonné » de votre backlog (chapitre 1, section 3).

**Proposition, au-delà du programme** : trois débuts de phrase à compléter avec vos chiffres et votre fiche. « Nos mesures montrent que… » ; « Elles ne permettent pas de dire que… » ; « N'utilisez pas cet outil pour… ».

> **À retenir.** Un regard critique sans chiffre est une opinion. Donnez vos mesures, dites ce qu'elles ne prouvent pas, et nommez ce pour quoi l'outil ne doit pas servir.

---

## 10. Répéter

### 10.1 Avant la séance : une fois, en équipe, avec chronomètre

Le programme (section 5, sprint final), mot pour mot : **« Répétition de la démonstration avant S5 : une fois, en équipe, avec chronomètre. »** Elle entre dans la charge du sprint, sous le poste « fiche, documentation et répétition 3 à 5 h ». Après le gel des fonctionnalités (au plus tard une semaine avant la séance 5, soit le **vendredi 22 janvier 2027**), le programme ne laisse que trois activités : « correctifs, documentation, préparation de la démonstration ».

Ce que la répétition doit vous apprendre (liste proposée par ce chapitre) :

- **si la partie commune tient en une dizaine de minutes.** Notez la durée de chacun des trois temps : ce sont **vos** mesures, pas une norme. Si vous dépassez, retirez du contenu ; parler plus vite ne règle rien ;
- **si le scénario passe du début à la fin**, sur la machine et par la voie prévues (section 4.4) ;
- **si vous savez repartir de zéro** avec le jeu de données de secours (section 5.2) ;
- **qui parle, et qui tient le clavier** (section 10.3).

**Proposition, au-delà du programme** : répétez sur l'état que vous allez taguer `v1.0-rc` (l'avant-veille de la séance 5 à 18h, soit le **mercredi 27 janvier 2027 à 18h**). Un bug découvert avant le tag se corrige encore par une PR ordinaire ; en séance, il ne reste que les correctifs bloquants du bloc 2 (chapitre 1, section 8). Entre `v1.0-rc` et le début de la séance, le programme ne dit pas ce qui est permis ; proposition des supports : appliquer déjà la règle du bloc 2 (chapitre 1, section 2).

### 10.2 En séance : la répétition technique (bloc 4)

Le bloc 4, mot pour mot : « Répétition technique par les équipes, chacune vérifiant sa démonstration dans sa salle (affichage, jeu de données de secours, plan B enregistré). » Son intention : « Éviter la panne technique le jour J ». Il vient **après** le gel (bloc 3) : ce que vous vérifiez est `v1.0`. Pendant ce temps, les évaluateurs se calibrent entre eux.

Ce bloc est **Important**, pas Indispensable, pour les équipes : « la répétition peut se faire en équipe avant la séance si besoin », et, si la séance prend du retard, elle est « faite en équipe avant la séance ou pendant le passage de l'équipe précédente ». Ne comptez donc pas sur lui pour répéter votre parole : il sert à vérifier la technique. La colonne de droite est une **proposition** de ce chapitre :

| Vérification du programme | Ce que vous constatez |
|---|---|
| **Affichage** | Votre poste s'affiche sur le vidéoprojecteur ; le texte se lit du fond de la salle ; l'application, à l'état `v1.0`, s'ouvre par la voie prévue |
| **Jeu de données de secours** | Le parcours « repartir de zéro » fonctionne sur le poste de démonstration ; le fichier CSV fictif est à portée de main |
| **Plan B enregistré** | L'enregistrement se lit sur le poste de démonstration, sans dépendre du réseau |

Ajoutez, comme pour le passage devant le RSSI (chapitre 4 de la séance 4, section 7.2), les **onglets ouverts à l'avance** : l'application, la PR de votre « moment », le tableau des mesures, les PR `erreur-agent`, la fiche de conformité.

### 10.3 Qui parle

Le programme ne fixe pas qui parle pendant la partie commune. Il fixe deux choses : chaque étudiant répond ensuite à **deux questions individuelles**, et chacun doit pouvoir expliquer toute PR qu'il a ouverte ou approuvée. Personne ne peut donc se cacher derrière celui qui présente.

Le rôle de **gardien de la démonstration** n'existe que dans les équipes de 5 : il tient le « README testé à froid » et le « jeu de données de soutenance » (programme, rôles d'équipe ; l'énoncé de chaque thème y ajoute le scénario du « wow »). Dans une équipe de 3 ou de 4, ce rôle est cumulé avec un autre, et le programme ne dit pas lequel : c'est à votre équipe de le décider, et de l'écrire.

**Une répartition possible, proposée par ce chapitre**, sur le modèle de celle du passage devant le RSSI (chapitre 4 de la séance 4, section 7.3) :

| Temps | Qui peut le porter |
|---|---|
| Démonstration | Le gardien de la démonstration (équipe de 5), ou le membre que l'équipe désigne ; un second membre tient le clavier |
| Le harnais, l'historique, les mesures | Le gardien du harnais et de la CI |
| La décision sur les données | Le gardien des données |
| Le point de conformité | Le gardien conformité, ou le gardien produit et conformité dans une équipe de 3 |

Prévoyez un **remplaçant** pour chaque temps. Le programme est clair sur l'absence : « l'équipe passe normalement » ; l'absent est interrogé plus tard (chapitre 3, section 11).

> **À retenir.** Une répétition chronométrée avant la séance, pour le contenu et la durée ; une répétition technique dans la salle, pour l'affichage, les données de secours et l'enregistrement. Chaque temps a un porteur et un remplaçant.

---

## 11. Le passage, en séance (bloc 5)

### 11.1 Le déroulement d'un passage

Le bloc 5, mot pour mot :

> *Programme, séance 5, bloc 5.* Passage de chaque équipe selon le format ci-dessus : démonstration en direct, « sous le capot », conformité, puis questions individuelles. Une pause entre deux séries de passages, au moment le moins gênant.

Ce bloc est **Indispensable** : les soutenances « avec leurs deux questions individuelles » ne se sacrifient jamais.

| Moment du passage | Ce qui se passe | Ordre de grandeur (programme) |
|---|---|---|
| Partie commune | Démonstration en direct, « sous le capot », conformité | Une dizaine de minutes |
| Questions individuelles | Deux questions à chaque étudiant, la même trame pour tous (chapitre 3, section 2) | Quatre minutes par étudiant |
| Transition | L'équipe suivante prend la place | Quatre minutes |

Le chronomètre est visible, et l'observateur « chronomètre et note les écarts ». Le « respect du temps » est dans le critère « Soutenance ». Le programme ne dit pas qui conduit le passage ; ses chiffres sont « à ajuster selon les équipes et les évaluateurs ». Conseils de ce chapitre : si l'on vous demande d'abréger, passez au temps suivant sans négocier ; et en cas de panne, appliquez ce que vous avez décidé (section 5.3) en le disant simplement (« nous basculons sur la machine de secours »).

### 11.2 Les transitions

La formule compte « une transition de quatre minutes » par équipe ; le programme n'en décrit pas le contenu. **Proposition, au-delà du programme** : l'équipe qui sort libère le vidéoprojecteur dès la dernière question ; l'équipe qui entre a déjà son poste allumé et ses onglets prêts. Une transition qui déborde retarde la salle, et le programme dit ce qui cède alors : « Si les passages d'une salle prennent du retard, on raccourcit la plénière avant de toucher à un passage. »

### 11.3 Pendant que les autres passent

Vous êtes le public des trois autres équipes de votre salle. Quelques repères :

- **Vous ne touchez plus à votre dépôt.** Le gel est passé.
- **Vous n'évaluez pas les autres équipes.** Les fiches d'évaluation par les pairs portent sur les membres de votre équipe ; le programme les place à la fois pendant les passages et au bloc 6 : l'enseignant dit quand les remplir (chapitre 3, section 12).
- **Vous pouvez apprendre.** **Proposition, au-delà du programme**, sur le modèle de l'observation des passages devant le RSSI (chapitre 4 de la séance 4, section 8.3) : regardez ce que chaque équipe **montre** et ce qu'elle se contente de **dire**, et comment elle présente un chiffre et sa limite. Ce sont des matériaux pour le retour d'expérience collectif du bloc 7 (« Ce qui a marché, ce qui a échoué, ce que je ferais autrement »).

> **À retenir.** Trois temps en commun, puis deux questions à chacun, puis quatre minutes pour laisser la place. Le temps est compté et observé.

---

## 12. Avez-vous fini ?

La part de ce chapitre dans le livrable et la definition of done de la séance 5 (texte du programme en gras) :

- [ ] **Soutenance passée** (livrable de fin de séance : « Tag `v1.0`, dossier de rendu à jour (section 7) et soutenance passée »).
- [ ] **`v1.0` est taguée avant le premier passage le jour de S5** : la démonstration a montré cet état.
- [ ] **La version web publiée sur GitHub Pages est accessible.**
- [ ] **La fiche de conformité est complète (13 rubriques) et contient la réponse du RSSI datée (go, go sous conditions avec actions, ou no-go assumé avec les raisons).**
- [ ] **`JOURNAL.md` est à jour et les PR portent leur section « ce que l'agent a proposé, ce que j'ai refusé » et leurs temps.**

Et ce que regarde le critère « Soutenance » (grille, 1 point), élément par élément ; la déclinaison après les deux-points est proposée par ce chapitre :

- [ ] **Clarté** : chaque temps a un porteur, un remplaçant et une preuve à montrer.
- [ ] **Respect du temps** : la partie commune a été chronométrée en répétition (« une fois, en équipe, avec chronomètre ») et tient en une dizaine de minutes.
- [ ] **Démonstration maîtrisée** : le scénario a été joué en entier sur la machine et par la voie du jour J, avec des données fictives.
- [ ] **Plan de secours** : la démonstration enregistrée et le jeu de données de secours existent et ont été essayés ; ils ne servent qu'en cas de panne.
- [ ] **Compilation des mesures (temps estimé, réel, retouches)** : le tableau est prêt, et dit combien de PR sont mesurées.
- [ ] Les **deux cas `erreur-agent`** sont retrouvés, et chaque membre sait les raconter.

La ligne de la definition of done sur les deux questions individuelles est au chapitre 3, section 13.

---

## Glossaire

- **Budget indicatif** : ordre de grandeur du temps prévu par équipe pour dimensionner les salles et le jury ; ce n'est pas un minutage.
- **Compilation des mesures** : rassemblement, en un seul tableau, des temps estimés, des temps réels et des retouches notés dans les PR.
- **Démonstration enregistrée** : vidéo du scénario de démonstration, préparée à l'avance et utilisée seulement en cas de panne ; le programme l'appelle aussi « plan B enregistré ».
- **Étiquette `erreur-agent`** : étiquette GitHub posée sur une PR où l'équipe a repéré une erreur de l'agent ; elle sert à retrouver ces cas (chapitre 3 de la séance 2, section 9.3).
- **Format dégradé** : soutenance à une seule salle et un seul évaluateur, à budget réduit, quand le second évaluateur est absent.
- **Jeu de données de secours** : de quoi remettre l'application dans un état connu et rejouer le scénario de démonstration.
- **Machine de secours** : poste disponible dans chaque salle pour remplacer un poste en panne.
- **Observateur** : personne qui, à côté de l'évaluateur, chronomètre le passage et note les écarts.
- **Partie commune** : ce que l'équipe présente ensemble avant les questions individuelles : démonstration, « sous le capot », conformité.
- **Plan B de publication (séance 4)** : build web local et démonstration avec `flutter run -d chrome` quand GitHub Pages ou Actions posent problème ; à ne pas confondre avec l'entrée suivante.
- **Plan de secours de la démonstration** : ce qui prend le relais de la démonstration en direct en cas de panne : la démonstration enregistrée et le jeu de données de secours.
- **Répétition technique** : vérification, dans la salle, de l'affichage, du jeu de données de secours et de l'enregistrement (bloc 4).
- **Rubrique 13** : dernière rubrique de la fiche de conformité, qui reçoit la réponse écrite et datée du RSSI (chapitre 4 de la séance 4, section 9.3).
- **Scénario de démonstration** : suite d'actions faites à l'écran, dans un ordre et avec des données décidés à l'avance.
- **« Sous le capot »** : deuxième temps de la partie commune : le harnais, une décision sur les données, un moment de l'historique git, les mesures.

Les autres termes (harnais, seed, clou, cas d'acceptation, go sous conditions…) sont définis dans les glossaires des séances 1 à 4.

---

## Pour aller plus loin

- Chapitre 1 de cette séance : section 3 (ce que l'équipe laisse de côté), section 4 (le dossier de rendu), sections 8 et 9 (retouches bloquantes, gel et tag `v1.0`).
- Chapitre 3 de cette séance : sections 2 et 6 (les deux questions), section 8 (la grille critère par critère), sections 9 et 12 (l'évaluation par les pairs), section 11 (l'étudiant absent, le format dégradé).
- Chapitre 4 de cette séance : fiche Y (répétition et soutenance d'équipe).
- Séance 1, chapitre 3, sections 3.1, 3.2 et 8. Séance 2, chapitre 3, sections 9.2 et 9.3. Séance 3, chapitre 2, sections 8 et 9, et chapitre 4.
- Séance 4 : chapitre 1, sections 8 et 9 ; chapitre 2, sections 5.3, 5.4 et 9 ; chapitre 4, sections 7 à 10.
- L'énoncé de votre thème dans `cours/projets/themes.md` : « Livrable minimum viable » et « Effet « wow » pour la soutenance ».

---

## Points non vérifiés (à signaler honnêtement)

- **Aucune soutenance n'a été jouée.** Tout le déroulement (ordre des temps, durée de la partie commune, transitions) est décrit d'après le programme. Rien n'a été chronométré.
- **Organisation « à confirmer ».** Le second évaluateur ou observateur de chaque salle, la présence du RSSI de l'établissement, et donc le choix entre deux salles et le format dégradé, sont marqués « à confirmer » dans le programme. L'affectation aux salles de la variante à 7 équipes est « indicative ».
- **Commandes.** Les commandes `git` des sections 4.4 (dont le cas du tag non reçu, puis `git pull`) et 6.3 et `flutter test --plain-name "refuse"` ont été exécutées sur une copie du dépôt-modèle (trois commits, rôles de démonstration `meneur` et `joueur`), pas sur un dépôt d'équipe. Les deux commandes `gh pr list` ont été essayées en lecture seule sur le dépôt du cours : la liste par étiquette `erreur-agent` y est vide, et son résultat sur un dépôt d'équipe n'a pas été observé. `flutter test test/acceptance` n'a pas été rejoué : sa sortie est celle du chapitre 1 de la séance 4. `flutter run -d chrome` n'a pas été rejoué pour cette séance. Vérifications sous Linux seulement.
- **Écrans GitHub.** L'onglet « Pull requests », l'affichage des PR fermées et le filtre par étiquette sont décrits de façon générale, sans avoir été observés sur un dépôt d'équipe.
- **Où tourne la démonstration.** Le programme ne le fixe pas. Ni la version publiée ni l'application locale n'ont été essayées dans une salle, sur un vidéoprojecteur ou sans réseau. Ce qui est installé sur la machine de secours n'est décrit par aucun document. La phrase sur la base « vide au départ » vient du `docs/ARCHITECTURE.md` du dépôt-modèle ; la façon dont le seed de votre application se charge dépend de votre équipe.
- **Enregistrement de la démonstration.** Le programme ne donne ni méthode ni outil ; aucun n'a été essayé, et ce chapitre n'en désigne aucun.
- **Points que le programme ne précise pas** (signalés à l'enseignant, non tranchés ici) : la répartition de la dizaine de minutes entre les trois temps ; le budget d'une équipe de 3 ; l'ampleur de la pénalité pour une démonstration enregistrée sans plan B live ; la façon dont le jury constate un plan de secours qui n'a pas servi ; la façon dont les deux cas `erreur-agent` sont « contrôlés en soutenance » ; si le chronomètre s'arrête en cas de panne ; le contenu d'une transition ; qui conduit le passage et qui parle pendant la partie commune ; qui cumule le rôle de gardien de la démonstration dans une équipe de 3 ou de 4 ; ce qui est permis entre `v1.0-rc` et le début de la séance.
- **Deux formulations du programme à rapprocher.** La partie commune cite les « mesures temps estimé et réel », la grille la « compilation des mesures (temps estimé, réel, retouches) » : ce chapitre suit la grille et compile les trois. Le programme place le remplissage des fiches d'évaluation par les pairs à la fois pendant les passages (le public les « rempli[t] ») et au bloc 6, et ces fiches portent, d'après sa section 7, sur les membres de sa propre équipe : ce chapitre ne tranche pas le moment.
- **Format dégradé, le calcul.** « 20 minutes par équipe » avec « trois minutes de questions par étudiant » laisse 8 minutes pour la partie commune et la transition d'une équipe de 4, et 5 minutes pour une équipe de 5. Le programme ne le commente pas.
- **Variante à 7 équipes et tirage au sort.** « 02, 04, 06 puis 01 » place l'équipe 01 en dernier, alors que l'ordre de passage est « tiré au sort à l'avance ».
- **Second évaluateur ou observateur.** Si le second est un évaluateur, le programme ne dit pas qui chronomètre, ni comment deux notes d'oral se combinent.
- **« Une démonstration enregistrée sans plan B live est pénalisée ».** La formule est peu claire, puisque le plan B enregistré est justement l'enregistrement ; la lecture de la section 5.1 est celle de ce chapitre.
- **Le RSSI en soutenance.** Le format de la soutenance envisage « le RSSI de l'établissement pour la partie conformité » parmi les seconds évaluateurs ; la section 10 du programme dit le RSSI « simulé par l'enseignant », « et non tenu par le RSSI de l'établissement ».
- **Textes proposés, à valider par l'enseignant** : les conseils de préparation des sections 2.2 et 2.4 ; le tableau « socle et écran », le choix d'un cas d'acceptation publié et l'affichage de la sortie de `flutter test test/acceptance` (section 4.2) ; ne saisir que du fictif devant le jury (section 4.3) ; le choix de la voie de démonstration (section 4.4) ; la lecture de la phrase sur le « plan B live » (section 5.1) ; la composition du jeu de données de secours, les conseils d'enregistrement, le tableau « quelle panne, quel relais » et le conseil de se préparer comme si le chronomètre continuait (sections 5.2 et 5.3) ; montrer une règle du harnais qui a servi (section 6.1) ; la présentation d'une décision en quatre points et l'exemple du thème B (section 6.2) ; la liste des « moments » possibles (section 6.3) ; qui relève les mesures (section 7.2) ; la forme du tableau de compilation, les trois phrases et les deux règles d'honnêteté (section 7.3) ; les trois points de présentation d'un cas `erreur-agent`, et le conseil que chaque membre sache raconter les deux cas (section 7.4) ; les tableaux de présentation de la fiche et de l'avis du RSSI, et la lecture « un no-go assumé n'est pas un échec de soutenance » (sections 8.1 et 8.2) ; la lecture selon laquelle le regard critique passe dans les deux derniers temps (section 9) ; l'application des trois questions à vos mesures et les trois débuts de phrase (sections 9.1 et 9.2) ; ce que la répétition doit apprendre, répéter sur l'état à taguer `v1.0-rc`, et appliquer déjà la règle du bloc 2 entre `v1.0-rc` et la séance (section 10.1 ; chapitre 1, section 2) ; le détail des trois vérifications du bloc 4 et les onglets ouverts (section 10.2) ; la répartition de la parole et le remplaçant (section 10.3) ; la conduite à tenir quand on vous demande d'abréger ou en cas de panne, la conduite d'une transition et l'observation des autres passages (section 11) ; la déclinaison du critère « Soutenance » en cases à cocher (section 12).
- **Chiffres d'exemple.** Le tableau de la section 7.3 reprend les deux PR d'exemple des séances 2 et 3, rédigées pour ces chapitres : ses temps et son écart d'environ 38 % ne sont pas des mesures.
- **Dates.** Le vendredi 22 janvier 2027 et le mercredi 27 janvier 2027 à 18h sont déduits de la date de la séance 5 (vendredi 29 janvier 2027 après-midi) ; le programme, qui écrit « au plus tard une semaine avant S5 » et « l'avant-veille de S5 à 18h », fait foi.

---

## Sources

Documents du cours :

- `cours/programme-detaille.md` : philosophie pédagogique (« Humans steer, agents execute », « Honnêteté sur les preuves ») ; rôles d'équipe ; séance 5 (objectifs, matériel et prérequis, « Format de la soutenance (contrainte de logistique) », blocs 1 à 7, ordre de coupe, « Ne se sacrifient jamais », livrable, definition of done) ; section 5 (sprint final : charge, calendrier, répétition) ; section 7 (grille sur 20, repères pour la notation, format de la soutenance, dossier de rendu, règles d'usage de l'IA) ; section 8 (socle commun, règles du jeu) ; section 10 (conformité, ligne de la séance 5) ; section 11 (risques « Panne le jour de la soutenance » et « Confiance excessive dans les chiffres ») ; séance 4, bloc 7.
- `cours/projets/themes.md` : rôles dans l'équipe, cas d'acceptation du thème B (cas 2), pièges d'agent, mesures de conformité, « Livrable minimum viable » et « Effet « wow » pour la soutenance » des thèmes A, B et C.
- `cours/conformite-ai-act-rgpd.md` : sections 6.1 (gabarit, rubriques 12 et 13) et 6.2 (no-go par défaut, portée d'un « go »).
- Supports de la séance 1 : chapitre 3, sections 3.1, 3.2 et 8. Séance 2 : chapitre 2, sections 4, 5 et 7 ; chapitre 3, sections 9.2 et 9.3. Séance 3 : chapitre 1, section 4.4 ; chapitre 2, sections 8, 9.1 et 9.3 ; chapitre 4, sections 3, 5, 6 et 8. Séance 4 : chapitre 1, sections 7.4, 8 et 9 ; chapitre 2, sections 5.3, 5.4, 6.3, 9 et 11 ; chapitre 3, sections 2.3 et 9.3 ; chapitre 4, sections 6.2 et 7 à 10.

Dépôt-modèle (`depot-modele/`, relu le 27 novembre 2026) : `.github/pull_request_template.md` (rubrique « Suivi ») ; `docs/fiche_conformite.md` ; `docs/ARCHITECTURE.md` (section 7, la base sur le web) ; `themes/PROJET-B.md` (« Ce que l'outil ne fera pas / limites », « Décisions de l'équipe ») ; `JOURNAL.md` ; `README.md` (« Démarrer »).

Vérifications locales (27 novembre 2026, Linux, git 2.53.0, Flutter 3.50.1, Dart 3.14.0), sur une copie du dépôt-modèle placée hors du dépôt du cours, clonée depuis un dépôt distant local : `git status`, `git describe --tags` (`v1.0` ; et, tag `v1.0` retiré du seul clone d'essai, `v1.0-rc-2-g5d2e30f`, puis `v1.0` après `git pull`) ; `git log --oneline --graph -5`, `git log --oneline -- docs/fiche_conformite.md`, `git show --stat --format='%h %ad %s' --date=short 65cc4fd` ; `flutter pub get`, `dart run build_runner build --delete-conflicting-outputs` (83 sorties), puis `flutter test --plain-name "refuse"` (`+3: All tests passed!`).

Essais en lecture seule sur le dépôt du cours (27 novembre 2026, gh 2.100.0) : `gh pr list --state merged --author "@me"` ; `gh pr list --state all --label erreur-agent` (liste vide).
