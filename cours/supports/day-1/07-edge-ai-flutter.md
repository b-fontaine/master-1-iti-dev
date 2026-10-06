# Chapitre 7 · EdgeAI et EdgeAI avec Flutter

*Supports de cours, séance 1 (« Comprendre et s'équiper »). Master ITI, Nantes Université, 2026-2027. État des informations techniques : 6 octobre 2026.*

> **Avertissement de fraîcheur.** Les noms d'outils, les versions et les modèles de ce domaine changent en quelques semaines. Chaque fait technique ci-dessous renvoie à une source numérotée entre crochets, par exemple [S3], listée en fin de chapitre. Quand un fait n'a pas pu être vérifié, il est signalé « non vérifié ». Avant toute décision de projet, relisez la documentation officielle citée.

## Ce que vous allez retenir

- L'**IA embarquée** (edge AI) consiste à exécuter un modèle d'IA directement sur l'appareil de l'utilisateur (téléphone, ordinateur, objet connecté) plutôt que sur un serveur distant. Le calcul d'une réponse s'appelle l'**inférence**.
- Quatre avantages sont mis en avant : latence, confidentialité, coût d'usage et fonctionnement hors ligne. Chacun est réel mais conditionnel : il faut le vérifier au cas par cas, et aucun ne dispense du RGPD.
- Quatre limites structurent tout choix : taille du modèle, mémoire, énergie, qualité des réponses. Un modèle local est plus petit, donc généralement moins capable qu'un grand modèle hébergé.
- La **quantification** (stocker les paramètres du modèle avec moins de précision) est la technique qui rend l'embarqué possible. Elle réduit fortement la mémoire, mais ses effets sur la vitesse, l'énergie et la qualité doivent être mesurés.
- Des **modèles ouverts** (Gemma, Qwen, Phi, etc.) peuvent être téléchargés et exécutés localement. Gemma 4, publié le 2 avril 2026, est sous licence Apache 2.0.
- L'écosystème est un empilement de couches : un moteur d'exécution (LiteRT, ONNX Runtime, Core ML), une couche d'orchestration pour les modèles de langage (LiteRT-LM, MediaPipe), des services système clés en main (ML Kit, Gemini Nano, Apple Foundation Models).
- Avec **Flutter**, la voie la plus complète aujourd'hui est le projet **Flutter Edge AI** (`flutter_edge_ai`, ex-`flutter_gemma`), un projet open source **communautaire**, pas un produit officiel de Google : Google lui-même classe le support Flutter de LiteRT-LM comme « communautaire ».
- Pour nos projets : on travaille sur des **jeux de données fictifs**, jamais de données personnelles, et on traite l'IA locale comme une brique à évaluer, pas comme une solution magique.

## 1. Qu'est-ce que l'IA embarquée ?

### 1.1 Définition et vocabulaire

Un **modèle d'IA** est un fichier volumineux contenant des millions ou des milliards de nombres, appelés **paramètres** (ou **poids**). Ces nombres ont été ajustés lors d'un long entraînement. Quand on pose une question à un assistant, un logiciel appelé **moteur d'inférence** lit ces paramètres et effectue les calculs qui produisent la réponse. **Inférence** désigne cette phase d'utilisation, par opposition à l'**entraînement**, qui est la phase de fabrication du modèle. L'analogie la plus parlante : l'entraînement, c'est écrire un livre de recettes ; l'inférence, c'est cuisiner une recette à la demande.

Deux architectures s'opposent :

1. **IA dans le cloud** : votre application envoie la question par Internet à un serveur puissant (chez un fournisseur), qui calcule et renvoie la réponse. Vos données quittent l'appareil. C'est le cas de la plupart des assistants grand public.
2. **IA embarquée (edge AI)** : le modèle est téléchargé une fois sur l'appareil, et l'inférence s'y déroule. *Edge* signifie « bord » : on calcule à la périphérie du réseau, au plus près de la personne qui utilise l'application, plutôt qu'au centre, dans les centres de données.

C'est exactement le schéma de la diapositive de séance : « dans le cloud, vos données partent ; sur votre poste, elles restent ». Ce chapitre approfondit ce que cette phrase promet, et ce qu'elle ne garantit pas.

> **À retenir.** L'IA embarquée n'est pas un autre type d'IA : c'est un autre **lieu d'exécution**. Le même type de modèle peut tourner dans le cloud ou sur l'appareil. Ce qui change, ce sont les compromis.

### 1.2 Un continuum, pas une opposition

Les sources officielles elles-mêmes présentent l'embarqué comme un choix de déploiement parmi d'autres. LiteRT, le moteur d'inférence de Google, est décrit comme un moteur « pour déployer des modèles de ML et d'IA générative sur des plateformes edge » [S1]. Le projet Flutter Edge AI propose même une brique « hybride » qui répartit les requêtes entre un modèle cloud (Gemini) et un modèle local (Gemma) selon des règles de routage [S10]. En pratique, beaucoup d'applications combineront les deux : le local pour ce qui est sensible, rapide ou hors ligne, le cloud pour les tâches qui exigent un grand modèle.

## 2. Pourquoi embarquer : les avantages

Les quatre avantages cités ci-dessous sont ceux que les éditeurs mettent en avant. Il faut les lire comme des **arguments de vendeur à vérifier**, pas comme des lois.

### 2.1 Latence

La **latence** est le délai entre la question et le début de la réponse. Une requête cloud traverse le réseau, attend son tour sur un serveur, puis revient. Le site Flutter Edge AI affirme que l'inférence locale « élimine les délais d'aller-retour serveur » [S9]. C'est logique pour le trajet réseau, mais le calcul lui-même peut être plus lent sur un téléphone que sur un serveur spécialisé : le bilan dépend du modèle, de l'appareil et de la connexion. **Aucun chiffre général ne peut être donné sans mesure sur l'appareil cible.** Les seuls chiffres de performance trouvés dans la documentation officielle de LiteRT-LM sont un tableau de mesures par appareil : pour Gemma 4 E2B (2 583 Mo) sur un Samsung S26 Ultra, la page annonce 557 jetons par seconde en phase de « prefill » (lecture de la question) sur processeur, contre 3 808 sur GPU ; en phase de génération (« decode »), 47 contre 52 jetons par seconde [S2]. Ces chiffres illustrent l'intérêt de l'accélération matérielle, surtout pour la lecture de la question, pas ce que vous obtiendrez sur votre propre appareil : les conditions précises du test (taille du contexte, version du logiciel) ne sont pas détaillées sur la page lue.

> **Un jeton (token)** est un morceau de mot, l'unité que les modèles de langage lisent et écrivent. Un mot courant français fait souvent un à deux jetons.

### 2.2 Confidentialité et RGPD

Quand l'inférence a lieu sur l'appareil, le texte saisi n'a pas besoin d'être envoyé à un tiers. La documentation d'Apple l'énonce ainsi pour Core ML : faire tourner un modèle strictement sur l'appareil « supprime tout besoin de connexion réseau, ce qui aide à garder les données de la personne privées et l'application réactive » (traduction libre de l'anglais) [S6]. Celle d'Android décrit Gemini Nano comme un modèle qui permet des expériences d'IA générative « sans connexion réseau ni envoi de données vers le cloud » (traduction libre) [S5].

Le **RGPD** (règlement européen sur la protection des données personnelles) pose notamment le principe de **minimisation** : les données collectées doivent être « adéquates, pertinentes et limitées à ce qui est nécessaire » au regard de la finalité [S12]. Une IA locale aide à respecter ce principe, puisque la donnée n'est pas collectée par vous. **Mais attention, trois nuances :**

1. **Local ne veut pas dire hors du champ du RGPD.** Si votre application traite des données personnelles sur l'appareil (par exemple le contenu des messages d'un client), des obligations demeurent (information des personnes, sécurité, durée de conservation, etc.). L'analyse juridique dépend du cas ; elle sort du cadre de ce chapitre, et la CNIL publie des recommandations sur l'IA [S12].
2. **Le téléchargement du modèle est un échange réseau.** Avec Flutter Edge AI, le modèle est téléchargé depuis une URL, par exemple Hugging Face (plateforme de partage de modèles), et certains modèles « à accès restreint » exigent un jeton d'accès personnel, que la documentation demande de ne jamais écrire en dur dans le code [S9].
3. **Le journal et le stockage restent à votre charge.** Un historique de conversation enregistré dans l'application est une donnée stockée sur l'appareil.

Le service système Gemini Nano (Android) illustre une approche encadrée : la documentation indique que son composant AICore « n'a pas d'accès direct à Internet » et est conçu pour isoler chaque requête sans conserver de trace des entrées ni des sorties après traitement [S5]. Ce sont des affirmations de l'éditeur, non auditées ici.

> **À retenir.** « Les données ne partent pas » est vrai pour l'inférence, à condition de le vérifier (aucun appel réseau caché, aucune télémétrie, aucun journal). Pour le cours, la règle d'or reste inchangée : **aucune donnée personnelle ni confidentielle dans un prompt ni dans un dépôt public**. L'IA locale réduit un risque, elle ne remplace pas la règle.

### 2.3 Coût

Dans le cloud, chaque requête est facturée (au jeton, en général). En local, l'utilisateur paie avec son propre matériel. Le site Flutter Edge AI revendique « pas de facture d'API, pas de limite de débit » et « coût zéro » [S9]. C'est vrai pour les appels, mais le coût se déplace : temps de développement, téléchargements de plusieurs centaines de mégaoctets à plusieurs gigaoctets (le modèle Gemma 4 E2B pèse 2,4 Go dans le catalogue du projet [S9]), espace de stockage occupé, batterie, et support d'une grande diversité d'appareils. Pour un chef de projet : le coût variable par requête tombe à zéro, mais le coût fixe de conception et de test augmente.

### 2.4 Fonctionnement hors ligne

Une application qui doit fonctionner dans un entrepôt, un train, une usine ou une zone sans couverture ne peut pas dépendre d'un serveur. C'est l'argument le plus solide en contexte industriel, et il ne se discute pas : sans réseau, seul le local fonctionne. Le modèle doit toutefois avoir été téléchargé au préalable.

## 3. Les limites

### 3.1 Taille du modèle

Les grands modèles hébergés comptent des centaines de milliards de paramètres ; ceux qui tiennent sur un téléphone en comptent de quelques centaines de millions à quelques milliards. On parle de **SLM** (*small language models*, petits modèles de langage), par opposition aux **LLM** (*large language models*). Le catalogue de Flutter Edge AI montre l'échelle : de SmolLM 135M (135 Mo) et FunctionGemma 270M (284 Mo) jusqu'à Gemma 4 E4B (4,3 Go) [S9]. Le « M » signifie million de paramètres, le « B » milliard.

### 3.2 Mémoire

Pour fonctionner, le modèle doit être chargé dans la **mémoire vive** (RAM) de l'appareil, qui est partagée avec le système et les autres applications. La documentation de Gemma fournit un tableau de besoins en mémoire selon la précision de stockage. Pour Gemma 4 E2B : 11,4 Go en BF16 (précision d'origine), 5,7 Go en 8 bits, 2,9 Go en 4 bits ; pour E4B : 17,9 Go, 8,9 Go et 4,5 Go [S3]. La page ne précise pas, dans l'extrait lu, tous les éléments pris en compte (par exemple la mémoire de travail), donc ces chiffres sont à lire comme des ordres de grandeur. Le site Flutter Edge AI note enfin qu'il ne fournit **pas de table de RAM recommandée par type d'appareil** [S9] : c'est à vous de tester.

