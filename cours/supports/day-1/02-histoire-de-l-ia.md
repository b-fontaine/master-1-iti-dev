# Chapitre 2 · Histoire de l'IA, des origines aux modèles de langage et aux agents

*Support de cours de la séance 1 (« Comprendre et s'équiper »), Master ITI, Nantes Université, 2026-2027. État des connaissances au 6 octobre 2026.*

## Ce que vous allez retenir

- L'intelligence artificielle (IA) n'est pas nouvelle : le champ est nommé en 1955-1956 et traverse **soixante-dix ans** de promesses, de déceptions (les « hivers » de l'IA) et de renaissances.
- Deux grandes familles s'opposent puis se rejoignent : l'IA **à base de règles écrites à la main** (systèmes experts) et l'IA **qui apprend à partir d'exemples** (apprentissage automatique, réseaux de neurones). Depuis 2012, la seconde domine.
- Les modèles de langage actuels reposent sur une invention de 2017, le **transformer**, et sur un principe étonnamment simple : **prédire le morceau de texte suivant** (le « token »), à très grande échelle.
- ChatGPT (30 novembre 2022) n'est pas une rupture technique soudaine : c'est la rencontre d'un modèle puissant, d'un **réglage par retour humain** (RLHF) et d'une interface grand public.
- Entre 2022 et 2026, trois ajouts transforment l'outil : le **raisonnement** (le modèle « réfléchit » avant de répondre), l'**usage d'outils** (il peut agir) et la **boucle d'agent** (il enchaîne les actions et vérifie leur résultat).
- Un modèle de langage a des limites structurelles : **hallucinations**, **non-déterminisme**, **biais**, **dépendance à ce qu'il a sous les yeux** (le contexte) et **coût**. Aucune n'est un bug passager : on les gère par la méthode.
- Un **agent** = un modèle + des outils + un environnement + des garde-fous, dans une boucle. C'est ce que vous utiliserez dès la séance 2 avec Claude Code.

## Comment lire ce chapitre

Chaque fait daté, chiffre, citation ou nom propre est suivi d'un numéro entre crochets, par exemple [18], qui renvoie à la liste « Sources » en fin de chapitre. Les passages sans numéro sont des **explications pédagogiques** : elles reprennent le consensus des praticiens et simplifient volontairement. Quand un point n'a pas pu être vérifié, il est signalé « non vérifié ». Les **opinions** sont présentées comme telles.

Le domaine va vite : les noms de modèles, les prix et les versions cités dans les sections 9 et 11 sont ceux de la documentation officielle consultée le 6 octobre 2026 et seront en partie périmés l'an prochain. Les faits historiques, eux, ne bougent pas.

## 1. Pourquoi une histoire de l'IA dans un cours de génie logiciel ?

Vous allez confier du travail à un agent. Pour savoir ce que vous pouvez raisonnablement lui demander, il faut comprendre d'où il vient et sur quoi il repose. Cette histoire donne trois réflexes utiles :

1. **Se méfier des promesses.** Plusieurs fois, des annonces enthousiastes ont précédé des déconvenues. Cela ne signifie pas que l'IA actuelle est un mirage (ses résultats sont mesurables), mais que les affirmations sans preuve doivent être traitées avec prudence.
2. **Distinguer ce qui est écrit de ce qui est appris.** Un logiciel classique suit des règles écrites par des humains. Un modèle d'IA moderne n'a pas de règles écrites : il a des milliards de réglages numériques obtenus par apprentissage. D'où des comportements puissants, mais difficiles à garantir.
3. **Comprendre pourquoi les tests et les garde-fous sont indispensables** : on ne peut pas « relire » un modèle comme on relit un programme, on peut seulement vérifier ce qu'il produit.

Un vocabulaire minimal avant de commencer :

- **Algorithme** : une suite d'instructions précises qui transforme des données en résultat (une recette de cuisine pour ordinateur).
- **Intelligence artificielle (IA)** : terme-parapluie pour les programmes qui accomplissent des tâches qu'on associe à l'intelligence humaine (comprendre une phrase, reconnaître une image, jouer aux échecs). Il n'a pas de définition scientifique unique.
- **Apprentissage automatique** (en anglais *machine learning*) : au lieu d'écrire les règles, on fournit des exemples et le programme en déduit lui-même des réglages.
- **Paramètre** : un réglage numérique interne au modèle, ajusté pendant l'entraînement. Un modèle récent en compte des milliards. Voyez-les comme les boutons d'une immense table de mixage.

## 2. Les origines (1943-1969)

### 2.1 Turing pose la question (1950)

Le mathématicien britannique Alan Turing publie en octobre 1950, dans la revue *Mind* (volume 59, numéro 236, pages 433 à 460), l'article « Computing Machinery and Intelligence ». Il commence par cette phrase : « I propose to consider the question, "Can machines think?" » (*Je propose d'examiner la question : « Les machines peuvent-elles penser ? »*). Comme la question est vague, il la remplace par un jeu pratique, le **jeu de l'imitation** : un interrogateur échange par écrit avec deux interlocuteurs cachés, un humain et une machine, et doit deviner lequel est la machine [1]. C'est l'ancêtre de ce qu'on appelle le « test de Turing ».

*À retenir pour la suite :* dès 1950, on juge une machine sur ce qu'elle **produit** (ses réponses), pas sur ce qui se passe à l'intérieur. C'est exactement l'attitude que nous adopterons avec les agents : on ne lit pas dans le modèle, on contrôle le résultat.

### 2.2 Les premiers neurones artificiels (1943) et le perceptron (1958)

Dès 1943, Warren McCulloch et Walter Pitts proposent une théorie de neurones formels, c'est-à-dire un modèle mathématique très simplifié d'une cellule nerveuse [3]. En 1958, Frank Rosenblatt décrit le **perceptron** dans la revue *Psychological Review* : une machine capable d'apprendre à classer des exemples en ajustant des réglages [4]. La presse s'emballe : le *New York Times* rapporte, après une conférence de presse de la Marine américaine, que le perceptron est « the embryo of an electronic computer that [the Navy] expects will be able to walk, talk, see, write, reproduce itself and be conscious of its existence » [4]. C'est le premier exemple documenté d'un cycle qui se répétera : promesse démesurée, puis déception.

### 2.3 Dartmouth : le champ reçoit son nom (1955-1956)

Le 31 août 1955, quatre chercheurs, John McCarthy (Dartmouth College), Marvin Minsky (Harvard), Nathaniel Rochester (IBM) et Claude Shannon (Bell Telephone Laboratories), déposent une demande de financement auprès de la Fondation Rockefeller pour un « Dartmouth Summer Research Project on Artificial Intelligence ». Ils prévoient deux mois, l'été 1956, avec dix scientifiques, et demandent 13 500 dollars. Leur pari, formulé dans la proposition : « Every aspect of learning or any other feature of intelligence can in principle be so precisely described that a machine can be made to simulate it » (*Chaque aspect de l'apprentissage ou toute autre caractéristique de l'intelligence peut en principe être décrit si précisément qu'on peut construire une machine pour le simuler*) [2]. La paternité du terme « intelligence artificielle » est généralement attribuée à McCarthy (non vérifié ici) ; ce qui est établi, c'est qu'il figure dans le titre de cette proposition [2]. L'atelier de 1956 est considéré comme l'acte de naissance du domaine [3].

### 2.4 Premiers programmes, premières illusions (années 1960)

Entre 1956 et 1974, c'est un « âge d'or » de la recherche symbolique [3]. **ELIZA**, écrit par Joseph Weizenbaum au MIT et diffusé en 1966, simule une psychothérapeute en repérant des mots-clés et en reformulant les phrases de l'utilisateur : « You are very helpful » devient « What makes you think I am very helpful? ». Il n'y a aucune compréhension, seulement du filtrage de motifs. Pourtant, Weizenbaum est stupéfait : sa propre secrétaire lui demande de la laisser seule avec le programme pour une « vraie conversation » [5]. On parle depuis d'**effet ELIZA** : notre tendance à attribuer de la compréhension à un programme qui sait seulement bien imiter la conversation [5].

