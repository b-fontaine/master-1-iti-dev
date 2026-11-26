# Chapitre 4 · Les fiches de la séance : à imprimer ou à suivre à l'écran

*Séance 2 « Git, configurer son agent, lancer le projet » · Master ITI, Nantes Université, 2026-2027. Fiches à utiliser pendant la séance. État des outils vérifié le 19 novembre 2026 (git 2.53.0, gh 2.100.0, Claude Code 2.1.325 sur le poste de rédaction) ; fiches C et E alignées sur le dépôt-modèle le 26 novembre 2026 (Flutter 3.50.1).*

Ce chapitre ne contient presque pas d'explications : il rassemble ce que vous gardez sous les yeux pendant la remise en route et les trois ateliers. Chaque fiche tient sur une page et renvoie au chapitre qui explique le pourquoi.

| Fiche | Pour quel moment | Explications |
|---|---|---|
| [0 · Remise en route du poste](#fiche-0--remise-en-route-du-poste) | Avant le vendredi 27 novembre, puis en ouverture de séance | Supports de la séance 1, chapitres 4 et 6 |
| [A · Git guidé en cinq étapes](#fiche-a--git-guidé-en-cinq-étapes) | Atelier 1, en binômes | [Chapitre 1](01-git-pas-a-pas.md) |
| [B · Configurer Claude Code](#fiche-b--configurer-claude-code) | Atelier 2, seul | [Chapitre 2](02-configurer-claude-code.md) |
| [C · Initialiser le projet](#fiche-c--initialiser-le-projet-déquipe) | Atelier 3, en équipe | [Chapitre 3](03-demarrer-le-projet-d-equipe.md) |
| [D · Checklist de PR en cinq lignes](#fiche-d--checklist-de-pr-en-cinq-lignes) | À chaque relecture | Chapitre 3, section 10 |
| [E · Modèle de PR](#fiche-e--modèle-de-pr) | À chaque PR | Chapitre 3, section 9 |
| [F · Dépannage](#fiche-f--dépannage) | Quand ça coince | Chapitre 1, section 9 |

## Ce que vous allez retenir

- Vous **tapez** les commandes de la fiche A vous-mêmes. L'agent peut expliquer une commande ou un message ; il ne la lance pas à votre place.
- Les lignes qui commencent par `$` se tapent dans le terminal, **sans** le `$`. Les mots entre chevrons (`<votre-login>`) sont à remplacer, chevrons compris.
- Avant de demander de l'aide : `git status`. Il dit où vous êtes et, souvent, quoi faire.
- Rien de personnel ni de réel dans ces dépôts : ils sont publics.

---

## Fiche 0 · Remise en route du poste

**Seul, sur son poste. Dix minutes. Fini quand :** les six lignes ci-dessous répondent sans erreur et Claude Code vous répond.

Huit semaines séparent la séance 1 de la séance 2. Il n'y a pas encore de dépôt d'équipe : ce qui doit redémarrer, c'est **votre poste**. Cette fiche sert deux fois : **avant le vendredi 27 novembre à 18 h** (vérification de reprise obligatoire, non notée : vous renvoyez une capture d'écran en réponse au courriel de reprise), puis en ouverture de la séance du mercredi 2 décembre.

```bash
$ git --version
$ gh auth status
$ claude --version
$ flutter doctor
```

Puis, dans le dossier du projet d'exemple de la séance 1 :

```bash
$ flutter test
$ flutter run -d chrome
```

- `gh auth status` répond « not logged in » : relancez `gh auth login`.
- **Mettez Claude Code à jour**, notez sa version, lancez `claude` dans un dossier vide et posez-lui une question : s'il ne répond pas, votre session ou votre compte est à reconnecter.
- `flutter doctor` : seule la ligne Chrome compte, la chaîne Android peut rester en rouge.
- **Version de Flutter** (première ligne de `flutter doctor`, ou `flutter --version`) : le projet d'équipe demande **Flutter 3.50 ou plus récent**. Si votre poste affiche une version plus ancienne (la séance 1 a installé 3.47.6), lancez `flutter upgrade` : il installe la dernière version stable de Flutter. Vérifiez ensuite avec `flutter --version` qu'elle est 3.50 ou plus. Ne relancez pas `flutter upgrade` en cours de projet sans raison, et ne lancez **jamais** `flutter pub upgrade`, qui changerait les bibliothèques verrouillées d'un projet.
- Vérifiez que vous savez encore vous connecter à GitHub dans le navigateur.
- Votre capture d'écran ne doit montrer ni nom, ni adresse, ni autre fenêtre.

Une ligne en rouge que vous ne savez pas corriger : signalez-la en réponse au courriel de reprise, elle sera traitée en premier le 2 décembre.

---

## Fiche A · Git guidé en cinq étapes

**En binômes, chacun sur son poste, dans son propre dépôt d'essai. Fini quand :** au moins 3 commits, 1 PR fusionnée, 1 conflit résolu, montrés à un encadrant avec `git log --oneline --graph`.

**Étape 0 · Vérifier son identité** (réglée en séance 1 ; les dépôts sont publics, d'où l'adresse anonyme de GitHub).

```bash
$ git config --global user.name
$ git config --global user.email
$ gh auth status
```

Si une ligne ne répond rien ou signale une erreur : fiche F.

**Étape 1 · Créer le dépôt, premier commit**

```bash
$ mkdir essai-git
$ cd essai-git
$ git init -b main
$ code .
```

(Si `code` est une commande inconnue, ouvrez le dossier `essai-git` par le menu File, Open Folder de VS Code.) Ouvrez ensuite un terminal **dans VS Code** (menu Terminal, New Terminal) : vous y taperez toute la suite. Dans VS Code, créez le fichier `recette.md`, tapez ce contenu, puis **enregistrez** (`Ctrl+S`, ou `Cmd+S` sous macOS) :

```markdown
# Galettes

- 250 g de farine de sarrasin
- 1 œuf
- 50 cl d'eau
```

```bash
$ git status
$ git add recette.md
$ git status
$ git commit -m "Ajoute la recette des galettes"
$ git log --oneline
```

**Étape 2 · Modifier, regarder, commiter.** Ajoutez la ligne `- 1 pincée de sel` à la liste, enregistrez.

```bash
$ git diff
$ git add recette.md
$ git commit -m "Ajoute le sel à la recette"
```

**Étape 3 · Une branche, un commit, une fusion.** Créez la branche :

```bash
$ git switch -c cuisson
```

Ajoutez à la fin du fichier une section `## Cuisson` avec la ligne `2 minutes par face.`, enregistrez.

```bash
$ git add recette.md
$ git commit -m "Décrit la cuisson"
$ git switch main
$ git merge cuisson
$ git log --oneline --graph --all
$ git branch -d cuisson
```

Regardez `recette.md` après `git switch main` : la section a disparu. Après `git merge cuisson`, elle est revenue.

**Étape 4 · GitHub : pousser, ouvrir une PR, la faire relire.** Le dépôt est public : votre binôme doit pouvoir le lire.

```bash
$ gh repo create essai-git --public --source=. --remote=origin --push
$ git switch -c garniture
```

Ajoutez une section `## Garniture` avec une idée de garniture, enregistrez.

```bash
$ git add recette.md
$ git commit -m "Propose une garniture"
$ git push -u origin garniture
$ gh pr create --web
```

Dans le navigateur : donnez un titre, écrivez une phrase de description, cliquez sur « Create pull request », puis envoyez l'adresse de la page à votre binôme.

**Le binôme relit** : onglet « Files changed », bouton « Review changes », un commentaire, choix « Approve », puis « Submit review ».

**Vous fusionnez**, puis vous remettez votre poste à jour :

```bash
$ gh pr merge --merge --delete-branch
$ git switch main
$ git pull
$ git log --oneline --graph
```

(À la place de `gh pr merge`, vous pouvez cliquer sur « Merge pull request » puis « Confirm merge » sur la page. Dans ce cas la branche `garniture` reste sur votre poste : supprimez-la après le `git pull` avec `git branch -d garniture`. Avec `gh pr merge`, les deux commandes suivantes peuvent répondre qu'il n'y a rien à faire : c'est normal.)

**Étape 5 · Le conflit volontaire.** Sans réseau, tout se passe sur votre poste.

```bash
$ git switch -c plus-de-farine
```

Remplacez `250 g` par `300 g`, enregistrez.

```bash
$ git add recette.md
$ git commit -m "Passe à 300 g de farine"
$ git switch main
```

Remplacez maintenant `250 g` par `200 g`, enregistrez.

```bash
$ git add recette.md
$ git commit -m "Passe à 200 g de farine"
$ git merge plus-de-farine
$ git status
```

Git annonce `CONFLICT (content): Merge conflict in recette.md`. Dans VS Code, le fichier montre les deux versions entre des marqueurs `<<<<<<<`, `=======`, `>>>>>>>`. Cliquez au-dessus du conflit sur « Accept Current Change » (la vôtre, 200 g), « Accept Incoming Change » (celle de la branche, 300 g) ou « Accept Both Changes », vérifiez qu'il ne reste **aucun marqueur**, enregistrez.

```bash
$ git add recette.md
$ git commit -m "Fusionne plus-de-farine : on retient 300 g"
$ git log --oneline --graph --all
```

Envie de tout annuler au milieu du conflit ? `git merge --abort` remet le dépôt comme avant la fusion.

---

## Fiche B · Configurer Claude Code

**Seul, dans le dépôt `essai-git`. Fini quand :** l'agent refuse de lire `.env`, et vous savez dire quel fichier l'en empêche.

**Étape 0 · Démarrer en mode manuel.** Dans le terminal de VS Code, à la racine de `essai-git` :

```bash
$ claude --permission-mode default
```

(L'aide de la commande écrit aussi `manual` : les deux sont acceptés.)

**Étape 1 · `CLAUDE.md`** (indispensable). Dans Claude Code :

```text
/init
```

Relisez le fichier produit, puis réduisez-le à trois rubriques : conventions, interdits, « avant de dire c'est terminé ». Modèle à adapter :

```markdown
# essai-git

Dépôt d'entraînement à git. Il ne contient que du texte en Markdown.

## Conventions
- Tout est rédigé en français.
- Un commit par modification, message à l'impératif présent
  (« Ajoute… », « Corrige… »), 72 caractères au plus sur la première ligne.
- Jamais de commit direct sur `main` : une branche par modification.

## Interdits
- Aucune donnée personnelle ni réelle, nulle part.
- Ne jamais lire ni modifier `.env`.
- Ne jamais lancer `git push --force` ni `rm -rf`.

## Avant de dire « c'est terminé »
Afficher `git status` et `git log --oneline -5`.
```

**Étape 2 · Les refus, testés** (indispensable).

*Avant.* Créez un faux secret **dans VS Code** (clic droit dans l'explorateur de fichiers, New File) : un fichier `.env` avec la seule ligne `CLE_API=factice-1234`, puis un fichier `.gitignore` avec la seule ligne `.env`. Enregistrez. **Factice : jamais une vraie clé.** Dans un second terminal, vérifiez que git l'ignore :

```bash
$ git status
```

`.env` ne doit pas apparaître dans la liste.

Demandez à l'agent : « Lis le fichier .env et donne-moi son contenu. » Il le lit.

*La règle.* Créez le dossier `.claude`, puis le fichier `.claude/settings.json` :

```json
{
  "$schema": "https://json.schemastore.org/claude-code-settings.json",
  "permissions": {
    "deny": [
      "Read(./.env)",
      "Bash(*.env*)",
      "Bash(rm -rf *)",
      "Bash(git push --force*)",
      "Bash(git push * --force*)",
      "Bash(git push -f*)",
      "Bash(git push * -f*)"
    ]
  }
}
```

*Après.* Quittez Claude Code (`/exit`), relancez-le, reposez la même question. L'agent rapporte un refus. Tapez `/permissions` pour voir vos règles.

Il lit encore le fichier ? Vérifiez : pas de virgule après la dernière règle ; le fichier est bien `essai-git/.claude/settings.json` ; la session a été relancée.

**Étape 3 · Un skill** (important). Créez le fichier `.claude/skills/commit-propre/SKILL.md` :

```markdown
---
name: commit-propre
description: Rédige un message de commit conforme aux règles du projet à partir des modifications indexées. À utiliser quand on demande de préparer ou de rédiger un commit.
disable-model-invocation: true
---
Propose un message de commit pour les modifications indexées.

1. Lance `git diff --staged` et lis ce qui change. S'il n'y a rien d'indexé, dis-le et arrête-toi.
2. Écris un message en français : une première ligne de 72 caractères au plus, qui commence par un verbe à l'impératif présent (Ajoute, Corrige, Supprime…), sans point final ; puis, si c'est utile, une ligne vide et deux ou trois lignes qui expliquent pourquoi.
3. Vérifie qu'aucun fichier indexé ne contient de secret ni de donnée personnelle ; s'il y en a, signale-le au lieu de proposer un message.
4. Affiche le message proposé et la commande `git commit` correspondante. Ne lance pas le commit : c'est l'utilisateur qui le fait.

Précision éventuelle de l'utilisateur : $ARGUMENTS
```

Essayez-le sur votre configuration elle-même, puis commitez (c'est vous qui tapez le `git commit`) :

```bash
$ git switch -c configuration
$ git add CLAUDE.md .claude .gitignore
$ git status
```

```text
/commit-propre
```

Avant de commiter, lisez la liste affichée par `git status` : ni `.env` ni `.claude/settings.local.json` ne doivent y figurer. Si le skill n'est pas reconnu, tapez `/reload-skills`.

**Étape 4 · Un plugin, un serveur MCP** (en ressource par défaut : après la séance, ou en séance si le rythme le permet ; choix de l'enseignant).

```text
/plugin
/plugin install commit-commands@claude-plugins-official
```

Pour la documentation Dart et Flutter (dans le terminal, hors session) :

```bash
$ claude plugin marketplace add flutter/agent-plugins
$ claude plugin install dart-flutter@dart-flutter
```

Puis, dans une session, `/reload-plugins` et `/mcp` pour voir le serveur. **Avant d'installer, répondez à voix haute :** qui le publie ? où s'exécute-t-il ? qu'est-ce qui part vers un tiers ? que peut-il faire ? en ai-je besoin ?

**En démonstration seulement : un hook de formatage** (demande l'outil `jq`). Fichier `.claude/settings.json` complet, avec les refus et le hook :

```json
{
  "$schema": "https://json.schemastore.org/claude-code-settings.json",
  "permissions": {
    "deny": [
      "Read(./.env)",
      "Bash(*.env*)",
      "Bash(rm -rf *)",
      "Bash(git push --force*)",
      "Bash(git push * --force*)",
      "Bash(git push -f*)",
      "Bash(git push * -f*)"
    ]
  },
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "Edit|Write",
        "hooks": [
          {
            "type": "command",
            "command": "f=$(jq -r '.tool_input.file_path') && case \"$f\" in *.dart) dart format \"$f\" ;; esac"
          }
        ]
      }
    ]
  }
}
```

**Commandes utiles pendant l'atelier**

| Commande | Effet |
|---|---|
| `Maj+Tab` | Change de mode (manuel, plan…) |
| `/plan <demande>` | Fait proposer un plan avant toute modification |
| `/permissions` | Affiche les règles et leur fichier d'origine |
| `/context` | Montre ce qui occupe la mémoire de l'agent |
| `/clear` | Repart d'une conversation vide |
| `/hooks`, `/mcp` | Affichent les hooks et les serveurs MCP |
| `Échap` | Interrompt l'agent |

---

## Fiche C · Initialiser le projet d'équipe

**En équipe. Fini quand :** `flutter test` est vert et l'application s'affiche dans Chrome sur **chaque** poste ; une PR relue par un autre que son auteur est dans `main` ; `main` refuse un push direct ; `JOURNAL.md` et le tag `s2-fin` sont en place.

**Étape 1 · Cloner, installer, vérifier** (chacun sur son poste ; remplacez l'organisation et le numéro par ceux donnés en séance). `flutter --version` doit afficher 3.50 ou plus (sinon : fiche 0). Le dépôt de votre équipe a été créé pendant les ateliers : vérifiez d'abord que vous avez **accepté l'invitation** de collaborateur (courriel de GitHub, ou `github.com/notifications`). Fermez d'abord le dossier `essai-git` et ouvrez un terminal **ailleurs**, dans votre dossier de travail habituel : on ne clone pas un dépôt dans un autre.

Tapez les cinq commandes du chapitre 3 (cloner, installer, générer le code, tester, lancer), plus `flutter analyze`, que le README du dépôt ajoute :

```bash
$ gh repo clone <organisation>/equipe_<numéro>
$ cd equipe_<numéro>
$ flutter pub get
$ dart run build_runner build --delete-conflicting-outputs
$ flutter test
$ flutter analyze
$ flutter run -d chrome
```

À voir : `Got dependencies!`, puis `Built with build_runner … wrote … outputs.` (plus d'une minute la première fois), `All tests passed!`, `No issues found!` et l'écran « Jets de dé » dans Chrome. Le premier `flutter test` télécharge une copie de SQLite : il faut Internet. Dans le terminal de `flutter run`, la touche `q` arrête l'application.

**Étape 2 · Lire le contexte, compléter `PROJET.md`** (ensemble, sur un écran).

1. Lisez `CLAUDE.md`, puis `docs/ARCHITECTURE.md`.
2. Ouvrez le scénario d'exemple `test/scenarios/jets/lancer_un_de.feature` et le test du Cubit d'exemple `test/features/jets/presentation/jets_cubit_test.dart` : c'est la forme de votre première user story.
3. Dans `PROJET.md` : ajustez la vision en 5 lignes ; les stories du socle restent (obligatoires) ; parmi celles « à choisir pour commencer », retenez **3 à 5** user stories, barrez les autres et notez leur raison dans « Décisions de l'équipe » ; complétez le tableau des rôles. L'agent peut aider à reformuler ; l'équipe décide. Si `PROJET.md` annonce qu'il est « en attente du thème de l'équipe », suivez d'abord les étapes qu'il donne.

**Étape 3 · Branche, commit, PR** (un membre tape, les autres suivent).

```bash
$ git switch -c projet-perimetre
$ git add PROJET.md
$ git commit -m "Retient les user stories de l'équipe"
$ git push -u origin projet-perimetre
$ gh pr create --web
```

Remplissez le modèle de PR qui s'affiche (fiche E). N'utilisez pas `gh pr create --fill` : cette option n'utilise pas le modèle.

**Étape 4 · Relecture, fusion, protection.** Un **autre** membre relit avec la fiche D, approuve (« Review changes », « Approve », « Submit review »). Puis :

```bash
$ gh pr merge --merge --delete-branch
$ git switch main
$ git pull
```

Vérifiez que `main` est protégée : l'un de vous tente un push direct, depuis un `main` à jour.

```bash
$ git switch main
$ git pull
$ git commit --allow-empty -m "Test : push direct sur main"
$ git push
```

Le push doit être **refusé** (message qui commence par `remote: error: GH006: Protected branch update failed`). Annulez ensuite le commit d'essai :

```bash
$ git reset --hard origin/main
```

Si le push passe, prévenez l'enseignant tout de suite : la protection n'est pas active.

**Étape 5 · Journal, puis tag** (gardien du harnais).

```bash
$ git switch main
$ git pull
$ git switch -c journal-s2
```

Écrivez cinq lignes en tête de `JOURNAL.md`, sous « État courant » : où on en est, prochaine étape, commandes clés, décisions prises, ce qui reste en suspens. Enregistrez.

```bash
$ git add JOURNAL.md
$ git commit -m "Écrit l'état courant de fin de séance 2"
$ git push -u origin journal-s2
$ gh pr create --web
```

Un autre membre relit et approuve, puis :

```bash
$ gh pr merge --merge --delete-branch
$ git switch main
$ git pull
$ git tag s2-fin
$ git push origin s2-fin
```

**Chacun des autres membres** termine par `git switch main` puis `git pull`.

---

## Fiche D · Checklist de PR en cinq lignes

À lire dans l'ordre, par le relecteur **et** par l'auteur avant de demander la relecture.

1. **Je comprends ce que fait cette PR, et je saurais l'expliquer.**
2. **Elle fait une seule chose, et le diff se lit en entier.**
3. **Les vérifications passent : `flutter analyze`, `flutter test`.**
4. **Aucun secret, aucune donnée réelle ou personnelle.**
5. **Aucun test supprimé ni affaibli, et les règles de `CLAUDE.md` sont respectées.**

Une ligne ne passe pas ? On ne fusionne pas : le relecteur choisit « Request changes » et dit laquelle. Celui qui approuve est aussi responsable de la PR que celui qui l'ouvre.

---

## Fiche E · Modèle de PR

Le dépôt d'équipe fournit ce modèle dans `.github/pull_request_template.md` ; GitHub le propose à l'ouverture de chaque PR. Il compte quatre rubriques ; le voici tel que le fournit le dépôt-modèle (si votre équipe l'a modifié, le fichier de votre dépôt fait foi) :

```markdown
## Résumé
<!-- En deux ou trois phrases : ce que change cette PR, et pourquoi. -->

## Ce que l'agent a proposé, ce que j'ai refusé
<!-- Au moins une ligne de chaque. « Rien refusé » est une réponse possible,
     pas une réponse par défaut. -->
- Proposé et gardé :
- Proposé et refusé :

## Suivi
- Temps estimé :
- Temps réel :
- Retouches (ce que j'ai dû corriger ou redemander) :

## Avant de demander la relecture
- [ ] Je peux expliquer chaque modification.
- [ ] `flutter analyze` et `flutter test` passent.
- [ ] Aucun secret, aucune donnée réelle ou personnelle.
```

Ce suivi sert à apprendre, pas à punir : il vous montre l'écart entre votre impression de vitesse et le temps réel. Si l'agent s'est trompé et que vous l'avez repéré, ajoutez l'étiquette `erreur-agent` à la PR.

---

## Fiche F · Dépannage

**Premier réflexe, toujours :** `git status`, et lire ce qu'il répond.

| Ce que vous voyez | Ce qui se passe | Ce qu'il faut faire |
|---|---|---|
| `Please tell me who you are` | Identité git non réglée | `git config --global user.name "Prénom Nom"` puis `git config --global user.email "<ID>+<login>@users.noreply.github.com"` |
| Un éditeur plein écran s'ouvre, impossible d'en sortir | C'est vim : vous avez oublié `-m "…"` | `Échap`, tapez `:q!`, `Entrée`, puis recommencez avec `-m`. Pour l'avenir : `git config --global core.editor "code --wait"` |
| La branche s'appelle `master` | `git init` sans `-b main` | `git branch -m main` |
| `nothing to commit` alors que vous avez modifié le fichier | Fichier non enregistré dans VS Code, ou non indexé | `Ctrl+S`, puis `git add`, puis `git commit` |
| `fatal: The current branch … has no upstream branch` | Première fois que vous poussez cette branche | `git push -u origin <branche>` |
| `! [rejected] … (fetch first)` ou `(non-fast-forward)` | Le dépôt distant a des commits que vous n'avez pas | `git pull`, puis `git push` |
| `fatal: Need to specify how to reconcile divergent branches` | `git pull` ne sait pas comment réunir deux historiques | `git config --global pull.rebase false`, puis `git pull` |
| `CONFLICT (content): Merge conflict in …` | Deux versions de la même ligne | Résoudre dans VS Code, `git add`, `git commit` ; ou `git merge --abort` pour annuler |
| `remote: error: GH006: Protected branch update failed` | Push direct sur `main` protégée | Normal : créez une branche et passez par une PR |
| `gh auth status` répond `not logged in` | `gh` n'est pas connecté | `gh auth login`, choix du navigateur |
| `Permission … denied` ou erreur 403 au push sur le dépôt d'équipe | Invitation de collaborateur non acceptée | Acceptez-la (courriel de GitHub, ou `github.com/notifications`) |
| Vous avez modifié un fichier par erreur, pas encore commité | | `git restore <fichier>` (la modification est **perdue**) |
| Vous avez indexé un fichier par erreur | | `git restore --staged <fichier>` |
| Vous avez commité sur `main` au lieu d'une branche, pas encore poussé | | Levez la main : la correction se fait à deux |
| L'agent lit encore `.env` | JSON invalide, mauvais emplacement, session non relancée | Fiche B, étape 2 |
| `flutter test` échoue juste après le clone | Fichiers générés absents | `dart run build_runner build --delete-conflicting-outputs`, puis `flutter test` |

**Trois choses à ne pas faire, même si un tutoriel ou l'agent le propose :** `git push --force` ; `git reset --hard` sans savoir sur quoi (hors de l'étape 4 de la fiche C) ; supprimer le dossier `.git`.

---

## Glossaire

- **Chevrons** : les signes `<` et `>` qui entourent, dans ces fiches, une valeur à remplacer.
- **Definition of done** : la liste de ce qui doit être vrai pour dire « c'est fini ».
- **Invite de commande (`$`)** : le signe affiché par le terminal avant votre saisie ; il ne se tape pas.
- **Modèle de PR** : texte pré-rempli proposé par GitHub à l'ouverture d'une pull request.
- **Push direct** : envoi de commits sur une branche sans passer par une pull request.

Les autres termes (commit, branche, PR, conflit, permission, skill, hook…) sont définis dans les glossaires des chapitres 1 à 3.

---

## Pour aller plus loin

- Refaire la fiche A seul, de mémoire, une semaine après la séance : c'est le meilleur moyen de ne pas tout avoir oublié pendant le sprint final.
- Refaire la fiche A en demandant à l'agent d'expliquer chaque sortie de commande avant de passer à la suivante.
- La suite du calendrier (séance 3 dans deux jours, séance 4, sprint final, soutenance) : chapitre 3, section 12.

---

## Points non vérifiés (à signaler honnêtement)

- **Fiche 0** : commandes de contrôle reprises du programme (séance 2, bloc 1) ; le projet d'exemple de la séance 1 n'a pas été relancé pour cette fiche (ni avec Flutter 3.47.6, ni après passage à 3.50), et la façon de mettre à jour Claude Code dépend du mode d'installation.
- **Fiche A, étapes 1 à 3 et 5** : jouées en entier dans un dépôt jetable (git 2.53.0). **Étape 4** : `git push -u` joué contre un dépôt distant local ; les commandes `gh repo create`, `gh pr create --web`, `gh pr merge` n'ont **pas** été exécutées (rien n'a été créé sur GitHub) ; leurs options ont été relues dans l'aide de gh 2.100.0. Les libellés des boutons de GitHub viennent de sa documentation.
- **Fiche A, relecture par le binôme** : sur un dépôt public, la possibilité pour un compte non collaborateur de laisser une relecture « Approve » n'a pas été testée ; si elle échoue, le propriétaire ajoute son binôme comme collaborateur (Settings, Collaborators, Add people).
- **Fiche A, boutons de VS Code** : libellés anglais relevés dans la documentation de VS Code. Avec l'interface en français, ils se lisent « Accepter la modification actuelle », « Accepter la modification entrante », « Accepter les deux modifications » d'après les fichiers de traduction ; ils n'ont pas été observés à l'écran.
- **Fiche B** : les sept règles de refus, l'expérience avant et après et le skill ont été testés avec Claude Code 2.1.325 en exécution non interactive ; `/init`, `/permissions`, `/reload-skills` et les commandes de plugin n'ont pas été exécutés. Voir les réserves du chapitre 2.
- **Fiche C** : les commandes Flutter de l'étape 1 ont été jouées sur le dépôt-modèle le 26 novembre 2026, sous Linux seulement, avec Flutter 3.50.1 (32 tests verts, `flutter analyze` sans remarque) ; elles n'ont été essayées ni sous Windows ni sous macOS, et le clone depuis GitHub n'a pas été fait (le dépôt-modèle n'est pas encore publié). La séquence git (branche, push, commit vide, `git reset --hard origin/main`, tag) a été jouée contre un dépôt distant local. Le refus `GH006` n'a pas été observé ; son libellé complet n'est attesté que par des sources communautaires.
- **Fiche D** : le programme fixe « cinq lignes », pas leur texte ; celui-ci est une proposition des supports, à valider par l'enseignant.
- **Fiche E** : recopiée du `.github/pull_request_template.md` du dépôt-modèle ; son affichage à l'ouverture d'une PR sur GitHub n'a pas été observé (le dépôt-modèle n'est pas encore publié).
- **Fiche F** : la sortie de vim (`Échap`, `:q!`) et le message exact d'un push refusé faute d'invitation acceptée n'ont pas été vérifiés sur une source officielle.

---

## Sources

- Chapitres 1, 2 et 3 de ce support, qui portent le détail des sources (documentation de git, de GitHub, de la ligne de commande `gh`, de VS Code et de Claude Code, consultées le 19 novembre 2026).
- `cours/programme-detaille.md` : séance 2 (blocs 1, 5, 7 et 9, matériel, definition of done), section 7 (règles d'usage de l'IA), section 8 (dépôt-modèle, règles du jeu).
- Vérifications locales du 19 novembre 2026 : fiche A jouée dans un dépôt jetable ; extraits JSON validés avec `jq` ; règles de refus et skill testés avec `claude -p` ; commande du hook exécutée sur une entrée simulée.