### 3.3 Énergie

Faire calculer un téléphone décharge sa batterie et le fait chauffer. Un point contre-intuitif est documenté par Hugging Face dans sa page sur la quantification : en théorie, des nombres plus petits consomment moins d'énergie, mais des mesures récentes citées par cette page, réalisées sur des **cartes graphiques de bureau** (pas sur des téléphones), montrent que pour de petits modèles (moins de 3 milliards de paramètres) une quantification de type NF4 peut **augmenter** la consommation de 25 à 56 %, à cause du surcoût de décompression [S4]. La conclusion de la page est qu'il faut valider l'effet énergétique par la mesure pour chaque déploiement [S4]. Ces mesures ne se transposent pas telles quelles à un téléphone, mais elles rappellent que « plus petit » n'est pas automatiquement « plus sobre ».

### 3.4 Qualité

Un petit modèle se trompe plus, suit moins bien des consignes complexes et connaît moins de choses. C'est un consensus de praticiens plus qu'un fait chiffré universel : l'écart dépend de la tâche. Pour une tâche étroite et bien cadrée (classer un ticket, extraire une date, reformuler une phrase), un petit modèle suffit souvent. Pour une analyse ouverte et nuancée, non. Cette qualité doit s'évaluer sur des cas de test réalistes, ce que les projets du cours permettront de faire (section 9).