> **À retenir.** L'effet ELIZA est toujours d'actualité. Un modèle de langage moderne est incomparablement plus puissant qu'ELIZA, mais un texte fluide et assuré ne prouve pas que son contenu soit vrai. Fluidité et exactitude sont deux choses différentes.

## 3. Hivers de l'IA et systèmes experts (1966-1992)

### 3.1 Le premier hiver (1974-1980)

Un « **hiver de l'IA** » est une période où les financements et l'intérêt s'effondrent après des promesses non tenues. Le premier, environ de 1974 à 1980, a plusieurs causes datées [6] :

- 1966 : le rapport ALPAC conclut, selon la source, que la traduction automatique est plus chère, moins précise et plus lente que la traduction humaine ;
- 1969 : le livre *Perceptrons* de Marvin Minsky et Seymour Papert souligne les limites des perceptrons à une couche (il ne sait pas apprendre la fonction logique « ou exclusif ») ; la source précise toutefois que les auteurs savaient que des réseaux à plusieurs couches pouvaient la résoudre, nuance souvent perdue [4] ;
- 1973 : le rapport Lighthill, commandé en 1972 par le Science Research Council britannique, juge que « in no part of the field have the discoveries made so far produced the major impact that was then promised » ; il sert de base à la décision du gouvernement britannique de cesser de soutenir la recherche en IA dans la plupart des universités [7] ;
- 1974 : la DARPA (agence américaine de recherche militaire) annule un contrat de reconnaissance de la parole de 3 millions de dollars par an, après la déception causée par un système de l'université Carnegie Mellon [6].

La cause de fond, citée par le rapport Lighthill, est l'**explosion combinatoire** : un programme qui fonctionne sur un exemple de laboratoire devient inutilisable quand le problème grandit, parce que le nombre de cas à explorer croît trop vite [7].

### 3.2 Les systèmes experts (années 1970-1980)

La renaissance vient d'une autre idée : plutôt que de viser une intelligence générale, capturer **le savoir d'un spécialiste** dans un programme. Un **système expert** comporte deux parties : une **base de connaissances** (des faits et des règles du type « si ... alors ... ») et un **moteur d'inférence** qui applique ces règles pour déduire de nouveaux faits. Les premiers exemples médicaux, comme MYCIN, viennent du projet de programmation heuristique de Stanford dirigé par Edward Feigenbaum [8].

Analogie : c'est un arbre de décision géant, rédigé avec un médecin, un ingénieur ou un juriste. Dans les années 1980, la technologie se diffuse : « two-thirds of the Fortune 500 companies » l'appliquent dans leurs activités quotidiennes [8], et le Japon lance son projet d'ordinateurs de cinquième génération (budget cité : 850 millions de dollars, début en 1981 selon cette source ; d'autres sources donnent 1982) [6].

### 3.3 Le second hiver (à partir de 1987)

Les systèmes experts butent sur des obstacles que les ingénieurs en logiciel reconnaîtront immédiatement :

- le **goulot d'acquisition des connaissances** : obtenir et formaliser le temps des experts coûte cher [8] ;
- la **fragilité** (*brittleness*) : hors de leur domaine étroit, les règles échouent brutalement [6] ;
- la **maintenance** : mettre à jour des milliers de règles interdépendantes est lent et coûteux [8].

En 1987, le marché des machines spécialisées Lisp (des ordinateurs conçus pour ces programmes) s'effondre, face à des stations de travail généralistes meilleures et moins chères : « an entire industry worth half a billion dollars » disparaît en un an. Le projet japonais s'achève en 1992 sans avoir atteint ses objectifs [6]. Un constat nuancé de la littérature : certains y voient un échec, d'autres des victimes de leur propre succès, car l'idée de règles métier a été absorbée par les logiciels d'entreprise ordinaires [8].

> **À retenir.** Les systèmes experts échouent par ce que nous appellerions aujourd'hui de la **dette de maintenance** : un savoir figé dans des règles écrites à la main devient impossible à faire évoluer. L'IA moderne contourne ce problème en apprenant à partir de données, au prix d'autres difficultés (section 11).

## 4. Apprendre plutôt que programmer (1986-2011)

### 4.1 Le changement de philosophie

