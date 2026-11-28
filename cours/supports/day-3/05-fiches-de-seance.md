# Chapitre 5 · Les fiches de la séance : à imprimer ou à suivre à l'écran

*Séance 3 « Première user story, données et RGPD » · Master ITI, Nantes Université, 2026-2027. Fiches à utiliser pendant la séance. Condensées des chapitres 1 à 4, dont les commandes ont été exécutées le 26 novembre 2026 sous Linux (git 2.53.0, gh 2.100.0, Flutter 3.50.1) sur une copie du dépôt-modèle, sans GitHub.*

Ce chapitre ne contient presque pas d'explications : il rassemble ce que vous gardez sous les yeux pendant le contrôle d'ouverture et les ateliers. Chaque fiche tient sur une ou deux pages, se termine par un « Fini quand » et renvoie à la section du chapitre qui explique le pourquoi. Les lettres continuent celles de la séance 2 (fiches 0 et A à F).

| Fiche | Pour quel moment | Explications |
|---|---|---|
| [G · Contrôle d'ouverture](#fiche-g--contrôle-douverture) | Ouverture de séance, chacun puis en équipe | [Chapitre 1](01-travailler-a-plusieurs.md), section 2 |
| [H · Première user story en TDD et en BDD](#fiche-h--première-user-story-en-tdd-et-en-bdd) | Atelier user story, chacun sur sa branche | [Chapitre 2](02-premiere-user-story.md) |
| [I · Checklist de revue de PR](#fiche-i--checklist-de-revue-de-pr) | À chaque PR, auteur et relecteur | Chapitre 1, sections 4 et 5 |
| [J · Test en 4 questions et début de la fiche de conformité](#fiche-j--test-en-4-questions-et-début-de-la-fiche-de-conformité) | Ateliers RGPD, en équipe | [Chapitre 3](03-rgpd-applique-au-projet.md), sections 6 à 8 |
| [K · Modèle de données, migration, test d'intégrité](#fiche-k--modèle-de-données-migration-test-dintégrité) | Atelier données, gardien des données et un coéquipier | [Chapitre 4](04-les-donnees.md), sections 3, 5 à 7 |
| [L · Revue croisée entre équipes](#fiche-l--revue-croisée-entre-équipes) | Atelier de revue croisée, deux équipes | Chapitre 1, section 7 |
| [M · Bilan et livrable de fin de séance](#fiche-m--bilan-et-livrable-de-fin-de-séance) | Fin de séance, en équipe | Chapitre 1, section 3.2 ; chapitre 4, section 7.3 |
| [N · Dépannage de la séance 3](#fiche-n--dépannage-de-la-séance-3) | Quand ça coince | Chapitres 1, 2 et 4 |

## Ce que vous allez retenir

- Les lignes qui commencent par `$` se tapent dans le terminal, **sans** le `$`. Les mots entre chevrons (`<branche>`) sont à remplacer, chevrons compris.
- Sur un poste qui vient de cloner ou de tirer un `.feature` ou une table : `dart run build_runner build --delete-conflicting-outputs` **avant** `flutter test`. Les fichiers générés ne sont pas versionnés.
- Une branche par tâche, depuis un `main` à jour ; une PR annonce une seule chose ; c'est un **coéquipier** de l'auteur, autre que lui, qui approuve.
- `All tests passed!` ne prouve rien si un test a été désactivé ou assoupli : avant la PR, l'auteur cherche les signes de triche (fiche H, étape 8) ; en relecture, un fichier de `test/` dans la liste des fichiers touchés appelle une question.
- Une seule migration à la fois, annoncée au gardien des données. Un instantané de `drift_schemas/` déjà fusionné ne se supprime ni ne se regénère.
- Aucun nom civil, aucun courriel, aucune donnée réelle : ni dans le dépôt, ni dans la fiche de conformité, ni dans un prompt.

---

## Fiche G · Contrôle d'ouverture

**Chacun sur son poste, puis en équipe. Quelques minutes. Fini quand :** `flutter test` est vert sur **chaque** poste, l'état courant de `JOURNAL.md` a été lu, les rôles sont confirmés, et l'initialisation de la séance 2 est terminée.

La séance 2 a eu lieu l'avant-veille et rien n'a été demandé entre les deux : ce n'est pas une remise en route, c'est un contrôle.

**Étape 1 · Les commandes, dans l'ordre** (dans le dossier `equipe_<numéro>`).

```bash
$ git status
$ git switch main
$ git pull
$ flutter pub get
$ dart run build_runner build --delete-conflicting-outputs
$ flutter test
```

À voir : `nothing to commit, working tree clean` ; `Switched to branch 'main'` (ou `Already on 'main'`) ; la liste des fichiers reçus ou `Already up to date.` ; `Got dependencies!` ; `Built with build_runner … wrote … outputs.` ; `All tests passed!`.

- `build_runner` est indispensable si `git pull` a apporté un `.feature` ou une table modifiée, ou si vous venez de cloner. Quand tout est déjà à jour, il ne fait rien (`wrote 0 outputs`) : le lancer à chaque fois ne coûte rien.
- La ligne `… packages have newer versions incompatible with dependency constraints` n'est pas une erreur. N'y répondez **jamais** par `flutter pub upgrade`, interdit dans le projet.
- `git status` montre des fichiers modifiés, ou `flutter test` est rouge : fiche N.

**Étape 2 · Lire l'état courant de `JOURNAL.md`** (en équipe, à voix haute). Rubrique « État courant » : où on en est, prochaine étape, commandes clés, décisions, reste à faire.

1. La ligne « Reste à faire » est-elle vide ? Sinon, qui s'en charge, et maintenant ?
2. La « Prochaine étape » est-elle la première user story de `PROJET.md` ? (Thème B : la story 4, limitée à la disponibilité.)
3. Le tag `s2-fin` est-il visible ? `git tag` l'affiche après le `git pull`.

**Étape 3 · Terminer l'initialisation, si besoin.** Pas encore de première PR relue par un autre que son auteur dans `main`, ou refus d'un push direct sur `main` jamais constaté ? On le termine **maintenant**, avant toute user story : fiche C de la séance 2, à l'étape où vous vous étiez arrêtés. Notez dans `JOURNAL.md` ce qui a été terminé ce matin.

**Étape 4 · Point d'équipe.** Où en est-on, qui tient quel rôle ? Les rôles sont **confirmés** : le gardien des données coordonne la migration (fiche K), le gardien produit et conformité la fiche de conformité (fiche J), le gardien du harnais `CLAUDE.md` et `JOURNAL.md` (fiche M). Un rôle change : le tableau des rôles de `PROJET.md` est mis à jour par une PR.

Si le temps le permet, un quiz éclair de cinq questions sur les séances 1 et 2 (Pratique : il saute en premier).

*Explications : chapitre 1, section 2.*

---

## Fiche H · Première user story en TDD et en BDD

**Chacun avec son agent, sur sa branche. Fini quand :** le plan a été critiqué avant toute écriture, le scénario `.feature` a été vu rouge puis vert, les tests de la règle, du cas d'usage et du Cubit ont été vus rouges puis verts, chaque commit de test précède dans l'historique le commit de code qui le fait passer, les six commandes de « Vérifier avant une PR » sont vertes, et la PR est ouverte avec le modèle, relue par un coéquipier, puis fusionnée.

L'exemple est celui du thème B : la disponibilité d'un quart (règles 2 et 3). Thèmes A et C : votre story est dans la rubrique « Première user story conseillée » de votre `PROJET.md`, votre scénario dans `cours/projets/themes.md` (chapitre 2, section 10).

**Étape 1 · Demander un plan, et le critiquer**, avant d'écrire quoi que ce soit, scénario compris. En mode plan (`Maj+Tab`, ou `/plan <demande>`), l'agent lit et propose sans rien modifier. Donnez-lui le contexte (`CLAUDE.md`, `docs/ARCHITECTURE.md`, `PROJET.md` : la première user story conseillée et ses critères), la tâche (livrer la story en TDD, dans l'ordre de la section 5 d'`ARCHITECTURE.md` : le scénario d'abord, puis les tests unitaires, puis le code), les limites (règles de la story seulement ; pas de table drift, un repository en mémoire ; pas d'écran ; ni le `.feature` ni un test existant modifiés) et ce que vous attendez (fichiers, test écrit avant, commande qui prouve le rouge puis le vert). Avant d'approuver, vérifiez :

| Question | Ce que vous attendez |
|---|---|
| Où vont les fichiers ? | `lib/features/<fonctionnalité>/` avec `domain/`, `data/`, `presentation/` ; tests sous `test/features/<fonctionnalité>/` |
| Dans quel ordre ? | Le scénario d'abord, puis, pour chaque pièce, le test (commité rouge) avant le code ; règle et cas d'usage avant le Cubit |
| Quelles pièces ? | Règle pure ; interface dans `domain/repositories/` ; implémentation en mémoire dans `data/` ; cas d'usage ; Cubit qui ne reçoit que le cas d'usage |
| Quelle injection ? | Les nouvelles pièces enregistrées dans `lib/core/di/injection.dart`, sous le type de leur contrat |
| Quels tests ? | Les critères de `PROJET.md`, avec les valeurs de l'énoncé |
| Que ne touche-t-il pas ? | Ni le `.feature` une fois relu, ni `test/acceptance/`, ni `pubspec.yaml` |

Ce que vous refusez dans le plan va dans la rubrique « Proposé et refusé » de la PR. Le plan approuvé, on passe au scénario.

**Étape 2 · Une branche courte, depuis un `main` à jour.**

```bash
$ git switch main
$ git pull
$ git switch -c disponibilite-quart
```

**Étape 3 · Écrire le scénario** dans `test/scenarios/<fonctionnalité>/` (snake_case, sans accent). Trois règles : `# language: fr` en **première ligne** ; les **valeurs entre accolades**, `{480}` pour un nombre, `{'pause'}` pour un texte ; les **valeurs de l'énoncé**, jamais d'autres.

```gherkin
# language: fr
Fonctionnalité: Calcul de la disponibilité d'un quart

  Scénario: disponibilité avec un arrêt planifié et deux arrêts non planifiés
    Soit un quart de {480} minutes
    Et un arrêt planifié {'pause'} de {30} minutes
    Et un arrêt non planifié {'panne'} de {45} minutes
    Et un arrêt non planifié {'changement_serie'} de {15} minutes
    Quand je calcule la disponibilité
    Alors le temps requis est de {450} minutes
    Et le temps de marche est de {390} minutes
    Et la disponibilité affichée est {'86,7 %'}
```

Le scénario de `themes.md` a ses valeurs entre accolades : reprenez ses phrases et ses valeurs sans rien changer. Sans accolades, l'outil crée une étape par valeur (chapitre 2, section 4.2).

**Étape 4 · Générer, constater le rouge, commiter le scénario seul.**

```bash
$ dart run build_runner build --delete-conflicting-outputs
$ flutter test
```

`build_runner` crée le test du scénario et, dans `test/steps/`, un squelette par étape nouvelle. `flutter test` est **rouge** (`UnimplementedError`) : c'est attendu, et c'est la preuve que le scénario est exécuté. Commitez le scénario et les squelettes d'étapes à ce moment-là, seuls : le test précède le code dans l'historique.

**Étape 5 · Les tests unitaires d'abord, une pièce à la fois, du centre vers l'écran.** Pour chaque pièce : le test, le rouge constaté, **un commit du test**, puis le code minimal, le vert, **un commit du code**. Deux commits par pièce, dans cet ordre ; jamais le test et le code dans le même commit.

1. **La règle** (`domain/regles/`) : les critères chiffrés de `PROJET.md` (pour B : 450, 390, `86,7 %` ; quart sans arrêt `100,0 %` ; panne tronquée `93,8 %`). Un rouge de compilation (`Error when reading '…'`) compte comme rouge.
2. **Le cas d'usage** (`domain/usecases/`), testé avec un repository simulé par `mocktail`, déclaré dans `test/helpers/fausses_pieces.dart` ; avec lui, l'interface du repository dans `domain/repositories/` et son implémentation en mémoire dans `data/`.
3. **Le Cubit** (`presentation/`), testé avec `bloc_test`. Il reçoit le cas d'usage, **jamais** le repository.

L'écran est facultatif (Pratique) : il peut glisser au sprint.

**Étape 6 · Compléter les étapes du scénario** dans `test/steps/`. Retirez la ligne `// @dart=3.6` des squelettes et donnez aux paramètres (`param1`, `param2`) des noms parlants. Pour une règle, les étapes **appellent le cas d'usage** via l'annuaire, sans monter d'écran (aucun `pumpWidget`). `build_runner` ne réécrit pas une étape qui existe déjà. Commitez les étapes : le scénario est encore rouge (`… is not registered inside GetIt`), il attend l'étape suivante.

**Étape 7 · Enregistrer les pièces dans l'annuaire**, `lib/core/di/injection.dart`, et nulle part ailleurs : le repository sous le type de son **interface** avec `registerLazySingleton`, le cas d'usage et le Cubit avec `registerFactory`. Le scénario passe au vert ; commitez.

**Étape 8 · Chercher la triche avant tout le monde.**

```bash
$ git diff --stat main
$ git diff main -- test/
```

Refusez et faites expliquer si vous voyez : un `.feature` ou un test existant modifié ; un test supprimé ; `skip:` ou un test mis en commentaire (un `~` dans la sortie de `flutter test`) ; une valeur attendue changée ; un nombre de l'énoncé écrit dans `lib/` ; un test vert dès son premier lancement ; un fichier de `test/acceptance/` touché. Dans l'historique (`git log --oneline`), chaque commit de test doit précéder le commit de code qui le fait passer.

**Étape 9 · Vérifier avant la PR** (« Vérifier avant une PR » du `README.md`, dans l'ordre, sortie gardée) :

```bash
$ flutter pub get --enforce-lockfile
$ dart run build_runner build --delete-conflicting-outputs
$ dart run drift_dev make-migrations
$ dart format --output=none --set-exit-if-changed .
$ flutter analyze
$ flutter test
```

`make-migrations` ne doit rien changer. Si le contrôle de format échoue : `dart format .`, puis commitez.

**Étape 10 · Ouvrir la PR.** Poussez la branche et ouvrez la PR comme à la fiche C de la séance 2 (`git push -u origin <branche>`, puis `gh pr create --web` ; **jamais** `--fill`, qui n'utilise pas le modèle). Remplissez le modèle honnêtement, suivi des temps compris. Relecture avec la fiche I ; c'est un coéquipier qui approuve.

*Explications : chapitre 2, sections 3 (plan), 4 (scénario), 5 à 7 (tests, couches, étapes), 8 (triche) et 9 (commits, vérification, PR) ; thèmes A et C, section 10.*

---

## Fiche I · Checklist de revue de PR

À lire dans l'ordre, par le relecteur (coéquipier ou équipe jumelée) **et** par l'auteur avant d'ouvrir sa PR. Les lignes 1 à 5 suffisent pour une PR qui ne touche que de la documentation ; les lignes 6 à 10 s'ajoutent selon ce que la PR contient.

**Pour toute PR**

1. **Je comprends ce que fait cette PR, et je saurais l'expliquer.**
2. **Elle fait ce qu'elle annonce : je l'ai vue fonctionner (scénario, tests verts, application lancée), et les fichiers touchés correspondent à l'annonce.**
3. **Les vérifications passent : `flutter analyze`, `flutter test`** (pastille de CI verte, ou résultat collé par l'auteur).
4. **Aucun secret, aucune donnée réelle ou personnelle**, ni nom civil ni courriel, y compris dans la fiche de conformité et dans `JOURNAL.md`.
5. **Aucun test supprimé ni affaibli, et les règles de `CLAUDE.md` sont respectées.**

**Si la PR livre une user story**

6. **Le scénario `.feature` dit la règle avec les valeurs de `PROJET.md`**, commence par `# language: fr`, et rien n'a été « arrangé » pour qu'il passe (valeur arrondie, cas retiré, hasard en dur).
7. **Le commit du test précède celui du code** dans l'onglet des commits.
8. **Chaque fichier est dans la bonne couche** : la règle dans `domain/`, le stockage derrière l'interface du domain (repository fake en mémoire à ce stade), le Cubit ou le BLoC ne reçoit que des cas d'usage.

**Si la PR touche aux données ou à la conformité**

9. **Une seule migration à la fois** : `schemaVersion` augmente de un, aucun instantané de `drift_schemas/` déjà présent sur `main` n'est modifié ni supprimé (seul un nouvel instantané s'ajoute), et le gardien des données est au courant (chapitre 4).
10. **La fiche de conformité dit « données fictives »** avec une justification, et ne contient aucun nom civil ni courriel (« équipe n° X », identifiants GitHub).

**Et pour finir**

- **Le modèle de PR est rempli**, avec au moins une ligne « proposé et refusé » ou un « rien refusé » assumé.

Une ligne ne passe pas ? On ne fusionne pas : le coéquipier relecteur choisit « Request changes » et dit laquelle ; l'équipe jumelée le dit en commentaire.

**Relire par les preuves**, dans l'ordre : description (ce que la PR annonce), pastille de CI, liste des fichiers modifiés (« Files changed ») comparée à l'annonce, scénario et tests, place de chaque fichier dans les couches, historique des commits. Pas de lecture du code ligne à ligne. **Commenter** : précisément, à propos du code et non de la personne, en question quand vous n'êtes pas sûr, préfixé par **[bloquant]**, **[question]** ou **[suggestion]**. Dites aussi ce que vous n'avez **pas** vérifié. **Conclure** (« Review changes ») : *Comment* pour tout relecteur et toujours pour l'équipe jumelée ; *Request changes* ou *Approve* pour un coéquipier de l'auteur, autre que lui.

*Explications : chapitre 1, sections 4 et 5.*

---

## Fiche J · Test en 4 questions et début de la fiche de conformité

**En équipe, le gardien produit et conformité veille, il n'écrit pas seul. Fini quand :** le test en quatre questions a ses réponses pour la formation et pour l'usage réel ; `docs/fiche_conformite.md` est commité avec ses rubriques 1 à 5, indique « données fictives » avec une justification, ne contient ni nom civil ni courriel, et sa PR a été relue et approuvée par un coéquipier autre que l'auteur.

*Sensibilisation, pas avis juridique : la validation revient au RSSI et au DPO.*

**Étape 1 · Le test en quatre questions.** Chaque question se pose deux fois : **dans la formation** (données fictives, dépôt public) et **en usage réel** (si l'outil servait vraiment).

1. Y a-t-il des données sur des personnes réelles ?
2. L'outil décide-t-il ou aide-t-il à décider quelque chose pour quelqu'un ?
3. Les données ou prompts sortent-ils vers un fournisseur tiers ?
4. L'outil sera-t-il utilisé en dehors de l'équipe ?

**Un seul « oui » suffit** : fiche de conformité et passage devant le RSSI. Pour tous les thèmes, la question 3 suffit à elle seule : vos prompts, et ce que l'agent lit pour vous répondre, partent chez le fournisseur du modèle.

**Étape 2 · Qualifier les données de votre thème.** Repérez votre colonne : elle se transpose dans les rubriques 2 et 3.

| | Thème A | Thème B | Thème C |
|---|---|---|---|
| Ce qui qualifie le thème | L'identifiant de l'utilisateur qui possède une fiche de passeur (`proprietaire`) | Postes et quarts, **sans identifiant d'opérateur** | Des étudiants et une décision d'affectation |
| Personnes concernées (usage réel) | Les utilisateurs des comptes `passeur` ou `greffier` | Opérateurs et responsables de la ligne ; salariés dont le travail est mesuré | Les étudiants (et, moins, les enseignants) |
| Point de vigilance | Effacement d'un utilisateur, information des utilisateurs | Glissement vers l'évaluation d'individus | Décision automatisée (art. 22) : un humain valide avant publication |

Les mesures obligatoires de votre thème sont dans votre `PROJET.md` ; les durées proposées dans l'énoncé (chapitre 3, section 7).

**Étape 3 · Une branche, puis l'en-tête de la fiche.**

```bash
$ git switch main
$ git pull
$ git switch -c fiche-conformite-1-5
```

Ouvrez `docs/fiche_conformite.md` (le gabarit à 13 rubriques est déjà là). En-tête : **Équipe n° X**, les **identifiants GitHub** des membres, le thème, une version, une date. **Aucun nom civil, aucune adresse de courriel**, nulle part. Ne retirez pas la deuxième ligne du gabarit, qui le rappelle.

**Étape 4 · Les rubriques 1 à 5.**

| Rubrique | Ce qu'on y écrit | Erreur fréquente |
|---|---|---|
| 1 · Finalité | Le but de l'outil en **une** phrase, et ce qu'il exclut (reprendre la vision de `PROJET.md`) | Décrire l'application au lieu de son but ; plusieurs buts ; une phrase vague |
| 2 · Données traitées | Les catégories de données ; réelles ou fictives ; sensibles oui ou non | Oublier le compte de connexion, les commentaires libres, les journaux |
| 3 · Personnes concernées | Qui, dans la formation (aucune personne réelle) et en usage réel ; un ordre de grandeur | Répondre « personne » sans distinguer ; oublier les personnes mesurées |
| 4 · Base légale ou justification | « Données fictives » : d'où elles viennent, pourquoi elles ne visent personne, comment on s'en assure. Usage réel : base légale (art. 6) à déterminer avec le DPO | Choisir soi-même une base légale réelle ; « le RGPD ne s'applique pas » |
| 5 · Conservation | Une durée, une date ou un événement déclencheur, et ce qui se passe à cette date | « Tant que nécessaire » ; une durée sans point de départ |

Thème B, rubrique 1 : « Mesurer et améliorer le rendement des équipements de la ligne 4 (TRS par poste et par quart) pendant une campagne de mesure, sans jamais évaluer individuellement un salarié. » La fiche d'exemple complète du thème B est au chapitre 3, section 8.7. En A, la rubrique 2 nomme `proprietaire` ; en C, la rubrique 1 nomme la décision d'affectation et la rubrique 2 le rang et les vœux. La date de fin du dépôt dans la formation : demandez-la à l'enseignant.

**Étape 5 · Commit, PR, relecture.**

```bash
$ git add docs/fiche_conformite.md
$ git commit -m "Remplit les rubriques 1 à 5 de la fiche de conformité"
```

Poussez et ouvrez la PR comme à la fiche H, étape 10. Le relecteur, un coéquipier **autre que l'auteur**, passe la fiche I et vérifie en plus :

1. aucun nom civil, aucune adresse de courriel, en-tête compris ;
2. la finalité tient en une phrase et ressemble à la vision de `PROJET.md` ;
3. les rubriques 2 et 3 distinguent la formation (fictif) de l'usage réel ;
4. les rubriques 4 et 5 ne tranchent rien qui revienne au DPO ou au RSSI, et donnent une durée avec une date ou un événement.

**Pas aujourd'hui** : les rubriques 6 et 7 (elles peuvent glisser), les rubriques 8 à 13 (séance 4). En retard, les rubriques 4 et 5 se réduisent à une phrase chacune ; la fiche commitée reste au livrable. N'écrivez pas de `@identifiant` dans un exemple ou une description de PR : GitHub prévient la personne qui porte ce nom.

*Explications : chapitre 3, sections 6 à 9.*

---

## Fiche K · Modèle de données, migration, test d'intégrité

**Le gardien des données et au moins un coéquipier. Fini quand :** le modèle sur papier a été validé ; les tables du thème sont déclarées et ajoutées à `@DriftDatabase` ; `schemaVersion` vaut 2 (ou 3 après la résolution « Si deux branches… » ci-dessous, avec alors `drift_schema_v3.json` en plus), et `drift_schema_v2.json`, `base_de_donnees.steps.dart` et `test/core/data/migrations/` sont commités ; `flutter test test/core/data/migrations` est vert ; un test prouve qu'une insertion orpheline est rejetée et n'a rien écrit ; `make-migrations` relancé ne change rien ; la PR est relue par un coéquipier et fusionnée avant la fin de la séance.

**Avant tout : une seule migration à la fois.** Prévenez le gardien des données avant de modifier une table drift ou `schemaVersion`. Tant qu'une PR de migration est ouverte, aucune autre branche n'en prépare.

**Étape 1 · Le modèle sur papier, validé par l'enseignant.** Une boîte par entité avec ses colonnes (type, obligatoire ou non) ; la clé primaire `id` ; un trait par relation, avec sa cardinalité et la clé étrangère, toujours du côté « plusieurs » ; les contraintes en marge (unicité, `fin > début`, liste fermée) ; ce qu'on **ne stocke pas**, et pourquoi (thème B : aucune colonne d'opérateur). Les entités viennent de l'énoncé, rubrique « Données manipulées ». Dates en UTC (`debut_utc`, `fin_utc`).

**Étape 2 · Une branche, puis les tests d'abord.**

```bash
$ git switch main
$ git pull
$ git switch -c modele-donnees-v2
```

Ajoutez à `test/core/data/base_de_donnees_test.dart` les tests des nouvelles tables : un cas accepté, **une insertion orpheline refusée et rien d'écrit**, les contraintes. Ils ne compilent pas encore (`Undefined name 'PostesCompanion'`) : c'est le rouge. Commitez.

**Étape 3 · Déclarer les tables et passer à la version 2.** Une table par fichier dans `lib/features/<fonctionnalité>/data/` ; leur nom dans la liste `@DriftDatabase(tables: [...])` de `lib/core/data/base_de_donnees.dart` ; `schemaVersion => 2`. On ne touche pas encore à `onUpgrade`.

**Étape 4 · Générer, dans cet ordre.**

```bash
$ dart run build_runner build --delete-conflicting-outputs
$ dart run drift_dev make-migrations
$ git status
```

`git status` montre `base_de_donnees.dart` modifié, et trois nouveautés à versionner : `drift_schemas/base_de_donnees/drift_schema_v2.json`, `lib/core/data/base_de_donnees.steps.dart`, `test/core/data/migrations/`. À ce stade, le test de migration généré échoue (`Schema does not match`) : normal, l'étape de migration n'est pas écrite.

**Étape 5 · Écrire l'étape de migration.** Dans `base_de_donnees.dart`, ajoutez `import 'base_de_donnees.steps.dart';` et remplacez toute la fonction `onUpgrade` (exemple du thème B) :

```dart
    onUpgrade: stepByStep(
      // Version 2 : tables du thème B, les postes et leurs quarts.
      from1To2: (m, schema) async {
        await m.createTable(schema.postes);
        await m.createTable(schema.quarts);
      },
    ),
```

Écrivez `schema.postes`, la table telle qu'elle est en version 2. Ne touchez pas à `beforeOpen` : la ligne `PRAGMA foreign_keys = ON` active les clés étrangères à chaque ouverture.

**Étape 6 · Nettoyer le test généré.** Dans `migration_test.dart`, gardez la première partie (« simple database migrations ») ; supprimez la seconde, le modèle à remplir avec ses `TODO`, quand la migration ne fait que créer des tables.

**Étape 7 · Commiter, puis vérifier comme la CI.**

```bash
$ dart format .
$ git add -A
$ git commit -m "Ajoute les tables du thème et la migration vers la version 2"
$ dart run build_runner build --delete-conflicting-outputs
$ dart run drift_dev make-migrations
$ git status --porcelain -- drift_schemas lib/core/data test/core/data/migrations
$ dart format --output=none --set-exit-if-changed .
$ flutter analyze
$ flutter test
```

Le `git status --porcelain` ne doit **rien** afficher : `make-migrations` n'a rien changé. Puis `No issues found!` et `All tests passed!`.

**Étape 8 · La fiche, puis la PR.** Notez en commentaire (`<!-- … -->`) dans `docs/fiche_conformite.md` les rubriques que touche le modèle (thème B : 2, 5, 6 et 11 ; exemple au chapitre 4, section 8). Poussez, ouvrez la PR (fiche H, étape 10), joignez la photo du modèle. Un coéquipier relit avec la fiche I, ligne 9 comprise.

**Trois interdits** : modifier une base à la main pour faire passer un changement ; modifier à la main `drift_schemas/` ou un fichier `*.steps.dart` ; supprimer ou régénérer un instantané `drift_schema_vN.json` déjà fusionné dans `main`, même si `make-migrations` le propose.

**Si deux branches ont préparé chacune une version 2.** Celle de `main` reste ; la branche qui fusionne en second devient la **version 3**. Avec le gardien des données, sur la branche en conflit après `git pull origin main` :

1. reprendre la version de `main` des fichiers de migration en conflit :

   ```bash
   $ git checkout origin/main -- drift_schemas/base_de_donnees/drift_schema_v2.json lib/core/data/base_de_donnees.steps.dart test/core/data/migrations/base_de_donnees/generated/schema_v2.dart lib/core/data/base_de_donnees.dart
   ```

2. dans `base_de_donnees.dart`, rajouter l'import et le nom de sa table dans la liste, passer à `schemaVersion => 3`, **sans** toucher à `from1To2` ;
3. `dart run build_runner build --delete-conflicting-outputs`, puis `dart run drift_dev make-migrations` (`Creating schema file for version 3`) ;
4. écrire `from2To3` à la suite de `from1To2` (`flutter analyze` le réclame tant qu'il manque) ;
5. `dart format .`, `flutter analyze`, `flutter test`, puis `git add -A`, `git commit`, `git push`.

**Thèmes A et C.** Même méthode, entités de l'énoncé. A : `voie`, `passeur`, `saison`, `route`, `traversee` (orpheline possible : une route d'une saison inexistante). C : `enseignant`, `sujet`, `etudiant`, `voeu`, `affectation` (orpheline possible : un vœu vers un sujet inexistant). Le seed complet et la garde `RequireRole` ne sont pas demandés aujourd'hui.

*Explications : chapitre 4, sections 3 à 7 et 9.*

---

## Fiche L · Revue croisée entre équipes

**Deux équipes (ou trois), auteurs présents. Fini quand :** au moins une PR de chaque équipe a été relue par l'équipe jumelée, auteur présent, avec des commentaires **écrits** sur GitHub ; chaque commentaire a reçu une réponse ; la fusion a été approuvée par un coéquipier de l'auteur.

**Les paires** (numéros attribués en séance 2 ; si l'attribution réelle s'en écarte, l'annonce de l'enseignant fait foi).

| Avec 8 équipes | Avec 7 équipes |
|---|---|
| 01–04 | 02–05 |
| 02–05 | 03–06 |
| 03–06 | Trio circulaire 01, 04, 07 : **07 relit 01, 01 relit 04, 04 relit 07** |
| 07–08 (même thème : toléré en séance 3, évité en séance 4) | |

Avec 8 équipes, quatre paires ; avec 7 équipes, deux paires et un trio circulaire. Dans une paire, chaque équipe relit l'autre. Dans le trio, chacune relit une équipe et est relue par une autre.

**Le déroulé.**

1. **L'équipe choisit la PR à faire relire** : une PR ouverte de la séance, par exemple la première user story.
2. **L'auteur la présente à voix haute**, en quelques minutes : ce qu'elle fait, pourquoi, ce que l'agent a proposé et ce qu'il a refusé.
3. **L'équipe jumelée relit avec la fiche I**, pose ses questions à l'oral, puis **les écrit sur GitHub** : commentaires de ligne, relecture de type **Comment**. Un commentaire oral non écrit est perdu.
4. **L'auteur répond à chaque commentaire** : par un nouveau commit sur la même branche, poussé, ou par une explication.
5. **Les rôles s'inversent** (dans le trio : l'équipe suivante).

Pour voir la PR fonctionner sur son poste (facultatif si la CI est verte et que la PR ne touche pas d'écran) :

```bash
$ gh pr checkout <numéro>
$ dart run build_runner build --delete-conflicting-outputs
$ flutter test
$ flutter run -d chrome
```

**Ce que l'équipe jumelée ne fait pas** : pousser un commit sur la branche, fusionner, approuver à la place de l'équipe, corriger elle-même ce qu'elle a trouvé. Elle n'a pas d'accès en écriture au dépôt.

**Qui approuve.** Un **coéquipier de l'auteur**, autre que lui, après avoir lu la PR **et** les commentaires de l'équipe jumelée. Chaque point [bloquant] a reçu une correction ou une réponse convaincante ; sinon, on n'approuve pas. Si l'enseignant annonce une autre variante, sa consigne du jour s'applique.

La revue croisée ne dispense pas des relectures internes : chaque étudiant ouvre une PR, même petite, et relit celle d'un autre.

*Explications : chapitre 1, sections 4 et 7.*

---

## Fiche M · Bilan et livrable de fin de séance

**En équipe ; le gardien du harnais tient la plume. Fini quand :** chaque ligne de la definition of done ci-dessous est vraie, `JOURNAL.md` et `CLAUDE.md` sont à jour dans `main`, et chacun sait ce qu'il fera (ou non) de la tâche facultative.

**Le livrable de fin de séance (identique pour les trois thèmes).** **Première règle verte, modèle et migrations fusionnés, début de `docs/fiche_conformite.md` commité.** Détail : première user story livrée (scénario `.feature`, tests, code, PR relue), modèle de données (schéma, première migration, test d'intégrité), `docs/fiche_conformite.md` commité (rubriques 1 à 5), au moins une PR relue par une autre équipe.

**La definition of done**, à cocher ensemble :

- [ ] Sur une base en mémoire vide, le schéma se crée et les migrations se rejouent sans erreur (test), avec une seule migration à la fois ; `flutter test` est vert (le seed complet est attendu entre S3 et S4, au début de S4 ou pendant le sprint).
- [ ] Un test prouve qu'une insertion orpheline est rejetée.
- [ ] Chaque étudiant a ouvert une PR (même petite) et relu celle d'un autre.
- [ ] **Aucune donnée personnelle réelle dans le dépôt, la fiche existe et indique « données fictives » avec une justification, sans nom civil ni courriel.**
- [ ] La fiche de conformité est commitée (rubriques 1 à 5) et a été relue par un coéquipier.

**`JOURNAL.md` et `CLAUDE.md`, dans une même PR** (gardien du harnais) :

```bash
$ git switch main
$ git pull
$ git switch -c journal-s3
```

1. Dans `JOURNAL.md`, réécrivez l'« État courant » : où on en est, prochaine étape, commandes clés, décisions, reste à faire. Notez ce qui a glissé et qui s'en charge.
2. Dans `CLAUDE.md`, ajoutez la règle de données (proposition des supports, à reformuler si l'équipe le souhaite en gardant les trois idées). Section « Règles » :

   ```markdown
   - Une seule migration à la fois, coordonnée par le gardien des données : avant de
     modifier une table drift ou `schemaVersion`, le prévenir ; tant qu'une PR de
     migration est ouverte, aucune autre branche ne prépare de migration.
   - Si deux branches préparent la même version : celle qui fusionne en second
     reprend les fichiers de migration de `main` et passe à la version suivante
     (chapitre 4 de la séance 3, section 7.2).
   ```

   Section « Interdits » :

   ```markdown
   - Ne jamais supprimer ni régénérer un instantané `drift_schemas/` déjà présent sur
     `main`, même si `make-migrations` le propose.
   ```

3. Commit, PR (fiche H, étape 10), relecture par un coéquipier, fusion. Puis chacun : `git switch main`, `git pull`.

**L'état de la fiche de conformité** : rubriques 1 à 5 commitées et relues ? Sinon, c'est la priorité avant de partir.

**Ce qui peut glisser** (entre la séance 3 et la séance 4, au début de la séance 4 ou dans le sprint) : l'écran de la première user story (le Cubit et son test restent) ; le seed complet ; la garde d'accès `RequireRole` avec son test de refus ; les rubriques 6 et 7 de la fiche ; l'exercice de courriel de demande d'accès.

**Ce qui ne se sacrifie jamais** : contrôle d'ouverture, première user story en TDD et en BDD sur la sous-règle isolée du thème, modèle de données avec première migration et test d'intégrité, RGPD (dont les droits des personnes) et début de la fiche, PR croisées.

**Avant la séance 4 (douze jours) : une tâche facultative, de 2 h au plus par étudiant.** En priorité, terminer ce qui a glissé (seed complet, rôles et garde `RequireRole` avec son test de refus) et fusionner les PR ouvertes ; sinon, au choix, relire la fiche de conformité ou rédiger en cinq lignes un courriel de demande d'accès (art. 15 RGPD) à un service que l'on utilise, à ne pas envoyer, sauf si l'on le souhaite vraiment (trame au chapitre 3, section 5.3 ; ce brouillon ne va ni dans le dépôt, ni dans un prompt). La séance 4 ne suppose pas le CRUD terminé.

*Explications : chapitre 1, section 3.2 ; chapitre 3, section 9 ; chapitre 4, sections 7.3 et 10.*

---

## Fiche N · Dépannage de la séance 3

**Premier réflexe, toujours :** `git status`, et lire ce qu'il répond. Pour les erreurs git de base (identité, push refusé, `master`…), la fiche F de la séance 2 reste valable.

| Ce que vous voyez | Ce qui se passe | Ce qu'il faut faire |
|---|---|---|
| `flutter test` rouge après un clone ou un `git pull` : `Error when reading 'lib/core/data/base_de_donnees.g.dart'`, puis `+20 -4: Some tests failed.` | Les fichiers générés n'existent pas : ils ne sont pas versionnés | `dart run build_runner build --delete-conflicting-outputs`, puis `flutter test` (chapitre 2, section 9.4) |
| `flutter test` est vert, mais aucun scénario n'apparaît dans le compte | Les tests tirés des `.feature` n'ont pas été générés : ils disparaissent sans bruit | Même geste : `build_runner`, puis `flutter test` |
| `… packages have newer versions incompatible with dependency constraints` | Les versions sont verrouillées exprès | Rien. **Jamais** `flutter pub upgrade` |
| `git status` montre des fichiers modifiés de mercredi ; ou `git pull` refuse à cause de modifications locales | Du travail non commité est resté | `git diff` ; à garder : une branche et un commit ; à jeter : `git restore <fichier>` (irréversible) |
| `git pull` affiche un conflit sur `main` | Un commit a été fait sur `main` en local | Appeler l'enseignant (chapitre 1 de la séance 2, section 9.9) |
| Tout est rouge chez un seul membre | Poste différent des autres | Comparer `flutter --version` avec un poste qui marche |
| Des étapes générées portent les valeurs dans leur nom (`un_quart_de480_minutes.dart`) | Le scénario a été écrit sans accolades | Valeurs entre accolades (`{480}`, `{'pause'}`), puis `build_runner` (chapitre 2, section 4.2) |
| Les mots-clés `Soit`, `Quand`, `Alors` ne sont pas reconnus | `# language: fr` n'est pas la première ligne | Le mettre en première ligne, sans rien avant |
| Le scénario modifié n'a pas d'effet, ou une étape nouvelle n'a pas de fichier dans `test/steps/` | `build_runner` n'a pas été relancé après la modification du `.feature` | `dart run build_runner build --delete-conflicting-outputs` |
| Le scénario échoue sur `UnimplementedError` | Les étapes sont encore des squelettes | Normal au départ : les compléter (fiche H, étape 6) |
| Un test échoue sur `Error when reading 'lib/features/…'` ou `Undefined name '…'` | Le test nomme du code qui n'existe pas encore | Normal en TDD : c'est le rouge. Écrire le code minimal |
| `All tests passed!` avec un `~1` dans la sortie | Un test est sauté (`skip:`) | Chercher `skip:` dans `git diff main -- test/` et le retirer |
| La page de la PR affiche *This branch has conflicts that must be resolved* | Une PR d'un coéquipier, fusionnée avant, touche la même zone | `git switch <branche>`, `git pull origin main`, résoudre dans VS Code, `git add`, `git commit`, `flutter test`, `git push` (chapitre 1, sections 6.3 à 6.5). Jamais `--force` |
| Conflit dans `JOURNAL.md` ou « Décisions de l'équipe » | Deux personnes ont ajouté une ligne au même endroit | Garder les deux entrées ; vérifier avec `git diff` qu'aucune ligne n'est perdue et qu'il ne reste aucun marqueur |
| Un fichier généré (`*.g.dart`, test tiré d'un `.feature`) apparaît dans un conflit ou dans le diff d'une PR | Il a été commité par erreur | Le signaler en relecture ; relancer `build_runner` après la fusion (chapitre 1, section 6.7) |
| Conflit dans `pubspec.yaml` ou `pubspec.lock` | Deux branches ont modifié les dépendances | `git merge --abort`, prévenir le gardien du harnais et l'enseignant. Jamais de correction à la main |
| `CONFLICT (add/add)` sur `drift_schema_v2.json`, `base_de_donnees.steps.dart`, `schema_v2.dart`, et conflit dans `base_de_donnees.dart` | Deux branches ont préparé chacune une version 2 | Celle de `main` reste, la vôtre devient la version 3 : fiche K, encadré « Si deux branches… » (chapitre 4, section 7.2) |
| `make-migrations` s'arrête : `A schema for version 2 … already exists and differs from the current schema` | Une table a changé sans nouvelle version | Passer à la version suivante (`schemaVersion` + 1). **Ne jamais** supprimer l'instantané existant |
| Le contrôle de la PR est rouge à l'étape « Refuser la modification d'un instantané déjà fusionné » | Un instantané `drift_schema_vN.json` déjà présent sur `main` a été modifié, supprimé ou régénéré | Le rétablir : `git fetch origin`, puis `git restore --source origin/main -- drift_schemas/base_de_donnees/drift_schema_vN.json`. Passer ensuite à la version suivante et relancer `make-migrations` (chapitre 4, section 7.2) |
| Le test de migration échoue : `Schema does not match` | `onUpgrade` ne crée pas les nouvelles tables | Écrire l'étape `fromNToM` (fiche K, étape 5) |
| `flutter analyze` : `The named parameter 'from2To3' is required` | Une version a été ajoutée sans son étape | Écrire `from2To3` à la suite de `from1To2` |
| `les clés étrangères sont activées` échoue (`Expected: <1>`, `Actual: <0>`) et le refus de l'orphelin ne lève plus d'erreur | La ligne `PRAGMA foreign_keys = ON` de `beforeOpen` a été retirée | La remettre. Ne jamais « corriger » le test |
| L'agent propose de modifier un test de refus pour qu'il passe (l'orphelin disparaît, l'attente devient « réussit ») | Il change le juge au lieu du jugé | Refuser, demander **pourquoi** le test échoue, noter le refus dans la PR |
| L'agent propose `git push --force` ou `gh pr review --approve` | Il veut en finir à votre place | Refuser. On ajoute un commit, on ne réécrit rien ; une approbation engage une personne |
| Votre base de développement dans Chrome est incohérente | Votre base locale seulement | Outils de développement, onglet « Application », « Clear site data ». Ce n'est pas une migration |

**Trois choses à ne pas faire, même si un tutoriel ou l'agent le propose :** `git push --force` ; `flutter pub upgrade` ; supprimer ou régénérer un instantané de `drift_schemas/` déjà fusionné.

---

## Glossaire

- **Équipe jumelée** : équipe désignée par le programme pour relire les PR de la vôtre pendant la revue croisée.
- **Fini quand** : la condition, en tête de chaque fiche, qui dit que l'atelier est terminé.
- **Instantané (de schéma)** : fichier JSON de `drift_schemas/` qui décrit le schéma exact d'une version.
- **Insertion orpheline** : tentative d'enregistrer une ligne dont la clé étrangère pointe vers une ligne qui n'existe pas.
- **Livrable** : ce que l'équipe doit avoir fusionné à la fin de la séance.
- **Tâche facultative** : travail de 2 h au plus par étudiant, entre la séance 3 et la séance 4, pour terminer ce qui a glissé.
- **Trio circulaire** : groupe de trois équipes où chacune relit la suivante, utilisé avec un nombre impair d'équipes.

Les autres termes (PR, conflit, scénario, étape, cas d'usage, Cubit, migration, clé étrangère, donnée personnelle, base légale…) sont définis dans les glossaires des chapitres 1 à 4.

---

## Pour aller plus loin

- Supports de la séance 2, chapitre 4 : fiches C (initialisation), D (checklist en cinq lignes), E (modèle de PR) et F (dépannage git).
- `docs/ARCHITECTURE.md` de votre dépôt : section 5 (ordre de travail d'une story) et section 7 (migrations, retrait de `jets`, ajout d'une colonne).
- Module de conformité du cours (`cours/conformite-ai-act-rgpd.md`), sections 4 à 7, pour aller au-delà des rubriques 1 à 5.

---

## Points non vérifiés (à signaler honnêtement)

- **Les fiches n'ont pas été rejouées en tant que telles.** Elles condensent les chapitres 1 à 4, dont les commandes ont été exécutées sous Linux seulement, avec Flutter 3.50.1, sur une copie du dépôt-modèle (voir les points non vérifiés de chaque chapitre). Ni Windows ni macOS.
- **Presque rien n'a été exécuté sur GitHub** : seul l'essai du script de création des dépôts (27 novembre 2026) s'est fait en ligne. `gh pr create --web`, `gh pr checkout`, les relectures, l'approbation par un coéquipier et la fusion avec suppression de la branche sont décrits d'après la documentation, le programme et les supports de la séance 2.
- **Fiche H** : le travail avec l'agent (plan, critique) n'a pas été rejoué ; le nom de branche est un exemple. L'ordre des commits (test, puis code, pièce par pièce) suit l'historique obtenu au chapitre 2, section 9.1. Les commandes `git push -u origin <branche>` et `gh pr create --web` viennent de la fiche C de la séance 2.
- **Fiche K** : l'étape 7 suit le chapitre 4, section 5.3, étape 6 (« Commiter, puis vérifier comme la CI ») : le `git status --porcelain` n'est vide que si tout est commité. La résolution en version 3 a été jouée avec des branches locales, pas sur GitHub.
- **Fiche L** : l'absence d'accès en écriture de l'équipe jumelée découle du script de création des dépôts, lancé en réel le 27 novembre 2026 pour une seule équipe d'essai sans que l'accès d'un compte extérieur à l'équipe soit vérifié ; le programme lui-même note une « variante à vérifier ».
- **Fiche N** : les messages cités viennent des chapitres 1, 2 et 4 (sorties anglaises, `LC_ALL=C` pour git) ; ceux qui n'y figurent pas (mots-clés non reconnus sans `# language: fr`, étape sans fichier) sont décrits par leur effet, pas par un message relevé.

---

## Sources

- Chapitres 1 à 4 de ce support, qui portent le détail des sources et des vérifications (26 novembre 2026, Linux, git 2.53.0, gh 2.100.0, Flutter 3.50.1, drift 2.35.4).
- `cours/programme-detaille.md` : séance 3 (blocs 1 à 11, ordre de coupe, « peut glisser », livrable, definition of done) ; section 5 (lignes S2 → S3 et S3 → S4).
- Dépôt-modèle (`depot-modele/`) : `README.md` (commandes après le clone, « Vérifier avant une PR »), `CLAUDE.md`, `JOURNAL.md`, `docs/fiche_conformite.md`, `.github/pull_request_template.md`.
- Supports de la séance 2, chapitre 4 : fiches C et F.