### 3.5 Hétérogénéité des appareils

Un serveur cloud est une machine connue ; les téléphones de vos utilisateurs sont des centaines de modèles. La documentation de Flutter Edge AI le montre : l'accélération par processeur neuronal (NPU) n'est prise en charge que sur certains appareils Qualcomm Snapdragon sous Android et certains processeurs Intel sous Windows, et pas sur iOS [S9] ; le simulateur iOS fonctionne seulement sur processeur [S9]. Une application doit donc prévoir des **solutions de repli** (par exemple basculer vers un modèle plus petit ou vers le cloud).

## 4. La quantification expliquée simplement

### 4.1 Le principe

Les paramètres d'un modèle sont des nombres décimaux. Les stocker en haute précision coûte cher en mémoire. La **quantification** est l'opération qui les remplace par des nombres moins précis. Hugging Face la définit comme une technique qui réduit les coûts de calcul et de mémoire de l'inférence en représentant les poids avec des types de données de faible précision, comme un entier de 8 bits à la place du nombre flottant habituel de 32 bits [S4].

**Analogie.** Imaginez un catalogue où tous les prix sont écrits au centime. Vous décidez de les arrondir à l'euro : le catalogue est plus court et plus rapide à parcourir, vous perdez un peu de précision, et pour la plupart des usages cela ne change rien. Si vous arrondissez à la dizaine d'euros, l'erreur devient visible. Quantifier un modèle, c'est choisir ce niveau d'arrondi.

### 4.2 Un calcul d'ordre de grandeur

Un nombre stocké sur 16 bits occupe 2 octets ; sur 4 bits, un demi-octet. Pour un modèle d'un milliard de paramètres, cela donne environ 2 Go à 16 bits et 0,5 Go à 4 bits (calcul simple du cours, hors métadonnées). On retrouve cette logique dans le tableau de la documentation Gemma : pour E2B, le passage de BF16 à 4 bits fait passer l'empreinte de 11,4 à 2,9 Go, soit un facteur d'environ 3,9 [S3]. (Le nom « E2B » signifie 2 milliards de paramètres *effectifs*, selon la documentation Gemma, grâce à une technique d'« embeddings par couche » ; l'empreinte totale en mémoire est donc supérieure à ce que suggère « 2B » [S3].)

### 4.3 Ce que la quantification coûte

- **Qualité** : la précision diminue. La page Hugging Face indique d'ailleurs qu'on évalue le modèle quantifié et qu'on recommence avec une méthode plus fine si la précision n'est pas suffisante [S4].
- **Vitesse** : les opérations sur entiers peuvent être plus rapides, mais cela dépend du matériel [S4].
- **Énergie** : non garantie (section 3.3).

Les modèles livrés pour téléphone sont déjà quantifiés par leurs éditeurs ; vous n'avez normalement pas à le faire vous-même. Il faut en revanche savoir **lire** les mentions de précision dans le nom d'un fichier de modèle et en comprendre l'effet.

> **À retenir.** Quantifier, c'est arrondir les nombres du modèle pour qu'il tienne dans la mémoire d'un appareil. Gain principal : l'espace. Prix : un peu de qualité, et des effets sur la vitesse et l'énergie qu'il faut mesurer.

## 5. Les modèles ouverts

### 5.1 Ouvert, que veut dire ce mot ?

Un modèle à **poids ouverts** (*open weights*) est un modèle dont le fichier de paramètres peut être téléchargé et exécuté localement. Ce n'est pas la même chose qu'un logiciel **open source** au sens strict : les données d'entraînement ne sont généralement pas publiées. La **licence** décide de ce que vous avez le droit de faire (usage commercial, redistribution, etc.). C'est un point de vigilance en entreprise.

### 5.2 La famille Gemma

**Gemma** est la famille de modèles ouverts de Google. **Gemma 4** a été annoncée le 2 avril 2026 par le blog open source de Google, avec une licence **Apache 2.0**, reconnue comme licence open source et décrite comme offrant des « conditions bien comprises pour la modification, la réutilisation et le développement » [S3b]. La documentation Gemma liste cinq tailles : E2B et E4B (petites tailles, « pour le déploiement ultra-mobile, edge et navigateur »), 12B, 26B A4B (architecture dite « mixture d'experts ») et 31B [S3]. Les deux plus petites sont celles qui nous intéressent.  Nous suivons la documentation officielle pour la liste des tailles [S3].

### 5.3 Les autres modèles ouverts

Le catalogue de Flutter Edge AI recense d'autres familles utilisables en local : Qwen (Alibaba), Phi-4 Mini (Microsoft), DeepSeek R1, SmolLM, FastVLM, etc. [S9]. La documentation de LiteRT-LM cite comme modèles pris en charge Gemma 4, Gemma 3n, Phi-4-mini et la série Qwen [S2]. Les **licences diffèrent d'un modèle à l'autre** : elles ne sont pas détaillées dans les pages lues et sont **non vérifiées** pour ces familles. Vérifiez la licence de chaque modèle avant tout usage commercial.

### 5.4 Les types de capacités

Selon le modèle, on dispose ou non de :
- **texte seul** (dialogue, résumé, reformulation) ;
- **multimodalité** : vision (analyser une image) et audio ;
- **appel de fonctions** (*function calling*) : le modèle ne fait pas que répondre, il demande à l'application d'exécuter une action avec des paramètres (par exemple « change la couleur de fond en bleu ») ;
- **raisonnement visible** (*thinking mode*) ;
- **plongements** (*embeddings*) : transformer un texte en liste de nombres pour comparer des sens, base de la recherche sémantique.

Le tableau du site Flutter Edge AI indique, modèle par modèle, quelles capacités sont prises en charge, et sur quelles plateformes [S9]. Par exemple, d'après la documentation de l'appel de fonctions, les modèles Gemma 3 (270M et 1B) ne font que générer du texte, alors que Gemma 4 E2B et E4B ont un appel de fonctions natif [S11].

## 6. Cartographie de l'écosystème

L'écosystème se comprend comme un empilement. De bas en haut : le matériel (processeur CPU, carte graphique GPU, processeur neuronal NPU), le **moteur d'exécution** qui sait faire tourner un modèle sur ce matériel, la **couche d'orchestration** pour les modèles de langage (gestion des conversations, de la mémoire de contexte, de l'appel de fonctions), puis l'**application**.