Au lieu d'écrire les règles, on montre au programme des milliers d'exemples (« cette image est un chat, celle-ci n'en est pas un ») et on le laisse ajuster ses paramètres pour se tromper de moins en moins. C'est l'**apprentissage automatique**. Les **réseaux de neurones artificiels** en sont une variante : des empilements de « couches » de petites unités de calcul, chaque unité combinant des nombres reçus de la couche précédente.

Le problème technique de ce genre de réseau est de savoir **comment corriger les réglages de toutes les couches** quand la sortie est fausse. La réponse est la **rétropropagation du gradient** (en anglais *backpropagation*) : on mesure l'erreur en sortie, puis on la fait « remonter » couche par couche pour savoir quel réglage ajuster et de combien. Les bases mathématiques sont anciennes (travaux de Linnainmaa en 1970 et de Werbos en 1974), mais l'article de David Rumelhart, Geoffrey Hinton et Ronald Williams paru dans *Nature* en 1986 a popularisé la méthode dans la communauté [9].

### 4.2 Une parenthèse : Deep Blue (1997)

En mai 1997, l'ordinateur Deep Blue d'IBM bat le champion du monde d'échecs Garry Kasparov 3½ à 2½, après avoir perdu 4 à 2 un premier match en 1996 ; il évalue environ 200 millions de positions par seconde [10]. C'est un symbole fort, mais ce n'est **pas** de l'apprentissage : c'est une exploration très rapide et très bien réglée des coups possibles. À noter, pour ne pas tout mélanger : l'IA du XXe siècle est souvent de la recherche et des règles, celle du XXIe est surtout de l'apprentissage.

*Explication, non sourcée ici :* entre 1990 et 2011, l'apprentissage automatique « classique » (méthodes statistiques sur des caractéristiques choisies par des humains) s'impose dans le filtrage du courrier indésirable, la recommandation ou la traduction. Nous n'avons pas de jalon daté vérifié pour cette période et nous ne citons donc pas d'événement précis.

## 5. L'apprentissage profond (2012-2016)

L'**apprentissage profond** (*deep learning*) désigne des réseaux de neurones à **de nombreuses couches**. Il a fallu trois ingrédients réunis : des algorithmes (la rétropropagation), des **données** en masse et de la **puissance de calcul** (les processeurs graphiques, les GPU, conçus pour le jeu vidéo et très efficaces pour ces calculs).

### 5.1 ImageNet et AlexNet (2012)

**ImageNet** est une base de plus de 14 millions d'images annotées à la main, classées en plus de 20 000 catégories. Le projet est lancé par Fei-Fei Li en 2006 et présenté pour la première fois en 2009 [11]. Un concours annuel y mesure la capacité des programmes à reconnaître le contenu des images. En 2012, le réseau **AlexNet** (Alex Krizhevsky, Ilya Sutskever, Geoffrey Hinton) obtient 15,3 % d'erreur sur les cinq meilleures réponses, soit plus de 10 points de moins que le deuxième [11]. L'article décrit un réseau de 60 millions de paramètres et 500 000 neurones, entraîné grâce à « a very efficient GPU implementation » [12]. Selon *The Economist*, cité par la même source, « suddenly people started to pay attention, not just within the AI community but across the technology industry as a whole » [11]. 2012 est donc généralement retenue comme le début de la révolution de l'apprentissage profond.

### 5.2 AlphaGo (2016) et la reconnaissance du domaine

Du 9 au 15 mars 2016, à Séoul, le programme AlphaGo de Google DeepMind bat le champion Lee Sedol au jeu de go par 4 victoires à 1. Les experts jugeaient la machine encore à des années d'un tel résultat [13]. Pour les non-initiés : le go a tellement de positions possibles que l'exploration exhaustive de Deep Blue y est impossible, il faut de l'apprentissage.

La communauté scientifique en tire les conséquences : l'Association for Computing Machinery décerne le 27 mars 2019 le prix Turing 2018 à Yoshua Bengio, Geoffrey Hinton et Yann LeCun pour leurs avancées sur les réseaux de neurones profonds [14]. Le prix Nobel de physique 2024 est attribué à John Hopfield et Geoffrey Hinton « for foundational discoveries and inventions that enable machine learning with artificial neural networks » [15].

## 6. Le transformer : l'architecture qui change tout (2014-2017)

Pour traiter du texte, il faut un réseau capable de tenir compte de l'ordre des mots et de leurs relations à distance (« il » renvoie à quel nom, vingt mots plus tôt ?). Deux étapes marquent cette période :

- **L'attention (2014).** Dzmitry Bahdanau, Kyunghyun Cho et Yoshua Bengio proposent que le modèle puisse « (soft-)search for parts of a source sentence that are relevant to predicting a target word », c'est-à-dire se concentrer sur les parties pertinentes de la phrase à chaque étape [16]. Image : au lieu de lire un texte en mémorisant tout, on garde le texte sous les yeux et on surligne ce qui compte pour répondre.
- **Le transformer (2017).** Le 12 juin 2017, huit chercheurs (Vaswani, Shazeer, Parmar, Uszkoreit, Jones, Gomez, Kaiser, Polosukhin) publient « Attention Is All You Need », qui remplace les architectures précédentes par un empilement de mécanismes d'attention. Le modèle atteint 28,4 points de BLEU (une mesure de qualité de traduction) en anglais-allemand et 41,8 en anglais-français après 3,5 jours d'entraînement sur huit GPU, tout en étant « more parallelizable and requiring significantly less time to train » [18].

Le mot clé est **parallélisable** : on peut répartir le calcul sur de très nombreux processeurs. C'est ce qui a rendu possible l'entraînement sur des quantités de texte inimaginables jusque-là.

## 7. GPT et le passage à l'échelle (2018-2020)

Un **modèle de langage** est un programme qui, à partir d'un début de texte, estime quel texte vient après (section 9). L'idée de la série **GPT** (*Generative Pre-trained Transformer*, « transformer génératif pré-entraîné ») d'OpenAI est de **pré-entraîner** un transformer sur une énorme masse de texte, puis de l'utiliser pour de nombreuses tâches. Les jalons [19][21] :

| Date | Modèle | Taille (paramètres) |
|---|---|---|
| 11 juin 2018 | GPT-1 | 117 millions |
| 14 février 2019 | GPT-2 | 1,5 milliard |
| mai 2020 | GPT-3 | 175 milliards |

Octobre 2018 voit aussi paraître BERT, un modèle de Google, selon la même source [19]. Deux résultats de 2020 expliquent la course à la taille :

- **Les lois d'échelle.** Jared Kaplan et ses collègues (janvier 2020) montrent que la performance suit des lois de puissance régulières : « the loss scales as a power-law with model size, dataset size, and the amount of compute used for training, with some trends spanning more than seven orders of magnitude » [20]. Traduction : plus on grossit le modèle, les données et le calcul, plus l'erreur baisse, de façon prévisible. D'où la course.
- **L'apprentissage « few-shot ».** L'article sur GPT-3 (Brown et coll., mai 2020, 31 auteurs) montre que passer à l'échelle améliore fortement les performances « few-shot » : on explique la tâche dans le texte (« voici deux exemples, fais pareil ») sans réentraîner le modèle [21].

## 8. Du modèle brut au compagnon de conversation : RLHF et ChatGPT (2022)

Un modèle de langage brut prolonge un texte ; il ne cherche pas à vous aider. Demandez-lui une question, il peut continuer par d'autres questions, car c'est ce qui ressemble le plus à son corpus. Il faut donc le **réaligner** sur ce que veulent les utilisateurs.

La méthode décrite par OpenAI en mars 2022 (article « Training language models to follow instructions with human feedback », soumis le 4 mars 2022) est le **RLHF** (*Reinforcement Learning from Human Feedback*, apprentissage par renforcement avec retour humain). Les étapes : des humains rédigent des exemples de bonnes réponses ; on affine le modèle dessus ; puis des humains **classent** plusieurs réponses du modèle de la meilleure à la moins bonne ; ces classements servent à « récompenser » le modèle quand il produit des réponses préférées (c'est l'apprentissage par renforcement). Résultat annoncé : un modèle « InstructGPT » de 1,3 milliard de paramètres est préféré par les évaluateurs humains à GPT-3 (175 milliards), « despite having 100x fewer parameters », avec des gains de véracité et moins de contenus toxiques [22].

Le **30 novembre 2022**, OpenAI lance **ChatGPT**, un « modèle frère » d'InstructGPT entraîné de la même façon, avec une interface de dialogue gratuite (d'après l'annonce d'OpenAI, que nous n'avons pu consulter qu'indirectement : non vérifié à la source) [23]. L'annonce elle-même énumère déjà des limites : ChatGPT « sometimes writes plausible-sounding but incorrect or nonsensical answers », et OpenAI explique que corriger ce défaut est difficile car, pendant l'apprentissage par renforcement, il n'existe pas de « source de vérité » (même source, relayée par recoupement) [23]. L'adoption est fulgurante : selon une note d'analystes de la banque UBS rapportée par Reuters, ChatGPT atteint 100 millions d'utilisateurs actifs mensuels en janvier 2023, soit deux mois après son lancement, « the fastest-growing consumer application in history » selon la presse, alors que TikTok avait mis environ neuf mois et Instagram deux ans et demi [24]. Ce chiffre est une estimation d'analystes, non une donnée publiée par OpenAI.

Le 14 mars 2023, GPT-4 est présenté : il accepte des images en plus du texte ; OpenAI n'a pas publié sa taille ni son architecture, invoquant « the competitive landscape and the safety implications » [25].

> **À retenir.** Ce qui a changé fin 2022 n'est pas tant la technique de base (le transformer date de 2017) que l'**alignement** (RLHF) et l'**interface** : pour la première fois, n'importe qui peut converser avec un modèle puissant sans compétence technique.

## 9. Comment fonctionne un modèle de langage

Cette section est la plus utile pour votre pratique. Nous restons volontairement simples.

### 9.1 Les tokens : le texte découpé en morceaux

Un modèle ne lit pas des lettres ni exactement des mots : il lit des **tokens** (« jetons »), des morceaux de texte fréquents, parfois un mot entier, parfois une syllabe ou un signe de ponctuation. Le découpage s'appuie sur une technique de compression, l'encodage par paires d'octets (*byte pair encoding*), transposée au langage par Rico Sennrich et ses collègues en 2015 pour représenter les mots rares comme des suites de morceaux plus courts [17]. Analogie : un jeu de lettres de Scrabble dont les tuiles seraient des syllabes courantes plutôt que des lettres isolées.

Ordre de grandeur donné par la documentation d'Anthropic : avec son découpeur actuel, un million de tokens correspond à environ 555 000 mots, et avec les générations précédentes à environ 750 000 mots [37]. Un token vaut donc de l'ordre d'un demi-mot à trois quarts de mot, selon le modèle. Pour le français, qui est en général découpé en davantage de tokens que l'anglais, nous n'avons pas de chiffre sourcé : testez avec l'outil de comptage de votre fournisseur (non vérifié).

Pourquoi le token compte pour vous : **c'est l'unité de facturation, de vitesse et de mémoire** (sections 9.3 et 11.5).

### 9.2 Prédire le token suivant

Le cœur du modèle est une fonction qui, pour une suite de tokens, calcule **une probabilité pour chaque token possible comme suite**. Il en choisit un, l'ajoute au texte, puis recommence. Une réponse de dix lignes est donc le résultat de plusieurs centaines de petites prédictions successives.

Pour sentir le principe, voici un modèle de jouet : il compte, dans un mini-corpus, quel mot suit quel mot. Un vrai modèle fait la même chose avec un réseau de neurones de milliards de paramètres et des milliers de mots de contexte, au lieu d'un simple comptage.

