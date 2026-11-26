# Projet de l'équipe n° X : le registre d'un comptoir de Passeurs (thème A)

Nom de notre comptoir : à compléter par l'équipe.

## Vision

- Pour qui : le greffe d'un comptoir de Passeurs des Marches de Cendrelune, à la demande de l'intendante des Marches (personnage fictif).
- Quel problème : le registre est tenu à la plume, les soldes sont contestées et personne ne sait expliquer le rang d'un passeur.
- Quel outil : un registre qui juge chaque traversée avec la même règle (même lune, même jugement) et garde l'historique de chaque passeur.
- Pour combien de temps : le temps d'une saison des brumes, puis export CSV et archivage du dépôt.
- Ce que l'outil ne fera pas : profiler les utilisateurs, ni tirer lui-même l'éclat de la lune dans la règle de jugement. Toutes les données sont fictives.

## User stories proposées

### Stories du socle (obligatoires)

Ces stories ne se choisissent pas : elles font partie du socle commun. L'équipe les planifie, elle ne les écarte pas.

- S1. En tant que greffier, je veux créer, consulter, modifier et supprimer les passeurs (CRUD, écrans Flutter dans Chrome), afin de tenir le registre du comptoir. Si l'équipe est en retard, le CRUD se limite à la création et à la lecture.
- S2. En tant que greffier ou passeur, je veux que mes droits dépendent de mon rôle : le `greffier` ouvre les routes, juge, corrige et accorde un repos ; le `passeur` lit tout et ne modifie que la fiche dont il est `proprietaire`. La garde `RequireRole` (couche domain) est testée par un test de refus.
- S3. En tant que greffier, je veux que le jugement d'une traversée applique les six règles du clou niveau 1 (voir les stories de règle ci-dessous), afin que les soldes ne soient plus contestées. Les cas d'acceptation sont écrits avant le code de l'agent.
- S4. En tant qu'équipe, nous voulons un jeu de démonstration (4 voies, 60 passeurs, 3 saisons, 30 routes, environ 600 traversées) généré avec une graine fixe, afin de montrer l'outil sans aucune donnée réelle.
- S5. En tant que greffier, je veux importer des passeurs depuis un fichier CSV (un seul fichier, pendant le sprint) et lire le rapport des lignes rejetées avec leur motif, afin de remplir le registre sans tout ressaisir.

Les libellés affichés du monde (noms des rangs, lieux, textes) se rangent dans un seul fichier, `lib/core/presentation/lexique.dart`. Le domaine ne connaît que les codes.

### À choisir pour commencer

> L'équipe en retient 3 à 5 pour les premières séances, ajuste le texte et décide. Les sous-règles du clou non retenues ici restent à livrer plus tard : le clou niveau 1 est obligatoire. Les autres stories restent ici, barrées ou supprimées, avec la raison dans « Décisions de l'équipe ».

1. En tant que greffier, je veux inscrire un passeur d'une voie donnée, avec le souffle du rang 1 de cette voie, afin que son registre existe dès son arrivée au comptoir.
2. En tant que greffier, je veux ouvrir une route (nature du péril, péril, usure, renom promis), afin que les traversées puissent être jugées contre une route connue.
3. En tant que greffier, je veux saisir l'éclat de la lune pour un passeur et une route et obtenir le total et le passage tenu ou rompu, afin que chaque traversée soit jugée de la même façon (règle 3).
4. En tant que greffier, je veux que l'éclat soit un entier de 1 à 20, qu'un éclat de 20 (pleine cendrelune) donne toujours un passage tenu (`tenue_pleine_lune`) et un éclat de 1 (lune noire) toujours un passage rompu (`rompue_lune_noire`), quel que soit le total, afin que les lunes franches décident de l'issue (règle 2).
5. En tant que greffier, je veux qu'un passeur épuisé (souffle à 0) ne puisse pas être jugé et que l'usure du souffle soit appliquée avec un plancher à 0, afin que les soldes ne soient plus contestées (règles 1 et 4). Je veux aussi pouvoir accorder un repos à un passeur épuisé.
6. En tant que greffier, je veux que le renom soit cumulé et que le rang change aux seuils prévus, afin que l'on puisse expliquer pourquoi un passeur est à tel rang (règles 5 et 6).
7. En tant que passeur, je veux consulter ma fiche avec l'historique de mes traversées, afin de suivre mon souffle et mon rang. En tant que greffier, je veux voir quels passeurs sont épuisés et lesquels vont changer de rang.

## Première user story conseillée

Story 3 de la liste « À choisir pour commencer », limitée au total et au passage (règle 3 de l'énoncé) : sans usure, sans renom, sans changement de rang. Elle sert de première story en séance 3, en TDD et en BDD.

Critères d'acceptation :

- Un veneur de rang 1, une route de nature `bete` de péril 17, un éclat de 11 : total 17 ≥ 17, passage tenu (`tenue`).
- Même passeur, même route, éclat 10 : total 16 < 17, passage rompu (`rompue`).
- Un héraut de rang 1, une route de nature `faction` de péril 10, un éclat de 10 : total 10 + 5 + 1 = 16 ≥ 10, passage tenu (`tenue`).

## Rôles dans l'équipe

À compléter. Dans une équipe de 3, les rôles se cumulent ; dans une équipe de 5, le dernier rôle s'ajoute. Dans tous les cas, chacun relit au moins une PR d'un autre.

| Rôle | Ce qu'il tient | Identifiant GitHub |
|---|---|---|
| Gardien produit et conformité | ce fichier, `docs/monde.md`, les cas d'acceptation, la fiche de conformité | à compléter |
| Gardien des données | modèle, migrations, seed, import CSV | à compléter |
| Gardien du harnais et de la CI | `CLAUDE.md`, hooks, permissions, GitHub Actions, test d'architecture sur l'aléa | à compléter |
| Gardien conformité (équipe de 4 ou 5) | fiche, pseudonymisation, originalité du monde, contact avec le RSSI | à compléter |
| Gardien de la démonstration (équipe de 5) | README testé à froid, lexique et jeu de données de soutenance, scénario de démonstration | à compléter |

## Mesures de conformité obligatoires

Elles sont comprises dans les 15 à 20 h de charge d'équipe.

- Mention d'information visible (art. 13 du RGPD).
- Cas d'usage de suppression documenté d'un utilisateur et de ses données (droit à l'effacement, art. 17).
- Pseudonymes uniquement ; journal technique sans nom d'utilisateur (identifiants numériques) ; un passeur ne modifie que sa fiche.

## Ce que l'outil ne fera pas / limites

- Il ne sert qu'une saison : à la fin, export CSV du registre, archivage du dépôt en lecture seule et arrêt du service.
- Il n'a pas d'authentification réelle : un utilisateur courant fictif porte l'un des deux rôles, `greffier` ou `passeur`.
- Il ne fait aucun profilage des utilisateurs et aucun classement public des « meilleurs passeurs » associé à des personnes sans leur accord.
- Le domaine ne tire jamais d'aléa et ne lit pas l'horloge : l'éclat de la lune arrive en paramètre.
- Le monde est original : aucun nom, lieu ou créature repris d'une œuvre existante, aucune personne réelle.
- Aucune donnée réelle : le dépôt et le build web sont publics. Les pseudonymes d'utilisateurs sont supprimés ou anonymisés à la clôture de la saison.
- Une mise en usage réelle demanderait une nouvelle fiche de conformité et une nouvelle validation du RSSI.

## Décisions de l'équipe

Une ligne par décision : date, ce qui est décidé, qui a décidé, pourquoi.

- JJ/MM/AAAA : à compléter.