> **Glossaire express du matériel.** CPU : le processeur généraliste. GPU : le processeur graphique, très bon en calcul parallèle. NPU : processeur dédié aux calculs d'IA, de plus en plus présent dans les téléphones et les PC récents.

### 6.1 LiteRT : le moteur de Google

**LiteRT** est « le moteur d'inférence sur appareil de Google pour déployer des modèles de ML et d'IA générative sur des plateformes edge, avec des outils pour les convertir, les optimiser et les exécuter » (traduction libre) [S1]. C'est le successeur de **TensorFlow Lite** : l'API historique `Interpreter` (ex-TensorFlow Lite) reste disponible pour la compatibilité, et l'API récente `CompiledModel` est recommandée pour l'accélération matérielle [S1]. La documentation cite en plateformes Android (API 24 et plus), iOS (15 et plus), macOS (12 et plus), navigateurs, Linux, Windows et objets embarqués, avec des accélérations CPU, GPU et NPU de plusieurs fabricants [S1]. Le format de fichier de modèle est `.tflite` [S1].

### 6.2 LiteRT-LM : la couche pour les modèles de langage

**LiteRT-LM** est décrit comme « la couche d'orchestration prête pour la production pour exécuter des LLM avec LiteRT, conçue pour une exécution performante et multiplateforme » (traduction libre) [S2]. Les accélérations prises en charge par plateforme, d'après la page officielle lue le 6 octobre 2026 [S2] :

| Plateforme | CPU | GPU | NPU |
|---|---|---|---|
| Android | oui | oui | oui |
| iOS | oui | oui | non |
| macOS | oui | oui | non |
| Windows | oui | oui | Early Preview (préversion) |
| Linux | oui | oui | non |
| IoT | oui | non | non |

Le dépôt GitHub officiel indique la licence Apache-2.0 et une version v0.18.0 au moment de la lecture, ainsi qu'un statut par langage : Python, Kotlin et C++ « Stable », Swift et JavaScript (Web) « Early Preview », Flutter « Community » [S2b] (numéro de version amené à changer vite ; on remarque d'ailleurs qu'un numéro 0.x signale en général un projet encore jeune, mais c'est une convention, pas une garantie).

**Flutter** figure dans la page LiteRT-LM avec le statut **« communautaire »**, via le paquet `flutter_gemma` [S2]. Autrement dit : Google ne maintient pas lui-même de support Flutter pour LiteRT-LM.

### 6.3 MediaPipe

**MediaPipe Solutions** est une suite de bibliothèques et d'outils de Google pour appliquer des techniques d'IA (vision, texte, audio) dans des applications, disponible selon les tâches sur Android, Web, Python et iOS [S7]. Son **LLM Inference API** (modèles de langage) est listé pour Android et le Web ; la documentation le présente à côté de LiteRT-LM comme offre séparée, ce qui suggère que Google promeut LiteRT-LM pour l'IA générative sur appareil [S7]. Cette dernière phrase est **notre interprétation**, pas une déclaration officielle de remplacement : aucun statut d'obsolescence n'a été lu. MediaPipe reste utilisé pour les fichiers de modèle de format `.task` (voir section 7) [S9].

### 6.4 ONNX Runtime

**ONNX Runtime** (Microsoft) est un « moteur d'IA de qualité production » pour l'inférence et l'entraînement, qui fonctionne sur Linux, Windows, Mac, iOS, Android et navigateurs, avec une édition **Mobile** pour Android et iOS [S8]. ONNX est un format d'échange de modèles indépendant du fabricant. C'est la piste « neutre » : intéressante si vous partez d'un modèle qui n'existe pas au format LiteRT.

### 6.5 Core ML et Core AI (Apple)

**Core ML** est le cadre d'Apple pour intégrer des modèles dans une application, et pour les entraîner ou les affiner sur l'appareil. Il tire parti du processeur, du GPU et du **Neural Engine** (le NPU d'Apple) en minimisant mémoire et consommation [S6]. La documentation Core ML renvoie désormais vers un cadre nommé **Core AI** pour les applications qui intègrent « les dernières architectures et techniques d'inférence » [S6]. Selon une session de questions-réponses de la conférence WWDC26 résumée par la page vidéo d'Apple, Core ML « n'est pas déprécié », et Core AI est présenté comme la direction d'investissement pour les modèles génératifs modernes [S6b]. Cette dernière information provient d'une page résumée automatiquement : **à confirmer** sur la documentation Apple avant de s'y fier. Enfin, le cadre **Foundation Models** donne accès en Swift au modèle sur appareil qui alimente Apple Intelligence [S6b].

### 6.6 ML Kit et Gemini Nano (Android)

**ML Kit** apporte aux développeurs mobiles iOS et Android des fonctions d'IA prêtes à l'emploi : vision (lecture de codes-barres, reconnaissance de texte, détection de visages, etc.), langage (identification de langue, traduction en 58 langues, etc.), et des API d'IA générative (résumé, correction, reformulation, description d'image, reconnaissance vocale, génération à partir d'un prompt) fondées sur **Gemini Nano** [S5b]. ML Kit affirme que le traitement se fait sur l'appareil et « fonctionne hors ligne » [S5b]. **Gemini Nano** tourne dans le service système **AICore** d'Android, qui gère la distribution et la mise à jour du modèle : l'application n'a pas à le télécharger elle-même [S5]. La documentation ne liste pas les appareils compatibles dans la page lue : la disponibilité par appareil est **non vérifiée** et doit être contrôlée [S5].

### 6.7 Synthèse : quel outil pour quel besoin ?

| Besoin | Piste | Remarque |
|---|---|---|
| Tâche prête à l'emploi (OCR, traduction, résumé) | ML Kit, Gemini Nano, Apple Foundation Models | Intégration simple, mais liée à la plateforme et aux appareils compatibles |
| Modèle de langage ouvert, choisi par vous | LiteRT-LM (+ moteur ONNX ou MediaPipe selon le format) | Plus de liberté, plus de responsabilité (taille, licence, qualité) |
| Modèle de vision ou de classification maison | LiteRT, ONNX Runtime, Core ML | Conversion du modèle nécessaire |
| Application Flutter multiplateforme | Flutter Edge AI (section 8) | Projet communautaire, voir maturité |

## 7. Formats de fichiers de modèles : un piège fréquent

La documentation de Flutter Edge AI insiste sur un point : le **format de fichier** du modèle détermine quel moteur l'exécute, et « n'est pas déduit du nom du fichier » [S9]. Elle distingue `.litertlm` (moteur LiteRT-LM, toutes plateformes) et `.task` (MediaPipe, mobile et web uniquement) ; sur ordinateur il n'y a pas de moteur MediaPipe, et le format recommandé est `.litertlm` (les modèles ONNX et le modèle intégré à l'OS y fonctionnent aussi) [S9, S9g]. Retenez : **choisir un modèle, c'est aussi choisir un format compatible avec ses plateformes cibles**.