```dart
import 'dart:math';

/// Mini « modèle de langage » : il compte, dans un petit corpus,
/// quel mot suit quel mot, puis prédit le mot suivant.
void main() {
  const corpus = 'le chat dort le chat mange le chien dort le chat dort';
  final mots = corpus.split(' ');

  // Entraînement : compter les paires (mot, mot suivant).
  final compteurs = <String, Map<String, int>>{};
  for (var i = 0; i < mots.length - 1; i++) {
    final suivants = compteurs.putIfAbsent(mots[i], () => <String, int>{});
    suivants[mots[i + 1]] = (suivants[mots[i + 1]] ?? 0) + 1;
  }

  // Inférence : après « chat », quelles probabilités ?
  final apresChat = compteurs['chat']!;
  final total = apresChat.values.reduce((a, b) => a + b);
  apresChat.forEach((mot, n) {
    print('après « chat » : $mot ${(100 * n / total).round()} %');
  });

  // Température : on réécrit les probabilités p en p^(1/T), puis on normalise.
  String tirer(Map<String, int> suivants, double temperature, Random hasard) {
    final poids = suivants.map(
      (mot, n) => MapEntry(mot, pow(n.toDouble(), 1 / temperature).toDouble()),
    );
    final somme = poids.values.reduce((a, b) => a + b);
    var seuil = hasard.nextDouble() * somme;
    for (final e in poids.entries) {
      seuil -= e.value;
      if (seuil <= 0) return e.key;
    }
    return poids.keys.last;
  }

  for (final t in [0.1, 1.0, 5.0]) {
    final hasard = Random(7);
    final tirages = [
      for (var i = 0; i < 1000; i++) tirer(apresChat, t, hasard),
    ];
    final dort = tirages.where((m) => m == 'dort').length;
    print('température $t : « dort » tiré $dort fois sur 1000');
  }
}
```

Lecture de ce code, ligne à ligne pour un non-développeur :

- `corpus.split(' ')` découpe la phrase en mots ; la boucle `for` parcourt chaque paire de mots voisins et incrémente un compteur (c'est l'**entraînement**) ;
- ensuite, on regarde les mots qui suivent « chat » : « dort » deux fois, « mange » une fois, soit 67 % et 33 % (c'est l'**inférence**, l'usage du modèle entraîné) ;
- la fonction `tirer` choisit au hasard un mot suivant en respectant ces probabilités, modulées par la **température** (section 9.5).

Ce programme a été exécuté avec Dart 3.13.5 (la version fournie avec le SDK Flutter de la machine de rédaction, le 6 octobre 2026) ; il affiche :

```text
après « chat » : dort 67 %
après « chat » : mange 33 %
température 0.1 : « dort » tiré 999 fois sur 1000
température 1.0 : « dort » tiré 669 fois sur 1000
température 5.0 : « dort » tiré 554 fois sur 1000
```

Vous pouvez le relancer : enregistrez-le sous `predire.dart` et lancez `dart run predire.dart`. Le graine du générateur aléatoire étant fixée (`Random(7)`), vous obtiendrez les mêmes nombres.

### 9.3 La fenêtre de contexte : la mémoire de travail

La **fenêtre de contexte** est tout le texte que le modèle peut « avoir sous les yeux » pour produire sa réponse. La documentation d'Anthropic la décrit comme une « working memory » (mémoire de travail) qui comprend l'invite système, tous les messages, les résultats d'outils, les définitions d'outils et la réponse en cours de rédaction, y compris le raisonnement [38]. Ce n'est **pas** le corpus d'entraînement : c'est ce que vous lui montrez maintenant. Le modèle n'a pas de souvenir entre deux conversations, sauf si l'outil lui remet des notes (c'est le rôle du fichier `CLAUDE.md` vu en séance) [36].

Deux conséquences pratiques :

1. **Le contexte se remplit.** À chaque tour, le modèle reçoit tout l'historique de la conversation plus le nouveau message [38]. Plus la session dure, plus chaque échange est long et coûteux.
2. **Plus de contexte n'est pas mieux.** La documentation parle de *context rot* : « as token count grows, accuracy and recall degrade » (quand le nombre de tokens augmente, la précision et le rappel se dégradent) [38]. Une étude de référence (« Lost in the Middle », Liu et coll., soumise en juillet 2023, publiée dans *Transactions of the ACL*) montre que les modèles retrouvent le mieux l'information placée au début ou à la fin d'un long texte, et moins bien celle du milieu [41].

Au 6 octobre 2026, les modèles principaux d'Anthropic ont une fenêtre de 1 million de tokens (200 000 pour le plus petit) [37]. Cette taille est un plafond, pas une recommandation d'usage.

### 9.4 Entraînement et inférence : deux moments très différents

| | Entraînement | Inférence |
|---|---|---|
| Quand ? | Une fois, avant la mise à disposition (puis lors des mises à jour) | À chaque question, en continu |
| Quoi ? | Le modèle ajuste ses paramètres sur d'énormes corpus de texte | Les paramètres sont figés ; le modèle calcule une réponse |
| Où ? | Chez l'éditeur, sur de très grands parcs de GPU | Chez l'éditeur (cloud) ou, pour de petits modèles, sur votre machine |
| Coût | Très élevé, supporté par l'éditeur | Facturé à l'usage (par token) |
| Effet | Fixe ce que le modèle « sait » et sa date de connaissance | N'apprend rien de durable : tout ce que vous lui dites disparaît avec le contexte |

Conséquence importante : **le modèle n'apprend pas de votre conversation**. Il sait ce qu'il sait au moment où son entraînement s'est arrêté (sa « date de connaissance », au sens de la date jusqu'à laquelle ses connaissances sont les plus étendues et fiables : juin 2026 pour les derniers modèles d'Anthropic, février 2025 pour le plus petit, selon la documentation [37]) ; tout le reste doit lui être fourni dans le contexte, ou obtenu par un outil de recherche. Les étapes de l'entraînement se superposent : *pré-entraînement* sur un corpus massif (prédire le token suivant), puis *affinage* sur des exemples choisis, puis *alignement* par retour humain (RLHF, section 8) [22].

Sur le coût d'entraînement : Sam Altman a déclaré que l'entraînement de GPT-4 avait coûté « more than $100 million » (déclaration rapportée par une source secondaire, non vérifiée à la source) [25]. Les éditeurs ne publient pas de chiffres comparables pour les modèles récents : nous ne citons donc aucun coût d'entraînement pour 2026.

### 9.5 La température : doser le hasard

À chaque pas, le modèle a une distribution de probabilités. Le choix du token peut être :

- **le plus probable** à chaque fois (réponse presque toujours identique, parfois répétitive) ;
- **tiré au hasard** selon les probabilités (réponses variées, parfois surprenantes).

La **température** est le réglage qui fait varier ce comportement. Température basse : on s'en tient presque toujours au token le plus probable. Température haute : les options peu probables ont plus de chances. Notre programme le montre : à température 0,1, « dort » sort 999 fois sur 1 000 ; à 5, seulement 554 fois, car la distribution s'aplatit (section 9.2).

