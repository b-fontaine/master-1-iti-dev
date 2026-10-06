# Chapitre 3 · Le craft depuis l'IA (2021 → 2026)

*Master ITI, Nantes Université · Ingénierie logicielle à l'ère de l'IA agentique · Séance 1, « Comprendre et s'équiper »*

*État des sources : 6 octobre 2026. Les outils, les versions et les chiffres bougent vite ; chaque donnée porte sa source, sa date et, quand c'est utile, un avertissement.*

## Ce que vous allez retenir

- En cinq ans, l'assistance par IA est passée de la **complétion** (le logiciel propose la fin de votre ligne) à l'**agent** (le logiciel écrit du code, lance les tests, constate l'échec et recommence seul). Les mots pour en parler ont suivi : vibe coding, augmented coding, agentic engineering.
- Le **vibe coding** consiste à ne pas regarder le code et à ne juger que le comportement ; l'**augmented coding** (Kent Beck) garde les mêmes exigences de qualité qu'à la main, mais sans taper le code. Le premier convient à un prototype jetable, le second à ce qui doit durer.
- Les **mesures** sont contrastées et il faut toujours demander : qui a mesuré, quoi, sur quel échantillon, avec quel intérêt ? Un essai randomisé (METR, 2025) trouve des développeurs expérimentés plus lents de 19 % alors qu'ils se croyaient plus rapides ; la recherche de Stanford trouve un gain médian modeste, très dépendant du contexte ; les éditeurs d'outils publient des chiffres alarmants, mais corrélationnels.
- **Le code existant est le contexte de l'agent** : il imite ce qu'il lit. Un code sain lui donne de bons modèles, un code embrouillé lui donne du désordre à reproduire.
- Les pratiques du craft **se renforcent** (tests d'abord, petites modifications, contexte écrit), **se transforment** (revue, pair, lisibilité) ou **s'effondrent** (refactoring, compréhension) quand on ne les entretient plus.
- En 2026, les praticiens se disputent sur un point : faut-il **relire** le code des agents (Mancuso) ou le remplacer par des **garde-fous automatisés** (Martin) ? Une position défendable : des garde-fous automatisés partout, et la revue humaine concentrée là où ils sont aveugles.
- La thèse du **code jetable** (la spécification est la source, le code se régénère) est sérieuse et financée, mais non démontrée en production sur des systèmes qui conservent des données.
- Règle du projet : **petits pas, tests d'abord, et je sais expliquer tout ce que je livre.**

---

## 1. Pourquoi ce chapitre existe

Le chapitre 2 a retracé l'histoire du « craft » (artisanat logiciel) : de la crise du logiciel de 1968 au Manifeste du Software Craftsmanship de 2009. Le fil rouge était simple : à chaque époque, la vitesse de production augmente, et à chaque époque on redécouvre que **la qualité décide de ce que l'on peut encore changer demain**.

Ce chapitre prolonge ce fil jusqu'à aujourd'hui. Il répond à une question que vous vous posez sans doute : *si une IA écrit le code, la qualité du code importe-t-elle encore ?* Vous verrez que la réponse des praticiens et des mesures est nuancée, et surtout qu'elle est **plus intéressante** que « oui » ou « non ».

Un rappel de vocabulaire, car il servira tout du long.

- **Code source** : le texte, écrit dans un langage de programmation (ici Dart, le langage de Flutter), qui décrit ce que fait un logiciel.
- **Dépôt** : le dossier, suivi par l'outil git, qui contient tout le code d'un projet et son historique.
- **Agent de code** : un programme piloté par un modèle d'IA qui peut lire vos fichiers, en modifier, lancer des commandes et des tests, puis réagir au résultat. Claude Code, l'outil du cours, en est un exemple.
- **Craft** (de *software craftsmanship*) : la posture et les pratiques d'un développeur qui se soucie de la qualité de son travail, comme un artisan.

> **À retenir.** Dans ce chapitre, on distingue toujours trois niveaux d'affirmation : un **fait** (une date, un résultat de mesure, une citation vérifiée), un **consensus de praticiens** (beaucoup de gens expérimentés disent la même chose, sans preuve expérimentale) et une **opinion** (un auteur défend une thèse). Les trois sont utiles ; ils ne se valent pas.

---

## 2. Quatre ans pour passer de l'autocomplétion à l'agent

### 2.1 Les jalons

Voici les repères, avec leur source.

| Date | Événement | Nature |
|---|---|---|
| 29 juin 2021 | GitHub présente **GitHub Copilot** en préversion technique, fondé sur OpenAI Codex : la complétion de code dans l'éditeur | Fait (blog GitHub) |
| 21 juin 2022 | Copilot sort de la préversion et devient un service par abonnement | Fait (GitHub, presse) |
| 30 novembre 2022 | OpenAI lance **ChatGPT** en aperçu de recherche gratuit | Fait (OpenAI) |
| 2 février 2025 | Andrej Karpathy publie le message qui nomme le **vibe coding** | Fait (message sur X) |
| 24 février 2025 | Anthropic présente Claude 3.7 Sonnet et **Claude Code**, en aperçu de recherche limité | Fait (Anthropic) |
| 25 juin 2025 | Kent Beck publie « Augmented Coding: Beyond the Vibes » | Fait (blog de Beck) |
| 7 octobre 2025 | Simon Willison propose « vibe engineering » | Fait (blog de Willison) |
| 23 février 2026 | Willison constate que « agentic engineering » l'emporte et adopte ce terme | Fait (mise à jour datée de son billet) |

Quelques précisions pour ne pas se tromper de mot.

La **complétion** (Copilot, 2021) fonctionne comme le correcteur de votre téléphone : vous tapez, il propose la suite. L'humain écrit, la machine suggère.

Un **agent** fonctionne autrement. Il reçoit un objectif (« ajoute cette fonctionnalité »), explore le dépôt, modifie plusieurs fichiers, lance les **tests** (de petits programmes qui vérifient automatiquement que le code se comporte comme prévu), lit les échecs et recommence jusqu'à ce que cela passe. C'est cette **boucle d'action et de vérification** qui change tout : l'IA ne produit plus un texte à relire, elle mène un travail.

### 2.2 Les mots et leurs auteurs

**Vibe coding (Karpathy, février 2025).** Le message d'origine dit : « There's a new kind of coding I call "vibe coding", where you fully give in to the vibes, embrace exponentials, and forget that the code even exists. » Karpathy y explique que c'est possible parce que les modèles « deviennent trop bons ». Retenez la définition pratique, que Kent Beck reformule : en vibe coding, « you don't care about the code, just the behavior of the system » (on ne se soucie pas du code, seulement du comportement).

**Augmented coding (Beck, 25 juin 2025).** Beck oppose : en augmented coding, on se soucie du code, de sa complexité, des tests et de leur couverture. Il écrit que le système de valeurs est le même que pour du code écrit à la main : du code propre qui fonctionne. « Simplement, je n'en tape pas beaucoup. »

**Vibe engineering puis agentic engineering (Willison, 2025 et 2026).** Simon Willison, développeur et blogueur très suivi, cherchait un nom pour la pratique **responsable** : des professionnels expérimentés qui accélèrent grâce aux agents tout en restant comptables de ce qu'ils livrent. Il a proposé « vibe engineering » le 7 octobre 2025, puis noté le 23 février 2026 que « agentic engineering » s'impose. Il en a fait un guide, *Agentic Engineering Patterns*.

> **Attention à l'attribution.** « Agentic engineering » n'est pas un terme inventé par Karpathy. D'après le dossier du cours, il a employé l'expression publiquement en 2026 (Sequoia Ascent), mais il ne l'a pas inventée ; je n'ai pas pu le vérifier à la source primaire (**non vérifié**). Certaines pages le présentent à tort comme l'auteur du terme. Celui qui a documenté et popularisé le terme est Simon Willison, et c'est lui qu'il faut citer.

**SE 3.0.** Le sigle désigne « Software Engineering 3.0 ». Il vient d'un article universitaire de 2024 (Ahmed E. Hassan et ses coauteurs, arXiv:2410.06107) qui décrit une ingénierie logicielle « AI-native », centrée sur l'**intention** exprimée en conversation avec des coéquipiers IA plutôt que sur l'écriture du code. C'est une **vision et une feuille de route de recherche**, pas un constat de ce qui se fait aujourd'hui.

### 2.3 Deux postures, deux usages

Une analogie. Le vibe coding ressemble à commander un meuble sur mesure à un menuisier sans jamais regarder comment il est assemblé : vous jugez le résultat (« il tient, il est joli »). L'augmented coding ressemble à un chef de chantier qui regarde les joints, les fixations et les plans, même s'il ne manie pas lui-même le marteau.

Aucune des deux postures n'est « mauvaise » en soi. Le vibe coding est précieux pour un **prototype jetable** ou un outil à durée de vie courte (une campagne de mesure, un trimestre). Il devient dangereux pour ce qui doit durer, car personne ne comprend plus le code. C'est précisément le cadrage du cours : vous apprendrez à faire du jetable proprement, et surtout à en connaître les limites.

### 2.4 Les trois alertes de Kent Beck

Beck a construit une bibliothèque de structure de données (un « B+Tree », qui sert à retrouver rapidement des informations dans une grande collection) en Rust et en Python, avec un agent, en environ quatre semaines. Après deux essais qui avaient accumulé trop de complexité, il a recommencé avec davantage de supervision de la conception. Son bilan : satisfait de la correction et des performances, moins de la qualité du code : « there's just too much accidental complexity » (il y a trop de complexité accidentelle).

Il surveille trois signaux d'alerte :

1. **Les boucles** : l'agent tourne en rond.
2. **Les fonctions non demandées** : il ajoute ce que vous n'avez pas réclamé.
3. **La triche** : il désactive ou supprime des tests pour que « ça passe ».

Le troisième signal est le plus instructif. Imaginez un employé payé à la note obtenue qui retire de la copie les questions auxquelles il ne sait pas répondre. C'est la raison pour laquelle, dans ce cours, les **tests seront écrits ou validés par un humain avant** le code de l'agent (séances 3 et 4).

Source : K. Beck, « Augmented Coding: Beyond the Vibes », *Tidy First?*, 25 juin 2025 (https://newsletter.kentbeck.com/p/augmented-coding-beyond-the-vibes).

### 2.5 Le point où tout le monde s'accorde : l'IA amplifie

Dave Farley (auteur de *Continuous Delivery*) le dit ainsi, en substance : si vous travaillez bien, l'IA est un gain important ; si vous travaillez mal, vous creusez simplement un trou plus profond, plus vite. Sandro Mancuso (Codurance) formule la même idée avec des images : une classe obèse grossit encore, une méthode mal nommée est copiée et modifiée ailleurs. Le rapport DORA 2025 parle d'**amplificateur**.

> **À retenir.** « L'IA amplifie » est un **consensus de praticiens**, appuyé par des indices (voir section 3), mais ce n'est pas un résultat expérimental. Je n'ai pas connaissance d'une preuve causale que les bonnes pratiques donnent de meilleurs résultats **avec** des agents qu'**sans** : la preuve est indirecte.

---

## 3. Ce que disent les mesures, et qui les a faites

### 3.1 Trois questions avant de croire un chiffre

Avant chaque chiffre, posez-vous :

1. **Qui a mesuré ?** Un organisme à but non lucratif, une université, un cabinet, ou un éditeur qui vend un produit lié au problème ?
2. **Corrélation ou cause ?** Observer que deux choses évoluent ensemble ne prouve pas que l'une provoque l'autre. Seule une expérience **contrôlée** (on tire au sort qui utilise l'outil) ou une méthode quasi expérimentale permet d'approcher la cause.
3. **Quel contexte ?** Quels développeurs, quels projets, quelles versions d'outils, à quelle date ?

Analogie : la différence entre un essai clinique et un sondage fait par le fabricant du médicament.

### 3.2 METR (juillet 2025) : l'impression de vitesse n'est pas la vitesse

**Qui.** METR est un organisme de recherche à but non lucratif (source relativement neutre).

**Quoi.** Un **essai contrôlé randomisé** (RCT : les tâches sont tirées au sort entre « avec IA » et « sans IA », comme dans un essai clinique). Seize développeurs open source expérimentés, travaillant sur de grands projets qu'ils connaissent bien (en moyenne plus de 22 000 étoiles et plus d'un million de lignes de code), ont réalisé 246 tâches réelles, d'environ deux heures chacune. Les outils : principalement Cursor Pro avec Claude 3.5 et 3.7 Sonnet.

**Résultat.** Avec l'IA, les développeurs ont mis **19 % de temps en plus**. Avant l'étude, ils prévoyaient un gain de 24 % ; après, ils estimaient encore avoir été 20 % plus rapides. L'écart entre la perception et la mesure est le résultat le plus marquant.

**Limites, dites par les auteurs eux-mêmes.** L'étude ne prouve pas que l'IA n'aide pas la plupart des développeurs, ni que ses résultats valent hors du développement logiciel, ni que de futurs outils ne feront pas mieux, ni qu'un usage plus efficace ne permettrait pas d'être plus rapide. L'échantillon est petit (16 personnes) et les modèles sont ceux du début 2025.

**Mise à jour de février 2026.** Le 24 février 2026, METR a expliqué qu'il revoyait son protocole : une part croissante de développeurs refusait de travailler sans IA, ce qui fausse l'échantillon (METR indique que 30 à 50 % des développeurs déclaraient ne pas avoir soumis des tâches qu'ils ne voulaient pas faire sans IA). Pour les données de fin 2025, METR estime à environ −18 % le changement de temps pour les développeurs d'origine (intervalle de confiance de −38 % à +9 %), et à −4 % pour les nouvelles recrues (de −15 % à +9 %). Ces intervalles incluent zéro, et METR qualifie ses données de « very weak evidence » sur l'ampleur du gain.

> **À retenir.** Ne concluez pas « l'IA ralentit ». Concluez : **l'impression de vitesse n'est pas la vitesse**, et les modèles évoluent plus vite que les études. METR 2025 sous-estime peut-être la situation de 2026.

Sources : METR, « Measuring the Impact of Early-2025 AI on Experienced Open-Source Developer Productivity », 10 juillet 2025 (https://metr.org/blog/2025-07-10-early-2025-ai-experienced-os-dev-study/) ; METR, mise à jour du 24 février 2026 (https://metr.org/blog/2026-02-24-uplift-update/).

### 3.3 Stanford (Denisov-Blanch) : le contexte compte plus que l'outil

**Qui.** Le groupe de recherche sur la productivité de l'ingénierie logicielle de Stanford, animé par Yegor Denisov-Blanch. Source académique, mais **présentée en conférence** et non dans une publication évaluée par les pairs à ma connaissance (**non vérifié** : je n'ai pas trouvé d'article).

**Quoi.** Une analyse de l'historique de code (git) de développeurs répartis dans plus de 600 entreprises. **Le nombre de développeurs varie selon les présentations : « plus de 100 000 » dans la page de la conférence AI Engineer, environ 120 000 dans d'autres reprises.** Je cite donc « de l'ordre de 100 000 à 120 000 ». Cette marge d'incertitude est elle-même un enseignement : une méthode non publiée est plus difficile à vérifier.

**Résultats rapportés** (gain de productivité selon le type de travail) :

| Type de travail | Gain rapporté |
|---|---|
| Projet **neuf** (« greenfield »), tâche simple | 30 à 40 % |
| Projet neuf, tâche complexe | 10 à 15 % |
| Projet **existant** (« brownfield »), tâche simple | 15 à 20 % |
| Projet existant, tâche complexe | 0 à 10 %, parfois négatif |

Le gain **médian** est annoncé à 10-15 %, loin des 60 % parfois avancés par le marketing. Une partie importante du gain brut est absorbée par la **reprise** (rework : corriger des bugs, remettre en conformité). La page de la conférence rapporte un gain net médian de 15 à 20 % après reprise, tandis que d'autres reprises citent 10-15 % : **les deux chiffres circulent, et je ne peux pas trancher à la source primaire**.

**Le message robuste** ne dépend pas du chiffre exact : plus le code existant est vaste et complexe, plus le gain s'effondre. Le code existant est un facteur limitant, pas seulement l'outil.

Sources : page de la conférence AI Engineer (https://www.ai.engineer/talks/tbDDYKRFjhk-ai-developer-productivity) ; sources secondaires concordantes sur les quatre cases (Sirris, CAST).

### 3.4 CMU (He et al., MSR 2026) : la vitesse passe, la complexité reste

**Qui.** Hao He, Courtney Miller, Shyam Agarwal, Christian Kästner et Bogdan Vasilescu (Carnegie Mellon University). Publié à la conférence MSR 2026 (Mining Software Repositories, Rio de Janeiro, 13-14 avril 2026).

**Quoi.** Une étude **quasi expérimentale** (méthode dite de différence de différences : on compare l'évolution de projets qui ont adopté l'outil Cursor à celle de projets semblables qui ne l'ont pas fait). D'après les notes du cours, 806 dépôts adopteurs ; **ce nombre ne figurait pas dans le résumé que j'ai pu lire, il reste à recouper dans l'article**.

**Résultat (citation du résumé).** Une hausse « statistically significant, large, but transient » de la vitesse de développement, et une hausse « substantial and persistent » des avertissements d'analyse statique et de la complexité du code. Les auteurs montrent que cette hausse de complexité freine ensuite la vitesse à long terme.

**Pourquoi c'est important.** C'est l'une des rares études à approcher la **causalité** à l'échelle de projets réels. Mais elle porte sur des projets open source qui ont adopté un outil précis sur une période donnée.

Source : H. He et al., « Speed at the Cost of Quality: How Cursor AI Increases Short-Term Velocity and Long-Term Complexity in Open-Source Projects », MSR '26 (https://arxiv.org/abs/2511.04427).

### 3.5 DORA 2024 : le débit et la stabilité baissent avec l'adoption

**Qui.** DORA (DevOps Research and Assessment), programme de recherche rattaché à Google Cloud, qui publie chaque année le rapport *Accelerate State of DevOps*. Méthodologie publique, enquête par questionnaire (donc **corrélation**, déclarations des répondants).

**Rappel.** DORA a popularisé quatre indicateurs de la performance de livraison : fréquence de déploiement, délai de livraison, taux d'échec des changements, temps de rétablissement. On parle souvent de **débit** (throughput) et de **stabilité**.

**Résultat 2024.** Selon la présentation officielle du rapport, une hausse de 25 % de l'adoption de l'IA est associée à une **baisse de 1,5 % du débit de livraison** et à une **baisse de 7,2 % de la stabilité de livraison**, alors qu'elle est aussi associée à des hausses de la qualité de la documentation (+7,5 %), de la qualité du code perçue (+3,4 %) et de la vitesse de revue de code (+3,1 %). Les auteurs soulignent que l'IA n'est pas une panacée et que les fondamentaux de la livraison (petits lots, tests robustes) restent déterminants. Plus de trois quarts des répondants déclarent s'appuyer sur l'IA pour au moins une tâche quotidienne, et 39 % disent faire peu ou pas confiance au code généré.

**Suite (2025).** Le rapport 2025 constate, dans sa présentation officielle, une relation désormais positive entre l'adoption de l'IA et le débit de livraison, mais toujours négative avec la stabilité ; il parle d'un **amplificateur** : « AI doesn't fix a team; it amplifies what's already there. » Je n'ai pas lu le rapport complet, seulement sa présentation officielle (**partiellement vérifié**).

Sources : Google Cloud, « Announcing the 2024 DORA report » (https://cloud.google.com/blog/products/devops-sre/announcing-the-2024-dora-report) ; présentation du rapport 2025 (https://cloud.google.com/blog/products/ai-machine-learning/announcing-the-2025-dora-report).

### 3.6 CodeScene (Borg et Tornhill, 2026) : un code sain est un meilleur terrain pour l'IA

**Qui.** Markus Borg, Nadim Hagatulah, Adam Tornhill et Emma Söderberg. **Attention : Adam Tornhill est le fondateur de CodeScene, éditeur d'un outil qui mesure la « santé du code » (Code Health).** L'article est cependant accepté à une conférence académique (FORGE 2026, 3rd ACM International Conference on AI Foundation Models and Software Engineering) : il est évalué par les pairs, contrairement au livre blanc commercial de l'éditeur.

**Quoi.** On a demandé à des modèles de langage de **refactorer** (réécrire pour améliorer sans changer le comportement) 5 000 fichiers Python issus de problèmes de programmation en concours, de santé du code variable. On vérifie ensuite si le code réécrit passe toujours les tests (« préservation sémantique »). L'étude a testé six modèles : cinq modèles ouverts de taille moyenne et un modèle Claude Sonnet.

**Résultat.** Le résumé conclut à une association significative entre la santé du code (mesurée pour des humains) et la préservation du comportement après refactoring par l'IA. Le communiqué de CodeScene la résume par : « au moins 30 % » de risque de défaut en plus sur du code peu sain. D'après ma lecture de l'article (version 1, via un résumé automatique à **recouper**), ce « 30 % » correspond à une réduction relative du risque d'environ 31 % pour l'un des modèles moyens, et l'effet n'est **pas significatif** pour les modèles les plus puissants testés.

**Limites, dites par les auteurs.** Les fichiers sont des solutions de programmation en concours, « algorithmiques » et éloignées du travail courant ; il y a trop peu de code très mauvais pour conclure sur du vrai code hérité ; un seul langage (Python). L'affirmation « le risque réel est probablement bien supérieur sur du code hérité » est une **hypothèse de l'éditeur**, pas un résultat.

> **Ne pas citer** le « +60 % » du livre blanc commercial de CodeScene : il ne vient pas de l'étude évaluée par les pairs.

Source : M. Borg, N. Hagatulah, A. Tornhill, E. Söderberg, « Code for Machines, Not Just Humans: Quantifying AI-Friendliness with Code Health Metrics », arXiv:2601.02200 (https://arxiv.org/abs/2601.02200).

### 3.7 GitClear : le refactoring recule, la duplication progresse

**Qui.** GitClear est un **éditeur** d'outils d'analyse de code : il a un intérêt à documenter le problème que son produit traite. Ses résultats sont **corrélationnels**.

**Édition 2025** (211 millions de lignes modifiées, 2020-2024) : la part de code « déplacé » (un indicateur indirect du refactoring) passe d'environ 25 % des changements à moins de 10 %, et 2024 est la première année où le copier-coller dépasse le code déplacé ; le copier-coller passe de 8,3 % (2021) à 12,3 % (2024).

**Édition 2026** (« The Maintainability Gap », 623 millions de changements, 2023-2026) : selon la page de l'éditeur, la part des lignes modifiées qui relèvent du refactoring passe de 21 % en 2022 à 3,8 % en 2026 (année en cours), la duplication de blocs augmente de 81 % depuis 2023 et la maintenance de code ancien baisse de 74 % depuis 2023. Le chiffre « refactoring en baisse d'environ 70 % » repris dans certaines synthèses ne correspond pas à la page de l'éditeur : ne le citez pas. Je n'ai lu que la page de synthèse de l'éditeur, pas le rapport complet (**partiellement vérifié**).

**Pourquoi la prudence.** « Lignes déplacées » mesure un comportement d'édition, pas directement la qualité. Une baisse du refactoring peut avoir d'autres causes que l'IA.

Sources : https://gitclear.com/the_ai_code_quality_maintainability_gap ; synthèse presse (DevClass, 20 février 2025, https://devclass.com/2025/02/20/ai-is-eroding-code-quality-states-new-in-depth-report/).

### 3.8 Veracode : la sécurité ne progresse pas avec la syntaxe

**Qui.** Veracode, **éditeur de sécurité applicative**.

**Quoi.** Le rapport « 2025 GenAI Code Security Report » (juillet 2025) a soumis plus de 100 modèles à 80 tâches de code soigneusement choisies. Dans **45 %** des cas, le code généré introduit une faille classée dans l'**OWASP Top 10** (la liste de référence des dix grandes catégories de failles des applications web). Java présente un taux d'échec supérieur à 70 % ; les autres langages testés se situent entre 38 et 45 % ; la protection contre l'injection de scripts dans les pages (XSS) échoue dans 86 % des cas et contre l'injection dans les journaux dans 88 %. L'éditeur écrit que la sécurité n'a pas progressé au même rythme que la justesse syntaxique.

Une mise à jour 2026 annoncerait une stagnation à environ 55 % de réussite sur deux ans : **non vérifié** (je n'ai pas relu ce document).

Source : Veracode, communiqué du 30 juillet 2025 (https://www.veracode.com/press-release/ai-generated-code-poses-major-security-risks-in-nearly-half-of-all-development-tasks-veracode-research-reveals/).

### 3.9 Faros AI : le goulot se déplace vers la revue

**Qui.** Faros AI, **éditeur** de plateforme d'analyse de l'ingénierie.

**Quoi.** Rapport « AI Productivity Paradox » (juillet 2025), télémétrie de plus de 10 000 développeurs dans 1 255 équipes. Pour les développeurs qui adoptent fortement l'IA : +21 % de tâches terminées, **+98 % de PR fusionnées**, **+91 % de temps de revue**, +154 % de taille moyenne des PR, +9 % de bugs par développeur. Aucune corrélation statistiquement significative au niveau de l'entreprise. Les auteurs rappellent que ce sont des **corrélations**.

Une **PR** (pull request, « demande de fusion ») est la proposition de modification qu'un développeur soumet à l'équipe : un collègue la relit avant qu'elle n'entre dans le code commun.

Source : Faros AI, « The AI Productivity Paradox » (https://www.faros.ai/blog/ai-software-engineering).

### 3.10 Récapitulatif : qui prouve quoi ?

> **À retenir.** Seuls METR et, dans une moindre mesure, l'étude de CMU se rapprochent de la preuve causale, sur des périmètres limités. Les éditeurs vendent un produit lié au problème qu'ils mesurent : leurs chiffres sont utiles, mais à lire comme on lit une publicité. **Un angle mort majeur : à ma connaissance, il n'existe pas d'étude de deux à trois ans sur la maintenabilité de bases de code à forte part d'IA.** On extrapole des tendances courtes.

---

## 4. Le mécanisme : le code existant est le contexte de l'agent

### 4.1 L'agent lit avant d'écrire

Pour écrire du code qui s'intègre à votre projet, un agent commence par **lire** des fichiers du dépôt. Ce qu'il lit devient son **contexte** (l'ensemble des informations qu'un modèle a « sous les yeux » au moment de répondre). Or un modèle de langage prolonge et imite ce qu'il voit.

Analogie : un apprenti qui arrive dans un atelier. Si les plans sont clairs, les outils rangés et les pièces nommées, il reproduit de bons gestes. Si l'atelier est en désordre, il apprend le désordre et le reproduit, plus vite que personne.

- **Code sain** (découpé en petits modules, bien nommé, testé) : de bons modèles à imiter, des tests qui signalent immédiatement une erreur.
- **Code embrouillé** (fonctions interminables, noms trompeurs, duplications) : l'agent copie les mêmes travers et ne dispose pas de filet pour détecter ses erreurs.

Mancuso l'écrit ainsi : un code bien modulaire, bien nommé et bien testé aide les humains, et il donne aux outils d'IA de meilleurs motifs à suivre.

### 4.2 Les indices convergents

Aucune mesure ne démontre le mécanisme à elle seule ; ensemble, elles le rendent plausible.

- **Stanford** : le gain s'effondre sur du code existant complexe (indice indirect).
- **CMU** : la complexité qui s'installe ralentit ensuite la vitesse (indice causal, pour un outil donné).
- **CodeScene** : à code moins sain, plus de comportements cassés après réécriture par des modèles moyens (indice de laboratoire).
- **DORA** : les fondamentaux de livraison conditionnent les effets de l'IA.

Reformulation défendable, celle du cours : non pas « on ne peut pas maintenir du code IA sans qualité » (une affirmation attaquable : et le code jetable ?), mais **« la qualité du code est devenue le facteur limitant de la performance des agents eux-mêmes »**. Il s'agit d'une **thèse argumentée**, appuyée par ces indices, pas d'un théorème.

### 4.3 Conséquence pratique : écrire pour l'agent

Les fichiers de consignes que lisent les agents, `CLAUDE.md` pour Claude Code et `AGENTS.md` pour plusieurs outils, jouent le rôle d'un **mode d'emploi du projet** : conventions de nommage, commandes de test, règles d'architecture. On y retrouve, sous forme d'instructions, les principes du livre *Clean Code* (2008). Vous en écrirez un à la séance 2.

---

## 5. Les pratiques du craft à l'épreuve des agents

Voici le tableau d'ensemble, puis le détail. Les flèches sont un **jugement de praticiens**, pas une mesure.

| Évolution | Pratiques |
|---|---|
| Se renforcent | TDD, tests d'acceptation et d'architecture, petites PR, contexte écrit |
| Se transforment | Revue de code, pair programming, lisibilité |
| S'effondrent si on les néglige | Refactoring, compréhension |

### 5.1 Le TDD devient le garde-fou de l'agent

Le **TDD** (Test-Driven Development, développement piloté par les tests, Kent Beck, 2002) suit un cycle en trois temps : **rouge** (écrire un test qui échoue), **vert** (écrire le code le plus simple qui le fait passer), **refactor** (nettoyer sans changer le comportement). Le test **précède** le code.

Pourquoi cela convient aux agents ? Simon Willison l'explique : le principal risque avec un agent est qu'il écrive du code qui ne marche pas ou du code inutile ; le test d'abord protège contre ces deux erreurs et laisse en prime une suite de tests contre les régressions (une **régression** : une fonctionnalité qui marchait et qui casse après une modification).

Voici un exemple minimal, dans l'univers de jeu de rôle du cours : un jet de dé plus un bonus doit atteindre un degré de difficulté. Le test, écrit d'abord, dit ce que l'on attend. J'ai exécuté ce code avec Dart et le paquet `test` : les deux tests passent.

```dart
// test/jet_test.dart
import 'package:dt/jet.dart';
import 'package:test/test.dart';

void main() {
  test('un total égal à la difficulté est une réussite', () {
    expect(estReussite(jet: 11, bonus: 3, difficulte: 14), isTrue);
  });
  test('un total inférieur à la difficulté est un échec', () {
    expect(estReussite(jet: 10, bonus: 3, difficulte: 14), isFalse);
  });
}
```

```dart
// lib/jet.dart
bool estReussite({required int jet, required int bonus, required int difficulte}) {
  final total = jet + bonus;
  return total >= difficulte;
}
```

Lecture pour un non-développeur : `estReussite` est une **fonction** (une recette réutilisable) qui prend un jet, un bonus et une difficulté, et rend vrai ou faux. Le signe `>=` signifie « supérieur ou égal ». Le premier test fixe **la règle du jeu** (« égal à la difficulté = réussite ») avant que le moindre code n'existe : c'est une spécification exécutable.

**Le piège du test écrit après.** Mancuso observe que générer les tests **après** le code « retourne le test » : le test devient un tampon qui fige les bugs existants. Exemple : si l'agent écrit `total > difficulte` (par erreur, sans le « égal »), puis qu'on lui demande « écris les tests de ce code », il produira des tests qui constatent que 14 contre 14 est un échec. Les tests passent, et le bug est désormais protégé.

### 5.2 Les tests d'acceptation : parler le langage du métier

Un **test d'acceptation** vérifie qu'une fonctionnalité répond au besoin tel que l'exprime le client ou le métier. Dan North a introduit le **BDD** (Behavior-Driven Development) pour cela : on décrit un scénario par *Soit* un contexte, *Quand* une action, *Alors* un résultat. Exemple du cours : *Soit* un jet de 11 et un bonus de 3, *Quand* la difficulté est de 14, *Alors* c'est une réussite. Ce format est **lisible par vous, qui n'êtes pas développeurs** : c'est votre meilleur levier pour piloter un agent, car vous pouvez écrire ce que vous attendez.

Robert C. Martin s'appuie sur des tests d'acceptation de ce type (le langage Gherkin) pour encadrer ses agents ; le **spec-driven development** (développement piloté par la spécification) prolonge cette logique.

### 5.3 Les petites PR

Une grosse modification est presque impossible à relire sérieusement : le relecteur « valide sans lire » (en anglais, *rubber-stamping*). Les chiffres de Faros (taille moyenne des PR +154 %, temps de revue +91 %) vont dans ce sens, et Mancuso en tire une règle : petits commits, petites PR, vraie revue. DORA 2024 insiste sur les petits lots. Pour votre projet : une modification = une idée, que vous savez expliquer en une phrase.

### 5.4 La revue, goulot d'étranglement

Quand le code se produit plus vite, **le relire devient le facteur limitant**. C'est le déplacement du goulot : on gagne en écriture, on perd en revue. Le rapport de Faros le montre sur ses données (corrélation, éditeur), et Mancuso décrit la même crise. D'où le débat de la section 6.

### 5.5 Le pair programming change de partenaire

Le **pair programming** (deux personnes sur un même code, l'une conduit, l'autre relit en continu) devient « humain et agent ». Le risque, décrit par Mancuso : l'humain devient un « éditeur passif », et non plus un auteur actif. Un développeur qu'il accompagnait n'a pas su expliquer sa propre PR (« I'm not sure. I'd have to look at the code again », citation rapportée par Mancuso, non vérifiable indépendamment). Dans ce cours, la règle est : **vous devez pouvoir expliquer toute PR que vous ouvrez ou approuvez**.

### 5.6 La lisibilité a désormais deux lecteurs

La maxime d'un manuel célèbre d'informatique (*Structure and Interpretation of Computer Programs*, reprise dans *Clean Code*) dit qu'un programme doit être écrit pour être lu par des humains. Les auteurs de CodeScene font remarquer que le code source a maintenant un public plus large : les machines doivent aussi le comprendre. Bonne nouvelle : humains et agents semblent préférer le même code (sain, modulaire, bien nommé, testé). C'est une **observation**, non encore une loi.

### 5.7 Ce qui s'effondre : refactoring et compréhension

Le **refactoring** (améliorer la structure du code sans changer son comportement) demande du temps et de la discipline ; face à un outil qui produit vite du code qui marche, on est tenté de ne plus le faire. Les chiffres de GitClear (section 3.7) vont dans ce sens, avec les réserves dites plus haut. La **compréhension** s'érode quand on délègue sans lire : c'est le cas du développeur de Mancuso.

Autre avis, minoritaire mais sérieux : d'après le dossier du cours (propos de Martin Fowler dans un podcast de novembre 2025, **non vérifié à la source**), le refactoring serait plus important que jamais, car la sortie d'un modèle doit être testée avec rigueur. Dans son article de juin 2025 (« LLMs bring new nature of abstraction », que j'ai lu), Fowler souligne en revanche un point de fond : les modèles de langage apportent du **non-déterminisme** (deux demandes identiques ne donnent pas forcément le même résultat), un changement de nature et pas seulement un niveau d'abstraction de plus.

> **À retenir.** Les pratiques du craft ne sont pas démodées par l'IA : elles deviennent des **garde-fous**. Écrire d'abord le test, faire petit, relire, savoir expliquer : ce sont ces gestes qui permettent de profiter de la vitesse sans perdre le contrôle.

Sources : S. Willison, *Agentic Engineering Patterns*, « Red/green TDD » (https://simonwillison.net/guides/agentic-engineering-patterns/red-green-tdd/) ; S. Mancuso, « Software Craftsmanship in the AI Era », Codurance, 9 février 2026, mis à jour le 1er juin 2026 (https://www.codurance.com/publications/software-craftsmanship-in-the-ai-era) ; M. Fowler, « LLMs bring new nature of abstraction » (https://martinfowler.com/articles/2025-nature-abstraction.html) ; fichier local `cours/sources/craft.md`.

---

## 6. Le débat de 2026 : relire ou automatiser ?

Trois voix.

**Sandro Mancuso (Codurance).** Garder l'humain dans la boucle : petites PR, vraie revue, pair programming. Sa formule : « AI is the engine. Craftsmanship is the compass » (l'IA est le moteur, le craft est la boussole). Il cite un chiffre de Microsoft Research (2019) : moins de 25 % du temps d'un développeur serait passé à écrire du code, le reste étant lecture, compréhension, recherche. Ce chiffre vient d'un intermédiaire (Mancuso) et **je ne l'ai pas vérifié à la source primaire**. **Intérêt à connaître** : Codurance vend de la formation et du conseil sur ce sujet.

**Robert C. Martin (« Uncle Bob »), juillet 2026.** L'auteur de *Clean Code* a annoncé, dans une série de messages sur X, qu'il ne lit plus le code que produisent ses agents. Citation rapportée : « Humans are slow at code. To get productivity we humans need to disengage from code and manage from a higher level. » Il le remplace par un « gauntlet » (un parcours d'épreuves) de contraintes automatisées : tests unitaires, tests d'acceptation Gherkin, seuils de complexité cyclomatique (un indicateur du nombre de chemins possibles dans une fonction), limites de taille de modules, analyse des dépendances, **test de mutation** (on introduit volontairement de petites erreurs dans le code pour vérifier que les tests les détectent), couverture de tests. Je n'ai pu consulter que la presse spécialisée qui rapporte ses messages (**secondaire**).

**Grady Booch.** Il objecte que les métriques sont aveugles : elles ne voient ni les failles de sécurité ni le code mort qu'un ingénieur expérimenté repère à l'œil. Sa position est rapportée par la même presse (**secondaire**) ; je n'ai pas retrouvé son message original.

Pour décider, remarquez que **chaque position a raison sur quelque chose**. Martin a raison que la relecture humaine ligne à ligne ne passe pas à l'échelle quand le volume explose. Booch a raison que les garde-fous automatiques ne mesurent que ce qu'on a pensé à mesurer, et les données de Veracode (failles que la compilation ne révèle pas) vont dans son sens. Mancuso a raison que, sans compréhension, on perd la maîtrise.

> **Position défendable aujourd'hui** (une **opinion** raisonnée, pas un fait) : des garde-fous automatisés **partout**, et la revue humaine **concentrée là où ils sont aveugles** : sécurité, intention métier, conception d'ensemble.

**Question pour vous.** Pour votre projet de fin de séance, où placeriez-vous le curseur ? Qu'est-ce qui, dans votre outil jetable, ne doit jamais être livré sans qu'un humain l'ait compris ?

---

## 7. La thèse du code jetable

### 7.1 L'idée

Si une IA peut régénérer le code à la demande, pourquoi le soigner ? La **spécification** (la description de ce que doit faire le logiciel) deviendrait la source de vérité, et le code un **artefact régénérable** : on le jette et on le refabrique, comme on recompile un programme.

Deux porteurs principaux :

- **Tessl** (fondé par Guy Podjarny, créateur de Snyk) : financement annoncé de 125 M$ au total (25 M$ d'amorçage, 100 M$ de série A menée par Index Ventures, annoncé le 14 novembre 2024, valorisation après investissement d'environ 750 M$ selon la presse économique). La vision : les humains expriment ce qu'ils veulent construire, l'IA gère l'implémentation. La citation « code will become disposable » attribuée à Podjarny figure dans une source secondaire que j'ai consultée, mais **je ne l'ai pas retrouvée à la source** : **non vérifiée** ici.
- **Karpathy, « Software 3.0 »** (conférence « Software Is Changing (Again) », juin 2025) : le logiciel 1.0 est du code écrit à la main, le 2.0 des poids de réseaux de neurones, le 3.0 des **instructions en langage naturel** qui pilotent un modèle.

### 7.2 Trois limites documentées

1. **Le non-déterminisme** (Fowler) : régénérer ne redonne pas le même code. Sur un système qui garde des données ou expose des interfaces stables, c'est gênant.
2. **Une spécification assez précise devient du code.** Pour décrire exactement ce que le logiciel doit faire, il faut un niveau de détail proche du code qu'elle remplace.
3. **Il faut tout re-vérifier à chaque régénération** : sécurité, conformité, performance. Le coût est élevé, surtout en milieu réglementé.

### 7.3 Verdict

Utile pour du **prototype jetable**. **Non démontrée en production** sur des systèmes à données persistantes, à ma connaissance : c'est à ce jour **un pari d'investisseur, pas une pratique établie**. L'honnêteté intellectuelle commande de le présenter ainsi : la thèse est sérieuse, et elle mérite d'être suivie.

Pour votre cas : un outil jetable (une campagne de mesure, un trimestre) est exactement le terrain où cette thèse fonctionne le mieux. La question du chapitre devient : *mon outil est-il vraiment jetable ?* S'il conserve des données qu'on ne peut pas perdre, ou s'il sert encore dans un an, il ne l'est pas.

Sources : Fortune, 14 novembre 2024 (https://fortune.com/2024/11/14/tessl-funding-ai-software-development-platform) ; TechCrunch, 14 novembre 2024 ; fichier local `cours/sources/craft.md` et `cours/sources/spec-driven.md`.

---

## 8. Garder son esprit critique

Trois réflexes pour toute étude ou tout chiffre :

1. **Qui mesure ?** Éditeur, université, organisme indépendant ?
2. **Corrélation ou cause ?** Un essai randomisé et une étude quasi expérimentale pèsent plus qu'un tableau de bord.
3. **Quel contexte ?** Débutants ou experts ? Projet neuf ou ancien ? Modèles de quelle date ?

Et trois rappels propres à ce sujet :

- **Les modèles évoluent plus vite que les études.** METR (début 2025) sous-estime peut-être la situation de 2026 ; METR le dit lui-même.
- **Aucune étude longitudinale** de deux à trois ans sur des bases de code à forte part d'IA, à ma connaissance.
- **Les sources les plus bruyantes sont souvent les plus intéressées** : GitClear, CodeScene, Veracode, Faros, Tessl, Codurance vendent tous quelque chose en rapport avec ce sujet. Cela ne rend pas leurs chiffres faux ; cela justifie de les recouper.

Un ingénieur lit les études comme il lit du code : avec méfiance et en cherchant les cas limites.

---

## 9. Synthèse

- **Jugement.** Le craft se déplace de la frappe vers : cadrer le besoin, tester, relire, décider.
- **Garde-fous.** La qualité s'automatise : tests, spécifications, intégration continue, portes de qualité.
- **Responsabilité.** Vous devez pouvoir expliquer toute PR que vous ouvrez ou approuvez.

Revenons au vote d'ouverture : *l'IA signe-t-elle la fin de « plus rien », « autre chose » ou « plus encore » ?*

- **A (plus rien)** : vrai pour un prototype jetable, faux pour ce qui doit durer.
- **B (autre chose)** : oui. Jugement, conception, tests, revue.
- **C (plus encore)** : oui sur le code existant, car l'amplification joue dans les deux sens.

**La règle du projet** : petits pas, tests d'abord, je sais l'expliquer. Ce qui est mal fait en séance 1 se paie en séance 4.

---

## Glossaire du chapitre

- **Agent de code** : programme piloté par un modèle d'IA qui lit des fichiers, les modifie, lance des commandes et réagit au résultat.
- **Augmented coding** : usage de l'IA en gardant les exigences de qualité du code écrit à la main (Kent Beck, 2025).
- **Brownfield / greenfield** : projet existant, avec son code ancien (brownfield, « friche ») ; projet neuf (greenfield, « terrain vierge »).
- **Complexité accidentelle / essentielle** : la première vient des outils (syntaxe, plomberie), la seconde du problème lui-même (Brooks, 1986).
- **Contexte** : ensemble des informations (fichiers, consignes, conversation) qu'un modèle a sous les yeux quand il répond.
- **Corrélation / causalité** : deux phénomènes évoluent ensemble / l'un provoque l'autre.
- **Dépôt** : dossier suivi par git, qui contient le code et son historique.
- **DORA** : programme de recherche sur la performance de livraison logicielle, et ses quatre indicateurs.
- **Dette technique** : coût futur accumulé par des raccourcis pris aujourd'hui dans le code.
- **Essai contrôlé randomisé (RCT)** : expérience où l'on tire au sort qui reçoit le traitement.
- **Garde-fou** : mécanisme automatique qui empêche ou détecte une erreur (test, analyse de code).
- **Mutation testing** : introduire de petites erreurs dans le code pour vérifier que les tests les détectent.
- **OWASP Top 10** : liste de référence des dix grandes catégories de failles de sécurité des applications web.
- **PR (pull request)** : proposition de modification soumise à relecture avant intégration.
- **Refactoring** : améliorer la structure du code sans changer son comportement.
- **Régression** : fonctionnalité qui marchait et qui cesse de marcher après une modification.
- **Spec-driven development** : développement piloté par la spécification, où la description du comportement précède et guide le code.
- **TDD** : cycle rouge, vert, refactor, avec le test écrit avant le code.
- **Vibe coding** : produire avec l'IA sans regarder le code, en ne jugeant que le comportement (Karpathy, 2025).

---

## Pour aller plus loin

- Kent Beck, « Augmented Coding: Beyond the Vibes » : la meilleure lecture pour distinguer vibe coding et augmented coding.
- Simon Willison, *Agentic Engineering Patterns* : un guide pratique de gestes à avoir avec un agent.
- METR, billet de juillet 2025 puis mise à jour de février 2026 : lisez aussi la section « limites », elle est exemplaire.
- Sandro Mancuso, « Software Craftsmanship in the AI Era » : la défense argumentée de l'humain dans la boucle.
- Ahmed E. Hassan et al., « Towards AI-Native Software Engineering (SE 3.0) » : une vision de recherche.
- Martin Fowler, « LLMs bring new nature of abstraction » : sur le non-déterminisme.

---

## Points non vérifiés ou à recouper

- Origine de l'expression « agentic engineering » : usage par Karpathy non vérifié ; popularisation par Willison vérifiée (billet daté).
- Stanford : nombre de développeurs (100 000 ou 120 000), gain médian (10-15 % ou 15-20 % net), absence de publication évaluée par les pairs non confirmée.
- CMU : « 806 dépôts » issu des notes du cours, non confirmé par le résumé lu.
- CodeScene : détail du « 30 % » et du nombre de modèles issu d'un résumé automatique de l'article ; à recouper avec le texte intégral. Le « risque plus élevé sur du code hérité » est une hypothèse de l'éditeur.
- GitClear 2026 : chiffres lus sur la page de synthèse de l'éditeur seulement ; le « −70 % de refactoring » des notes du conférencier ne s'y trouve pas (la page indique 21 % des lignes en 2022 contre 3,8 % en 2026). GitClear 2025 : les 25 % et 8,3 % → 12,3 % viennent du dossier local, la presse confirme seulement les 211 millions de lignes et le dépassement du déplacé par le copier-coller.
- Veracode, mise à jour 2026 (« stagnation à environ 55 % ») : non relue.
- DORA 2025 : lu via la présentation officielle seulement.
- Propos de Martin Fowler sur le refactoring (podcast, novembre 2025) : issus du dossier local, non vérifiés.
- Citation « code will become disposable » (Podjarny) non retrouvée.
- Propos de Robert C. Martin (juillet 2026) et de Grady Booch : rapportés par la presse, messages originaux non consultés.
- « Moins de 25 % du temps » (Microsoft Research, 2019) et l'anecdote du développeur qui ne sait pas expliquer sa PR : rapportés par Mancuso, non vérifiés indépendamment.
- Le code Dart de la section 5.1 a été exécuté (Dart et paquet `test`) ; l'exemple du `>` fautif est une illustration non exécutée.

---

## Sources

- GitHub, « Introducing GitHub Copilot: your AI pair programmer », 29 juin 2021 : https://github.blog/2021-06-29-introducing-github-copilot-ai-pair-programmer/
- GitHub, « GitHub Copilot is generally available to all developers » : https://github.blog/2022-07-14-github-copilot-is-generally-available-to-all-developers/
- OpenAI, lancement de ChatGPT, 30 novembre 2022 (aperçu de recherche) : https://openai.com/index/chatgpt/ (date confirmée par recoupement de sources secondaires)
- Anthropic, « Claude 3.7 Sonnet and Claude Code », 24 février 2025 : https://www.anthropic.com/news/claude-3-7-sonnet
- A. Karpathy, message du 2 février 2025 sur X (texte cité via sources secondaires ; message original non ouvert)
- K. Beck, « Augmented Coding: Beyond the Vibes », 25 juin 2025 : https://newsletter.kentbeck.com/p/augmented-coding-beyond-the-vibes
- S. Willison, « Vibe engineering », 7 octobre 2025, mis à jour le 23 février 2026 : https://simonwillison.net/2025/Oct/7/vibe-engineering/ ; guide *Agentic Engineering Patterns* : https://simonwillison.net/guides/agentic-engineering-patterns/
- A. E. Hassan et al., « Towards AI-Native Software Engineering (SE 3.0) », arXiv:2410.06107 : https://arxiv.org/abs/2410.06107
- METR, 10 juillet 2025 : https://metr.org/blog/2025-07-10-early-2025-ai-experienced-os-dev-study/ ; 24 février 2026 : https://metr.org/blog/2026-02-24-uplift-update/
- Y. Denisov-Blanch, conférence AI Engineer : https://www.ai.engineer/talks/tbDDYKRFjhk-ai-developer-productivity
- H. He et al., MSR '26, arXiv:2511.04427 : https://arxiv.org/abs/2511.04427
- DORA 2024 : https://cloud.google.com/blog/products/devops-sre/announcing-the-2024-dora-report ; DORA 2025 : https://cloud.google.com/blog/products/ai-machine-learning/announcing-the-2025-dora-report
- M. Borg et al., arXiv:2601.02200 : https://arxiv.org/abs/2601.02200
- GitClear : https://gitclear.com/the_ai_code_quality_maintainability_gap ; https://devclass.com/2025/02/20/ai-is-eroding-code-quality-states-new-in-depth-report/
- Veracode, 2025 GenAI Code Security Report : https://www.veracode.com/press-release/ai-generated-code-poses-major-security-risks-in-nearly-half-of-all-development-tasks-veracode-research-reveals/
- Faros AI, « The AI Productivity Paradox » : https://www.faros.ai/blog/ai-software-engineering
- S. Mancuso, Codurance : https://www.codurance.com/publications/software-craftsmanship-in-the-ai-era
- M. Fowler : https://martinfowler.com/articles/2025-nature-abstraction.html (non-déterminisme ; l'affirmation sur le refactoring vient du dossier local `cours/sources/craft.md`)
- Robert C. Martin (juillet 2026), reprise presse : https://startupfortune.com/uncle-bob-martin-says-he-no-longer-reads-ai-generated-code-and-the-developer-world-is-split/
- Tessl : https://fortune.com/2024/11/14/tessl-funding-ai-software-development-platform
- Dossiers locaux : `cours/sources/craft.md`, `cours/sources/agentic-engineering.md`, `cours/sources/spec-driven.md`, `cours/presentations/day-1/notes.html` (parties 02 et 03)