## 8. EdgeAI avec Flutter

### 8.1 Rappel : Flutter en une phrase

**Flutter** est le kit de Google pour construire, avec le langage **Dart**, des applications qui tournent sur mobile, web et ordinateur à partir d'un même code. C'est la pile du cours. Le point important pour ce chapitre : un modèle d'IA est écrit en C++ ou autre langage natif ; Flutter y accède via des **plugins** (paquets Dart qui font le pont avec le code de chaque système).

### 8.2 Ce qui est officiel, ce qui ne l'est pas

La page officielle de Flutter sur l'IA (docs.flutter.dev/ai) présente quatre pistes : Firebase AI Logic, Genkit Dart, le GenUI SDK et le Flutter AI Toolkit [S13]. Dans la page lue, **aucune** solution d'inférence sur appareil n'est mentionnée, et `flutter_gemma` n'y figure pas [S13]. Les pistes officielles sont donc surtout orientées cloud. Pour le local, l'écosystème est porté par la communauté.

### 8.3 Flutter Edge AI : ce que propose flutteredge.ai

Le site **flutteredge.ai** présente le projet **Flutter Edge AI** : « des LLM sur appareil dans votre application Flutter. Pas de serveur. Pas de cloud. Juste du Dart » (traduction libre) [S9]. Voici ce que nous avons relevé en le lisant en détail le 6 octobre 2026.

**Qui.** Le projet est maintenu par **Sasha Denisov** sous licence **MIT** [S9]. Son profil sur le site d'une conférence le présente comme Google Developer Expert pour l'IA, Firebase, Flutter et Dart [S14] ; cette qualité n'est pas vérifiée sur une source de Google. Le dépôt GitHub (`DenisovAV/flutter_edge_ai`) est celui d'un compte individuel, pas d'une organisation Google ou Flutter [S9b] : c'est un projet **indépendant**.

**Historique de nom.** Le projet s'appelait **Flutter Gemma** (paquet `flutter_gemma`). Il a été renommé en version 2.0 ; la page pub.dev de `flutter_gemma` indique qu'il est « discontinued » (abandonné) avec le message : « Moved to flutter_edge_ai. This is the final release under the name flutter_gemma; new versions ship as flutter_edge_ai, part of Flutter Edge AI. » (dernière version 1.11.4) [S9c]. **Conséquence importante pour vous** : une grande partie des tutoriels, vidéos et réponses de forums en ligne parlent encore de `flutter_gemma`. Le guide de migration du site indique de remplacer les dépendances et de renommer les imports, puis de lancer `dart fix --apply` [S9d]. La documentation officielle de LiteRT-LM cite encore l'ancien nom (`flutter_gemma`) [S2] : elle n'est donc pas à jour sur ce point à la date de lecture.

**Version.** `flutter_edge_ai` 2.0.0 a été publiée environ 38 heures avant notre lecture, soit le 5 octobre 2026, et la 2.1.0 moins d'une heure avant (dates relatives affichées par pub.dev) ; la 1.11.4 date de trois jours [S9e]. Le projet est donc **très récent** sous ce nom, et le numéro de version change déjà.

**Fonctions annoncées** [S9] :
1. entrées multimodales (vision et audio) avec Gemma 4, Gemma 3n, FastVLM ;
2. appel de fonctions (le modèle invoque des fonctions Dart) ;
3. mode « thinking » (chaîne de raisonnement visible) ;
4. « Agent Skills » (le modèle exécute des fichiers `SKILL.md`) ;
5. voix : reconnaissance (STT) et synthèse (TTS) sur appareil ;
6. **RAG** (*retrieval-augmented generation*, génération augmentée par recherche : on cherche d'abord les passages pertinents dans vos propres documents, puis on les donne au modèle pour qu'il réponde en s'appuyant dessus) ;
7. accélération matérielle CPU/GPU, et NPU sur Qualcomm (Android) et Intel (Windows) ;
8. IA « intégrée » à l'OS : Gemini Nano, Apple Foundation Models, Phi Silica, API Prompt de Chrome ;
9. moteurs d'exécution interchangeables (inférence, plongements, voix) ;
10. paquets optionnels ;
11. intégration avec des assistants de code (Claude Code, Codex, Cursor, Copilot).

**Plateformes.** Android, iOS, Web, macOS, Windows, Linux. Le site indique un support de la vision partout, de l'audio sauf sur le Web, et du NPU seulement sur Android et Windows [S9]. Sur pub.dev, le Web est signalé « preview » pour certaines fonctions [S9e].

**Architecture modulaire.** Le cœur du projet (`flutter_edge_ai`) reste minimal, et vous ajoutez les moteurs et stockages voulus [S9e]. Le site annonce 14 paquets au total [S9] :
- moteurs : `flutter_edge_ai_litertlm`, `_mediapipe`, `_builtin_ai`, `_onnx` ;
- fonctions : `_embeddings`, `_rag`, `_qdrant`, `_sqlite`, `_agent`, `_speech`, `_diagnostics` ;
- intégrations : `genkit_flutter_edge_ai`, `genkit_hybrid` (pont avec Genkit, le cadre de Google, pour combiner cloud et local).

On retrouve ici l'écosystème de la section 6 : LiteRT-LM, MediaPipe, ONNX Runtime, et les IA intégrées au système (Gemini Nano, Apple Foundation Models).

**Documentation et formation.** Le site propose huit « codelabs » (ateliers guidés) allant de 35 minutes (« Prise en main des LLM sur appareil dans Flutter », niveau débutant) à plus de 2 heures (IA hybride avec Genkit Dart, niveau avancé) [S9f].

### 8.4 Installation et premier appel

L'installation annoncée tient en une commande [S9] :

```bash
flutter pub add flutter_edge_ai flutter_edge_ai_litertlm
```

Le site présente ensuite l'exemple suivant (copié tel quel de la page d'accueil de flutteredge.ai le 6 octobre 2026 ; les URL sont tronquées par le site) [S9] :

