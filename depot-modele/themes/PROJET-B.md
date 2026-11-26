# Projet de l'équipe n° X : le TRS de la ligne 4 (thème B)

## Vision

- Pour qui : la responsable amélioration continue d'un fabricant fictif de sous-ensembles électroniques (personnage fictif), pour la ligne 4.
- Quel problème : le TRS est recalculé à la main dans un tableur et change d'un jour à l'autre selon celui qui compte.
- Quel outil : un calcul du TRS par poste et par quart, avec la même formule pour tous, sa décomposition (disponibilité, performance, qualité) et la répartition des pertes.
- Pour combien de temps : une campagne de mesure (par exemple un trimestre), puis export CSV, archivage du dépôt et arrêt du service.
- Ce que l'outil ne fera pas : évaluer une personne, ni devenir un système de pilotage d'atelier. Toutes les données sont fictives.

## User stories proposées

### Stories du socle (obligatoires)

Ces stories ne se choisissent pas : elles font partie du socle commun. L'équipe les planifie, elle ne les écarte pas.

- S1. En tant que responsable, je veux créer, consulter, modifier et supprimer les postes, les quarts, les OF, les déclarations et les arrêts (CRUD, écrans Flutter dans Chrome), afin de préparer et de tenir la campagne de mesure. Si l'équipe est en retard, le CRUD se limite à la création et à la lecture.
- S2. En tant que responsable ou opérateur, je veux que mes droits dépendent de mon rôle : le `responsable` lit, importe, exporte et corrige ; l'`operateur` déclare uniquement sur les quarts de son poste. La garde `RequireRole` (couche domain) est testée par un test de refus.
- S3. En tant que responsable, je veux que le TRS d'un poste pour un quart applique les six règles du clou niveau 1 (voir les stories de règle ci-dessous), afin que la formule soit la même pour tous. Les cas d'acceptation sont écrits avant le code de l'agent.
- S4. En tant qu'équipe, nous voulons un jeu de démonstration (6 postes, 90 quarts par poste, environ 3 000 déclarations et arrêts, dont le quart de nuit du 24 au 25 octobre 2026) généré avec une graine fixe, afin de montrer l'outil sans aucune donnée réelle.
- S5. En tant que responsable, je veux importer les déclarations de production depuis un fichier CSV (un seul fichier, pendant le sprint) et lire le rapport des lignes rejetées avec leur motif, afin de ne pas tout ressaisir.

### À choisir pour commencer

> L'équipe en retient 3 à 5 pour les premières séances, ajuste le texte et décide. Les sous-règles du clou non retenues ici restent à livrer plus tard : le clou niveau 1 est obligatoire. Les autres stories restent ici, barrées ou supprimées, avec la raison dans « Décisions de l'équipe ».

1. En tant que responsable, je veux décrire les postes et créer les quarts, afin de préparer la campagne de mesure.
2. En tant que responsable, je veux saisir un ordre de fabrication (OF) avec son temps de cycle idéal, afin que la performance se calcule sur une base connue.
3. En tant qu'opérateur, je veux déclarer les pièces produites et rebutées d'un quart et ses arrêts, uniquement sur les quarts de mon poste, afin que le temps perdu soit compté de la même façon par tous.
4. En tant que responsable, je veux consulter la disponibilité d'un poste pour un quart, afin de savoir où le temps se perd (règles 2 et 3).
5. En tant que responsable, je veux consulter la performance et la qualité d'un quart, afin de comparer les postes avec les mêmes règles (règles 4 et 5). La performance est plafonnée à 100 % et le drapeau `performance_plafonnee` indique que le plafond a joué.
6. En tant que responsable, je veux consulter le TRS d'un poste pour un quart avec sa décomposition, afin d'obtenir un chiffre ou un « non calculable » sans erreur (règle 6 et cas dégénérés). Le temps d'ouverture est la durée réelle du quart calculée à partir des horodatages UTC, sans constante de 480 (règle 1) ; la nuit du changement d'heure, du 24 au 25 octobre 2026, dure 540 minutes (cas 8).

Autre idée de l'énoncé, non reprise ci-dessus : voir les causes d'arrêt classées par minutes perdues.

## Première user story conseillée

Story 4 de la liste « À choisir pour commencer », limitée à la disponibilité (règles 2 et 3 de l'énoncé) : sans déclaration et sans performance. Elle sert de première story en séance 3, en TDD et en BDD.

Critères d'acceptation :

- Un quart de 480 minutes avec une pause de 30 minutes, une panne de 45 minutes et un changement de série de 15 minutes : temps requis 450 minutes, temps de marche 390 minutes, disponibilité affichée 86,7 %.
- Un quart du mardi 6 octobre 2026, de 06:00 à 14:00 heure de Paris, avec une panne de 13:30 à 14:30 : l'arrêt est tronqué à 30 minutes, disponibilité affichée 93,8 %.
- Un quart de 480 minutes sans aucun arrêt : disponibilité affichée 100,0 %.

## Rôles dans l'équipe

À compléter. Dans une équipe de 3, les rôles se cumulent ; dans une équipe de 5, le dernier rôle s'ajoute. Dans tous les cas, chacun relit au moins une PR d'un autre.

| Rôle | Ce qu'il tient | Identifiant GitHub |
|---|---|---|
| Gardien produit et conformité | ce fichier, le glossaire d'équipe, les cas d'acceptation, la fiche de conformité | à compléter |
| Gardien des données | modèle, migrations, seed, import CSV, fuseaux et UTC | à compléter |
| Gardien du harnais et de la CI | `CLAUDE.md`, hooks, test d'architecture sur les unités, GitHub Actions | à compléter |
| Gardien conformité (équipe de 4 ou 5) | fiche, anonymisation des opérateurs, contact avec le RSSI | à compléter |
| Gardien de la démonstration (équipe de 5) | README testé à froid, jeu de données du quart de nuit, scénario de démonstration | à compléter |

## Mesures de conformité obligatoires

Elles sont comprises dans les 15 à 20 h de charge d'équipe.

- Aucun identifiant d'opérateur n'est stocké dans les données métier (seul le compte de connexion existe).
- Consigne affichée dans le formulaire des arrêts : aucun nom dans le commentaire d'arrêt, complétée par une revue en audit croisé des commentaires de la base de démonstration.
- Agrégation par poste et par quart, jamais par personne ; journal technique sans nom.

## Ce que l'outil ne fera pas / limites

- Il ne sert qu'une campagne de mesure : à la fin, export CSV des TRS, archivage du dépôt et arrêt du service.
- Il n'est pas un MES : les événements de production viennent de fichiers CSV importés.
- Il n'a pas d'authentification réelle : un utilisateur courant fictif porte l'un des deux rôles, `responsable` ou `operateur`.
- Il n'évalue jamais une personne : agrégation par poste et par quart, jamais par personne, aucun identifiant d'opérateur dans les données métier, aucun nom dans les commentaires d'arrêt.
- Le TRS est un indicateur d'aide à la décision, pas une sanction automatique.
- Aucune donnée réelle d'usine : le dépôt et le build web sont publics.
- Une mise en usage réelle demanderait une nouvelle fiche de conformité, une nouvelle validation du RSSI et l'information-consultation du CSE.

## Décisions de l'équipe

Une ligne par décision : date, ce qui est décidé, qui a décidé, pourquoi.

- JJ/MM/AAAA : à compléter.
