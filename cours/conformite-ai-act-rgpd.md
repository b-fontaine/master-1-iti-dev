# Conformité : AI Act et RGPD pour des applicatifs ponctuels

> **Sensibilisation, pas avis juridique.** Ce module donne des repères pour reconnaître les limites d'un projet et connaître ses droits. Il ne remplace ni le RSSI, ni le délégué à la protection des données (DPO), ni un juriste. Toute mise en usage réelle d'un applicatif passe par une validation du RSSI (et du DPO le cas échéant).
>
> Public : étudiants de Master ITI (industrie et innovation), non développeurs. Usage : support pour l'enseignant, réutilisable tel quel en séance (S1 : règle d'or ; S3 : données et RGPD, dont le §5 « vos droits » en 15 min ; S4 : AI Act, fiche de conformité, validation RSSI).
>
> **Répartition des contenus** (séances de 4 h) : en S3, indispensable en séance : rappel de la règle d'or, RGPD (§2 et §4), §5 (15 min), début de la fiche (§6.1) ; se fait hors séance (tâche facultative S3→S4) : l'exercice de courriel du §5. En S4, indispensable en séance : atelier de classification (§8.1, 40 min) et passage devant le RSSI (§8.2, 3 tables en parallèle) ; peut glisser dans le sprint : le quiz (§8.3, 10 min). **Livrable de fin de S3 (identique pour les trois thèmes)** : première règle verte, modèle et migrations fusionnés, début de `docs/fiche_conformite.md` commité.
>
> Les mentions « (à vérifier) » signalent ce qui n'a pas été confirmé sur une source officielle au moment de la rédaction.

## 0. Vérification du calendrier (faite le 1er octobre 2026)

Sources consultées le 1er octobre 2026 : page de la Commission européenne sur le cadre réglementaire de l'IA (digital-strategy.ec.europa.eu) et plusieurs synthèses de cabinets juridiques (Morgan Lewis, Gibson Dunn, Cooley, DLA Piper). Le texte officiel de l'omnibus sur EUR-Lex n'a pas été relu directement : les dates ci-dessous sont donc **à vérifier** sur EUR-Lex avant diffusion. Aucune de ces dates ne figure dans les notes de `cours/sources/`.

| Échéance | Contenu | Statut au 1er octobre 2026 |
|---|---|---|
| 1er août 2024 (à vérifier) | Entrée en vigueur du règlement (UE) 2024/1689 | Confirmé |
| 2 février 2025 (à vérifier) | Pratiques interdites (art. 5) et obligation de maîtrise de l'IA (art. 4) | En application (la Commission indique que ces règles sont en vigueur) |
| 2 août 2025 (à vérifier) | Gouvernance et obligations des modèles d'IA à usage général (GPAI) | En application |
| 2 août 2026 | Date initiale de l'essentiel du règlement, dont transparence (art. 50) | Art. 50 maintenu, avec un report au 2 décembre 2026 pour certaines obligations de marquage des contenus générés (systèmes déjà sur le marché avant le 2 août 2026) (à vérifier) |
| 2 décembre 2027 | Systèmes à haut risque de l'annexe III (éducation, emploi, biométrie, etc.) | **Reportés** par l'omnibus numérique sur l'IA (à vérifier) |
| 2 août 2028 | Haut risque intégré à des produits réglementés (annexe I) | **Reporté** (à vérifier) |

**Omnibus numérique sur l'IA** : accord politique le 7 mai 2026 (à vérifier), vote du Parlement le 16 juin 2026 (à vérifier), adoption du Conseil le 29 juin 2026 (à vérifier), signature le 8 juillet 2026 (à vérifier), entrée en vigueur le 27 juillet 2026 (à vérifier) (dates issues des synthèses et de la page de la Commission ; à vérifier sur EUR-Lex).

**Acte modificatif** : règlement (UE) 2026/1744 modifiant le règlement (UE) 2024/1689, publié au Journal officiel le 24 juillet 2026, en vigueur le 27 juillet 2026 (à vérifier sur EUR-Lex).

**Ce qui reste incertain ou à surveiller** :
- le texte exact de l'article 4 après l'omnibus : l'obligation est « allégée » (voir §3 pour la formulation retenue, à vérifier sur EUR-Lex). Pour la formation, on retient l'esprit : **être capable de former et de se former à l'IA** ;
- les lignes directrices de la Commission sur la classification haut risque et l'article 50 (publication et contenu à vérifier) ;
- l'omnibus numérique « données/RGPD » (volet distinct de l'omnibus IA), dont le statut n'a pas été vérifié : **à vérifier**. Ne pas affirmer que le RGPD a été assoupli ;
- le report ne dit **rien** sur le RGPD : il s'applique pleinement depuis le 25 mai 2018.