```dart
await FlutterEdgeAi.initialize(
  inferenceEngines: [LiteRtLmEngine(), MediaPipeEngine()],
  embeddingBackends: [LiteRtEmbeddingBackend()],
  embeddingTokenizers: [GemmaEmbeddingTokenizers()],
);

await FlutterEdgeAi.installModel(
  modelType: ModelType.gemma4,
  fileType: ModelFileType.litertlm,
).fromNetwork('https://.../gemma-4-E2B-it.litertlm').install();

final model = await FlutterEdgeAi.getActiveModel(maxTokens: 2048);
final chat = await model.createChat();
await chat.addQueryChunk(Message.text(text: 'Hello!', isUser: true));
final response = await chat.generateChatResponse();
```

Lecture pas à pas, pour un non-développeur :
1. `initialize` : on démarre la bibliothèque et on déclare les moteurs d'inférence à utiliser.
2. `installModel ... install()` : on télécharge le modèle une seule fois depuis une adresse Internet, et on le range sur l'appareil. C'est l'étape lourde (plusieurs gigaoctets).
3. `getActiveModel` : on charge en mémoire le modèle actif, avec une limite de longueur de réponse (`maxTokens`).
4. `createChat`, `addQueryChunk`, `generateChatResponse` : on ouvre une conversation, on pose une question, on reçoit la réponse.

Le site promet « environ cinq minutes jusqu'à l'inférence sur appareil » [S9]. Prenez cette durée comme une promesse commerciale : elle exclut le temps de téléchargement du modèle sur votre connexion.

**Avertissements officiels à connaître** [S9a, S9g] :
- toujours passer `isUser: true` pour les messages de l'utilisateur, sinon le modèle renvoie une réponse vide ;
- toujours fermer (`close()`) les sessions et les modèles quand on a fini, car ils occupent la mémoire ;
- sur le Web, `getActiveModel()` ne met pas le modèle en cache : récupérez-le une seule fois et conservez la référence ;
- le simulateur iOS est limité au processeur ;
- configuration par plateforme : sous Android, certaines options exigent un `minSdk` plus élevé (26 pour ML Kit GenAI et AICore, 30 pour les fonctions fondées sur LiteRT dont les modèles `.litertlm` ; architecture `arm64-v8a` en principe) ; sous iOS, version minimale 15.0 (16.0 avec MediaPipe) ; sous macOS, une manipulation des réglages de gestionnaire de dépendances est demandée [S9g]. La fiche d'installation du site fait foi et change.

**Honnêteté sur ce code.** Cet extrait est recopié de la page d'accueil de flutteredge.ai (texte vérifié le 6 octobre 2026) ; il n'a **pas** été compilé ni exécuté, car il exige le paquet, un appareil et le téléchargement d'un modèle. Les noms d'API peuvent avoir évolué depuis (la version 2.1.0 est sortie le 6 octobre). Vérifiez-le sur votre poste avec `flutter analyze` avant de vous y fier.

### 8.5 Exemple d'appel de fonctions

La documentation du projet donne l'exemple suivant, où le modèle peut demander à l'application de changer la couleur de fond. Seuls certains modèles le permettent (Gemma 4 E2B et E4B, Gemma 3n E4B en version `.litertlm`, FunctionGemma 270M, Qwen, Phi-4 Mini, DeepSeek R1) [S11] :

```dart
final tools = [
  const Tool(
    name: 'change_background_color',
    description: 'Change the app background color.',
    parameters: {
      'type': 'object',
      'properties': {
        'color': {'type': 'string', 'description': 'A CSS color name.'},
      },
      'required': ['color'],
    },
  ),
];

final chat = await model.createChat(
  tools: tools,
  supportsFunctionCalls: true,
  toolChoice: ToolChoice.auto,
);
```

L'intérêt pour un chef de projet : le modèle ne « fait » rien tout seul. Il propose un appel (« change_background_color, bleu ») ; c'est le **code de l'application** qui décide d'exécuter ou non l'action. C'est le même principe de garde-fou que les permissions d'un agent de code.

### 8.6 Architecture type d'une application Flutter avec inférence locale