Nuance importante à jour au 6 octobre 2026 : sur l'API d'Anthropic, ce paramètre est désormais marqué obsolète. Les modèles publiés après Claude Opus 4.6 n'acceptent plus de régler la température : seule la valeur 1,0 est tolérée, par compatibilité [39]. Les éditeurs déplacent donc le réglage de la variabilité vers d'autres commandes (niveau d'effort, section 10). Retenez le principe plutôt que le bouton.

## 10. Raisonnement, outils et agents (2022-2026)

### 10.1 Faire « réfléchir » le modèle

En janvier 2022, Jason Wei et ses collègues montrent qu'il suffit d'inviter un modèle à produire des **étapes intermédiaires de raisonnement** (une « chaîne de pensée », *chain of thought*) pour améliorer nettement ses résultats : avec huit exemples de ce type, un modèle de 540 milliards de paramètres dépasse l'état de l'art sur un banc d'essai de problèmes de mathématiques niveau école (GSM8K) [26]. Analogie : poser le calcul sur papier plutôt que de donner le résultat de tête.

Les éditeurs en font ensuite une fonction native. Le 12 septembre 2024, OpenAI présente o1-preview (version complète le 5 décembre 2024), un modèle entraîné par apprentissage par renforcement à « penser » avant de répondre, dont la performance s'améliore avec le temps de réflexion alloué [27]. En janvier 2025, DeepSeek publie R1 : son article affirme que « reasoning abilities of LLMs can be incentivized through pure reinforcement learning (RL), obviating the need for human-labeled reasoning trajectories » [28]. Anthropic suit : Claude 3.7 Sonnet (24 février 2025) propose soit des réponses immédiates, soit une réflexion « étendue » rendue visible, avec un budget de réflexion réglable [34].

Aujourd'hui, on parle de **modèles de raisonnement** et de **niveau d'effort** : plus on laisse le modèle réfléchir, plus la réponse est souvent bonne, mais plus elle est lente et coûteuse en tokens (les tokens de réflexion sont facturés comme du texte produit) [38]. Les modèles récents d'Anthropic décident eux-mêmes combien réfléchir (« adaptive thinking »), guidés par un réglage d'effort dont la valeur par défaut est « high » ou « medium » selon le modèle [37].

### 10.2 Donner des outils au modèle

Un modèle seul ne fait que produire du texte. Pour qu'il agisse, on lui décrit des **outils** (rechercher sur le web, lire un fichier, lancer une commande) et il peut répondre non par du texte mais par une **demande d'appel d'outil**, que le logiciel qui l'entoure exécute avant de lui rendre le résultat. Les jalons :

- **ReAct** (6 octobre 2022, Yao et coll.) alterne « raisonnements » et « actions » (par exemple des requêtes à Wikipédia) ; les auteurs rapportent 34 points de succès absolus de mieux que les références sur un banc d'essai de tâches interactives (ALFWorld) [29] ;
- **Toolformer** (9 février 2023, Schick et coll.) montre qu'un modèle peut apprendre seul quand appeler une calculatrice, un moteur de recherche ou un calendrier [30] ;
- **Appel de fonctions** : OpenAI l'introduit dans son API le 13 juin 2023 (les modèles décrivent l'appel sous forme d'objet JSON, un format de données structuré) [31] ;
- **MCP** (*Model Context Protocol*) : Anthropic publie le 25 novembre 2024 « a new standard for connecting AI assistants to the systems where data lives » [32], un standard ouvert pour brancher des outils aux assistants sans refaire un branchement sur mesure à chaque fois.

Le fonctionnement actuel, tel que décrit par la documentation d'Anthropic : le modèle « determines when to call a tool based on the user's request and the tool's description » ; il renvoie un appel structuré que votre application exécute, puis le résultat est renvoyé au modèle qui formule sa réponse [40]. **Le modèle ne fait jamais rien lui-même : c'est le logiciel autour qui agit.** Cette séparation est ce qui permet de poser des garde-fous.

### 10.3 Les agents (2024-2026)

Le 19 décembre 2024, Anthropic publie « Building effective agents ». Il y distingue :

- les **workflows**, « systems where LLMs and tools are orchestrated through predefined code paths » (le chemin est fixé à l'avance par un programme) ;
- les **agents**, « systems where LLMs dynamically direct their own processes and tool usage » (le modèle décide lui-même de la suite) ; autrement dit, des « LLMs using tools based on environmental feedback in a loop » [33].

Le même texte recommande de commencer simple : les agents « trade off latency and cost for better task performance » (ils échangent latence et coût contre de meilleurs résultats) et ne se justifient que pour les problèmes ouverts, où l'on ne peut pas figer les étapes [33].

Du côté des produits pour développeurs, la chronologie récente est la suivante :

- **24 février 2025** : Anthropic présente Claude Code comme « limited research preview », un assistant en ligne de commande qui peut « search and read code, edit files, write and run tests, commit and push code to GitHub, and use command line tools » [34] ;
- **22 mai 2025** : Claude Code devient généralement disponible, avec des intégrations VS Code et JetBrains [35] ;
- les pratiques se nomment à mesure qu'elles apparaissent. Selon les dossiers de sources du cours (non recoupés indépendamment pour ce chapitre) : « vibe coding » proposé par Andrej Karpathy en février 2025, « augmented coding » par Kent Beck le 25 juin 2025, « vibe engineering » par Simon Willison le 7 octobre 2025 puis rebaptisé « agentic engineering » le 23 février 2026 [45]. Willison définit ce dernier comme la construction de logiciel avec des agents de code, « where the defining feature is that they can both generate and execute code », ce qui leur permet de tester et d'itérer seuls [45]. Ces termes sont des étiquettes de praticiens, pas des standards ;
- le terme de **harnais** (*harness*) pour désigner tout ce qui entoure le modèle apparaît début 2026 d'après les notes du conférencier (Lopopolo, OpenAI, 11 février 2026 ; Böckeler, Thoughtworks, 2 avril 2026) [45] ; la documentation de Claude Code l'emploie aussi : « Claude Code is the layer around the model that provides the tools and manages the context the model sees. This surrounding layer is what the term agentic harness refers to » [36].

> **À retenir.** La chronologie de l'IA générative tient en quatre étapes cumulatives : **prédire** (2017-2020), **converser** (2022), **raisonner et utiliser des outils** (2022-2025), **agir en boucle** (2024-2026). Chaque étape s'appuie sur la précédente.

## 11. Les limites structurelles des modèles de langage

Ces cinq limites découlent du fonctionnement décrit en section 9. Les connaître, c'est savoir pourquoi les pratiques du cours (tests, relecture, contexte court, règle d'or) existent.

### 11.1 Les hallucinations

Une **hallucination** est un contenu généré qui est faux ou sans fondement, présenté avec aplomb. Le terme est employé dans la littérature de traitement du langage depuis bien avant ChatGPT : une synthèse de Ziwei Ji et coll. (soumise en février 2022) décrit la génération de texte profonde comme « prone to hallucinate unintended text » [42]. La cause est dans le principe même : le modèle produit le texte **le plus plausible**, pas le texte **vérifié**. Si une réponse plausible est fausse, il n'a pas de mécanisme intrinsèque pour s'en apercevoir. OpenAI le disait dès l'annonce de ChatGPT (section 8) [23].

Exemple réel : dans l'affaire *Mata v. Avianca* (tribunal fédéral de New York), des avocats ont déposé un mémoire citant des décisions de justice **inventées** par ChatGPT ; interrogé ensuite, l'outil a affirmé qu'on pouvait les retrouver dans les bases juridiques LexisNexis et Westlaw. Le juge P. Kevin Castel les a sanctionnés le 22 juin 2023 d'une amende de 5 000 dollars [43].

*Que faire :* ne jamais publier un fait, une citation ou une référence issus d'un modèle sans le vérifier à la source ; donner au modèle des outils de vérification (tests, recherche) plutôt que de lui demander de « bien faire attention ».

### 11.2 Le non-déterminisme

Parce que le choix du token est en partie aléatoire (section 9.5), **deux demandes identiques peuvent donner deux réponses différentes**. Même avec une température basse, on ne doit pas supposer que le résultat est identique d'une exécution à l'autre ; et depuis 2026, certains éditeurs ne laissent plus régler ce paramètre [39]. Pour un ingénieur, c'est un changement de culture : un test unitaire classique donne toujours le même verdict, la sortie d'un modèle non. D'où l'importance de **vérifier le résultat** (tests automatisés sur le code produit) plutôt que de supposer la reproductibilité du processus.

### 11.3 Les biais

Un modèle apprend des textes qu'on lui donne et en reflète les déséquilibres. Exemple documenté, sur un système d'apprentissage automatique antérieur aux modèles de langage : selon Reuters (octobre 2018), Amazon a abandonné un outil expérimental de tri de candidatures, entraîné sur dix ans de CV majoritairement masculins, qui pénalisait les CV contenant le mot « women's » [44]. Le mécanisme est le même pour les modèles de langage : ce qui est sur-représenté dans les données est sur-représenté dans les sorties. L'alignement (RLHF) en réduit certains effets, mais introduit aussi les préférences de ses évaluateurs ; il n'élimine pas le problème. Un projet réel doit traiter cela dès la conception (le règlement européen sur l'IA est abordé en séance 4).

