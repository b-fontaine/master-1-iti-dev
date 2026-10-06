# Chapitre 1 · Histoire détaillée du craft (software craftsmanship)

*Master ITI, Nantes Université, 2026-2027 · Ingénierie logicielle à l'ère de l'IA agentique · Séance 1, « Comprendre et s'équiper » · Version du 6 octobre 2026*

## Ce que vous allez retenir

- Le problème du logiciel n'est pas d'écrire du code, c'est de le **faire évoluer** sans le casser. On le constate dès 1968, à la conférence de Garmisch, et encore en 1995 avec l'aéroport de Denver.
- Fred Brooks (1975, 1986) distingue la complexité **accidentelle** (l'outillage, la syntaxe) et la complexité **essentielle** (comprendre le besoin, décider). Un outil peut réduire la première, jamais la seconde.
- La **dette technique** (Ward Cunningham, 1992) est une métaphore : un raccourci pris aujourd'hui se paie plus tard, avec des intérêts. À l'origine, elle ne désigne pas du « mauvais code » assumé.
- Entre 1996 et 2006, une famille de pratiques naît : **XP et TDD** (tests d'abord, petits pas), **Agile** (le Manifeste de 2001), **DDD** (le code parle la langue du métier) et **BDD** (décrire le comportement par des exemples).
- Le **manifeste du craft** (2008-2009) répond à un constat : l'agilité s'est diffusée sans les pratiques techniques qui la rendent possible. Il ajoute « pas seulement… mais aussi ».
- **Git** (2005), la **livraison continue** (2010) et les travaux **DORA** (*Accelerate*, 2018) ont transformé ces pratiques en système mesurable : on peut livrer souvent, vite et de façon fiable.
- Le craft, c'est une **posture**, des **pratiques** et une **conception** dont l'objectif commun est de pouvoir changer le logiciel demain sans avoir peur. Ce n'est ni un dogme ni un club : le mouvement a été critiqué, et ces critiques font partie de l'histoire.
- C'est le socle de tout le cours : un agent de code accélère l'écriture, donc il rend ces garde-fous **plus** nécessaires, pas moins.

> **Comment lire ce chapitre.** Chaque jalon suit le même plan : le problème de l'époque, qui et quand, l'idée, ce qu'elle apporte encore, ses limites. Les références entre crochets, par exemple [S3], renvoient à la section « Sources » en fin de chapitre. Trois niveaux d'affirmation sont distingués : un **fait** (daté, sourcé), un **consensus de praticiens** (largement partagé, mais pas démontré scientifiquement) et une **opinion** (la mienne ou celle d'un auteur nommé). Quand un point n'a pas pu être vérifié, il est marqué « non vérifié ».

## 0. Pourquoi une histoire, pour des non-développeurs ?

Vous ne deviendrez pas développeurs. Vous allez pourtant **commander** du logiciel à une équipe, ou, dans ce cours, à un agent d'intelligence artificielle. Pour juger ce qu'on vous livre, il faut connaître les problèmes que des générations d'ingénieurs ont rencontrés, car un agent de code les rencontre à son tour, et plus vite.

Le fil rouge de la séance tient en une phrase : à chaque époque, la vitesse de production augmente, et à chaque époque on redécouvre que la qualité décide de ce que l'on peut encore changer demain.

Un mot de vocabulaire avant de commencer. Un **logiciel** est un ensemble d'instructions écrites dans un langage de programmation. Ces instructions, le **code source**, sont stockées dans un **dépôt** (en anglais *repository*), une sorte de dossier partagé qui garde la trace de toutes les modifications. Nous définirons les autres termes au fil du texte, et vous les retrouverez dans le glossaire final.

## 1. Accroche : Denver, 1995

**Le problème.** L'aéroport international de Denver (Colorado, États-Unis) devait ouvrir en octobre 1993. Il n'a ouvert que le 28 février 1995, soit environ seize mois plus tard. Une des causes les plus citées est un système automatisé de tri des bagages : un gros logiciel couplé à du matériel (rails, chariots, scanners).

**Les faits.**

- Le rapport du Government Accountability Office (GAO, l'organisme d'audit du Congrès américain) daté du 14 octobre 1994 écrit que l'ouverture était « originellement prévue en octobre 1993 » et que les problèmes du système de bagages avaient causé « plusieurs reports ». [S1]
- Ce même rapport décrit un système qui avait « de sérieux problèmes mécaniques et logiciels » : lors des tests, des bagages étaient mal chargés, mal aiguillés ou tombaient des chariots, provoquant des blocages. Le contrat de conception et de construction confié à l'entreprise BAE Automated Systems s'élevait à 193 millions de dollars. [S1]
- Le coût du retard : un déficit mensuel de 18 à 19 millions de dollars, et environ 360 millions de dollars au total si l'ouverture avait lieu fin février 1995. Attention, ce sont des **estimations** faites avant l'ouverture. [S1]
- Pour pouvoir ouvrir, l'aéroport a fait installer en parallèle un système conventionnel (tapis, tracteurs, remorques) estimé à environ 51 millions de dollars. [S1]
- L'ouverture a bien eu lieu le 28 février 1995. Le système automatisé, lui, a été abandonné en septembre 2005, d'après Wikipédia (source secondaire). [S2]

**Ce que cela illustre.** Ce n'est ni 1968 ni les années 2020 : le problème est constant. Un projet logiciel ambitieux, découvert tard, testé tard, accumulant les reports. Le chiffre « 16 mois » est un calcul simple entre octobre 1993 et février 1995, cohérent avec les sources publiques.

**Limites de l'exemple.** Denver n'est pas qu'un échec de logiciel : c'est un projet de génie civil, politique et industriel où beaucoup de facteurs jouent (grève, désaccords avec les compagnies aériennes, changements de périmètre). Les sources consultées pointent le logiciel de bagages comme cause majeure du retard final, pas comme cause unique. L'analyse détaillée de l'échec n'a pas été vérifiée ici : on s'en sert comme **accroche**, non comme démonstration.

> **À retenir.** Un retard, un dépassement de coût et une fiabilité insuffisante sont les trois symptômes classiques d'un projet logiciel qui échappe à ses concepteurs. Ils sont toujours mesurés aujourd'hui.

## 2. Jalon 1 · 1968, la « crise du logiciel » et le génie logiciel

**Le problème de l'époque.** Dans les années 1960, les ordinateurs deviennent assez puissants pour que l'on écrive de très gros programmes (systèmes d'exploitation, systèmes de réservation, contrôle aérien). Or ces programmes arrivent en retard, coûtent plus cher que prévu et tombent en panne.

**Qui, quand.** Du 7 au 11 octobre 1968, à Garmisch (Allemagne), le Comité scientifique de l'OTAN réunit plus de cinquante personnes (constructeurs, universités, sociétés de services, utilisateurs). Le rapport est édité par Peter Naur et Brian Randell, sous la présidence de F. L. Bauer. [S3]

**L'idée.** Le rapport explique que l'expression « software engineering » (génie logiciel) a été « délibérément choisie comme provocante » : elle sous-entend que la fabrication du logiciel doit reposer sur les fondations théoriques et les disciplines pratiques des branches établies de l'ingénierie. [S3] Le mot « crise » est employé avec prudence : le rapport signale un débat sur ce que « certains membres ont choisi d'appeler » la « crise du logiciel » ou le « fossé du logiciel », et les participants avaient des vues très différentes sur sa gravité. [S3] Une des contributions du rapport décrit un « fossé grandissant entre les ambitions et les réalisations » (promesses faites aux utilisateurs, performances atteintes, estimations de coût et dépenses réelles). [S3]

**Ce que cela apporte encore.** Trois symptômes, retard, coût, fiabilité, restent la grille de lecture d'un projet. Les indicateurs DORA, que nous verrons au jalon 9, les mesurent aujourd'hui de façon beaucoup plus fine. L'idée à retenir est que la difficulté n'est pas d'écrire du code, mais de le faire évoluer.

**Limites et critiques.**

- Le terme de « crise » est contesté dès 1968, par les participants eux-mêmes [S3]. Une crise qui dure plus d'un demi-siècle est, en fait, un état normal de la discipline : opinion fréquente chez les praticiens, non sourcée ici.
- L'analogie avec l'ingénierie traditionnelle (pont, avion) a ses limites : un pont ne se modifie pas chaque semaine. Une partie du craft, plus loin dans ce chapitre, consiste précisément à proposer un autre modèle que celui de l'usine.
- La diapositive montre une capture de la page Wikipédia du *CHAOS Report* (Standish Group, 1994) en simple décor. Nous ne citons aucun de ses chiffres, que nous n'avons pas vérifiés.

> **À retenir.** « Software engineering » est, dès l'origine, un **pari** : traiter le logiciel avec la rigueur d'une ingénierie. Les participants de 1968 doutaient déjà de l'ampleur de la « crise ».

## 3. Jalon 2 · 1975 et 1986, Fred Brooks : pas de balle d'argent

**Le problème.** Face aux retards, la réaction naturelle d'un manager est d'ajouter des personnes, ou d'acheter l'outil miracle.

**Qui, quand.** Frederick P. Brooks Jr. (né le 19 avril 1931, mort le 17 novembre 2022) a dirigé le développement du système d'exploitation OS/360 chez IBM, puis écrit *The Mythical Man-Month* (1975), puis l'essai « No Silver Bullet » (1986). Il a reçu le prix Turing en 1999. [S5]

**L'idée, première partie : la loi de Brooks (1975).** « Ajouter de la main-d'œuvre à un projet logiciel en retard le retarde encore » (*Adding manpower to a late software project makes it later*). [S5] Pourquoi ? Les nouveaux arrivants doivent être formés (par ceux qui travaillent déjà), et le nombre de canaux de communication croît vite avec la taille de l'équipe. L'unité « homme-mois » est un **mythe** : on ne peut pas échanger des personnes et du temps comme on échange des briques. À ne pas confondre avec une règle absolue : c'est une observation d'expérience, qui vaut surtout pour les projets en retard et complexes.

**L'idée, deuxième partie : « No Silver Bullet » (1986).** Une « balle d'argent » désigne, dans le folklore, l'arme unique qui tue le monstre. Brooks écrit : « Il n'existe aucun développement unique, ni en technologie ni en technique de gestion, qui promette à lui seul un gain d'un ordre de grandeur en productivité, en fiabilité, en simplicité, dans la décennie. » [S4] Son raisonnement repose sur une distinction :

- les tâches **accidentelles** : représenter les idées dans un langage de programmation, composer avec les contraintes de la machine, les outils ;
- les tâches **essentielles** : concevoir la structure conceptuelle complexe du logiciel, c'est-à-dire comprendre le problème et décider.

Brooks fait un calcul simple. Même en ramenant à zéro tout le travail accidentel, on ne gagne pas un facteur dix, sauf si ce travail représentait plus de 9/10 de l'effort total. [S4] Pour un lecteur de formation « chiffres », c'est un raisonnement de type loi d'Amdahl : le gain maximal d'une accélération est borné par la part du travail que l'on accélère.

*Analogie.* Imaginez un cabinet de conseil. Rendre la mise en page des livrables dix fois plus rapide ne change pas grand-chose à la durée d'une mission, parce que le temps est passé à comprendre le client et à construire l'analyse.

**Ce que cela apporte encore.** La grille « accidentel contre essentiel » reste la meilleure question à poser devant tout outil, y compris un agent de code. Lecture proposée dans ce cours (opinion) : un agent attaque l'accidentel avec une efficacité inédite, et l'essentiel reste à nous. Brooks avait raison sur la **nature** du problème, mais pas nécessairement sur l'absence de gros gains d'outillage.

**Limites et critiques.**

- Brooks parlait d'un gain d'ordre de grandeur **dans la décennie** et **par une seule** innovation. Il n'excluait pas des progrès cumulés importants : la phrase est souvent citée plus fortement qu'elle n'est écrite.
- La frontière entre « accidentel » et « essentiel » est elle-même discutable : ce qui est accidentel aujourd'hui (un format de fichier) peut devenir essentiel demain (une exigence d'interopérabilité). C'est un jugement, pas une mesure.

> **À retenir.** L'outil mange l'accidentel, jamais l'essentiel. Avant d'adopter un outil, demandez : quelle part de notre effort est vraiment accidentelle ?

## 4. Jalon 3 · 1992, la dette technique (Ward Cunningham)

**Le problème.** Une équipe est pressée de livrer. Elle prend des raccourcis : un morceau de code qui marche mais qu'on ne comprend plus très bien, un cas particulier ajouté à la va-vite. Au début, cela accélère. Puis chaque nouvelle fonctionnalité devient plus lente et plus risquée.

**Qui, quand.** Ward Cunningham, dans un rapport d'expérience présenté à la conférence OOPSLA en 1992 sur le système WyCash (gestion de portefeuilles d'obligations, écrit en Smalltalk). [S6] Il est aussi l'un des dix-sept signataires du Manifeste Agile (jalon 5).

**L'idée.** La citation originale : « Livrer du code de première intention, c'est comme s'endetter. Un peu de dette accélère le développement, tant qu'elle est remboursée rapidement par une réécriture. » Et plus loin : « Chaque minute passée sur du code pas tout à fait juste compte comme des intérêts sur cette dette. » Les organisations entières peuvent être « paralysées sous le poids de la dette d'une implémentation non consolidée ». [S6] (Traduction libre. Texte original sur la page citée.)

*Analogie du citron moisi* (diapositive). De l'extérieur, le citron tient encore, mais la moisissure progresse en silence. Une équipe qui n'a pas remboursé sa dette paie des intérêts, c'est-à-dire du temps, à chaque modification.

**Une nuance essentielle.** En 2009, Cunningham a précisé dans une vidéo que la métaphore ne voulait pas dire « faire un mauvais travail maintenant et un meilleur plus tard » : « Je ne suis jamais favorable à l'écriture de mauvais code, mais je suis favorable à l'écriture d'un code qui reflète votre compréhension actuelle du problème, même partielle. » (Citation relayée par un article secondaire, la vidéo n'a pas été revisionnée pour ce chapitre.) [S7] Autrement dit, la dette désigne l'écart entre le code et ce que l'on a **compris depuis** : on apprend en construisant, et il faut remanier le code pour qu'il reflète cet apprentissage.

**Exemple concret.** Voici le même calcul de panier (articles de type « A » à 10 % de remise) écrit de deux façons. Le premier fonctionne, mais personne ne sait ce que `'A'` et `0.9` signifient. Le second a le même comportement, avec des intentions nommées. Ce code a été exécuté avec Dart 3.13.5 et ses tests passent.

```dart
// Avant : ça marche, mais l'intention est cachée.
double p(List<Map<String, Object>> d) {
  var t = 0.0;
  for (final i in d) {
    if (i['t'] == 'A') {
      t += (i['p'] as num) * 0.9;
    } else {
      t += (i['p'] as num);
    }
  }
  return t;
}

// Après : même comportement, intentions nommées.
const tauxRemiseAbonne = 0.10;

double prixAvecRemise(double prix) => prix * (1 - tauxRemiseAbonne);

double totalPanier(List<({double prix, bool abonne})> articles) {
  var total = 0.0;
  for (final article in articles) {
    total += article.abonne ? prixAvecRemise(article.prix) : article.prix;
  }
  return total;
}
```

La remise de 10 % devient une valeur nommée, qu'on modifie à un seul endroit. Un agent qui lira ce code comprendra mieux l'intention, nous y reviendrons.

**Ce que cela apporte encore.** Un vocabulaire pour parler à un responsable financier : la dette est un **choix de gestion** (emprunter pour aller vite) à condition de savoir qu'on emprunte et de prévoir de rembourser. Avec un agent, la dette se crée plus vite que jamais : c'est le thème de la troisième séance.

**Limites et critiques.**

- Toute métaphore a ses limites. Une dette financière se chiffre, la dette technique non : il n'existe pas de mesure consensuelle (opinion répandue chez les praticiens, non sourcée ici).
- Le terme a été élargi au point d'excuser tout code mal fait, ce que Cunningham déplore lui-même (voir ci-dessus). [S7]

> **À retenir.** La dette technique est un emprunt : on peut le contracter en connaissance de cause, mais les intérêts courent. Si personne ne rembourse, la vitesse s'effondre.

## 5. Jalon 4 · 1996 à 2002, Extreme Programming et TDD (Kent Beck)

**Le problème.** Comment éviter l'accumulation de dette et les mauvaises surprises tardives, quand le besoin change en cours de route ?

**Qui, quand.** Kent Beck prend la direction du projet C3 (Chrysler Comprehensive Compensation System, un projet de remplacement de systèmes de paie, en Smalltalk) en mars 1996. [S8] Le projet est à l'origine de l'**Extreme Programming** (XP), dont Beck publie la présentation dans *Extreme Programming Explained* (octobre 1999). Il publie *Test-Driven Development by Example* en 2002. [S8, S9]

**L'idée.** XP pousse à l'extrême des pratiques de bon sens : écrire des tests en continu, programmer à deux (**pair programming**), livrer de petites versions, **intégrer** le code de tous très souvent (intégration continue), garder une conception simple, **remanier** (*refactoring*) sans cesse. Le **refactoring** désigne l'amélioration de la structure du code **sans changer son comportement** : un peu comme réorganiser un classeur sans modifier son contenu. Martin Fowler publie la même année (1999) le livre *Refactoring*. [S9]

Au centre se trouve le **TDD** (*Test-Driven Development*, développement piloté par les tests). Un **test** est un petit programme qui vérifie qu'un morceau de code fait ce qu'on attend. Le cycle tient en trois temps :

1. **Rouge** : on écrit un test pour un comportement qui n'existe pas encore. Il échoue, c'est normal.
2. **Vert** : on écrit le code **le plus simple** qui fait passer le test.
3. **Refactor** : on nettoie, protégé par les tests, sans changer le comportement.

*Démonstration.* Reprenons l'exemple de la séance : un jet de dés plus un bonus doit atteindre un degré de difficulté (DD) pour réussir. Écrire d'abord le test, c'est écrire la **spécification exécutable** du comportement.

```dart
// test/jeu_test.dart
import 'package:test/test.dart';
import 'package:mon_jeu/jeu.dart';

void main() {
  test('réussite si total égal au dd', () {
    expect(estReussite(12, 12), isTrue);
  });
  test('échec si total inférieur au dd', () {
    expect(estReussite(11, 12), isFalse);
  });
}
```

Étape rouge : la fonction `estReussite` n'existe pas, le test ne peut pas passer. Étape verte, première tentative, volontairement naïve :

```dart
bool estReussite(int total, int dd) {
  return true;
}
```

Le premier test passe, le second échoue (`Expected: false, Actual: <true>`, comportement vérifié à l'exécution). Ce second test rouge force à préciser la vraie règle :

```dart
bool estReussite(int total, int dd) {
  return total >= dd;
}
```

Les deux tests passent (`All tests passed!`). On peut maintenant nettoyer le code ou les tests, en étant sûr de ne rien casser. Dans le cours, vous exécuterez ces tests avec `flutter test`. J'ai vérifié les extraits ci-dessus avec la commande `dart test` (Dart 3.13.5), ce qui revient au même pour du code sans interface.

**Ce que cela apporte encore.** Le test est un **garde-fou** et une documentation vivante. C'est l'idée la plus réutilisée pour encadrer un agent de code : on lui donne le test, il doit faire passer le test. Kent Beck lui-même surveille les dérives des agents (boucles, fonctions non demandées, triche sur les tests), voir le chapitre 3.

**Limites et critiques.**

- **Le projet fondateur a mal fini.** D'après Wikipédia, C3 a été annulé en février 2000, après le rachat de Chrysler par Daimler-Benz. [S8] Cela n'invalide pas XP, mais cela rappelle qu'une méthode seule ne garantit pas le succès d'un projet. Les raisons exactes de l'arrêt n'ont pas été vérifiées dans des sources primaires.
- Le TDD divise les praticiens. Certains le jugent coûteux sur des problèmes mal définis (opinion répandue, non sourcée ici). Retenez que le TDD est une **discipline** parmi d'autres, pas une loi.
- Le TDD ne remplace pas la réflexion sur la conception : des tests peuvent passer sur un code mal conçu.

> **À retenir.** Rouge, vert, refactor : de petits pas vérifiés en continu. Un test est une spécification exécutable.

## 6. Jalon 5 · 2001, le Manifeste Agile

**Le problème.** Dans les années 1990, la méthode dominante est le **cycle en cascade** : on spécifie tout, on conçoit tout, on code tout, on teste à la fin. Quand le besoin change en cours de route, c'est un désastre. Les méthodes « légères » (XP, Scrum, et d'autres) naissent en réaction.

**Qui, quand.** Du 11 au 13 février 2001, au Lodge de Snowbird (Utah), dix-sept personnes issues de XP, Scrum, DSDM, Crystal et d'autres courants se réunissent. Cette rencontre avait été précédée d'une réunion de partisans d'XP organisée par Kent Beck à Rogue River (Oregon) au printemps 2000. [S10]

**L'idée.** Quatre valeurs, dans une formule où l'on reconnaît la valeur des seconds éléments mais où l'on privilégie les premiers : les individus et leurs interactions plus que les processus et les outils ; des logiciels opérationnels plus qu'une documentation exhaustive ; la collaboration avec les clients plus que la négociation contractuelle ; l'adaptation au changement plus que le suivi d'un plan. [S10] Les dix-sept signataires sont Kent Beck, Mike Beedle, Arie van Bennekum, Alistair Cockburn, Ward Cunningham, Martin Fowler, James Grenning, Jim Highsmith, Andrew Hunt, Ron Jeffries, Jon Kern, Brian Marick, Robert C. Martin, Steve Mellor, Ken Schwaber, Jeff Sutherland et Dave Thomas. [S10]

Le manifeste est presque entièrement fait de **valeurs**. La technique n'y apparaît qu'une fois, dans le neuvième des douze principes : « Une attention continue à l'excellence technique et à une bonne conception renforce l'agilité » (en anglais : *Continuous attention to technical excellence and good design enhances agility*). [S10] C'est l'origine du glissement que corrige le jalon 8.

**Ce que cela apporte encore.** La livraison fréquente, la collaboration avec le client, l'acceptation du changement : ce sont les bases des projets que vous vivrez, y compris le sprint de votre projet final.

**Limites et critiques.**

- **Fait.** L'agilité s'est largement diffusée, en particulier sous la forme de Scrum, une méthode d'organisation (rôles, réunions, cycles courts) qui, contrairement à XP, ne prescrit **aucune pratique technique**. Martin Fowler décrit dès le 29 janvier 2009 un cas fréquent, qu'il appelle « Flaccid Scrum » : l'équipe adopte les rituels de Scrum, puis « les progrès deviennent lents parce que la base de code est un désordre », faute d'attention à la qualité interne du logiciel. [S11] Il rappelle que Scrum omet volontairement les pratiques techniques, contrairement à XP, et recommande de s'appuyer sur celles d'XP comme point de départ (la page ne détaille pas lesquelles). [S11]
- **Fait.** Dave Thomas, signataire du Manifeste, publie en 2014 un texte intitulé « Agile is Dead (Long Live Agility) » : selon lui, le mot « agile » a été dévoyé par la commercialisation. [S12]
- **Opinion.** Pour beaucoup de praticiens, le Manifeste est trop général pour être appliqué tel quel. Cette lecture est défendable, mais elle n'est pas démontrée.

> **À retenir.** Le Manifeste Agile pose des valeurs, très peu de technique. Quand l'agilité s'applique sans pratiques techniques, la vitesse du début se paie en dette.

## 7. Jalon 6 · 2003, Domain-Driven Design (Eric Evans)

**Le problème.** Une équipe de développeurs et des experts du métier (juristes, comptables, logisticiens) ne parlent pas la même langue. Les besoins sont mal compris, traduits plusieurs fois, déformés. Le code finit par refléter l'organisation technique plutôt que le métier.

**Qui, quand.** Eric Evans, *Domain-Driven Design: Tackling Complexity in the Heart of Software*, Addison-Wesley, 2003, avec une préface de Martin Fowler. [S9, S13]

**L'idée.** La complexité principale d'un logiciel vient du **métier** (le « domaine »), pas de la technique. Deux notions sont à retenir.

- Le **langage omniprésent** (*ubiquitous language*) : experts du métier et développeurs construisent un vocabulaire commun, utilisé dans les conversations, la documentation et le code lui-même. Dan North, dans l'article sur le BDD (jalon 7), résume l'idée de cette façon : le vocabulaire du métier « pénètre jusque dans la base de code ». [S14]
- Le **contexte délimité** (*bounded context*) : un modèle ne vaut que dans un périmètre. Exemple : le mot « client » ne désigne pas la même chose en facturation (un payeur avec une adresse de facturation) et en support (un utilisateur qui a un problème). Mélanger les deux crée des ambiguïtés. (Illustration pédagogique de ce cours, pas une citation du livre.)

**Ce que cela apporte encore.** Un agent de code ne connaît pas votre métier. Un code qui emploie le vocabulaire du métier lui fournit un meilleur **contexte** (voir chapitre 3). C'est aussi une ligne directrice pour l'architecture du projet du cours : les couches du code reflètent les notions du métier.

**Limites et critiques.** Je n'ai pas pu vérifier de sources de critique précises sur ce point : ce qui suit relève des retours de praticiens, non sourcés ici. Le DDD demande un accès régulier à des experts du métier, et un investissement de modélisation qui n'est pas rentable pour un petit outil jetable. Sur un outil ponctuel, comme ceux que vous construirez, on retient surtout la discipline du vocabulaire commun, pas l'arsenal complet.

> **À retenir.** Le code qui parle la langue du métier se lit, se discute avec les experts et guide mieux un agent.

## 8. Jalon 7 · 2006, Behavior-Driven Development (Dan North)

**Le problème.** En enseignant le TDD, Dan North rencontre toujours les mêmes confusions. Ses mots : les programmeurs voulaient savoir « par où commencer, quoi tester et ne pas tester, combien tester d'un coup, comment nommer leurs tests, et comment comprendre pourquoi un test échoue ». [S14]

**Qui, quand.** Dan North, « Introducing BDD », article paru dans le magazine *Better Software* en mars 2006 (la version en ligne de son blog est datée du 20 septembre 2006). [S14] Les étapes qu'il raconte : un outil de son collègue Chris Stevenson (agiledox) qui transforme les noms de tests en phrases lisibles ; fin 2003, la création de JBehave, un remplaçant de JUnit sans vocabulaire de test ; fin 2004, avec l'analyste Chris Matts, l'extension de l'idée aux **exigences**. [S14]

**L'idée.** Parler de **comportement** plutôt que de test. « La réponse à "comment nommer un test" est facile : c'est une phrase qui décrit le prochain comportement qui vous intéresse. » [S14] Pour décrire les critères d'acceptation d'une fonctionnalité, North et Matts proposent un gabarit : « Étant donné un contexte initial (*Given*), Quand un événement se produit (*When*), Alors s'assurer de certains résultats (*Then*). » [S14] En français : **Soit / Quand / Alors**. Le scénario de la séance se lit comme une phrase :

```gherkin
Fonctionnalité: Jet de dés
  Scénario: jet égal au DD
    Soit un degré de difficulté de 12
    Quand le total du jet est 12
    Alors c'est une réussite
```

(Ce texte n'est pas exécuté ici : l'outil d'exécution, Cucumber, n'est pas installé dans notre environnement. La syntaxe est celle du langage Gherkin, en version française.) Les outils comme Cucumber et le langage Gherkin viendront plus tard rendre ce texte exécutable. Les dates de ces outils n'ont pas été vérifiées pour ce chapitre.

**Ce que cela apporte encore.** C'est la même idée que « un test est une spécification exécutable », mais lisible par un non-développeur. Vous pouvez relire et valider un scénario sans lire une ligne de code, ce qui vous donne un rôle précis dans un projet avec un agent : décrire le comportement attendu. Le *spec-driven development* (développement piloté par les spécifications), que nous verrons plus tard, reprend cette logique.

**Limites et critiques.**

- Dans l'article de North, la partie exécutable est liée à des classes Java (JBehave). Ce qui reste de l'idée est le **vocabulaire** plus que l'outil. [S14]
- Retour de praticiens (non sourcé ici) : écrire des scénarios que seuls des développeurs lisent revient à ajouter une couche de cérémonie. L'intérêt du BDD est la **conversation** entre métier, test et développement, pas le fichier produit.
- Une confusion à éviter : Cucumber et Gherkin, outils qui ont popularisé le BDD plus tard, ne sont pas l'origine du BDD. Celle-ci date de 2006 (article de Dan North). [S14]

> **À retenir.** Un scénario Soit / Quand / Alors décrit un comportement dans la langue du métier, et peut devenir un test.

## 9. Jalon 8 · 2001 à 2009, le mouvement du craft et son manifeste

**Le problème.** L'agilité se diffuse largement, souvent sans les pratiques techniques qui la rendent possible (voir « Flaccid Scrum », jalon 5). Les équipes livrent vite au début, puis ralentissent sous le poids du code.

**Qui, quand.**

- **1992** : Jack Reeves publie « What Is Software Design? » : pour lui, le code source est le vrai document de conception d'un logiciel. [S15]
- **1999** : *The Pragmatic Programmer: From Journeyman to Master* (Andrew Hunt et Dave Thomas). Le sous-titre fait référence au compagnonnage (apprenti, compagnon, maître). [S9, S15]
- **2001** : Pete McBreen, *Software Craftsmanship: The New Imperative* (Addison-Wesley). Il propose un modèle de travail par petites équipes de gens de métier, en alternative au modèle « usine ». [S9, S15]
- **Août 2008** : à la conférence Agile 2008 (Toronto), Robert C. Martin propose une cinquième valeur pour le Manifeste Agile, d'abord « Craftsmanship over Crap », puis, dans un billet ultérieur, « Craftsmanship over Execution ». [S16, S17]
- **2008** : *Clean Code: A Handbook of Agile Software Craftsmanship* (Robert C. Martin). [S9]
- **Décembre 2008** : un groupe de développeurs, réuni à Libertyville (Illinois), cherche à établir des principes. Environ trois mois plus tard, en mars 2009, une synthèse est présentée publiquement pour consultation et signature : le **Manifeste du Software Craftsmanship**. [S16, S18]

**L'idée.** Le manifeste se présente ainsi : en tant qu'aspirants artisans du logiciel, « nous relevons le niveau du développement logiciel professionnel en le pratiquant et en aidant les autres à apprendre le métier ». Il énonce quatre « pas seulement… mais aussi » : [S18]

| Pas seulement… | …mais aussi |
|---|---|
| des logiciels opérationnels | des logiciels **bien conçus** |
| l'adaptation au changement | l'ajout **constant de valeur** |
| des individus et des interactions | une **communauté** de professionnels |
| la collaboration avec les clients | des **partenariats** productifs |

(Traduction libre du texte anglais. Le texte du site officiel est chargé dynamiquement et n'a pu être relu en ligne : cette traduction s'appuie sur plusieurs copies concordantes trouvées en recherche.) Le manifeste **complète** l'agile, il ne le remplace pas : chaque ligne reprend une valeur du Manifeste Agile et l'étend.

**Ce que cela apporte encore.** Une exigence de **responsabilité professionnelle** : le « ça marche » ne suffit pas, le code doit pouvoir être compris, modifié et testé par d'autres. Cette exigence est au cœur de la règle de ce cours : une demande de fusion (*pull request*, PR) doit tenir en petits pas, avec des tests d'abord, et vous devez pouvoir l'expliquer.

**Limites et critiques.**

- **Fait.** Le mouvement a été critiqué pour son élitisme. Ted Neward, dans InfoWorld (23 janvier 2013), s'inquiète de la « face sombre » de l'idée d'artisanat : une ségrégation entre ceux qui « comprennent » et ceux qui « ne comprennent pas », fondée sur des critères subjectifs. [S19]
- **Fait.** Le terme « craftsman » (artisan, au masculin) a été jugé excluant pour les femmes. Robert C. Martin a lui-même répondu par un billet consacré à « Craftsman, Craftswoman, Craftsperson » (2 mai 2018). L'entreprise 8th Light a de son côté publié un texte intitulé « Software Craftsmen Are Arrogant, Slow, and Dogmatic » pour répondre aux critiques. Je n'ai relu ni l'un ni l'autre en détail : ils sont cités comme existants. [S20]
- **Opinion** (non vérifiée) : la comparaison avec les guildes médiévales est jugée prétentieuse par certains praticiens.
- **Fait.** Le craft est une réponse **culturelle**, pas une démonstration scientifique. Il est antérieur aux données qui, quelques années plus tard, mesureront les effets de pratiques techniques (jalon 9).

> **À retenir.** « Pas seulement… mais aussi » : l'agilité fixe le cap, le craft fournit les pratiques techniques et la responsabilité pour le tenir.

## 10. Jalon 9 · 2005 à 2018, Git, livraison continue et DORA

**Le problème.** Même avec de bonnes pratiques, un code qui ne peut pas être livré en toute sécurité est un code qui ne produit aucune valeur. Il faut des outils pour **versionner** (garder l'historique de chaque modification), **intégrer** (fusionner le travail de plusieurs personnes) et **livrer** (mettre à disposition des utilisateurs).

**2005 : Git.** Le premier commit de Git date du 7 avril 2005 ; l'outil est écrit par Linus Torvalds, créateur du noyau Linux, après la perte d'accès de la communauté du noyau à l'outil propriétaire BitKeeper. La version 1.0 date du 21 décembre 2005. [S21] Un **commit** est un enregistrement d'un ensemble de modifications, avec un message qui l'explique. Une **branche** est une ligne de travail parallèle, créée à peu de frais. L'historique de Git est **distribué** : chaque copie du dépôt contient tout l'historique. On peut donc **essayer sans risque**, sur une branche, puis fusionner ou jeter. GitHub, une plateforme d'hébergement de dépôts Git, est lancé publiquement le 10 avril 2008. [S21]

**2010 : Continuous Delivery.** Jez Humble et David Farley publient *Continuous Delivery* chez Addison-Wesley le 27 juillet 2010. [S22] Ils popularisent le **pipeline de déploiement** : une chaîne automatisée qui, à chaque modification, construit le logiciel, lance les tests et le prépare pour la **production** (l'environnement réel, utilisé par les vrais utilisateurs). L'idée est que chaque changement doit pouvoir partir en production à tout moment. On parle aussi de **CI/CD** (*Continuous Integration / Continuous Delivery*), thème de la séance 4.

**2018 : Accelerate et DORA.** *Accelerate: The Science of Lean Software and DevOps* (Nicole Forsgren, Jez Humble, Gene Kim) paraît en 2018 (et non 2017). [S9] DORA (*DevOps Research and Assessment*) est le programme de recherche à l'origine de ces travaux. Sa première étude date de 2014 ; en 2015, il établit que la vitesse n'est pas obtenue au détriment de la stabilité : les équipes les plus performantes excellent sur les deux. [S23] Le programme est aujourd'hui géré par Google Cloud. [S23]

**Les « quatre indicateurs » et leur évolution.** La diapositive présente les quatre indicateurs historiques : fréquence de déploiement, délai de livraison (*lead time*), taux d'échec des changements, temps de rétablissement. **Mise à jour importante.** Depuis 2024, DORA recense **cinq** indicateurs, regroupés en deux familles : [S23]

| Famille | Indicateur | Définition officielle (traduction libre) |
|---|---|---|
| Débit (*throughput*) | Délai de livraison d'un changement | Temps entre l'enregistrement du changement et son déploiement en production |
| Débit | Fréquence de déploiement | Nombre de déploiements sur une période |
| Débit | Temps de rétablissement après déploiement raté | Temps pour se remettre d'un déploiement qui échoue et demande une intervention immédiate |
| Instabilité | Taux d'échec des changements | Part des déploiements qui exigent une intervention immédiate (retour arrière ou correctif) |
| Instabilité | Taux de reprise (*rework*) | Part des déploiements non planifiés, faits à la suite d'un incident en production |

Ces cinq indicateurs ne contredisent pas la diapositive : les quatre originaux sont toujours là, avec des définitions affinées (le « temps de rétablissement » a été redéfini en 2023, et le « taux de reprise » ajouté en 2024). [S23]

**Ce que cela apporte encore.** Pour la première fois, la qualité devient **mesurable** à l'échelle de l'organisation, et DORA insiste : vitesse et stabilité ne sont pas en compromis, les deux sont corrélées pour la plupart des équipes. [S23] Ce sont aussi les indicateurs avec lesquels on mesure aujourd'hui l'effet de l'IA sur les équipes, ce que nous verrons à la partie 3 de la séance.

**Limites et critiques.**

- **Fait.** DORA met lui-même en garde : les indicateurs sont adaptés pour mesurer **une application ou un service à la fois**, et agréger des équipes de contextes différents est « problématique ». [S23]
- **Mise en garde générale (opinion de praticiens, non sourcée ici).** Un indicateur devenu un objectif de performance se détourne de son but (loi de Goodhart). Mesurer la « fréquence de déploiement » d'une équipe en lui donnant un bonus incite à déployer des changements triviaux.
- **À ma connaissance, non revérifié ici** : ces recherches reposent surtout sur des questionnaires déclaratifs, ce qui n'établit pas à lui seul une causalité.

> **À retenir.** Git rend l'essai sans risque, la livraison continue rend la publication banale, DORA rend la qualité mesurable. Ce sont les trois conditions pour changer souvent un logiciel sans le casser.

## 11. Un fait qui structure la suite : on lit plus qu'on n'écrit

On cite souvent le fait suivant : moins de 25 % du temps d'un développeur est consacré à l'écriture de code ; le reste est de la lecture, de la recherche, des échanges et des tests.

**Provenance, avec prudence.** Le chiffre est repris par Sandro Mancuso (cofondateur de Codurance, société de formation et de conseil en craft, donc partie prenante) dans son article « Software Craftsmanship in the AI Era » (9 février 2026). Mancuso écrit qu'on peut estimer sans risque (« it's safe to estimate ») que moins de 25 % du temps est passé à éditer du code, en s'appuyant sur une étude de Microsoft Research de 2019 (« Today was a Good Day: The Daily Life of Software Developers ») et sur d'autres études citées. [S24] Il s'agit donc d'une **estimation** de Mancuso à partir de travaux de Microsoft, non d'une mesure unique et directe. Les 14 cases colorées sur 60 de la diapositive sont une illustration, pas une mesure.

**Pourquoi c'est important.** Écrire plus vite ne supprime pas le coût de lecture et de compréhension. Produire davantage de code à lire peut même l'amplifier. C'est ce que dit Mancuso à propos de l'IA : elle ne retire pas ce coût, « dans bien des cas, elle l'amplifie » (« In many cases, it amplifies it »). [S24]

## 12. Ce que « craft » veut dire concrètement

Après neuf jalons, voici une synthèse en trois mots-clés. C'est la lecture du cours, elle reprend la diapositive « Le craft, concrètement » avec ses limites : les listes détaillées des pratiques ne sont pas toutes sourcées ligne à ligne.

**La posture.**

- La **responsabilité** : je réponds de ce que je livre, que je l'aie écrit moi-même ou non.
- L'**apprentissage** continu, seul et en communauté : lectures, exercices répétés (les *katas*), séances de pratique en groupe (les *dojos*). (Pratiques courantes de la communauté du craft, non sourcées ici.)
- La capacité à **dire non** et à **estimer honnêtement**, que Robert C. Martin place au cœur du professionnalisme dans *The Clean Coder* (*The Clean Coder*, 2011, d'après la base Open Library [S9]). Le contenu du livre n'a pas été revérifié ici : cette mention est à confirmer avant diffusion.

**Les pratiques.**

- Le **TDD** et les tests : le test d'abord, puis le code (jalon 4).
- Le **refactoring** : améliorer sans changer le comportement.
- Les **petits commits** et petites demandes de fusion : des modifications faciles à relire.
- La **revue** de code (relecture par un collègue) et le travail à deux ou à plusieurs (**pair** et **mob**) : on partage la compréhension.
- L'**intégration** et la **livraison continues** (jalon 9).

**La conception.**

- Un **code lisible** : des noms qui disent l'intention (le « avant/après » du jalon 3).
- Les principes **SOLID**, cinq règles de conception de Robert C. Martin (par exemple : un module ne devrait avoir qu'une seule raison de changer).
- Le **DDD** : le code parle la langue du métier (jalon 6).

**Le point commun : pouvoir changer le logiciel demain sans avoir peur.** C'est la définition pratique que nous retenons, celle de la séance. Il ne s'agit pas d'écrire du « beau » code, mais de garder la possibilité de changer.

**Ce que le craft n'est pas.** Ce n'est pas du perfectionnisme : une dette assumée, remboursée à temps, est un choix légitime (jalon 3). Ce n'est pas un titre à décerner : la critique d'élitisme du jalon 8 vaut avertissement. Ce n'est pas non plus une garantie : C3 (jalon 4) et Denver (accroche) rappellent que les meilleures pratiques ne remplacent pas le jugement.

## 13. Pourquoi cela compte avant d'aborder les agents

Le chapitre précédent montre un enchaînement : à chaque époque, une nouvelle capacité de production (machines, langages, méthodes, outils de livraison) fait apparaître un goulot d'étranglement déplacé. Avec les agents de code, la **production** de code devient presque gratuite. Ce qui reste cher, ce sont les trois points que ce chapitre a mis en place :

1. **Comprendre le besoin** (Brooks, DDD, BDD) : un agent n'invente pas le métier à votre place.
2. **Vérifier** (TDD, tests d'acceptation, revue, DORA) : un agent écrit du code qui a l'air juste. Les tests sont les garde-fous qui l'empêchent de dériver.
3. **Garder le code changeable** (dette, refactoring, conception) : un agent produit vite un désordre aussi vite qu'un code sain.

C'est pourquoi la règle du projet est : **petits pas + tests d'abord + je sais l'expliquer.** On y reviendra dans les chapitres 2 et 3 (histoire de l'IA, craft depuis l'IA), et en séances 2 et 4 pour les pratiques.

> **À retenir.** Le craft n'est pas une nostalgie. C'est le jeu d'outils qui rend possible de changer vite et sans casser : exactement ce qu'on attend d'un agent.

## Glossaire du chapitre

- **Accidentel / essentiel (complexité)** : distinction de Brooks entre la difficulté liée aux outils (accidentelle) et celle liée au problème à résoudre (essentielle).
- **Agile** : famille de méthodes de travail par cycles courts, avec retours fréquents du client, formalisée par le Manifeste de 2001.
- **Behavior-Driven Development (BDD)** : développement piloté par le comportement. Les exigences sont décrites par des scénarios lisibles par le métier.
- **Bounded context (contexte délimité)** : périmètre à l'intérieur duquel un modèle et son vocabulaire ont un sens précis.
- **Branche** : ligne de travail parallèle dans un dépôt Git.
- **CI/CD** : intégration continue et livraison continue, chaîne automatisée qui construit, teste et prépare le logiciel à chaque modification.
- **Code source** : texte des instructions d'un logiciel.
- **Commit** : enregistrement d'un ensemble de modifications dans l'historique d'un dépôt, accompagné d'un message.
- **Craft (software craftsmanship)** : mouvement et posture professionnelle qui font de la qualité technique et de la responsabilité une valeur, au-delà du simple « ça marche ».
- **Dépôt (repository)** : espace de stockage du code et de son historique.
- **Dette technique** : métaphore de Cunningham. Un raccourci pris aujourd'hui coûte, plus tard, du temps supplémentaire (« intérêts »).
- **DORA** : programme de recherche (aujourd'hui rattaché à Google Cloud) sur la performance de livraison logicielle, source de cinq indicateurs.
- **Domain-Driven Design (DDD)** : conception pilotée par le domaine métier.
- **Gherkin** : langage de scénarios Soit / Quand / Alors (*Given / When / Then*).
- **Git** : outil de gestion de versions distribué créé par Linus Torvalds en 2005.
- **Langage omniprésent (ubiquitous language)** : vocabulaire commun entre experts du métier et développeurs.
- **Pair / mob programming** : travail à deux (pair) ou à tout un groupe (mob) sur le même code.
- **Pipeline de déploiement** : chaîne automatisée qui mène un changement du dépôt à la production.
- **Production** : environnement réel, utilisé par les vrais utilisateurs.
- **Pull request (PR)** : demande de fusion d'une branche, accompagnée d'une relecture.
- **Refactoring (remaniement)** : amélioration de la structure du code sans changer son comportement.
- **Scrum** : méthode agile d'organisation (rôles, réunions, cycles courts), sans pratiques techniques prescrites.
- **SOLID** : cinq principes de conception orientée objet popularisés par Robert C. Martin.
- **Test** : petit programme qui vérifie qu'un morceau de code fait ce qui est attendu.
- **TDD (Test-Driven Development)** : cycle rouge (test qui échoue), vert (code minimal), refactor (nettoyage).
- **Versionner** : garder l'historique de toutes les modifications d'un fichier ou d'un projet.

## Pour aller plus loin

Les lectures ci-dessous sont des pistes. Pour les livres, seule l'année de publication a été vérifiée, pas le contenu détaillé.

- Rapport de la conférence de Garmisch (1968), texte intégral [S3] : les citations de ce chapitre y sont retrouvables.
- Fred Brooks, « No Silver Bullet » (1986) [S4] : un essai court et lisible par des non-développeurs.
- Ward Cunningham, rapport OOPSLA 1992 [S6] : une page, très claire.
- Dan North, « Introducing BDD » [S14] : l'histoire racontée par son auteur.
- DORA, « A history of DORA's software delivery metrics » [S23].
- Martin Fowler, « Flaccid Scrum » [S11] : cinq minutes de lecture, très utiles pour votre propre projet.
- Livres : Kent Beck, *Test-Driven Development by Example* (2002) ; Eric Evans, *Domain-Driven Design* (2003) ; Robert C. Martin, *Clean Code* (2008) ; Jez Humble et David Farley, *Continuous Delivery* (2010) ; Nicole Forsgren, Jez Humble, Gene Kim, *Accelerate* (2018).
- Dans ce dépôt : `cours/sources/craft.md` (état de la qualité du code à l'ère des agents, chapitre 3) et `cours/presentations/day-1/` (diapositives et notes).

## Sources

Consultées le 6 octobre 2026, sauf mention contraire. Quand une affirmation vient d'une source secondaire (Wikipédia, article de blog), c'est indiqué dans le texte.

- [S1] U.S. GAO, *New Denver Airport: Impact of the Delayed Baggage System*, rapport GAO/RCED-95-35BR, 14 octobre 1994. https://www.govinfo.gov/content/pkg/GAOREPORTS-RCED-95-35BR/html/GAOREPORTS-RCED-95-35BR.htm
- [S2] Wikipédia (anglais), « Denver International Airport » (source secondaire : calendrier des reports, ouverture du 28 février 1995, arrêt du système en septembre 2005). https://en.wikipedia.org/wiki/Denver_International_Airport
- [S3] P. Naur, B. Randell (éd.), *Software Engineering: Report on a conference sponsored by the NATO Science Committee, Garmisch, Germany, 7th to 11th October 1968*. http://homepages.cs.ncl.ac.uk/brian.randell/NATO/nato1968.PDF (le certificat du serveur était expiré lors de la consultation ; le texte a été lu en désactivant la vérification).
- [S4] F. P. Brooks Jr., « No Silver Bullet: Essence and Accident in Software Engineering », 1986 (IFIP, repris dans l'édition anniversaire de *The Mythical Man-Month*, 1995). https://worrydream.com/refs/Brooks_1986_-_No_Silver_Bullet.pdf
- [S5] Wikipédia (anglais), « Fred Brooks » (loi de Brooks, prix Turing 1999) ; SIGGRAPH, notice nécrologique de Fred Brooks (19 avril 1931, 17 novembre 2022). https://en.wikipedia.org/wiki/Fred_Brooks ; https://www.siggraph.org/remembering/remembering-frederick-p-brooks-jr/
- [S6] W. Cunningham, *The WyCash Portfolio Management System*, OOPSLA 1992. http://c2.com/doc/oopsla92.html
- [S7] Citation de la vidéo de Cunningham (2009) relayée par : « Technical debt isn't technical at all, it's not even debt », Hackernoon. https://www.hackernoon.com/technical-debt-isnt-technical-at-all-its-not-even-debt
- [S8] M. Fowler, « C3 », 3 août 2004, https://martinfowler.com/bliki/C3.html ; Wikipédia (anglais), « Chrysler Comprehensive Compensation System » (mars 1996, annulation en février 2000). https://en.wikipedia.org/wiki/Chrysler_Comprehensive_Compensation_System
- [S9] Dates de publication des livres : base bibliographique Open Library (API de recherche), consultée le 6 octobre 2026, https://openlibrary.org ; date d'*Extreme Programming Explained* (octobre 1999) d'après la page Wikipédia sur C3 (S8). Source secondaire : à confirmer sur les notices des éditeurs.
- [S10] Agile Alliance, « History: The Agile Manifesto » ; « Manifeste pour le développement Agile de logiciels » (version française) ; « Principles behind the Agile Manifesto ». https://agilemanifesto.org/history.html ; https://agilemanifesto.org/iso/fr/manifesto.html ; https://agilemanifesto.org/principles.html
- [S11] M. Fowler, « Flaccid Scrum », 29 janvier 2009. https://martinfowler.com/bliki/FlaccidScrum.html
- [S12] InfoQ, article sur « Agile is Dead (Long Live Agility) » de Dave Thomas (2014). https://www.infoq.com/news/2014/10/pragmatic-dave-agility
- [S13] O'Reilly, notice de *Domain-Driven Design: Tackling Complexity in the Heart of Software* (E. Evans, Addison-Wesley, 2003, préface de M. Fowler). https://www.oreilly.com/library/view/domain-driven-design-tackling/0321125215/pref04.html
- [S14] D. North, « Introducing BDD », *Better Software*, mars 2006 (version en ligne du 20 septembre 2006). https://dannorth.net/blog/introducing-bdd/
- [S15] Jack Reeves (1992), *The Pragmatic Programmer* (1999), P. McBreen (2001) : synthèse de recherche vérifiée par vote, fichier local `/tmp/claude-1000/-home-bfontaine-git-master-1-iti-dev/d23f8d3a-3a49-463b-8078-f2bec091248e/tasks/walsip7ao.output`, recoupée avec https://en.wikipedia.org/wiki/Software_craftsmanship
- [S16] Wikipédia (anglais), « Software craftsmanship » (Agile 2008, Libertyville, décembre 2008, présentation du manifeste trois mois plus tard). https://en.wikipedia.org/wiki/Software_craftsmanship
- [S17] D. Bradbury (8th Light), « Maturing the Manifesto », 27 août 2008. https://8thlight.com/insights/maturing-the-manifesto
- [S18] *Manifesto for Software Craftsmanship*, https://manifesto.softwarecraftsmanship.org/ ; InfoQ, mars 2009, https://www.infoq.com/news/2009/03/software_craftsmanship (texte anglais cité d'après des copies concordantes, le site officiel affichant son contenu par script).
- [S19] T. Neward, « On the Dark Side of "Craftsmanship" », InfoWorld, 23 janvier 2013. https://www.infoworld.com/article/2158569/on-the-dark-side-of-craftsmanship.html
- [S20] R. C. Martin, « Craftsman, Craftswoman, Craftsperson », 2 mai 2018, https://blog.cleancoder.com/uncle-bob/2018/05/02/Craftsman-Craftswoman-Craftsperson.html ; 8th Light, « Software Craftsmen Are Arrogant, Slow, and Dogmatic », https://8thlight.com/insights/software-craftsmen-are-arrogant-slow-and-dogmatic (cités comme existants, non relus en détail).
- [S21] GitHub Blog, « Git turns 20: A Q&A with Linus Torvalds », https://github.blog/open-source/git/git-turns-20-a-qa-with-linus-torvalds/ ; Wikipédia (anglais), « Git » et « GitHub », https://en.wikipedia.org/wiki/Git ; https://en.wikipedia.org/wiki/GitHub (version 1.0 du 21 décembre 2005, lancement public de GitHub le 10 avril 2008, sources secondaires). Le billet GitHub Blog confirme le premier commit du 7 avril 2005 ; Wikipédia situe, elle, le début du développement au 3 avril 2005.
- [S22] Pearson, notice de *Continuous Delivery* (J. Humble, D. Farley, Addison-Wesley Professional, 27 juillet 2010). https://www.pearson.com/en-us/subject-catalog/p/continuous-delivery-reliable-software-releases-through-build-test-and-deployment-automation/P200000009113
- [S23] DORA, « DORA's software delivery performance metrics » et « A history of DORA's software delivery metrics » (mis à jour le 2 janvier 2026). https://dora.dev/guides/dora-metrics/ ; https://dora.dev/guides/dora-metrics/history/
- [S24] S. Mancuso (Codurance), « Software Craftsmanship in the AI Era », 9 février 2026. https://www.codurance.com/publications/software-craftsmanship-in-the-ai-era
- [S25] Fichiers locaux : `cours/presentations/day-1/index.html` et `notes.html` ; `cours/programme-detaille.md` (section S1) ; `cours/sources/craft.md`.

## Points non vérifiés de ce chapitre

- Le contenu précis de la vidéo de Cunningham (2009) : citation relayée, vidéo non revisionnée.
- Le texte intégral du manifeste du craft sur le site officiel (rendu par script) : traduction faite d'après des copies concordantes.
- Dates de création de Cucumber et de Gherkin ; première édition du *Global Day of Coderetreat* ; première conférence *XP Universe*.
- Raisons exactes de l'annulation de C3 en 2000 ; analyse détaillée de l'échec de Denver (au-delà du rapport GAO de 1994).
- Date exacte de première publication de *Growing Object-Oriented Software, Guided by Tests* (2009 ou 2010).
- Les critiques de praticiens signalées « non sourcées » (DDD, BDD, TDD, loi de Goodhart, élitisme des guildes) sont des opinions courantes, non des faits.
- Les extraits Gherkin (non exécutés, faute de Cucumber) ; tout le code Dart a, lui, été exécuté avec Dart 3.13.5 (`dart test`, `dart analyze`) ; l'équivalent `flutter test` n'a pas été lancé.