Conséquence pédagogique : même si le haut risque n'est obligatoire qu'à partir de fin 2027, on raisonne dès maintenant comme si c'était applicable. C'est la bonne pratique de prudence, et le RSSI raisonne ainsi.

## 1. Pourquoi ce module

Trois raisons, qui correspondent aux trois objectifs de la formation.

1. **Connaître les limites de ses projets.** L'IA permet de fabriquer vite un outil jetable. Elle ne rend pas l'outil légal, sûr ou hébergeable. Un outil « pour une semaine » traite des données comme un outil pour dix ans.
2. **Faire valider par le RSSI.** Réflexe professionnel : aucun applicatif ne touche des données réelles ni n'est mis à disposition d'autres personnes sans validation du responsable de la sécurité des systèmes d'information (et du DPO si des données personnelles sont en jeu). Dans la formation, le RSSI est **simulé par l'enseignant** ou **tenu par le RSSI de l'établissement** (choix à faire par l'enseignant avant S3 ; dans les deux cas le déroulé est le même). En S4, trois tables en parallèle : un RSSI par table (enseignant, RSSI de l'établissement, aide ou second intervenant ; à défaut étudiant volontaire avec la grille).
3. **Connaître ses droits de citoyen européen.** Ces règles protègent aussi les étudiants : ils sont des personnes concernées (courriels, notes, vœux, données de connexion, usage de services d'IA).

**Règle d'or dès S1** : aucune donnée personnelle ni confidentielle dans un prompt ni dans un dépôt public. Les dépôts de la formation sont publics : tout ce qui y entre est publié. Il en va de même du build web Flutter publié sur GitHub Pages : il est public, tout ce qu'il contient (code, données embarquées, fichiers d'actifs) est lisible par n'importe qui. Donnée fictive uniquement, aucun secret dans l'application ni dans le bundle web.

## 2. Le RGPD en une page

Règlement (UE) 2016/679, applicable depuis le 25 mai 2018. Autorité de contrôle française : la **CNIL**.

**Champ** (art. 2 et 3) : tout traitement de **données à caractère personnel** (information se rapportant à une personne identifiée ou identifiable, art. 4). Un pseudonyme reste une donnée personnelle si la ré-identification est possible (art. 4, point 5, et considérant 26). Une donnée vraiment anonyme sort du champ, mais c'est rarement facile à garantir.

**Principes** (art. 5) : licéité, loyauté, transparence ; limitation des finalités ; **minimisation** ; exactitude ; **limitation de la conservation** ; intégrité et confidentialité ; responsabilité (« accountability » : il faut pouvoir prouver).

**Bases légales** (art. 6) : consentement, contrat, obligation légale, sauvegarde d'intérêts vitaux, mission d'intérêt public, intérêts légitimes. Il en faut **une**, par finalité. Les données sensibles (santé, opinions, appartenance syndicale, etc.) sont en principe interdites (art. 9) sauf exceptions.

**Minimisation et conservation** : ne collecter que le nécessaire ; fixer **une durée** et un mécanisme de suppression. Pour un outil temporaire : la date de fin de vie est fixée au départ, et on supprime données et dépôt à cette date.

**Droits des personnes** (art. 12 à 22) : information (art. 13 et 14), accès (art. 15), rectification (art. 16), effacement (art. 17), limitation (art. 18), portabilité (art. 20), opposition (art. 21), pas de décision uniquement automatisée à effet significatif (art. 22).

**Décision automatisée** (art. 22) : droit de ne pas faire l'objet d'une décision fondée **exclusivement** sur un traitement automatisé produisant des effets juridiques ou affectant de manière significative, avec exceptions encadrées et garanties (intervention humaine, possibilité de contester). Une intervention humaine purement formelle ne suffit pas (à vérifier sur les lignes directrices du CEPD).

**Privacy by design / by default** (art. 25) : on intègre la protection dès la conception (champs minimaux, pseudonymes, durées par défaut courtes, accès par rôle).

**Registre des traitements** (art. 30) : liste des traitements (finalité, catégories, destinataires, durées, mesures). La fiche de conformité de la formation en est une version allégée pédagogique, **pas** le registre officiel.

**Sous-traitants et transferts** (art. 28, chapitre V) : celui qui traite des données pour le compte d'un responsable est un **sous-traitant** (contrat obligatoire, art. 28). Le fournisseur d'un modèle d'IA (API, service en ligne) est, selon le cas, **sous-traitant ou destinataire** (à qualifier par le DPO). Conséquences pour les prompts :
- tout texte envoyé dans un prompt part chez un tiers, souvent hors UE (transfert : garanties du chapitre V, décision d'adéquation ou clauses types, à vérifier fournisseur par fournisseur) ;
- il faut connaître les conditions du fournisseur : conservation, usage pour l'entraînement, localisation ;
- donc **pas de données personnelles dans un prompt** sans accord préalable du RSSI/DPO.

**Analyse d'impact (AIPD, art. 35)** : obligatoire quand le traitement est susceptible d'engendrer un risque élevé (évaluation systématique de personnes, décision automatisée, grande échelle, données sensibles...). La CNIL publie une liste des traitements pour lesquels elle est requise.

**Violation de données** (art. 33 et 34) : notification à l'autorité **dans les 72 heures** après en avoir pris connaissance, si risque pour les personnes ; information des personnes si risque élevé. Un secret commité dans un dépôt public est un incident à signaler au RSSI immédiatement.

**Sanctions** (art. 83) : jusqu'à 20 M€ ou 4 % du chiffre d'affaires mondial annuel, le montant le plus élevé étant retenu, pour les manquements les plus graves. **Réclamation** : art. 77 (autorité de contrôle).

## 3. L'AI Act en une page

Règlement (UE) 2024/1689. Approche **par les risques**.

**Étape 0 : est-ce un système d'IA ?** (art. 3, point 1 : un système qui, à partir des entrées reçues, déduit comment générer des sorties telles que des prédictions, contenus, recommandations ou décisions). Si non (par exemple un calcul de TRS par poste, une règle de résolution fixe ou un algorithme d'affectation déterministe), l'outil est **hors champ de l'AI Act**, mais le **RGPD s'applique toujours** dès qu'il y a des données personnelles (à vérifier, lignes directrices de la Commission sur la définition). Ce n'est qu'ensuite que l'on classe par niveau de risque.

| Niveau | Exemples | Conséquence |
|---|---|---|
| Hors champ (pas un système d'IA) | tableau de TRS par poste, règle de calcul fixe, affectation déterministe | Pas d'AI Act ; RGPD et confidentialité restent applicables |
| Interdit (art. 5) | notation sociale, manipulation subliminale nuisible, reconnaissance des émotions au travail et à l'école (sauf raisons médicales ou de sécurité) (à vérifier pour le détail) | Interdit depuis le 2 février 2025 |
| Haut risque (art. 6 et annexes I et III) | éducation et formation, emploi et gestion des travailleurs, accès aux services essentiels, biométrie... | Exigences lourdes (gestion des risques, qualité des données, documentation, supervision humaine), applicables à partir de décembre 2027 pour l'annexe III (à vérifier) |
| Obligations de transparence (art. 50) | agents conversationnels, contenus générés ou manipulés (hypertrucages) | Fournisseurs : informer que l'on interagit avec une IA, marquer les contenus générés ; déployeurs : signaler hypertrucages et certains textes publiés (voir ci-dessous) |
| Minimal | filtres anti-spam, jeux | Pas d'obligation spécifique ; bonnes pratiques |

**Rôles** (art. 3) : **fournisseur** (développe ou met sur le marché un système d'IA sous son nom) ; **déployeur** (utilise un système sous sa propre autorité) ; importateur ; distributeur. **Attention** : une équipe qui construit un applicatif et le met à disposition de tiers peut devenir **fournisseur** ; un déployeur qui modifie substantiellement un système à haut risque peut aussi en devenir un (art. 25) (à vérifier pour les cas d'usage).

**Obligations pertinentes pour des utilisateurs et déployeurs** :
- **Maîtrise de l'IA (art. 4)** : les fournisseurs et déployeurs (et non « les organisations » en général) prennent des mesures pour favoriser la maîtrise de l'IA de leurs personnels et des personnes qui utilisent des systèmes d'IA en leur nom (formulation modifiée par l'omnibus, à vérifier sur EUR-Lex). C'est la justification de cette formation ;
- **Déployeurs de systèmes à haut risque (art. 26)** : utiliser selon la notice, **supervision humaine** par des personnes compétentes, qualité des données d'entrée, conservation des journaux, **informer les travailleurs** avant d'utiliser un système à haut risque sur le lieu de travail ;
- **Analyse d'impact sur les droits fondamentaux (art. 27)** pour certains déployeurs (organismes publics, etc.) (à vérifier) ;
- **Transparence (art. 50)** : obligations réparties. Les **fournisseurs** informent les personnes qu'elles interagissent avec une IA (art. 50(1)) et assurent le marquage lisible par machine des contenus générés (art. 50(2)) ; les **déployeurs** signalent les hypertrucages et certains textes publiés d'intérêt public (art. 50(4)) (à vérifier) ;
- **Droit à l'explication (art. 86)** : toute personne affectée par une décision prise sur la base d'un système à haut risque de l'annexe III (sauf le point 2, infrastructures critiques), ayant des effets juridiques ou affectant de façon similaire sa santé, sa sécurité ou ses droits fondamentaux, peut obtenir du déployeur des explications claires sur le rôle du système et les principaux éléments de la décision ;
- **Sanctions** (art. 99) : montants élevés (jusqu'à 35 M€ ou 7 % pour les pratiques interdites) (à vérifier).

**Éducation (annexe III, point 3)** : sont listés (formulation résumée, à vérifier) l'accès, l'admission ou l'**affectation** aux établissements d'enseignement et de formation ; l'évaluation des résultats d'apprentissage ; l'évaluation du niveau d'enseignement approprié ; la surveillance des comportements interdits pendant les examens.

**Emploi (annexe III, point 4)** : recrutement et sélection ; décisions affectant les conditions de travail, la promotion, la rupture, l'**attribution de tâches** sur la base du comportement ou de traits personnels, et **le suivi et l'évaluation de la performance et du comportement** des personnes.

**Dérogation (art. 6, par. 3)** : un système de l'annexe III peut ne pas être considéré comme à haut risque s'il ne présente pas de risque important (tâche procédurale étroite, amélioration d'un résultat humain déjà obtenu, etc.), **sauf** profilage de personnes. Cette appréciation se documente et ne se fait pas seul (à vérifier).

## 4. Pour un applicatif ponctuel : ce qui change, ce qui ne change pas

**Ce qui change (en pratique)**
- durée de vie courte : durée de conservation courte, date de suppression fixée dès le départ ;
- périmètre réduit : peu d'utilisateurs, finalité unique ;
- risque maîtrisable en **données fictives** : c'est le cadre de la formation (pseudonymes, graines fixes, aucune donnée réelle).

**Ce qui ne change pas**
- **un outil temporaire n'échappe pas au RGPD** : dès qu'une donnée personnelle réelle y entre, les principes, droits et obligations s'appliquent, même pour une semaine ;
- la confidentialité de l'entreprise : un tableau de production réel est une donnée confidentielle ;
- l'envoi dans un prompt reste un transfert vers un tiers ;
- l'**usage** détermine le risque, pas la sophistication : un petit script qui classe des candidats est un cas d'emploi sensible ;
- la validation du RSSI avant mise en usage.

**Test rapide en quatre questions** : (1) Y a-t-il des données sur des personnes réelles ? (2) L'outil décide-t-il ou aide-t-il à décider quelque chose pour quelqu'un ? (3) Les données ou prompts sortent-ils vers un fournisseur tiers ? (4) L'outil sera-t-il utilisé en dehors de l'équipe ? Un seul « oui » : fiche de conformité et RSSI.

## 5. Vos droits de citoyen européen : mode d'emploi

| Droit | Texte | Comment faire |
|---|---|---|
| Être informé | RGPD art. 13-14 | Lire la politique de confidentialité ; elle doit indiquer finalité, durée, destinataires, droits |
| Accès | art. 15 | Demander une copie de ses données et les informations sur le traitement |
| Rectification | art. 16 | Demander la correction d'une donnée inexacte |
| Effacement | art. 17 | Demander la suppression (pas absolu : exceptions, art. 17(3)) |
| Limitation | art. 18 | Demander le « gel » du traitement pendant une vérification |
| Portabilité | art. 20 | Récupérer ses données dans un format structuré (si base consentement/contrat et traitement automatisé) |
| Opposition | art. 21 | S'opposer pour raisons tenant à sa situation, et sans condition à la prospection |
| Décision automatisée | art. 22 | Demander une intervention humaine, exprimer son point de vue, contester |
| Explication (IA à haut risque) | AI Act art. 86 | Demander des explications au déployeur sur la décision (annexe III, sauf point 2, et sous réserve du droit de l'Union existant, art. 86 par. 2 et 3) (à vérifier) |
| Réclamation | RGPD art. 77 ; AI Act art. 85 (à vérifier) | Saisir la CNIL ; pour l'AI Act, l'autorité de surveillance du marché (désignation en France : à vérifier) |

**À qui s'adresser** : le responsable de traitement, via son DPO ou le contact indiqué dans la politique de confidentialité (courriel ou formulaire dédié).

**Comment** : demande écrite datée, objet clair (« Exercice de mon droit d'accès, art. 15 RGPD »), justificatif d'identité proportionné si un doute existe, conservation de la preuve d'envoi. La CNIL propose sur son site des modèles de courriers.

**Délais** (art. 12, par. 3) : réponse **sans retard injustifié et au plus tard dans un mois**, prolongeable de deux mois si la demande est complexe ou nombreuses (avec information de la personne dans le premier mois). Exercice **gratuit** en principe (art. 12, par. 5).

**Sans réponse ou refus injustifié** : relancer, puis **réclamation auprès de la CNIL** (formulaire en ligne sur cnil.fr) ; recours juridictionnels possibles (art. 78 et 79). Cette procédure est gratuite.

**Exercice pratique (10 min, hors des 15 min de séance du §5 : tâche facultative entre S3 et S4, voir programme §5)** : rédiger, pour un service que l'on utilise vraiment, un courriel de demande d'accès (art. 15) de cinq lignes. Ne pas l'envoyer, sauf si vous le souhaitez vraiment. Durée totale prévue du §5 : 15 min en S3, avec le RGPD.

## 6. La fiche de conformité d'une page et la validation RSSI

### 6.1 Gabarit à copier dans `docs/fiche_conformite.md` (déjà présent, vide, dans le dépôt-modèle)

Chemin unique pour toutes les équipes. Les rubriques résumées dans `themes.md` sont détaillées ici en 13 champs : c'est ce gabarit à 13 rubriques qui fait foi.

```markdown
# Fiche de conformité : <nom du projet>
Équipe n° <X> (identifiants GitHub : <@id1, @id2...>) · Thème : <A, B ou C> · Version : <n> · Date : <JJ/MM/AAAA>
(Dépôt public : aucun nom civil, aucune adresse de courriel dans cette fiche.)

1. Finalité (une phrase) :
2. Données traitées (liste ; réelles ou fictives ; sensibles oui/non) :
3. Personnes concernées (qui ? combien ?) :
4. Base légale ou justification (art. 6 RGPD) / justification « données fictives » :
5. Durée de conservation et date de suppression :
6. Hébergement et sous-traitants (ex. : build web publié sur GitHub Pages, public, données fictives uniquement ; stockage local drift/SQLite non chiffré dans l'application ; dont le fournisseur de modèle d'IA ; pays) :
7. Ce qui part dans les prompts (rien de personnel : confirmer) :
8. Décision automatisée (art. 22) ? Humain dans la boucle (qui ?) :
9. Rôle AI Act : fournisseur ou déployeur ? (justification) :
   Classement AI Act, une case : [ ] hors champ  [ ] minimal  [ ] obligations de transparence (art. 50)  [ ] haut risque  [ ] interdit
   Justification (commencer par : est-ce un système d'IA au sens de l'art. 3, point 1 ?) :
10. Droits : comment une personne accède, corrige, efface ses données :
11. Mesures (minimisation, pseudonymes, accès par rôle, journaux sans données personnelles, tests d'autorisation ; contrôles de l'import CSV via file_picker : taille max, rejet motivé, pas de donnée réelle) :
12. Risques résiduels et limites d'usage (« n'utilisez pas cet outil pour... ») :
13. Validation RSSI (rôle : enseignant simulant le RSSI, ou RSSI de l'établissement ; pas de nom) : date, décision (go / go sous conditions / no-go), conditions :
```

### 6.2 Processus de validation

| Question | Réponse |
|---|---|
| **Qui** | Le RSSI (simulé par l'enseignant ou tenu par le RSSI de l'établissement ; choix à indiquer aux étudiants), avec le DPO le cas échéant. En S4, trois tables en parallèle : un RSSI par table (enseignant, RSSI de l'établissement, aide ou second intervenant ; à défaut étudiant volontaire avec la grille) |
| **Quand** | Début de fiche en S3 (avec le modèle de données) ; passage devant le RSSI en S4 (4 décembre) ; v1 de la fiche en pull request le 8 décembre ; réponse du RSSI avant le 11 décembre ; mise à jour avant la soutenance en S5 |
| **Quoi** | La fiche, le dépôt (aucun secret, aucune donnée réelle), la CI verte, l'analyse des données |
| **Critères go** | Données fictives ou justifiées ; finalité unique ; durée et suppression définies ; pas de donnée personnelle dans les prompts ; rôle AI Act et classement qualifiés et argumentés ; accès par rôle testé ; limites d'usage écrites |
| **Critères no-go** | Données réelles sans cadre ; secret dans le dépôt ; décision automatisée sans humain sur des personnes ; finalité floue ; hébergement non identifié |
| **Trace** | Section 13 de la fiche, datée, et fichier versionné dans le dépôt (pull request approuvée) |

Une validation « go sous conditions » doit lister des actions datées. Sans réponse, la décision est **no-go** par défaut.

**Portée d'un « go »** : il vaut uniquement pour le périmètre pédagogique à données fictives. Tout passage à des données réelles impose une nouvelle fiche et une nouvelle validation.

**Format du passage devant le RSSI (S4)** : 3 tables en parallèle (8 équipes réparties 3-3-2), 10 à 12 min par équipe : environ 4 min de présentation de la fiche, 5 min de questions, 2 min de décision. Chaque table a son RSSI (enseignant, RSSI de l'établissement, second intervenant à confirmer ; à défaut, étudiant volontaire avec la grille go/no-go) ; les équipes non présentantes tiennent le rôle d'observateurs ou avancent l'audit croisé. Durée totale : 3 passages de 12 min au plus par table, soit 36 min, plus 4 min de rotation et de consignes : **bloc de 40 min en S4**, jeu de rôle intégré (voir §8.2).

## 7. Application aux trois thèmes du projet fil rouge

Rappel : tous les thèmes de la formation sont en données **fictives**. L'analyse ci-dessous porte sur ce qui se passerait en usage réel : c'est précisément ce que la fiche doit faire apparaître.

**Répartition des thèmes** : 8 équipes : 3-3-2 ; 7 équipes : 3-2-2 ou 3-3-1 ; tirage au sort si un thème dépasse 3 candidats. Le thème C demande plus de travail de conformité. Les mesures décrites ci-dessous sont incluses dans les 15 à 20 h du projet ; elles ne s'ajoutent pas.

### Thème A : carnet de campagne de jeu de rôle
- **Données** : noms de personnages (fictifs), identifiant de connexion du joueur (`proprietaire`), historique de jets. Dès que l'identifiant renvoie à une personne réelle, c'est une donnée personnelle (RGPD) ; un compte pseudonymisé reste personnel.
- **Risque AI Act probable** : minimal. Pas de décision sur des personnes ; un assistant conversationnel éventuel relève de la transparence (art. 50).
- **Mesures** : identifiants minimaux, accès par rôle (garde d'accès de la couche domain, refus testé), pas de données réelles en prompt, durée de vie de la campagne. **Obligatoires** : une mention d'information (finalité, durée, droits) et un script de suppression documenté des données d'un joueur. **En extension** : l'export des données du joueur (portabilité).
- **Pourquoi le RSSI** : publication sur GitHub Pages (public), stockage local non chiffré, comptes, secrets, export CSV (injection de formule), droit d'effacement d'un joueur.

### Thème B : TRS d'un atelier de câblage
- **Données** : productions, arrêts, postes. **Aucun identifiant d'opérateur n'est stocké dans les données métier** (seul le compte de connexion existe). Les données de poste sont de la donnée industrielle confidentielle ; en usage réel, toute donnée liée à un opérateur nommé serait personnelle et concernerait des salariés.
- **Risque probable** : **hors champ ou minimal** si l'indicateur est un calcul **par poste** (étape 0 du §3 : un calcul de TRS n'est pas forcément un système d'IA) ; **à discuter** (annexe III, point 4) si l'outil servait à suivre ou évaluer la **performance individuelle** d'opérateurs (suivi et évaluation des travailleurs). Dans un contexte réel, l'information et la consultation des représentants du personnel peuvent s'imposer (Code du travail, notamment art. L. 2312-38, moyens de contrôle de l'activité des salariés) (à vérifier).
- **Mesures** : agrégation par poste et par quart, pas de classement d'individus, durée de conservation courte, neutralisation des cellules à l'export. **Contrôle des commentaires libres** : consigne affichée (« aucune donnée personnelle dans les commentaires ») et revue en audit croisé.
- **Pourquoi le RSSI** : données industrielles confidentielles, qualification « suivi de travailleurs » à trancher, hébergement.

### Thème C : répartition de sujets de projet aux étudiants
- **Données** : pseudonymes, rang, parcours, vœux. En réel, le rang (issu de notes ou de classement) et les vœux sont des données personnelles d'étudiants, avec un effet sur leur parcours.
- **Risque probable** : **à discuter**. Annexe III, point 3 : l'« affectation » vise les établissements ; l'affectation à un sujet interne est plus proche d'une organisation pédagogique. Mais un outil qui évalue des étudiants ou dont la décision influence fortement leur parcours ressemble à de l'éducation à haut risque (à vérifier avec le DPO et la lecture des lignes directrices de la Commission). Par prudence : traiter **comme si** l'outil était à haut risque. C'est une démarche de précaution pédagogique, **pas une qualification juridique**. Un algorithme d'affectation déterministe peut aussi être hors champ de l'AI Act (étape 0 du §3) ; le RGPD s'applique dans tous les cas.
- **RGPD** : décision **automatisée** (art. 22) : l'algorithme déterministe propose, un humain valide avant publication et peut déroger. La validation humaine effective du gestionnaire est ce qui peut écarter la qualification de décision exclusivement automatisée (à vérifier, et à faire discuter par le RSSI/DPO). Droit à l'explication : information sur la « logique sous-jacente » (RGPD art. 13(2)(f), 14(2)(g) et 15(1)(h)), garanties de l'art. 22(3), explication individuelle (considérant 71), et AI Act art. 86 si haut risque : la vue « mon résultat » avec explication est exactement la réponse. Pour aller plus loin : CJUE, C-634/21 (SCHUFA, 7 décembre 2023) sur la notion de décision automatisée (à vérifier). Règle d'équité à publier **avant** la répartition.
- **Mesures** : pseudonymes uniquement, humain décisionnaire, **champ de statut `brouillon` / `publie` obligatoire** (validation humaine avant toute publication), voie de contestation, journaux sans pseudonyme ni vœu, aucune liste de classement réelle dans le dépôt.
- **Pourquoi le RSSI** : c'est le thème le plus sensible : données d'étudiants, effet sur leur parcours, décision automatisée.

## 8. Activités pédagogiques

### 8.1 Atelier de classification des risques (40 min)
- **Préparation** : 10 cartes de cas (une phrase chacune). Exemples : un chatbot qui répond sur la cantine ; un outil qui trie des CV ; un tableau de TRS par poste ; un outil qui note les copies ; un générateur d'images pour un flyer ; une application qui répartit des stagiaires ; une détection d'émotions des opérateurs par caméra ; un script qui résume des comptes rendus de réunion contenant des noms ; un filtre anti-spam ; une application de suivi du temps de pause des salariés.
- **Déroulé** : par équipe, 20 min pour classer chaque cas (étape 0 : est-ce un système d'IA ? puis hors champ / minimal / obligations de transparence (art. 50) / haut risque / interdit) et noter les données personnelles (2 min par carte) ; 12 min de mise en commun ; 8 min de synthèse de l'enseignant, qui servent à corriger les cartes (chaque équipe reporte seule, dans la rubrique 9 de la fiche, un classement provisoire de son projet pendant les minutes d'observation du passage RSSI, et le RSSI le discute ; la rubrique 8, art. 22, est discutée devant le RSSI). Total : 20 + 12 + 8 = 40 min. Les cartes ambiguës (stagiaires, pauses) sont réservées à la discussion de la mise en commun.
- **Corrigé indicatif** : CV : haut risque (emploi) ; copies : haut risque (éducation) ; détection des émotions au travail : interdit (art. 5) (à vérifier pour les exceptions) ; suivi des pauses : à discuter, probable haut risque (suivi des travailleurs) ; chatbot : obligations de transparence (art. 50) ; TRS par poste : hors champ (calcul, pas un système d'IA), RGPD si des opérateurs sont nommés ; répartition de stagiaires : à discuter (hors champ si algorithme déterministe, sinon éducation ou emploi selon le cas) ; flyer : obligations de transparence selon le cas ; spam : minimal (c'est bien de l'IA, sans obligation spécifique) ; résumé de réunions : minimal pour l'AI Act, mais RGPD et confidentialité à traiter.

### 8.2 Jeu de rôle « passage devant le RSSI » (bloc de 40 min en S4)
Le jeu de rôle est le passage devant le RSSI lui-même (pas une activité en plus).
- **Dispositif** : 3 tables en parallèle (8 équipes réparties 3-3-2), un RSSI par table (enseignant, RSSI de l'établissement, second intervenant à confirmer ; à défaut, étudiant volontaire), observateurs avec la grille go/no-go (les équipes non présentantes).
- **Déroulé par équipe (10 à 12 min)** : environ 4 min de présentation de la fiche ; 5 min de questions du RSSI (« où partent les prompts ? » ; « qui peut contester ? » ; « que se passe-t-il le jour de la fin de vie ? ») ; 2 min de décision (retour des observateurs inclus dans les questions ou la décision).
- **Temps total** : 3 passages de 12 min au plus par table = 36 min, plus 4 min de rotation et de consignes = 40 min.
- **Règle** : le RSSI peut décider un no-go ; l'équipe doit alors dire quoi corriger et sous quel délai. Le « go » ne vaut que pour le périmètre pédagogique à données fictives.

### 8.3 Quiz de 8 questions (10 min)
1. Un outil temporaire utilisé une semaine est-il soumis au RGPD s'il traite des données personnelles ? **Oui** : le RGPD s'applique dès qu'il y a traitement de données personnelles, sans seuil de durée.
2. Un pseudonyme est-il une donnée personnelle ? **Oui** si la personne peut être ré-identifiée (art. 4).
3. Peut-on coller une liste d'étudiants réels dans un prompt pour « tester » ? **Non** : transfert vers un tiers, sans cadre validé.
4. Quel délai maximal de réponse à une demande d'accès, en règle générale ? **Un mois**, prolongeable de deux mois (art. 12).
5. Dans quel délai notifier une violation à l'autorité ? **72 heures** (art. 33).
6. À qui adresser une réclamation en France ? **À la CNIL**.
7. Qu'est-ce qui rend un système d'IA « à haut risque » dans l'éducation ? **L'usage listé à l'annexe III** (admission ou affectation, évaluation des résultats, etc.), pas la technologie.
8. Qui valide la mise en usage de votre applicatif ? **Le RSSI** (et le DPO le cas échéant), avant toute mise en usage réelle.

### 8.4 Trois phrases d'or
1. **« Pas de donnée personnelle dans un prompt ni dans un dépôt public. »**
2. **« Temporaire ne veut pas dire hors la loi : le RGPD s'applique dès la première donnée réelle. »**
3. **« Aucun outil ne sort sans validation du RSSI, et un humain reste responsable des décisions qui touchent des personnes. »**

## 9. Sources officielles à lire

- RGPD, règlement (UE) 2016/679 : https://eur-lex.europa.eu/eli/reg/2016/679/oj
- AI Act, règlement (UE) 2024/1689 : https://eur-lex.europa.eu/eli/reg/2024/1689/oj
- Règlement (UE) 2026/1744 modifiant le règlement (UE) 2024/1689 (publié au JO le 24 juillet 2026) : lien à récupérer sur EUR-Lex (à vérifier)
- Commission européenne, cadre réglementaire de l'IA et calendrier : https://digital-strategy.ec.europa.eu/en/policies/regulatory-framework-ai
- AI Act Service Desk de la Commission : https://ai-act-service-desk.ec.europa.eu (à vérifier)
- CNIL, exercer ses droits et réclamation : https://www.cnil.fr (rubriques « Besoin d'aide » et « Plaintes »)
- CNIL, rubrique « Intelligence artificielle » : https://www.cnil.fr/fr/intelligence-artificielle (à vérifier)
- CNIL, analyse d'impact (AIPD) et liste des traitements concernés : https://www.cnil.fr (rubrique AIPD) (à vérifier)
- Comité européen de la protection des données (lignes directrices, dont décision automatisée) : https://www.edpb.europa.eu

Avant diffusion aux étudiants : revérifier le texte de l'omnibus numérique sur l'IA sur EUR-Lex et les liens ci-dessus.