### 11.4 La dépendance au contexte

Le modèle ne sait que ce qu'il a appris à l'entraînement **et** ce qui est dans le contexte (section 9.3). Il en résulte :

- une **date limite** de connaissance : il ignore les événements ultérieurs, sauf recherche web ;
- une **performance qui dépend de ce qu'on lui montre** : un contexte incomplet, contradictoire ou trop long dégrade les réponses [38][41] ;
- une **absence de mémoire d'une session à l'autre**, d'où les fichiers d'instructions (`CLAUDE.md`, `AGENTS.md`) qui le « rappellent » à chaque démarrage [36].

Une étude empirique de 2 853 dépôts GitHub (préprint de février 2026) constate d'ailleurs que les fichiers de contexte dominent les configurations des outils d'agents et sont souvent le seul mécanisme utilisé [45]. Elle ne porte que sur des dépôts publics.

### 11.5 Le coût

Les modèles se facturent au **token**, séparément pour ce qui entre (la question et le contexte) et ce qui sort (la réponse, réflexion comprise). Tarifs publics d'Anthropic au 6 octobre 2026, par million de tokens (entrée / sortie) [37] :

| Modèle | Entrée | Sortie |
|---|---|---|
| Claude Haiku 4.5 | 1 $ | 5 $ |
| Claude Sonnet 5.5 | 2 $ | 10 $ |
| Claude Opus 5.5 | 4 $ | 20 $ |
| Claude Fable 5.1 | 10 $ | 50 $ |

Le rapport est donc de 1 à 10 entre le plus petit et le plus grand. Les relectures de contexte mises en cache coûtent beaucoup moins : 10 % du prix d'entrée de base pour Sonnet 5.5 (5 % pour Opus 5.5 et 2,5 % pour Fable 5.1) [37]. Les autres fournisseurs ont leurs propres tarifs, non vérifiés ici.

Exemple chiffré (hypothétique, pour comprendre le mécanisme) : un agent qui, en 30 étapes, relit à chaque étape un contexte moyen de 50 000 tokens consomme 30 x 50 000 = 1,5 million de tokens en entrée, car il renvoie tout l'historique à chaque tour [38]. Avec 100 000 tokens produits sur Sonnet 5.5, la facture théorique est de 1,5 x 2 + 0,1 x 10 = 4 dollars, sans cache. Avec un cache bien exploité, la partie répétée coûte nettement moins. D'où deux réflexes : des **sessions courtes** et un **fichier d'instructions court**.

Il y a aussi des coûts qui ne sont pas des dollars : temps de calcul, énergie, dépendance à un fournisseur. Nous n'avons pas de chiffres sourcés sur l'énergie par requête et ne les citons pas.

## 12. Qu'est-ce qu'un agent, précisément ?

### 12.1 Définition

Nous retiendrons la définition opérationnelle du cours : **un agent est une boucle qui combine quatre éléments**.