Voici une architecture de référence, **proposée par ce cours** (ce n'est pas un schéma officiel du projet). Elle respecte le principe de la séparation en couches vu en séance : l'interface ne parle jamais directement à la bibliothèque d'IA.

```
Interface (widgets Flutter)
        |
Gestion d'état (BLoC, Cubit, Riverpod, au choix)
        |
Interface abstraite « Assistant »   <-- le contrat, écrit en Dart pur
     /              \
Adaptateur local     Adaptateur de test (faux assistant)
(flutter_edge_ai)    (réponses prédéfinies)
        |
Stockage du modèle (téléchargement, versions, espace disque)
```

Pourquoi cette découpe ?
- Le projet est jeune et son API a déjà changé (renommage, version 2.0 avec ruptures de compatibilité listées dans le guide de migration [S9d]) : isoler la bibliothèque dans un seul adaptateur limite les dégâts d'une mise à jour.
- Les tests automatiques ne doivent pas télécharger 2 Go : ils utilisent le faux assistant.
- Si l'on veut plus tard basculer vers un modèle cloud, on écrit un second adaptateur sans toucher à l'interface.

Le contrat et le faux assistant (code Dart pur, sans dépendance ; analysé avec `dart analyze` sans aucune alerte, et le test ci-dessous passe, avec Dart 3.13.5 et le paquet `test`, le 6 octobre 2026) :

```dart
/// Contrat : ce que l'application attend d'un assistant, quel qu'il soit.
abstract interface class Assistant {
  /// Renvoie la réponse à une question, jeton par jeton.
  Stream<String> repondre(String question);

  /// Libère la mémoire (à appeler quand on a fini).
  Future<void> fermer();
}

/// Faux assistant pour les tests : aucune IA, aucune donnée réelle.
class FauxAssistant implements Assistant {
  @override
  Stream<String> repondre(String question) async* {
    for (final mot in 'Réponse fictive à : $question'.split(' ')) {
      yield '$mot ';
    }
  }

  @override
  Future<void> fermer() async {}
}
```

Et le test qui l'accompagne (cycle « rouge, vert » vu en séance) :

```dart
import 'package:test/test.dart';

void main() {
  test('le faux assistant renvoie une réponse non vide', () async {
    final assistant = FauxAssistant();
    final morceaux = await assistant.repondre('Bonjour').toList();
    expect(morceaux.join(), contains('Bonjour'));
    await assistant.fermer();
  });
}
```

L'adaptateur réel réunirait les appels de la section 8.4 (`initialize`, `installModel`, `getActiveModel`, `createChat`, puis la génération) derrière cette interface. Nous ne l'écrivons pas ici : la forme exacte du résultat de génération est à vérifier sur la documentation de la version installée, et nous préférons ne pas publier de code non vérifié.

**Les quatre soucis propres à l'embarqué** que l'architecture doit traiter :
1. **Premier lancement** : écran de téléchargement avec progression (le site documente un suivi de progression `withProgress` [S9a]), reprise en cas de coupure, vérification de l'espace libre.
2. **Cycle de vie de la mémoire** : charger le modèle quand on en a besoin, le fermer ensuite.
3. **Repli** : si l'appareil est trop faible, proposer un modèle plus petit ou une fonction dégradée.
4. **Transparence** : informer l'utilisateur de ce qui est traité localement, de ce qui est téléchargé et de ce qui est stocké.

## 9. Maturité de chaque brique

Tableau de synthèse, **état au 6 octobre 2026**, fondé sur les pages officielles lues. « Statut » reprend les termes des éditeurs.

| Brique | Éditeur / porteur | Statut observé | Réserve |
|---|---|---|---|
| LiteRT | Google | Moteur officiel, successeur de TensorFlow Lite [S1] | Auto-description de l'éditeur |
| LiteRT-LM | Google | « Prêt pour la production » ; Python, Kotlin, C++ : Stable ; Swift et Web : Early Preview [S2b] ; NPU sous Windows : Early Preview [S2] | Version 0.x au dépôt [S2b] ; un statut « Stable » est une déclaration de l'éditeur |
| Support Flutter de LiteRT-LM | Communauté (`flutter_gemma`, devenu `flutter_edge_ai`) | **Communautaire** [S2] | Pas de garantie de Google |
| MediaPipe LLM Inference API | Google | Android et Web [S7] | Positionnement vis-à-vis de LiteRT-LM non précisé (interprétation) |
| ONNX Runtime | Microsoft | « Production-grade », mobile et web [S8] | Peu de documentation Flutter lue |
| Core ML / Core AI | Apple | Core ML « supporté, non déprécié » ; Core AI vers les modèles génératifs [S6, S6b] | Source secondaire pour la coexistence |
| ML Kit, Gemini Nano | Google | Produits officiels Android (et iOS pour ML Kit) [S5, S5b] | Appareils compatibles non vérifiés ; pas de plugin Flutter officiel identifié (non vérifié) |
| `flutter_edge_ai` | Indépendant (S. Denisov), licence MIT | Version 2.0.0 le 5 octobre 2026, 2.1.0 le 6 octobre [S9e] ; ex-`flutter_gemma` abandonné au profit de ce nom [S9c] | Très récent sous ce nom, API changeante, 6 « likes » pour la nouvelle entrée contre 436 pour l'ancienne [S9c, S9e] |

**Notre lecture, présentée comme opinion** : pour un projet de cours, `flutter_edge_ai` est suffisamment documenté (site, guide de migration, ateliers) pour une démonstration, mais il ne faut pas bâtir une promesse commerciale ni un système critique sur un projet porté par une personne, à l'API en évolution et au support Flutter non officiel. Le risque principal n'est pas technique mais de **pérennité** : que se passe-t-il si le mainteneur s'arrête ? Le modèle de gouvernance du projet n'est pas documenté dans les pages lues.

## 10. Pistes pour les projets du cours

### 10.1 Règles de base

- **Jeux de données fictifs.** On fabrique des données inventées, jamais copiées d'une vraie personne ou d'une vraie entreprise. L'IA locale ne dispense pas de la règle d'or (section 2.2).
- **Pas de téléchargement de modèle en séance sans préparation.** Un modèle pèse de 0,1 à plus de 4 Go [S9] : prévoir un miroir local ou un téléchargement à l'avance, comme pour les installeurs.
- **Vérifier la licence du modèle** avant tout usage, et noter la version exacte utilisée.
- **Mesurer plutôt que croire** : temps de première réponse, mémoire, chaleur, qualité sur vingt cas de test.

### 10.2 Idées de cas d'usage (fictifs)

1. **Classer des tickets de maintenance** d'une usine imaginaire en trois catégories (urgent, planifiable, information), hors ligne. Jeu de données : 100 tickets rédigés à la main ou générés, sans nom réel.
2. **Assistant de procédures hors ligne** : poser des questions sur un manuel fictif (« procédure de sécurité de l'atelier B ») avec le RAG du projet. Montre l'intérêt d'ancrer les réponses dans des documents.
3. **Formulaire à saisie vocale** pour un technicien terrain fictif (voix vers texte vers champs), à comparer à une version cloud.
4. **Reformulation de comptes rendus** : transformer des notes brutes inventées en compte rendu structuré.
5. **Comparatif de deux modèles** (petit et un peu plus grand) sur le même jeu de test : qualité contre vitesse contre taille.

### 10.3 Démarche conseillée

1. Écrire la **spécification** de l'usage (entrée, sortie attendue, critères d'acceptation) avant de choisir le modèle : c'est le principe du développement piloté par la spécification vu en séance.
2. Mettre en place l'**architecture en couches** de la section 8.6 avec le faux assistant et les tests.
3. Brancher le modèle local derrière l'interface, **en dernier**.
4. Évaluer sur le jeu de test fictif et consigner les résultats (tableau : modèle, taille, temps, score).
5. Décider avec des chiffres : local, cloud ou hybride.

Pour que l'agent de code (Claude Code) vous aide sans halluciner d'API, donnez-lui dans le fichier d'instructions du projet l'adresse de la documentation à jour (flutteredge.ai) et le nom actuel du paquet (`flutter_edge_ai`, et non `flutter_gemma`) : un assistant entraîné avant le renommage connaît surtout l'ancien nom. C'est une recommandation de bon sens du cours, pas un fait sourcé.

## Glossaire du chapitre

- **Accélération matérielle** : usage du GPU ou du NPU plutôt que du seul CPU pour calculer plus vite.
- **Appel de fonctions (function calling)** : capacité d'un modèle à demander à l'application d'exécuter une action décrite à l'avance.
- **BF16** : format de nombre à 16 bits utilisé pour stocker les paramètres sans quantification forte.
- **Cloud** : serveurs distants hébergés par un fournisseur.
- **Edge AI (IA embarquée)** : exécution d'un modèle d'IA sur l'appareil de l'utilisateur.
- **Embedding (plongement)** : liste de nombres représentant le sens d'un texte, utile pour la recherche par similarité.
- **Inférence** : phase d'utilisation d'un modèle déjà entraîné.
- **Jeton (token)** : unité de texte lue ou écrite par un modèle.
- **LLM / SLM** : grand modèle de langage / petit modèle de langage.
- **Modèle à poids ouverts** : modèle dont les paramètres sont téléchargeables et exécutables localement, sous licence précisée.
- **NPU** : processeur dédié aux calculs d'IA.
- **Paramètres (poids)** : nombres internes d'un modèle, ajustés à l'entraînement.
- **Plugin** : paquet qui relie Flutter au code natif d'un système.
- **Quantification** : réduction de la précision des paramètres pour économiser mémoire et calcul.
- **RAG** : génération augmentée par recherche dans vos propres documents.
- **RGPD** : règlement européen sur la protection des données personnelles.

## Pour aller plus loin

- Lire la page d'accueil, la documentation et au moins le premier atelier de flutteredge.ai (35 minutes) [S9, S9f].
- Parcourir la documentation de LiteRT et de LiteRT-LM pour comprendre le découpage moteur et orchestration [S1, S2].
- Lire la page de quantification de Hugging Face, surtout la partie sur l'énergie [S4].
- Consulter les recommandations de la CNIL sur l'IA et le RGPD [S12].
- Lire la documentation Android sur Gemini Nano et AICore pour une approche « modèle fourni par le système » [S5].

## Points non vérifiés de ce chapitre

- Licences des modèles autres que Gemma 4 (Qwen, Phi, DeepSeek, SmolLM, etc.).
- Appareils compatibles avec Gemini Nano et AICore.
- Existence et maturité d'un plugin Flutter officiel pour ML Kit.
- Statut exact de MediaPipe LLM Inference API par rapport à LiteRT-LM.
- Conditions détaillées des mesures de performance de LiteRT-LM citées en section 2.1 ; aucune performance de `flutter_edge_ai` sur appareil réel n'a été mesurée ni trouvée sourcée.
- Qualité de Google Developer Expert de S. Denisov : affirmée par son profil sur wearedevelopers.com, non confirmée par une source de Google.
- Citation de la documentation Core ML (section 6.5) : la page Apple n'a pas pu être relue automatiquement ; seule la session WWDC26 a été relue.
- Détails de coexistence Core ML et Core AI (page résumée d'une session de conférence).
- Code Dart : le contrat, le faux assistant et son test ont été exécutés (Dart 3.13.5) ; les extraits de `flutter_edge_ai` (sections 8.4 et 8.5) sont recopiés de la documentation et n'ont pas été compilés.

## Sources

Consultées le 6 octobre 2026. Les pages de ce domaine changent vite.

- [S1] LiteRT, vue d'ensemble : https://developers.google.com/edge/litert/overview (anciennement ai.google.dev/edge/litert/overview)
- [S2] LiteRT-LM, vue d'ensemble : https://developers.google.com/edge/litert-lm/overview
- [S2b] Dépôt LiteRT-LM : https://github.com/google-ai-edge/LiteRT-LM
- [S3] Gemma, documentation (tailles, mémoire, licence) : https://ai.google.dev/gemma/docs/core et https://ai.google.dev/gemma/apache_2
- [S3b] Google Open Source Blog, « Gemma 4: Expanding the Gemmaverse with Apache 2.0 », 2 avril 2026 : https://opensource.googleblog.com/2026/03/gemma-4-expanding-the-gemmaverse-with-apache-20.html
- [S4] Hugging Face Optimum, « Quantization » : https://huggingface.co/docs/optimum/concept_guides/quantization
- [S5] Android Developers, Gemini Nano et AICore : https://developer.android.com/ai/gemini-nano
- [S5b] ML Kit : https://developers.google.com/ml-kit
- [S6] Apple, Core ML (documentation) : https://developer.apple.com/documentation/coreml
- [S6b] Apple WWDC26, « Machine Learning & AI Group Lab » : https://developer.apple.com/videos/play/wwdc2026/8016/ (contenu lu via un résumé, à confirmer)
- [S7] MediaPipe Solutions : https://developers.google.com/edge/mediapipe/solutions/guide
- [S8] ONNX Runtime : https://onnxruntime.ai/
- [S9] Flutter Edge AI, page d'accueil : https://flutteredge.ai/ ; modèles : https://flutteredge.ai/docs/models
- [S9a] Démarrage : https://flutteredge.ai/docs/getting-started
- [S9b] Dépôt GitHub : https://github.com/DenisovAV/flutter_edge_ai
- [S9c] pub.dev, `flutter_gemma` (abandonné, déplacé) : https://pub.dev/packages/flutter_gemma
- [S9d] Guide de migration : https://flutteredge.ai/docs/migration
- [S9e] pub.dev, `flutter_edge_ai` : https://pub.dev/packages/flutter_edge_ai
- [S9f] Ateliers (codelabs) : https://flutteredge.ai/codelabs
- [S9g] Installation par plateforme : https://flutteredge.ai/docs/installation
- [S10] Ateliers, brique hybride (Genkit Dart) : https://flutteredge.ai/codelabs
- [S11] Appel de fonctions : https://flutteredge.ai/docs/function-calling
- [S12] CNIL, « IA : comment être en conformité avec le RGPD ? » : https://www.cnil.fr/fr/ia-comment-etre-en-conformite-avec-le-rgpd
- [S13] Flutter, IA : https://docs.flutter.dev/ai
- [S14] Profil de conférencier (programme de conférence) : https://www.wearedevelopers.com/@sasha-denisov
- Supports locaux : `cours/presentations/day-1/index.html` et `notes.html` (diapositive « Edge AI ») ; `cours/programme-detaille.md` (S1, bloc 7).
