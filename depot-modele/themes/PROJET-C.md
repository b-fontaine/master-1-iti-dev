# Projet de l'équipe n° X : la répartition des sujets de projet (thème C)

## Vision

- Pour qui : la responsable des projets d'un département fictif de formation d'ingénieurs (personnage fictif) et ses étudiants, tous pseudonymes.
- Quel problème : la répartition se fait à la main en une soirée, avec des tableurs, des mécontents et aucune explication.
- Quel outil : une répartition selon des règles connues à l'avance (mêmes vœux, même résultat), qui explique à chaque étudiant son résultat et montre les sujets trop peu choisis.
- Pour combien de temps : une campagne de vœux, puis suppression des vœux et des rangs après le délai de réclamation, archivage et arrêt du service.
- Ce que l'outil ne fera pas : publier un résultat sans validation humaine, ni réutiliser le rang ou les vœux pour un autre usage. Toutes les données sont fictives.

## User stories proposées

### Stories du socle (obligatoires)

Ces stories ne se choisissent pas : elles font partie du socle commun. L'équipe les planifie, elle ne les écarte pas.

- S1. En tant que gestionnaire, je veux créer, consulter, modifier et supprimer les sujets avec leurs capacités (CRUD, écrans Flutter dans Chrome), afin de préparer la campagne de vœux. Si l'équipe est en retard, le CRUD se limite à la création et à la lecture.
- S2. En tant que gestionnaire ou étudiant, je veux que mes droits dépendent de mon rôle : le `gestionnaire` importe, lance la répartition et corrige ; l'`etudiant` lit uniquement son propre vœu et son propre résultat. La garde `RequireRole` (couche domain) est testée par un test de refus.
- S3. En tant que gestionnaire, je veux que la répartition applique les six règles du clou niveau 1 (voir les stories de règle ci-dessous), afin qu'elle soit équitable et reproductible. Les cas d'acceptation sont écrits avant le code de l'agent.
- S4. En tant qu'équipe, nous voulons un jeu de démonstration (80 étudiants, 30 sujets, 10 enseignants, environ 400 vœux) généré avec une graine fixe et des pseudonymes `etu_NNN`, afin de montrer l'outil sans aucune donnée réelle.
- S5. En tant que gestionnaire, je veux importer les étudiants et leurs vœux depuis un fichier CSV (un seul fichier, pendant le sprint) et lire le rapport ligne par ligne des rejets avec leur motif, afin de ne pas tout ressaisir.

### À choisir pour commencer

> L'équipe en retient 3 à 5 pour les premières séances, ajuste le texte et décide. Les sous-règles du clou non retenues ici restent à livrer plus tard : le clou niveau 1 est obligatoire. Les stories écartées restent ici, barrées, avec la raison dans « Décisions de l'équipe ».

1. En tant que gestionnaire, je veux saisir les étudiants (pseudonyme, rang, parcours) et leurs vœux, afin d'avoir de quoi lancer une répartition.
2. En tant que gestionnaire, je veux que les étudiants soient traités par rang croissant, afin que la priorité soit connue et identique pour tous (règle 2).
3. En tant que gestionnaire, je veux que chaque étudiant ait de 3 à 5 vœux distincts, et que la répartition refuse de démarrer si deux étudiants ont le même rang, afin de ne répartir que des vœux valides (règle 1).
4. En tant que gestionnaire, je veux que chaque étudiant reçoive son vœu de plus petit ordre dont le sujet a encore une place, en ignorant les sujets réservés à un autre parcours, afin que la répartition respecte les capacités et les parcours (règles 3 et 4).
5. En tant que gestionnaire, je veux voir pour chaque étudiant non affecté le motif précis, et le statut de chaque sujet après répartition (`confirme` ou `sous_effectif`), afin de repérer qui est resté sans sujet et quels sujets sont trop peu choisis (règles 5 et 6).
6. En tant qu'étudiant, je veux consulter uniquement mon propre résultat (sujet obtenu, rang du vœu obtenu, explication), après validation par le gestionnaire (statut `publie`), afin de comprendre pourquoi j'ai obtenu ce sujet.

## Première user story conseillée

Story 2 de la liste « À choisir pour commencer », limitée à la priorité par rang (règle 2 de l'énoncé) : sans capacité et sans filtre de parcours. Elle sert de première story en séance 3, en TDD et en BDD.

Critères d'acceptation :

- Deux étudiants, `etu_010` de rang 7 et `etu_011` de rang 6 : `etu_011` est traité avant `etu_010`.
- Avec les sujets J5 (capacité 1) et J6 (capacité 2), tous deux vœux de `etu_010` et `etu_011` (J5 en vœu 1, J6 en vœu 2) : `etu_011` obtient J5 et `etu_010` obtient J6 (vœu 2). Ce critère se vérifie une fois la capacité traitée (story 4 de la liste).

## Rôles dans l'équipe

À compléter. Dans une équipe de 3, les rôles se cumulent ; dans une équipe de 5, le dernier rôle s'ajoute. Dans tous les cas, chacun relit au moins une PR d'un autre.

| Rôle | Ce qu'il tient | Identifiant GitHub |
|---|---|---|
| Gardien produit et conformité | ce fichier, les cas d'acceptation, la fiche de conformité, l'explication des décisions | à compléter |
| Gardien des données | modèle, migrations, seed fictif, import CSV, scan des données réelles | à compléter |
| Gardien du harnais et de la CI | `CLAUDE.md`, hooks, permissions, test de scan, GitHub Actions | à compléter |
| Gardien conformité (équipe de 4 ou 5) | fiche, art. 22 du RGPD, AI Act, contact avec le RSSI | à compléter |
| Gardien de la démonstration (équipe de 5) | README testé à froid, jeu de 80 étudiants fictifs, scénario de démonstration | à compléter |

## Mesures de conformité obligatoires

Elles sont comprises dans les 15 à 20 h de charge d'équipe.

- Statut `brouillon` / `publie` du résultat : validation humaine du gestionnaire avant publication.
- Explication de la décision pour chaque étudiant (vue « mon résultat ») ; motif de non-affectation toujours affiché.
- Règles publiées avant la collecte des vœux (une page statique suffit).
- Pseudonymisation de bout en bout ; journal technique sans pseudonyme ni vœu.

## Ce que l'outil ne fera pas / limites

- Il ne sert qu'une campagne de vœux : après la publication et le délai de réclamation, suppression des vœux et des rangs, puis arrêt du service.
- Il n'a pas d'authentification réelle : un utilisateur courant fictif porte l'un des deux rôles, `gestionnaire` ou `etudiant`.
- Il ne réutilise jamais le rang ou les vœux pour un autre usage (orientation, notation, prédiction).
- Il ne publie pas un résultat sans validation humaine du gestionnaire (statut `brouillon` puis `publie`).
- Aucune donnée réelle, même partielle : tous les étudiants sont `etu_NNN`, aucun nom, aucun courriel. Le dépôt et le build web sont publics.
- Il n'est relié à aucun établissement réel.
- Une mise en usage réelle demanderait une nouvelle fiche de conformité et une nouvelle validation du RSSI (et du DPO).

## Décisions de l'équipe

Une ligne par décision : date, ce qui est décidé, qui a décidé, pourquoi.

- JJ/MM/AAAA : à compléter.