1. **Un modèle** qui raisonne et décide de la prochaine action.
2. **Des outils** : les actions possibles (lire un fichier, modifier du code, lancer les tests, chercher sur le web).
3. **Un environnement** : le monde sur lequel il agit (votre dépôt de code, votre terminal) et dont il reçoit des retours (résultat des tests, messages d'erreur).
4. **Des garde-fous** : les limites posées par les humains (permissions, bac à sable, nombre maximal d'étapes, validation humaine, tests automatiques).

Cette définition est cohérente avec celle d'Anthropic (des modèles qui utilisent des outils d'après les retours de l'environnement, dans une boucle [33]) et avec l'équation du cours : **agent = modèle + harnais**, où le harnais regroupe les outils, les règles, les permissions et les contrôles.

### 12.2 La boucle

La documentation de Claude Code décrit trois phases qui se mêlent : **rassembler du contexte**, **agir**, **vérifier les résultats**, répétées jusqu'à la fin de la tâche, l'utilisateur pouvant interrompre à tout moment. Pour « corrige les tests qui échouent », l'agent peut lancer les tests, lire l'erreur, chercher les fichiers concernés, les lire, les modifier, puis relancer les tests [36]. Chaque appel d'outil rapporte une information qui oriente l'étape suivante : c'est la boucle d'agent.

Pour la rendre concrète, voici un squelette d'agent en Dart. Le « modèle » y est **simulé** par une fonction qui suit un petit scénario (un vrai agent appellerait un modèle de langage à cet endroit). Les trois éléments qui comptent sont bien là : une boucle, des outils, des garde-fous.

```dart
/// Squelette d'une boucle d'agent. Le « modèle » est ici simulé par une
/// fonction qui suit un petit scénario : en vrai, ce serait un appel à un LLM.
typedef Action = ({String outil, String argument});

// L'environnement : ici, un seul fait, « le code est-il corrigé ? ».
var corrige = false;

// Les outils : ce que l'agent a le droit de faire dans son environnement.
final outils = <String, String Function(String)>{
  'lancer_tests': (_) => corrige
      ? '3 tests passés'
      : '2 tests passés, 1 échoué : estReussite(11, 12)',
  'modifier_fichier': (a) {
    corrige = true;
    return 'fichier $a modifié';
  },
};

// Garde-fou : une liste blanche d'outils autorisés.
bool autorise(Action a) => outils.containsKey(a.outil);

// Faux modèle : regarde l'historique et propose la prochaine action (ou null = fini).
Action? modeleSimule(List<String> historique) {
  if (historique.isEmpty) return (outil: 'lancer_tests', argument: '');
  if (historique.length == 1)
    return (outil: 'modifier_fichier', argument: 'jeu.dart');
  if (historique.length == 2) return (outil: 'lancer_tests', argument: '');
  return null;
}

void main() {
  final historique = <String>[]; // le « contexte » de l'agent
  const maxEtapes = 10; // garde-fou : on borne la boucle
  for (var etape = 1; etape <= maxEtapes; etape++) {
    final action = modeleSimule(historique); // 1. le modèle décide
    if (action == null) {
      print('Terminé en ${etape - 1} actions.');
      return;
    }
    if (!autorise(action)) {
      historique.add('refusé : ${action.outil}');
      continue;
    }
    final resultat = outils[action.outil]!(action.argument); // 2. l'outil agit
    historique.add(resultat); // 3. le résultat revient dans le contexte
    print('Étape $etape : ${action.outil} -> $resultat');
  }
  print('Arrêt : nombre maximal d\'étapes atteint.');
}
```

Exécuté avec Dart 3.13.5 (et analysé sans avertissement par `dart analyze`), il affiche :

```text
Étape 1 : lancer_tests -> 2 tests passés, 1 échoué : estReussite(11, 12)
Étape 2 : modifier_fichier -> fichier jeu.dart modifié
Étape 3 : lancer_tests -> 3 tests passés
Terminé en 3 actions.
```

Ce que montre l'exemple :

- l'agent **vérifie** son travail en relançant les tests (étape 3) : sans test, il n'a aucun moyen de savoir s'il a réussi. C'est la raison pour laquelle le TDD vu en séance est le meilleur ami d'un agent ;
- la **liste blanche** (`autorise`) et la **limite d'étapes** (`maxEtapes`) sont des garde-fous : même si le modèle dérape, la boucle l'empêche d'utiliser un outil non prévu ou de tourner sans fin ;
- l'historique est le **contexte** : il grossit à chaque étape (section 9.3).

### 12.3 Les garde-fous dans un vrai outil

Dans Claude Code, les garde-fous prennent la forme de modes de permission que l'on parcourt avec les touches Maj+Tab : *Auto* (un classificateur bloque les actions risquées), *Manual* (l'agent demande avant de modifier un fichier ou d'exécuter une commande), *Accept edits* et *Plan* (l'agent explore et propose un plan sans modifier le code). Les modifications de fichiers sont sauvegardées avant l'intervention (*checkpoints*) et peuvent être annulées, mais ces points de restauration ne couvrent pas les actions sur des systèmes distants (bases de données, API, déploiements) [36]. Le mode de démarrage par défaut dépend de la version et de l'offre : vérifiez-le sur la documentation officielle avant la séance 2.

### 12.4 Ce qu'un agent n'est pas

- Ce n'est pas un **programme qui comprend** vos intentions : il prédit des actions plausibles à partir du contexte.
- Ce n'est pas un **collègue responsable** : la responsabilité du résultat reste humaine. Le cours en fait une règle : vous devez pouvoir expliquer ce que vous livrez.
- Ce n'est pas **fiable par construction** : sa fiabilité vient du harnais (tests, relecture, permissions) bien plus que du modèle seul. C'est l'esprit de la formule de Simon Willison reprise en séance : les outils d'IA amplifient l'expertise existante, ils ne la remplacent pas [45].

## 13. Faits, consensus, opinions : lire l'actualité avec recul

Vous lirez beaucoup d'affirmations sur l'IA. Un tri simple :

| Type | Exemple dans ce chapitre | Comment le traiter |
|---|---|---|
| **Fait daté et vérifiable** | Le transformer est publié le 12 juin 2017 [18] ; ChatGPT est lancé le 30 novembre 2022 [23] | Citer avec sa source |
| **Mesure** | AlexNet : 15,3 % d'erreur en 2012 [11] ; 100 millions d'utilisateurs en deux mois (estimation UBS) [24] | Regarder qui mesure, comment, sur quoi |
| **Consensus de praticiens** | L'IA amplifie les pratiques existantes ; il faut un harnais (tests, contexte) | Utile, mais « difficile à falsifier » : rester critique |
| **Opinion** | « Les agents remplaceront les développeurs » ; « le code sera jetable » | Chercher la preuve, les conflits d'intérêts, l'horizon de temps |

Les dossiers de sources du cours rappellent un point de méthode : une grande part du contenu sur l'ingénierie agentique vient d'éditeurs d'outils (OpenAI, Anthropic, Cursor, etc.) et doit être distinguée des billets de praticiens indépendants et des études [45]. Le présent chapitre n'échappe pas à la règle : plusieurs sources techniques sont les pages de documentation de l'éditeur dont nous utilisons l'outil.

> **À retenir (synthèse du chapitre).**
> 1. L'IA moderne est le fruit de **sept décennies** : idées (1950), nom (1956), hivers (à partir de 1974 et de 1987), renouveau par les données et le calcul (2012), transformer (2017), alignement et grand public (2022), raisonnement, outils et agents (2022-2026).
> 2. Un modèle de langage **prédit le token suivant** dans une **fenêtre de contexte** limitée ; l'entraînement fixe ses connaissances, l'inférence les utilise ; la température dose le hasard.
> 3. Ses limites (hallucination, non-déterminisme, biais, dépendance au contexte, coût) sont **structurelles** : on les gère par des tests, de la relecture et un contexte soigné.
> 4. Un agent est **une boucle** modèle + outils + environnement + garde-fous. Sa qualité dépend autant du harnais que du modèle.

## Glossaire

- **Agent** : boucle logicielle où un modèle choisit des actions, les exécute par des outils et lit le résultat, jusqu'à la fin de la tâche.
- **Alignement** : ensemble de techniques pour que le modèle produise des réponses utiles et sûres plutôt que simplement plausibles.
- **Apprentissage automatique** (*machine learning*) : méthode où le programme déduit ses réglages à partir d'exemples plutôt que de règles écrites.
- **Apprentissage profond** (*deep learning*) : apprentissage avec des réseaux de neurones à nombreuses couches.
- **Attention** : mécanisme qui permet au modèle de se concentrer sur les parties pertinentes du texte à chaque étape.
- **Banc d'essai** (*benchmark*) : jeu de problèmes standardisé pour comparer des modèles.
- **Biais** : écart systématique reproduit par le modèle à partir des déséquilibres de ses données.
- **Chaîne de pensée** (*chain of thought*) : étapes intermédiaires de raisonnement écrites avant la réponse finale.
- **Contexte (fenêtre de)** : texte total que le modèle peut considérer pour une réponse, mesuré en tokens.
- **Context rot** : dégradation de la précision quand le contexte devient très long.
- **Effort (niveau d')** : réglage qui fixe combien le modèle réfléchit avant de répondre.
- **Garde-fou** : limite posée à un agent (permissions, liste d'outils autorisés, limite d'étapes, validation humaine, tests).
- **GPU** (processeur graphique) : processeur très efficace pour les calculs massivement parallèles de l'apprentissage.
- **Hallucination** : contenu généré faux ou sans fondement, présenté comme plausible.
- **Harnais** (*harness*) : tout ce qui entoure le modèle dans un agent (outils, règles, contexte, permissions, contrôles).
- **Hiver de l'IA** : période de recul des financements et de l'intérêt après des promesses non tenues.
- **Inférence** : utilisation d'un modèle déjà entraîné pour produire une réponse.
- **LLM** (grand modèle de langage) : modèle de langage de très grande taille.
- **MCP** (*Model Context Protocol*) : standard ouvert pour connecter des outils et des données à des assistants d'IA.
- **Paramètre** : réglage numérique interne à un modèle, ajusté à l'entraînement.
- **Perceptron** : premier réseau de neurones artificiel apprenant (Rosenblatt, 1958).
- **Pré-entraînement** : phase d'apprentissage sur un énorme corpus de texte, par prédiction du token suivant.
- **Rétropropagation** : méthode qui répartit l'erreur de sortie sur les réglages de chaque couche pour les corriger.
- **RLHF** : apprentissage par renforcement avec retour humain (les humains classent les réponses).
- **Système expert** : programme à base de règles « si... alors... » codant le savoir d'un spécialiste.
- **Température** : réglage du degré de hasard dans le choix du token suivant.
- **Token** : morceau de texte (mot, syllabe, ponctuation) qui sert d'unité au modèle, à la facturation et à la mémoire.
- **Transformer** : architecture de réseau de neurones fondée sur l'attention (2017), base des modèles de langage actuels.

## Pour aller plus loin

- Lisez l'article de Turing de 1950 (en anglais, accessible) [1] et la proposition de Dartmouth [2] : ils sont courts et étonnamment actuels.
- Lisez « Building effective agents » d'Anthropic [33] pour la distinction workflow / agent et les conseils de prudence.
- Parcourez la page « How Claude Code works » [36] avant la séance 2 : c'est la boucle d'agent, vue de l'intérieur.
- Modifiez le mini-modèle de la section 9.2 : ajoutez des phrases au corpus, changez la température, et observez comment les probabilités bougent. C'est la meilleure façon de sentir pourquoi la même question peut donner des réponses différentes.
- Pour l'esprit critique, relisez la section 13 avant de lire un article de presse sur l'IA : qui mesure, avec quel intérêt, sur quel contexte ?

## Points non vérifiés ou à surveiller

- Page d'annonce de ChatGPT : non consultable directement (accès refusé) ; la date du 30 novembre 2022 et les formulations citées sont recoupées par des sources secondaires [23].
- Page OpenAI sur l'appel de fonctions : consultée par recoupement de presse uniquement (13 juin 2023) [31].
- Prix Nobel 2024 et prix Turing 2018 : formulations issues de recoupements de presse et du communiqué ACM ; la page nobelprize.org n'était pas accessible [14][15].
- Coût d'entraînement de GPT-4 (« plus de 100 millions de dollars ») : déclaration relayée par Wikipédia, non vérifiée à la source [25].
- Début du projet japonais de cinquième génération : 1981 ou 1982 selon les sources [6].
- Durée du second hiver : la source [6] donne 1987 à 2000 pour la période d'ensemble ; nous ne fixons donc pas de date de fin (la fin du projet japonais, en 1992, est un repère, pas une borne).
- Paternité du terme « intelligence artificielle » (McCarthy) : non vérifiée ici ; seule la présence du terme dans la proposition de 1955 est établie [2].
- Jalons de 2025-2026 sur le vocabulaire (Karpathy, Beck, Willison, Lopopolo, Böckeler) : repris des dossiers de sources du cours, non recoupés [45].
- Statistiques de tokens en français, énergie par requête : pas de source, donc pas de chiffre.
- Noms de modèles, tarifs et fenêtres de contexte : exacts le 6 octobre 2026 pour Anthropic seulement ; à revérifier avant diffusion [37].
- Code Dart : exécuté et analysé (Dart 3.13.5) ; aucune dépendance externe.

## Sources

Consultées entre le 1er et le 6 octobre 2026, sauf indication contraire. Les pages Wikipédia sont des sources secondaires, utilisées pour les jalons largement documentés.

1. A. M. Turing, « Computing Machinery and Intelligence », *Mind* LIX (236), octobre 1950, p. 433-460. https://doi.org/10.1093/mind/LIX.236.433 (page éditeur : https://academic.oup.com/mind/article/LIX/236/433/986238)
2. J. McCarthy, M. L. Minsky, N. Rochester, C. E. Shannon, « A Proposal for the Dartmouth Summer Research Project on Artificial Intelligence », 31 août 1955. https://www-formal.stanford.edu/jmc/history/dartmouth/dartmouth.html
3. Wikipédia, « Histoire de l'intelligence artificielle ». https://fr.wikipedia.org/wiki/Histoire_de_l'intelligence_artificielle
4. Wikipedia, « Perceptron ». https://en.wikipedia.org/wiki/Perceptron
5. Wikipedia, « ELIZA ». https://en.wikipedia.org/wiki/ELIZA
6. Wikipedia, « AI winter ». https://en.wikipedia.org/wiki/AI_winter
7. Wikipedia, « Lighthill report ». https://en.wikipedia.org/wiki/Lighthill_report
8. Wikipedia, « Expert system ». https://en.wikipedia.org/wiki/Expert_system
9. Wikipedia, « Backpropagation ». https://en.wikipedia.org/wiki/Backpropagation
10. Wikipedia, « Deep Blue (chess computer) ». https://en.wikipedia.org/wiki/Deep_Blue_(chess_computer)
11. Wikipedia, « ImageNet ». https://en.wikipedia.org/wiki/ImageNet
12. A. Krizhevsky, I. Sutskever, G. Hinton, « ImageNet Classification with Deep Convolutional Neural Networks », NIPS 2012. https://papers.nips.cc/paper/2012/hash/c399862d3b9d6b76c8436e924a68c45b-Abstract.html
13. Wikipedia, « AlphaGo versus Lee Sedol ». https://en.wikipedia.org/wiki/AlphaGo_versus_Lee_Sedol
14. ACM, « Fathers of the Deep Learning Revolution Receive ACM A.M. Turing Award », 27 mars 2019. https://www.acm.org/media-center/2019/march/turing-award-2018
15. Comité Nobel, communiqué du prix Nobel de physique 2024. https://www.nobelprize.org/prizes/physics/2024/press-release/ (consulté par recoupement de presse)
16. D. Bahdanau, K. Cho, Y. Bengio, « Neural Machine Translation by Jointly Learning to Align and Translate », arXiv, 2014. https://arxiv.org/abs/1409.0473
17. R. Sennrich, B. Haddow, A. Birch, « Neural Machine Translation of Rare Words with Subword Units », arXiv, 31 août 2015. https://arxiv.org/abs/1508.07909
18. A. Vaswani et coll., « Attention Is All You Need », arXiv, 12 juin 2017. https://arxiv.org/abs/1706.03762
19. Wikipedia, « Generative pre-trained transformer ». https://en.wikipedia.org/wiki/Generative_pre-trained_transformer
20. J. Kaplan et coll., « Scaling Laws for Neural Language Models », arXiv, 23 janvier 2020. https://arxiv.org/abs/2001.08361
21. T. B. Brown et coll., « Language Models are Few-Shot Learners », arXiv, 28 mai 2020. https://arxiv.org/abs/2005.14165
22. L. Ouyang et coll., « Training language models to follow instructions with human feedback », arXiv, 4 mars 2022. https://arxiv.org/abs/2203.02155
23. OpenAI, « Introducing ChatGPT », 30 novembre 2022. https://openai.com/index/chatgpt/ (accès direct refusé ; recoupé par la presse)
24. Reuters / UBS, « ChatGPT sets record for fastest-growing user base », février 2023, par exemple https://business.inquirer.net/384799/chatgpt-sets-record-for-fastest-growing-user-base-analyst-note
25. Wikipedia, « GPT-4 ». https://en.wikipedia.org/wiki/GPT-4
26. J. Wei et coll., « Chain-of-Thought Prompting Elicits Reasoning in Large Language Models », arXiv, 28 janvier 2022. https://arxiv.org/abs/2201.11903
27. Wikipedia, « OpenAI o1 » ; OpenAI, « Learning to reason with LLMs ». https://en.wikipedia.org/wiki/OpenAI_o1 ; https://openai.com/index/learning-to-reason-with-llms/
28. DeepSeek-AI, « DeepSeek-R1: Incentivizing Reasoning Capability in LLMs via Reinforcement Learning », arXiv, 22 janvier 2025. https://arxiv.org/abs/2501.12948
29. S. Yao et coll., « ReAct: Synergizing Reasoning and Acting in Language Models », arXiv, 6 octobre 2022. https://arxiv.org/abs/2210.03629
30. T. Schick et coll., « Toolformer: Language Models Can Teach Themselves to Use Tools », arXiv, 9 février 2023. https://arxiv.org/abs/2302.04761
31. OpenAI, « Function calling and other API updates », 13 juin 2023. https://openai.com/index/function-calling-and-other-api-updates/ (recoupé par la presse)
32. Anthropic, « Introducing the Model Context Protocol », 25 novembre 2024. https://www.anthropic.com/news/model-context-protocol
33. Anthropic, « Building effective agents », 19 décembre 2024. https://www.anthropic.com/research/building-effective-agents
34. Anthropic, « Claude 3.7 Sonnet and Claude Code », 24 février 2025. https://www.anthropic.com/news/claude-3-7-sonnet
35. Anthropic, « Introducing Claude 4 », 22 mai 2025. https://www.anthropic.com/news/claude-4
36. Anthropic, documentation Claude Code, « How Claude Code works ». https://code.claude.com/docs/en/how-claude-code-works
37. Anthropic, « Models overview » (modèles, prix, fenêtres de contexte, dates de connaissance). https://platform.claude.com/docs/en/models/overview
38. Anthropic, « Context windows ». https://platform.claude.com/docs/en/build-with-claude/context-windows
39. Anthropic, référence de l'API Messages, paramètre `temperature`. https://platform.claude.com/docs/en/api/messages
40. Anthropic, « Tool use with Claude ». https://platform.claude.com/docs/en/agents-and-tools/tool-use/overview
41. N. F. Liu et coll., « Lost in the Middle: How Language Models Use Long Contexts », arXiv, 6 juillet 2023, *TACL*. https://arxiv.org/abs/2307.03172
42. Z. Ji et coll., « Survey of Hallucination in Natural Language Generation », arXiv, 8 février 2022. https://arxiv.org/abs/2202.03629
43. Wikipedia, « Mata v. Avianca, Inc. ». https://en.wikipedia.org/wiki/Mata_v._Avianca,_Inc.
44. Reuters, « Amazon scraps secret AI recruiting tool that showed bias against women », octobre 2018 (consulté via des reprises, par exemple https://www.arabnews.com/node/1385386).
45. Dossiers locaux du cours : `cours/sources/agentic-engineering.md`, `cours/presentations/day-1/notes.html` (notes du conférencier, blocs « Modèles » et « Agent »), `cours/presentations/day-1/index.html` ; synthèse de recherche `tasks/walsip7ao.output` (fichier temporaire de la session de rédaction, non conservé ; étude arXiv 2602.14690 sur 2 853 dépôts GitHub : https://arxiv.org/pdf/2602.14690).
