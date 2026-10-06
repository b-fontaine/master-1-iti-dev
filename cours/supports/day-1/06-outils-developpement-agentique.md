# Chapitre 6 · Utiliser les outils de développement agentique : harnais, contexte, permissions et jetons

*Séance 1 « Comprendre et s'équiper » · Master ITI, Nantes Université, 2026-2027. Chapitre à lire avant ou après la séance. État des outils vérifié le 7 octobre 2026 (documentation officielle de Claude Code ; version 2.1.292 sur le poste de rédaction).*

## Ce que vous allez retenir

- Un **agent de code** est un modèle de langage entouré d'un **harnais** : des outils (lire, modifier, exécuter), une gestion de la mémoire de travail et des règles d'accès. Claude Code est ce harnais ; Claude Desktop en est une interface graphique qui utilise le même moteur.
- L'agent travaille en **boucle** : rassembler du contexte, agir, vérifier, recommencer. Vous pouvez l'interrompre à tout moment, et c'est à vous de lui donner un moyen de vérifier (un test, une compilation).
- Le **contexte** (tout ce que le modèle a sous les yeux) est limité et payant. Plus il grossit, plus le travail coûte cher et, selon la documentation officielle, plus la qualité baisse. La plupart des bonnes pratiques découlent de cette contrainte.
- Un **fichier d'instructions** (`CLAUDE.md`, `AGENTS.md`, règles Cursor, instructions Copilot) est lu à chaque session. Il doit être court, concret et vérifiable. Une consigne écrite dedans reste **une demande**, pas une garantie.
- Ce qui doit être garanti se configure : les **permissions** et les **hooks** sont appliqués par l'outil, pas par le modèle.
- **MCP**, **skills**, **sous-agents** et **hooks** ont chacun un coût de contexte et un usage propres. Économiser des jetons, c'est : bon modèle et bon effort, contexte vidé entre deux tâches, travail découpé, demandes cadrées, **cache de prompt** respecté.
- Côté sécurité : aucun secret ni donnée personnelle dans une conversation ou un dépôt, méfiance envers tout contenu externe (injection de prompt), mode manuel tant que le harnais n'est pas en place.

---

## 1. Pourquoi ce chapitre

Vous allez construire un logiciel avec un agent de code. Sans méthode, il est coûteux, imprévisible et parfois dangereux ; avec méthode, c'est un collaborateur rapide dont vous contrôlez le travail. La différence tient rarement au talent du modèle : elle tient à ce que vous mettez autour (instructions, droits, tests) et à la gestion de sa mémoire de travail.

Chaque notion est introduite par une analogie. Les commandes ont été relues dans la documentation officielle (voir « Sources ») et le code d'exemple exécuté quand l'outil existait sur le poste de rédaction (voir « Points non vérifiés »). Les noms de modèles, modes par défaut et limites changent vite : le chapitre indique les versions concernées. Tapez `claude --version` et relisez la documentation quand l'outil se comporte autrement.

> **À retenir.** Un agent, c'est un modèle plus un harnais. Vous ne choisissez pas seulement un modèle « intelligent » : vous concevez l'environnement dans lequel il travaille bien.

---

## 2. Claude Code et Claude Desktop

Selon la documentation, Claude Code est « un assistant agentique qui s'exécute dans votre terminal ». On y accède par le terminal (la fenêtre où l'on tape des commandes ; vous lancerez `claude` dans le dossier de votre projet), l'application de bureau, des extensions d'éditeurs dont VS Code, un site web ou des pipelines d'intégration continue ; la boucle est la même partout.

L'application **Claude Desktop** a trois onglets (Chat, Cowork, **Code**) ; seul le dernier nous concerne. Selon la documentation, elle « exécute le même moteur » que la ligne de commande, et les deux peuvent tourner en même temps sur le même projet. Ils partagent leur configuration et la mémoire de projet via les `CLAUDE.md`, et Desktop lit les mêmes fichiers de réglages que la ligne de commande. Choix : Desktop pour gérer des sessions parallèles ou relire visuellement les modifications ; ligne de commande pour les scripts (le mode non interactif `claude -p` n'existe pas dans Desktop). Desktop existe pour macOS, Windows et, **en bêta**, Linux (`.deb`). L'accès (compte ou crédit nominatif, plafond de dépense) est fourni par l'enseignant : ne le partagez jamais.

---

## 3. La boucle agentique et le harnais

### 3.1 La boucle

La documentation décrit trois phases qui se mélangent : **rassembler du contexte**, **agir**, **vérifier**. Pour « corrige les tests qui échouent », l'agent lance les tests, lit les erreurs, cherche et lit les fichiers, les modifie, relance les tests ; chaque résultat oriente l'étape suivante. Deux composants font tourner la boucle : les **modèles**, qui raisonnent, et les **outils**, qui agissent (fichiers, recherche, exécution de commandes, web, et intelligence du code via un plugin). *Source : « How Claude Code works ».*

Vous faites partie de la boucle : `Échap` arrête l'agent, et vous pouvez taper une correction sans l'arrêter. Avant chaque modification de fichier, Claude Code enregistre un instantané : deux appuis sur `Échap` (ou `/rewind`) font revenir en arrière. Ces points de contrôle ne couvrent ni les systèmes distants ni les changements faits par commande, et ne remplacent pas git.

### 3.2 Le harnais (harness engineering)

La documentation emploie le terme : la couche qui fournit les outils et gère le contexte vu par le modèle est « le harnais agentique ». Birgitta Böckeler (Thoughtworks, 2 avril 2026, « Harness Engineering for Coding Agent Users ») le définit comme « tout ce qui, dans un agent d'IA, n'est pas le modèle » et distingue :

- les **guides** (contrôles en amont, *feedforward*), qui orientent l'agent avant qu'il agisse : `CLAUDE.md`, spécifications, conventions ;
- les **capteurs** (contrôles en aval, *feedback*), qui lui permettent de se corriger : tests, analyseurs de code, intégration continue, relecture.

Les contrôles **calculatoires** (déterministes, rapides : tests, linters) s'opposent aux contrôles **inférentiels** (jugement d'une IA : plus lents, plus chers, probabilistes). Elle écrit : « un bon harnais ne cherche pas forcément à supprimer toute intervention humaine, mais à la diriger là où elle compte le plus ». Ryan Lopopolo (OpenAI, 11 février 2026), dont la formule « Humans steer, agents execute » guide ce cours, est l'autre source souvent citée (page non relue, voir « Points non vérifiés »). Une étude de 2026 (Galster et coauteurs, 2 853 dépôts GitHub) recense **huit mécanismes de configuration** des agents de code : les **fichiers de contexte** dominent et sont souvent le seul mécanisme, `AGENTS.md` émerge comme standard, peu de dépôts utilisent skills ou sous-agents. Commencez donc par un bon fichier de contexte.

Pour ce cours : les **guides** sont `CLAUDE.md`, règles et skills ; les **capteurs** sont les tests, `dart analyze` et l'intégration continue ; le **cadre** est fait de permissions et de bac à sable ; les **automatismes** sont les hooks ; les **extensions** sont les serveurs MCP et plugins.

> **À retenir.** Le harnais avant l'autonomie : tant que tests, règles et permissions ne sont pas en place, pas d'agent sans supervision, et surtout pas plusieurs agents en parallèle.

---

## 4. Choisir son modèle : taille, coût, latence, raisonnement

Choisir un modèle, c'est arbitrer entre la **capacité**, le **coût** (prix par jeton), la **latence** (temps d'attente) et le **raisonnement** (temps de réflexion avant de répondre). En général, plus un modèle est gros, plus il est capable, cher et lent ; un petit modèle est rapide et économique mais se perd plus vite sur une tâche complexe (distinction SLM et LLM vue en séance). La documentation résume : Sonnet traite bien la plupart des tâches de code et coûte moins cher qu'Opus, que l'on réserve aux décisions d'architecture complexes.

### 4.1 Les alias de Claude Code

Correspondance publiée au 7 octobre 2026 (connexion directe à l'API d'Anthropic) : `opus` = Opus 5.5 ; `sonnet` = Sonnet 5.5 ; `haiku` = Haiku 3.5 d'après la page consultée (le plus léger, pour les tâches simples) ; `fable` = Claude Fable 5.1 ; `best` = `fable` si disponible, sinon `opus` ; `opusplan` = Opus en mode plan, Sonnet pour l'exécution ; `sonnet[1m]` et `opus[1m]` = fenêtre d'un million de jetons ; `default` = retour au défaut du compte. *Source : « Model configuration ».*

La correspondance **dépend du fournisseur** (sur Microsoft Foundry, `sonnet` désigne encore Sonnet 4.5). Le défaut est Opus 5.5 pour Pro, Max, Team, Enterprise et l'API. Les modèles **Fable** ne sont le défaut d'aucune offre (`/model fable` pour les choisir) ; la documentation les juge adaptés aux « tâches plus grandes qu'une seule séance » et précise que leur usage peut être facturé en crédits d'usage. Pour changer de modèle : `/model` en session (`Entrée` enregistre le défaut, `s` ne change que la session), `claude --model sonnet`, la variable `ANTHROPIC_MODEL`, ou `"model"` dans `~/.claude/settings.json`.

### 4.2 Le niveau d'effort

La réflexion se règle par un **niveau d'effort** : `low`, `medium`, `high`, `xhigh`, `max` (sans `xhigh` pour Opus 4.6 et Sonnet 4.6), via `/effort high` ou `claude --effort`. Défaut : `medium` pour Opus 5.5 et Sonnet 5.5, `high` pour la plupart des autres. Selon la documentation : `low` pour échanges rapides et ébauches ; `medium` pour l'ingénierie quotidienne à périmètre clair ; `high` quand la vérification compte ; `xhigh` et `max` pour les problèmes difficiles. La réflexion est facturée comme du texte produit et peut atteindre des dizaines de milliers de jetons par requête ; sur Opus 5.5, Sonnet 5.5 et les Fable, on ne peut pas la désactiver : baisser l'effort est le levier le plus direct.

### 4.3 Règle pratique pour ce cours

`sonnet` en effort `medium` par défaut ; `opus` ou effort `high` pour une décision d'architecture, une panne obscure ou une relecture critique ; `haiku` en effort `low` pour les tâches mécaniques. Choisissez **au début** de la session : changer en route a un coût caché (11.3). C'est une recommandation pédagogique tirée des conseils officiels, pas une prescription de l'éditeur.

> **À retenir.** Pas de « meilleur modèle » dans l'absolu : le modèle adapté à la tâche, au budget et au délai. Noms et prix changent chaque trimestre.

---

## 5. La fenêtre de contexte et sa gestion

### 5.1 Une mémoire de travail limitée

Le modèle ne retient rien d'une requête à l'autre. À chaque message, Claude Code renvoie **tout** ce qui est utile : instructions système, fichiers d'instructions, historique, fichiers lus, résultats de commandes. C'est la **fenêtre de contexte**. Analogie : un bureau dont la surface est limitée ; plus il y a de papiers, plus il est dur de retrouver le bon. Selon la documentation, Sonnet 5.5, les modèles Fable et les Opus récents ont une fenêtre d'un million de jetons, d'autres environ 200 000. Un **jeton** est un fragment de mot (un mot courant en vaut un ou deux, ordre de grandeur).

La page « Best practices » pose le principe : la fenêtre « se remplit vite, et les performances se dégradent à mesure qu'elle se remplit » ; c'est « la ressource la plus importante à gérer ». L'agent peut oublier des consignes anciennes et se tromper davantage (*context rot*). Les supports de l'enseignant l'illustrent par des recherches de 2025 non relues ici.

Au lancement, Claude Code place dans le contexte : l'instruction système, des extraits de la mémoire automatique (6.5), l'environnement (dossier, système, état de git), les **noms** des serveurs MCP, les descriptions d'une ligne des skills et vos `CLAUDE.md`. Pour vos mesures, tapez `/context` (la simulation « Explore the context window » n'utilise que des chiffres représentatifs).

### 5.2 Les commandes

- `/clear` : conversation vide (l'ancienne reste accessible via `/resume`), à utiliser en changeant de tâche ;
- `/compact [consigne]` : résume la conversation, par exemple `/compact concentrez-vous sur la correction du bogue` ;
- `/context` : affiche la consommation du contexte ; `/autocompact 500k` : règle le seuil de compaction automatique ;
- `/rewind` : revient à un point antérieur de la conversation ou du code, ou résume à partir d'un message ;
- `/resume` ou `claude --continue` : reprend une session. *Source : « Commands », « Best practices ».*

Quand le contexte approche de la limite, Claude Code efface d'abord les anciennes sorties d'outils, puis résume : vos demandes et les extraits de code importants sont conservés, mais « des instructions détaillées données tôt peuvent être perdues ». **Ce qui doit survivre s'écrit dans un fichier.** Après `/compact`, selon la documentation : le `CLAUDE.md` racine et la mémoire automatique sont relus depuis le disque ; les `CLAUDE.md` de sous-dossiers et les règles à `paths:` se rechargent à la demande ; jusqu'à cinq fichiers récents sont relus ; les skills invoqués sont réinjectés (plafond de 5 000 jetons par skill, 25 000 au total) ; une instruction donnée **seulement en conversation** est résumée, donc possiblement perdue. On oriente le résumé avec une section de `CLAUDE.md` (exemple de « Manage costs ») :

```markdown
# Compact instructions

When you are using compact, please focus on test output and code changes
```

### 5.3 Seuils et rituels : officiel ou convention ?

Le talk de l'enseignant recommande de compacter vers **60 %** de remplissage et de ne jamais dépasser 80 %. C'est un **consensus de praticiens**, pas une règle de l'éditeur : la documentation dit seulement que le seuil automatique dépend du modèle (environ 967 000 jetons pour une fenêtre native d'un million, plus bas pour les autres) et se règle avec `/autocompact`. Deux rituels restent utiles : **une session, une tâche** (`/clear` entre deux tâches, recommandé par « Best practices ») ; **documenter puis vider** (supports de l'enseignant) : l'agent écrit plan et progression dans un fichier, vous videz le contexte, une session neuve reprend depuis le fichier. Variante de la documentation : demander à l'agent de vous interroger, d'écrire `SPEC.md`, puis ouvrir une session neuve.

### 5.4 Sous-agents : isoler les lectures volumineuses

Un **sous-agent** travaille dans **sa propre fenêtre de contexte** et ne renvoie qu'un résumé. Analogie : un stagiaire lit trente documents et rapporte une note d'une page ; votre bureau reste dégagé (configuration en 8.4).

> **À retenir.** Trois leviers quand le contexte est la contrainte : le vider (`/clear`), le résumer (`/compact`), en déporter une partie dans un sous-agent.

---

## 6. Les fichiers de contexte

### 6.1 CLAUDE.md : la mémoire du projet

`CLAUDE.md` est un fichier **Markdown** (format où `#` marque un titre et `-` une puce) lu au début de chaque session. La documentation précise qu'il est livré au modèle **comme un message**, après l'instruction système, et traité « comme du contexte, pas comme une configuration imposée ». Pour imposer ou interdire de façon sûre, utilisez une permission ou un hook (7 et 8.3).

Quatre portées, du plus large au plus précis : **organisation** (`/etc/claude-code/CLAUDE.md` sous Linux, `/Library/Application Support/ClaudeCode/CLAUDE.md` sous macOS), **utilisateur** (`~/.claude/CLAUDE.md`), **projet** (`./CLAUDE.md` ou `./.claude/CLAUDE.md`, partagé via git) et **local** (`./CLAUDE.local.md`, à mettre dans `.gitignore`). *Source : « How Claude remembers your project ».*

Les fichiers du dossier courant et de ses parents sont **concaténés**, ceux des sous-dossiers se chargent **à la demande**. `/context` (liste « Memory files ») ou `/memory` montrent ce qui est chargé. `/init` génère un `CLAUDE.md` de départ ; s'il existe déjà, elle propose des améliorations.

### 6.2 Écrire de bonnes instructions

La documentation recommande **moins de 200 lignes** par fichier (au-delà : plus de contexte, moins d'application des règles ; un fichier de plus de 4 Mio n'est pas chargé), des consignes **vérifiables** (« utiliser 2 espaces d'indentation » plutôt que « formater correctement »), l'absence de **contradictions**, et cette question pour chaque ligne : « si je la supprime, l'agent fera-t-il des erreurs ? ».

À inclure : commandes que l'agent ne peut pas deviner, règles différentes des usages courants, commandes de test, décisions d'architecture propres au projet, pièges de l'environnement. À exclure : ce qu'il découvre en lisant le code, conventions standard du langage, documentation d'API détaillée (mettre un lien), informations changeantes, évidences (« écris du code propre »). *Source : « Best practices for Claude Code ».*

Exemple pour un projet Flutter du cours, **fictif et rédigé pour ce chapitre** (un fichier d'instructions ne s'exécute pas ; sa valeur se juge à l'usage) :

```markdown
# Projet Thèmes (Flutter)

## Commandes
- Tests : `flutter test`
- Analyse statique : `dart analyze` (aucun avertissement toléré)

## Règles
- Écrire d'abord un test qui échoue, puis le code minimal pour le faire passer.
- Trois couches par fonctionnalité : `domain/`, `data/`, `presentation/`.
  `domain/` n'importe jamais `data/` ni `presentation/`.
- Jamais de donnée personnelle réelle dans le code, les tests ou les captures.
- Jamais de clé ni de mot de passe dans le dépôt.

## Avant de dire « c'est terminé »
Lancer `flutter test` et `dart analyze`, et coller le résultat.
```

### 6.3 AGENTS.md et les autres outils

`AGENTS.md` est un fichier d'instructions au format ouvert, lisible par plusieurs outils. Selon le talk de l'enseignant, il a été initié par OpenAI en août 2025 puis confié à l'*Agentic AI Foundation* de la Linux Foundation en décembre 2025 (historique non revérifié).

Point qui a **changé** depuis ces supports (avril 2026) : ils indiquaient que Claude Code ne lisait pas `AGENTS.md`. La documentation actuelle dit que, **depuis la version 2.1.277**, il peut le lire comme instructions de projet :

Par défaut : un `AGENTS.md` sans aucun `CLAUDE.md` (ni `CLAUDE.local.md`) dans le dossier courant ou au-dessus est lu ; dès qu'un `CLAUDE.md` existe, seuls les `CLAUDE.md` sont lus, sauf s'il importe `AGENTS.md`.

Le réglage « Project instructions » (`/config`) permet par exemple de lire les deux. La méthode d'**import** reste valable et c'est celle du dépôt de l'enseignant : un `CLAUDE.md` dont la première ligne est `@AGENTS.md`, suivie des consignes propres à Claude. Syntaxe `@chemin/fichier`, relatif au fichier qui importe, quatre niveaux de profondeur au maximum. Un import **ne réduit pas** le coût en contexte : les fichiers importés sont chargés au lancement.

| Outil | Fichier | Particularité (source) |
|---|---|---|
| Claude Code | `CLAUDE.md`, `.claude/rules/*.md` | règles limitables à des chemins (en-tête `paths:`) |
| Cursor | `.cursor/rules/*.mdc` | en-tête `description`, `globs`, `alwaysApply` ; quatre modes (toujours, selon pertinence, fichiers précis, manuel) ; moins de 500 lignes par règle ; `AGENTS.md` accepté |
| GitHub Copilot | `.github/copilot-instructions.md`, `.github/instructions/*.instructions.md` (clé `applyTo`) | peut aussi utiliser `AGENTS.md`, `CLAUDE.md` ou `GEMINI.md` |
| Gemini CLI | `GEMINI.md` | dans le dépôt de l'enseignant, importe `AGENTS.md` |

### 6.4 Un cas réel : le dépôt de l'enseignant

Le dépôt `devoxx-2026` (talk Devoxx France, 23 avril 2026) organise ces fichiers en couches : `AGENTS.md` (racine, 210 lignes : architecture, interdits, cycle test d'abord) ; `CLAUDE.md` (racine, 36 lignes : `@AGENTS.md`, commandes de référence, directives de session) ; `frontend/CLAUDE.md` et `backend/CLAUDE.md` (complètent `AGENTS.md`, chargés à la demande) ; `.cursor/rules/*.mdc` (dont `context-hygiene.mdc`, toujours active) ; `.github/copilot-instructions.md` et `GEMINI.md` (résumés renvoyant vers `AGENTS.md`). *Source : dépôt de l'enseignant, lu localement.*

Principe : **une source unique de vérité** (`AGENTS.md`) importée ailleurs, les sous-dossiers la complétant sans la dupliquer ; comme en logiciel, on n'écrit pas la même chose à deux endroits. Ce `AGENTS.md` dépasse un peu les 200 lignes recommandées (démonstration détaillée). `context-hygiene.mdc` condense de bons réflexes : une session, une tâche, une couche ; ne lire que les fichiers nécessaires ; recherche ciblée plutôt que lecture de toute l'arborescence. Ses signaux d'alerte (plus de dix fichiers lus sans produire de code, correction répétée) sont des choix de l'enseignant, pas des valeurs officielles.

### 6.5 La mémoire automatique

Claude Code peut aussi **prendre des notes lui-même** (activé par défaut en session locale), dans `~/.claude/projects/<projet>/memory/`. L'index `MEMORY.md` est chargé au démarrage dans la limite de **200 lignes ou 25 Ko** ; les autres notes sont lues à la demande ; tout se modifie avec `/memory`. Cette mémoire est **locale à la machine** : si une correction vaut pour tous, faites-la migrer dans `CLAUDE.md`.

### 6.6 Les fichiers aident-ils vraiment ?

Deux articles de 2026 donnent des résultats opposés. Lulla et coauteurs (arXiv:2601.20404, 10 dépôts, 124 demandes de fusion, agents Codex et Claude Code) associent la présence d'un `AGENTS.md` à une baisse de **28,64 %** du temps d'exécution médian et de **16,58 %** des jetons de sortie, à achèvement comparable. Gloaguen et coauteurs (arXiv:2602.11988, ETH Zurich, tests de type SWE-bench) trouvent que les fichiers de contexte « n'améliorent pas en général » la réussite et augmentent le coût d'inférence « de plus de 20 % en moyenne ». Les supports de l'enseignant y lisent que le contexte aide surtout quand le modèle ne connaît pas le code : **hypothèse plausible, non démontrée** par ces articles. Retenez la recommandation des seconds auteurs : toute amélioration doit être **évaluée** avant d'être généralisée.

> **À retenir.** Un fichier de contexte est un investissement, pas un talisman : court, concret, relu. Chaque ligne qui n'empêche aucune erreur coûte du contexte pour rien.

---

## 7. Consignes, droits et modes de permission

### 7.1 Formuler une demande

La page « Best practices » se résume en trois habitudes : **donner un moyen de vérifier** (tests, compilation, capture ; sinon vous devenez la boucle de vérification) ; **explorer, planifier, puis coder** (mode plan ; si vous pouvez décrire la modification en une phrase, sautez le plan) ; **être précis**. Plutôt que « corrige le bogue de connexion », écrivez « la connexion échoue après expiration de la session ; regarde `src/auth/`, surtout le renouvellement du jeton ; écris d'abord un test qui reproduit le problème, puis corrige » (adapté de la documentation). Pour une fonctionnalité plus grosse, demandez à l'agent de **vous interroger** puis d'écrire `SPEC.md` : c'est le développement piloté par la spécification vu en séance.

### 7.2 Les règles de permission

Les **permissions** décident de ce que l'agent peut faire sans vous demander (`/permissions` les affiche et les modifie) : **allow** (autoriser), **ask** (toujours demander), **deny** (refuser). L'ordre d'évaluation est **deny, puis ask, puis allow**, la première règle correspondante l'emportant. Une autorisation précise ne lève jamais un refus plus large, quel que soit le niveau de réglage (utilisateur, projet, organisation). Syntaxe : `Outil` ou `Outil(précision)`.

Exemples : `Bash` (toutes les commandes), `Bash(npm run build)` (exactement cette commande), `Read(./.env)` (lecture du `.env` du dossier courant), `WebFetch(domain:example.com)`.

Note capitale de la page : **« les règles de permission sont appliquées par Claude Code, pas par le modèle »**. Une consigne dans le prompt ou `CLAUDE.md` « façonne ce que Claude essaie de faire », sans changer ce que l'outil autorise. Le programme du cours cite un incident public de juillet 2025 (un agent de la société Replit aurait supprimé une base de production malgré un gel écrit dans le prompt), non revérifié ici ; le principe est, lui, confirmé par la documentation.

Exemple de `.claude/settings.json` pour un projet Flutter (JSON validé avec `jq` ; syntaxes conformes à la documentation) :

```json
{
  "permissions": {
    "allow": [
      "Bash(flutter test *)",
      "Bash(dart analyze)",
      "Bash(git status)",
      "Bash(git diff *)"
    ],
    "deny": [
      "Read(./.env)",
      "Bash(git push *)",
      "Bash(rm -rf *)"
    ]
  }
}
```

Les règles `allow` d'un dépôt ne sont appliquées qu'**après** votre acceptation de la boîte de confiance du dossier (*workspace trust*) ; les règles `deny` et `ask`, qui restreignent, s'appliquent toujours. `.claude/settings.local.json` contient vos réglages personnels non partagés.

### 7.3 Les modes de permission

| Mode | Sans demander | Pour |
|---|---|---|
| Manual (`default`) | lectures seulement | revoir chaque action |
| `acceptEdits` | lectures, modifications de fichiers, `mkdir`, `touch`, `mv`, `cp` | itérer sur du code relu |
| `plan` | lectures ; pas de modification des sources | explorer avant de changer |
| `auto` | tout, avec contrôle de sécurité par un second modèle (le classifieur) | longues tâches |
| `dontAsk` | lectures et outils pré-approuvés ; le reste est refusé | CI, scripts verrouillés |
| `bypassPermissions` | tout (sauf exceptions) | **conteneurs et machines virtuelles isolés uniquement** |

*Source : « Choose a permission mode ».*

`Maj+Tab` fait défiler les modes (`default`, `acceptEdits`, `plan`, puis `auto` s'il est disponible ; `bypassPermissions` seulement si vous avez démarré avec un drapeau qui l'active ; `dontAsk` jamais). Au démarrage : `claude --permission-mode plan`.

**Point de vigilance de cette année.** Depuis la version 2.1.283, le mode **auto** est le mode de démarrage intégré des sessions interactives du terminal et de VS Code. Selon la documentation, il « réduit les invites mais ne garantit pas la sécurité ». La règle du cours (programme) est : **pas de mode sans confirmation sur sa machine personnelle, actions destructrices refusées par configuration, un agent par étudiant sur sa branche**. Pour l'appliquer, démarrez en mode manuel :

```bash
claude --permission-mode default
```

ou réglez `"permissions": { "defaultMode": "default" }` dans `~/.claude/settings.json` (exemple de la documentation).

La barre d'état affiche `⏸ manual mode on`. À confirmer avec l'enseignant : « permissions par défaut » ne signifie plus « mode manuel » avec les versions récentes si l'on ne règle rien.

`bypassPermissions` (option `--dangerously-skip-permissions`) supprime les invites, y compris pour les écritures dans `.git` et `.claude`. La documentation est nette : isolation obligatoire (conteneur, machine virtuelle). Les règles `deny` s'appliquent dans tous les modes.

> **À retenir.** Une consigne dit ce que l'agent doit faire ; une permission dit ce qu'il peut faire. Pour ce qui compte (secrets, suppression, publication), configurez et testez.

---

## 8. MCP, skills, hooks, sous-agents

### 8.1 MCP : brancher des outils externes

Le **Model Context Protocol** est, selon la documentation, « un standard ouvert pour les intégrations entre IA et outils ». Un **serveur MCP** donne accès à un service (base de données, gestion de tickets, conception, navigateur). Exemples officiels :

```bash
# Serveur distant (HTTP), recommandé
claude mcp add --transport http notion https://mcp.notion.com/mcp

# Serveur local avec une variable d'environnement
claude mcp add --env AIRTABLE_API_KEY=YOUR_KEY --transport stdio airtable \
  -- npx -y airtable-mcp-server
```

Le `--` sépare les options de Claude de la commande du serveur. Trois portées : **local** (défaut, ce projet, vous seul), **projet** (`--scope project`, `.mcp.json` partagé), **utilisateur** (`--scope user`). `/mcp` liste les serveurs ; pour un `.mcp.json` de dépôt, Claude Code demande votre approbation. Les définitions d'outils MCP sont **différées par défaut** (seuls les noms entrent dans le contexte jusqu'à usage) ; la documentation conseille de **désactiver les serveurs inutilisés** et de préférer, quand ils existent, des outils en ligne de commande comme `gh`, plus économes. Côté sécurité : « vérifiez que vous faites confiance à chaque serveur avant de le connecter ; ceux qui récupèrent du contenu externe peuvent vous exposer à l'injection de prompt » ; Anthropic n'audite pas la sécurité des serveurs.

### 8.2 Skills : des savoir-faire chargés à la demande

Un **skill** est un dossier contenant un `SKILL.md` : des instructions chargées quand c'est utile, ou invoquées avec `/nom`. La documentation recommande d'en créer un « quand vous collez sans cesse les mêmes instructions ou la même procédure dans la conversation, ou quand une section de `CLAUDE.md` est devenue une procédure plutôt qu'un fait ». Seules les descriptions sont chargées au démarrage ; avec `disable-model-invocation: true`, même la description reste hors du contexte. Les skills suivent le standard ouvert *Agent Skills* (agentskills.io).

Exemple dans `.claude/skills/nouvelle-fonctionnalite/SKILL.md` (structure du skill `fix-issue` de la documentation, appliquée à Flutter ; en-tête vérifié par script) :

```markdown
---
name: nouvelle-fonctionnalite
description: Crée une fonctionnalité Flutter en suivant le cycle test d'abord. À utiliser quand on demande d'ajouter une fonctionnalité.
disable-model-invocation: true
---
Ajoute la fonctionnalité demandée : $ARGUMENTS

1. Écris d'abord un test qui échoue, puis lance `flutter test` et constate l'échec.
2. Écris le code minimal pour faire passer le test.
3. Lance `dart analyze` : aucun avertissement toléré.
4. Résume en trois lignes ce qui a changé.
```

Invocation : `/nouvelle-fonctionnalite affichage de la liste des thèmes`. Ayant des effets de bord, il ne se lance que sur votre demande.

### 8.3 Hooks : des automatismes garantis

Un **hook** est une commande que Claude Code exécute automatiquement à un moment précis (avant ou après un outil, au démarrage, avant une compaction, quand l'agent s'arrête). Différence avec une consigne, selon la documentation : un hook s'exécute **à coup sûr**. Règle : « mettez les garde-fous dans des hooks ; "ne jamais modifier `.env`" dans `CLAUDE.md` est une demande, un hook `PreToolUse` qui bloque la modification est une application de la règle ». Les hooks se déclarent dans les fichiers de réglages ; `/hooks` affiche ceux qui sont configurés.

Exemple complet. Fichier `.claude/hooks/block-secrets.sh` (`chmod +x` ensuite) :

```bash
#!/bin/bash
# Bloque toute lecture ou écriture d'un fichier .env
CHEMIN=$(jq -r '.tool_input.file_path // empty')

if [[ "$CHEMIN" == *".env"* ]]; then
  jq -n '{
    hookSpecificOutput: {
      hookEventName: "PreToolUse",
      permissionDecision: "deny",
      permissionDecisionReason: "Les fichiers .env contiennent des secrets : accès interdit."
    }
  }'
else
  exit 0
fi
```

Déclaration dans `.claude/settings.json` :

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Read|Edit|Write",
        "hooks": [
          {
            "type": "command",
            "command": "${CLAUDE_PROJECT_DIR}/.claude/hooks/block-secrets.sh"
          }
        ]
      }
    ]
  }
}
```

Avant chaque lecture ou écriture de fichier, Claude Code envoie à la commande une description JSON de l'action ; `jq` (outil qui lit du JSON) en extrait le chemin, et le script répond « refusé » s'il contient `.env`. Un script qui se termine sans rien écrire signifie « pas d'avis : le circuit normal des permissions s'applique », ce qui **ne vaut pas approbation**. Les valeurs de `permissionDecision` sont `allow`, `deny` et `ask` ; une quatrième, `defer`, n'existe qu'en mode non interactif (`claude -p`).

Vérifications faites : le script, exécuté sur une entrée simulée, renvoie `deny` pour un `.env` et ne dit rien pour `main.dart`. Un test réel (`claude -p`, modèle `haiku`) avec un `.env` factice a abouti à un refus, mais **sans isoler** le hook de la règle `Read(./.env)` : testez chaque mécanisme séparément (section 12).

### 8.4 Sous-agents : des assistants au contexte isolé

Un **sous-agent** est un fichier Markdown à en-tête YAML, rangé dans `.claude/agents/` (projet) ou `~/.claude/agents/` (personnel). Exemple adapté de la documentation :

```markdown
---
name: code-reviewer
description: Reviews code for quality and best practices. Use after writing or modifying code.
tools: Read, Glob, Grep
model: sonnet
---

You are a code reviewer. When invoked, analyze the code and provide
specific, actionable feedback on quality, security, and best practices.
```

Selon la documentation : chaque sous-agent démarre avec une fenêtre **neuve** (il ne voit ni votre conversation ni les fichiers déjà lus, mais reçoit les `CLAUDE.md` et l'état de git, sauf les sous-agents intégrés Explore et Plan qui omettent les deux) ; `tools` limite ses droits (un relecteur limité à `Read`, `Glob`, `Grep` ne peut rien modifier) ; on peut lui imposer un modèle moins coûteux ; il renvoie un résumé. Des sous-agents intégrés existent, dont **Explore** (lecture seule). À préférer pour une tâche qui produit beaucoup de sortie inutile ensuite ; à éviter pour les va-et-vient fréquents ou quand la latence compte.

### 8.5 Lequel choisir ?

| Besoin | Mécanisme | Coût de contexte |
|---|---|---|
| règle toujours utile (commande, convention) | `CLAUDE.md` | à chaque requête |
| règle pour certains fichiers | règle avec `paths:` | quand ces fichiers sont ouverts |
| procédure ou référence utile parfois | skill | description, contenu à l'usage |
| accès à un service externe | serveur MCP | faible tant qu'inutilisé |
| tâche qui lit beaucoup, seul le résumé compte | sous-agent | isolé de la session |
| action ou interdiction **garantie** | hook | nul, sauf s'il renvoie du texte |
| même configuration dans plusieurs dépôts | plugin | selon son contenu |

*Source : « Extend Claude Code ».*



> **À retenir.** Les consignes guident (`CLAUDE.md`, skills) ; permissions et hooks imposent ; MCP donne des pouvoirs ; les sous-agents protègent le contexte.

---

## 9. Bonnes et mauvaises pratiques

Cinq schémas d'échec fréquents (« Best practices », section « Avoid common failure patterns ») :

- **Session fourre-tout** (sujets sans rapport enchaînés) : `/clear` entre deux tâches.
- **Correction en boucle** (l'agent se trompe, vous corrigez, il se trompe encore) : après deux échecs, `/clear` et un meilleur prompt.
- **`CLAUDE.md` obèse** (la moitié des règles est ignorée) : élaguer ; ce que l'agent fait bien seul, supprimez-le ou faites-en un hook.
- **Écart confiance-vérification** (code plausible qui ignore les cas limites) : toujours une vérification ; « si vous ne pouvez pas le vérifier, ne le livrez pas ».
- **Exploration infinie** (« investigue ça » sans cadre) : cadrer, ou passer par un sous-agent.

Bons réflexes :

- **Un agent, une branche, une tâche** (branches vues en séance 2).
- **Relire vraiment.** Vous êtes responsable de relire code et commandes avant approbation. Si vous cliquez « oui » dix fois sans lire, créez des règles d'autorisation précises plutôt que de relire moins.
- **Interrompre tôt** (`Échap`), puis `/rewind` plutôt que d'accumuler les tentatives ; **commiter souvent**, car les points de contrôle ne remplacent pas git.
- **Faire relire par un autre contexte** (session neuve ou sous-agent), non biaisé par le raisonnement qui a produit le code. La documentation note qu'un relecteur à qui l'on demande des écarts en trouve presque toujours : demandez ceux qui touchent à la correction ou aux exigences.
- **Un test d'arrêt** : un hook `Stop` peut lancer vos vérifications et empêcher l'agent de conclure tant qu'elles échouent.



---

## 10. Sécurité : injection de prompt, secrets, périmètre

**Injection de prompt.** Selon la documentation, c'est une technique par laquelle un attaquant tente de détourner les instructions d'un assistant en insérant du texte malveillant. Pour un agent de code, tout ce qu'il lit (page web, ticket, README d'un dépôt cloné, sortie d'un serveur MCP) arrive dans son contexte comme du texte et peut contenir des instructions déguisées. Protections décrites : permissions (en mode manuel, opérations sensibles soumises à approbation), commandes réseau (`curl`, `wget`) non approuvées automatiquement, détection d'injection de commande, vérification de confiance du dossier. La documentation ajoute qu'aucun système n'est « complètement immunisé » et conseille : relire les commandes avant approbation, ne pas envoyer de contenu non fiable directement à l'agent, exécuter les appels face à des services externes dans une machine virtuelle. Pour vous : pas de dépôt inconnu avec un agent en `auto` ou `bypassPermissions` ; relisez serveurs MCP et hooks d'un dépôt cloné avant d'accepter sa confiance ; traitez un `CLAUDE.md` ou un skill trouvé en ligne comme du code à relire.

**Secrets.** Un **secret** est une valeur qui donne un accès (clé d'API, mot de passe, jeton). Trois règles : (1) **jamais dans le dépôt** (le `.env` va dans `.gitignore`, rien dans `CLAUDE.md`) ; (2) **jamais dans la conversation** : tous vos prompts et les sorties du modèle transitent par le réseau (TLS 1.2 ou plus), ce que vous collez sort de votre machine ; (3) **interdire la lecture par configuration**, pas par consigne : règle `deny` `Read(./.env)` (7.2) et, au besoin, hook `PreToolUse` (8.3). Les transcriptions de sessions sont stockées **en clair** dans `~/.claude/projects/` pendant 30 jours par défaut (`cleanupPeriodDays`) : un secret lu par l'agent y reste.

**Périmètre.** Principe du **moindre privilège**. En mode manuel, l'agent demande avant de lire ou d'écrire hors du dossier de lancement (simple invite : une commande approuvée peut écrire partout où votre compte le peut). Le **bac à sable** (`/sandbox`) isole système de fichiers et réseau pour les commandes, sur les plateformes prises en charge. Les écritures dans `.git` et `.claude` ne sont jamais approuvées automatiquement (sauf en `bypassPermissions`). Les outils d'un sous-agent se limitent, et tout fonctionnement sans supervision exige un **conteneur ou une machine virtuelle**.

> **À retenir.** Tout texte lu par l'agent est une entrée potentiellement hostile. Les secrets n'entrent ni dans le dépôt ni dans la conversation. Le périmètre se réduit par la configuration, pas par la confiance.

---

> **Encart RGPD : ce que vous pouvez envoyer à un agent**
>
> Le **RGPD** (Règlement général sur la protection des données) encadre le traitement des données personnelles. La CNIL définit une donnée personnelle comme « toute information se rapportant à une personne physique identifiée ou identifiable » : un nom, mais aussi un numéro de téléphone, une adresse postale ou courriel, une voix, une image.
>
> **Ce que Claude Code fait de vos données** (documentation « Data usage ») : il envoie par le réseau vos prompts et les réponses du modèle. Selon le compte :
> - **grand public (Free, Pro, Max)** : vous choisissez d'autoriser ou non l'usage de vos données pour améliorer les futurs modèles ; conservation de **5 ans** si vous l'autorisez, **30 jours** sinon ;
> - **professionnel (Team, Enterprise, API)** : conservation standard de **30 jours** ; Anthropic « n'entraîne pas de modèles génératifs avec le code ou les prompts envoyés à Claude Code » sous les conditions commerciales, sauf choix explicite du client ; une conservation nulle existe pour certains comptes qualifiés ;
> - `/feedback` envoie une copie de la conversation (code compris), conservée 5 ans (désactivable : `DISABLE_FEEDBACK_COMMAND=1`) ;
> - la télémétrie d'usage (désactivable par `DISABLE_TELEMETRY=1`) ne contient, selon la documentation, ni code, ni prompts, ni chemins de fichiers.
>
> **En pratique dans ce cours** : n'utilisez que des **données fictives** dans dépôts, tests, captures et prompts (le projet l'impose). Ne collez ni liste de personnes, ni courriels réels, ni données d'un employeur ou d'un stage. Ceci n'est pas un avis juridique : le cadre réglementaire (bases légales, droits des personnes, transferts hors Union européenne, règlement européen sur l'IA) est traité en séance 3.

---

## 11. Optimiser sa consommation de jetons

### 11.1 Ce que l'on paie

Chaque message renvoie toute la conversation : Claude Code envoie la conversation complète avec chaque requête, et chaque outil utilisé déclenche une requête de plus portant son résultat. Une question d'une ligne dans une session ouverte depuis le matin consomme donc l'usage de toute la conversation. Repères officiels (déploiements en entreprise) : environ **13 dollars par développeur et par jour actif**, 150 à 250 dollars par mois, moins de 30 dollars par jour actif pour 90 % des utilisateurs (le talk de l'enseignant citait 6 dollars : ces moyennes évoluent). Pour suivre : `/usage` (alias `/cost`) affiche le coût de la session (estimation locale aux tarifs publics, la facture fait foi), le détail par modèle et, depuis la version 2.1.251, une ligne `Prompt cache (main)`.

### 11.2 Le cache de prompt

Comme chaque requête commence presque comme la précédente, l'API **met ce début en cache** et le relit à tarif réduit. La correspondance se fait sur le **préfixe**, de façon exacte : un changement n'importe où force à tout recalculer après lui. Claude Code place donc d'abord ce qui change peu (instruction système, outils), puis le contexte du projet (`CLAUDE.md`, mémoire), puis la conversation. Le cache expire après inactivité, deux durées existant : **5 minutes** ou **1 heure** (écriture plus chère). Par défaut, Claude Code demande 1 heure pour la conversation principale **seulement avec un abonnement et dans le quota inclus** ; avec une clé d'API, un fournisseur cloud ou des crédits d'usage entamés, c'est 5 minutes (réglage `promptCacheTtl`). Après une pause plus longue, le premier message « manque » le cache et retraite tout.

### 11.3 Ce qui fait perdre le cache

Selon la documentation : **changer de modèle** (chaque modèle a son cache ; `opusplan` en provoque à chaque entrée ou sortie du mode plan), **changer l'effort** sur la plupart des modèles (pas sur Opus 5.5, Sonnet 5.5 ni Fable 5.1 avec une clé d'API ou un abonnement, où le cache est conservé), **connecter ou retirer un serveur MCP** chargé d'emblée, **compacter**, accumuler des images, mettre à jour Claude Code. Ne le perdent pas : modifier des fichiers, changer de mode de permission, invoquer un skill, `/rewind`, lancer un sous-agent (cache propre). Modifier `CLAUDE.md` en session ne le perd pas non plus, mais **ne s'applique pas** avant le prochain `/clear`, `/compact` ou redémarrage. Conseil officiel : choisir modèle et effort **au début**, et garder `/compact` pour les coupures naturelles.

### 11.4 Les leviers

| Levier | Comment |
|---|---|
| Vider entre deux tâches | `/rename` puis `/clear` ; un contexte périmé coûte à chaque message |
| Compacter avec consigne | `/compact concentrez-vous sur les tests` |
| Bon modèle, effort bas | `/model sonnet`, `/effort low` ; `model: haiku` pour un sous-agent simple |
| Sorties courtes | `flutter test --reporter failures-only` n'affiche que les échecs (vérifié avec Flutter 3.47.6) |
| Lectures ciblées | citer le fichier (`@lib/main.dart`), recherche ciblée plutôt que lecture de l'arborescence |
| Déléguer les grosses lectures | sous-agent (Explore) : seul le résumé revient |
| Procédures vers un skill, MCP inutiles coupés | un skill ne charge son contenu qu'à l'usage ; `/mcp` pour désactiver un serveur |
| Découper les tâches | une session, une tâche ; plan avant de coder si plusieurs fichiers |
| Éviter le parallèle superflu | les équipes d'agents consomment environ 7 fois plus de jetons qu'une session standard en mode plan (documentation) |

*Source : « Manage costs effectively », « Best practices », « Prompt caching ».*

Une session ouverte depuis des heures peut consommer bien plus que votre activité ne le laisse penser (contexte long, ratés de cache après une pause, sous-agents). La compaction est elle-même une grosse requête ; `/clear` ne coûte rien. **Mesurez** : `/usage` avant et après une tâche, `/context` pour voir ce qui pèse.

> **À retenir.** Économiser des jetons, c'est de l'hygiène de contexte : vider, cadrer, découper, déléguer. Le cache récompense la stabilité : pas de changement de modèle ni d'effort en pleine tâche.

---

## 12. Mise en pratique (30 minutes)

Dans un dossier d'essai (par exemple le projet Flutter d'exemple), en mode manuel.

1. `claude --version`, puis `claude --permission-mode default` : vérifiez `manual mode on` dans la barre d'état.
2. `/context` : repérez « Memory files » et la part de l'instruction système et des outils.
3. `/init`, relisez, supprimez ce qu'un agent trouve seul, ajoutez `flutter test`, `dart analyze` et trois règles (moins de 40 lignes).
4. Créez un `.env` factice (`CLE_API=factice`), ajoutez `Read(./.env)` en `deny` via `/permissions`, demandez « lis le fichier .env » : observez le refus.
5. (Facultatif) Copiez script et déclaration de 8.3, retirez provisoirement la règle de l'étape 4 pour vérifier que le hook seul refuse, puis remettez-la.
6. Notez `/usage` avant et après une petite tâche cadrée, puis après `/clear` ; comparez avec une demande vague.
7. `Maj+Tab` jusqu'à `plan mode on` : demandez un plan de fonctionnalité et relisez-le avant d'approuver.

Livrable : un court texte sur ce que vous avez observé aux étapes 2, 4 et 6, sans donnée réelle.

---

## Glossaire

- **Agent de code** : programme qui lit, modifie et exécute du code en boucle grâce à un modèle et des outils.
- **AGENTS.md** : fichier d'instructions au format ouvert, lisible par plusieurs outils.
- **Bac à sable (*sandbox*)** : isolation limitant les accès au système de fichiers et au réseau.
- **Cache de prompt** : relecture à tarif réduit du début inchangé des requêtes.
- **Compaction** : résumé de la conversation pour libérer du contexte.
- **Context rot** : dégradation de la qualité quand le contexte se remplit.
- **Contexte (fenêtre de)** : texte total reçu par le modèle à chaque requête.
- **Harnais (*harness*)** : tout ce qui entoure le modèle : outils, règles, contexte, vérifications.
- **Hook** : commande lancée automatiquement à un moment précis.
- **Injection de prompt** : texte malveillant glissé dans le contenu lu par l'agent.
- **Jeton (*token*)** : fragment de texte, unité de facturation.
- **MCP** : standard ouvert de connexion entre agents et services externes.
- **Mode de permission** : niveau global d'autonomie (manuel, `acceptEdits`, `plan`, `auto`, `dontAsk`, `bypassPermissions`).
- **Skill** : dossier d'instructions (`SKILL.md`) chargé à la demande.
- **Sous-agent** : agent secondaire à contexte isolé qui renvoie un résumé.

---

## Pour aller plus loin

- Documentation officielle de Claude Code : « Best practices », « How Claude remembers your project », « Extend Claude Code », « Manage costs effectively », et la page interactive « Explore the context window ».
- Birgitta Böckeler, « Harness Engineering for Coding Agent Users » (martinfowler.com, avril 2026).
- Les deux études sur `AGENTS.md` (arXiv:2601.20404 et 2602.11988) : comparez leurs conditions d'expérience.
- Chapitres 3 (le craft depuis l'IA) et 8 (CI/CD) de ce support.

---

## Points non vérifiés (à signaler honnêtement)

- **Article de Lopopolo (OpenAI, 11 février 2026)** : accès refusé (403) ; formule et date reprises du programme et de `cours/sources/agentic-engineering.md`.
- **Historique d'`AGENTS.md`**, **études de 2025 sur le context rot** et **seuils 60 % et 80 %** : repris du talk de l'enseignant, non relus ou non confirmés par la documentation.
- **Interprétation des deux études sur `AGENTS.md`** : hypothèse des supports de l'enseignant ; seuls les résumés des articles ont été lus.
- **Incident Replit de juillet 2025** : cité par le programme, non revérifié.
- **Test de bout en bout du hook** : le test réel n'a pas isolé le hook de la règle de refus. Les règles `allow` du dossier de test ont été ignorées faute de confiance accordée au dossier, comme la documentation l'annonce.
- **Cursor et GitHub Copilot** : documentation lue par résumé automatique ; recontrôlez les en-têtes (`globs`, `applyTo`).
- **Tarifs au jeton**, serveur MCP Dart et Flutter, extension VS Code : non relevés ni testés.
- **Mode de démarrage « auto » et consigne du cours** : à confirmer avec l'enseignant (7.3).
- **Versions et alias** (2.1.251, 2.1.277, 2.1.283, modèles) : état du 7 octobre 2026, susceptibles de changer. L'alias `haiku` (Haiku 3.5) provient d'un résumé automatique de la page : à recontrôler.
- **Exemple de sous-agent** : description adaptée de la documentation, non recopiée mot pour mot ; la page résumée donne une formulation plus courte.
- **Droit** : l'encart RGPD n'est pas un avis juridique ; seule la définition de la CNIL est sourcée.

---

## Sources

Documentation officielle de Claude Code (consultée le 7 octobre 2026) :

- How Claude Code works : https://code.claude.com/docs/en/how-claude-code-works
- Best practices : https://code.claude.com/docs/en/best-practices
- How Claude remembers your project : https://code.claude.com/docs/en/memory
- Explore the context window : https://code.claude.com/docs/en/context-window
- Model configuration : https://code.claude.com/docs/en/model-config
- Configure permissions : https://code.claude.com/docs/en/permissions
- Choose a permission mode : https://code.claude.com/docs/en/permission-modes
- Extend Claude Code : https://code.claude.com/docs/en/features-overview
- Skills : https://code.claude.com/docs/en/skills
- Subagents : https://code.claude.com/docs/en/sub-agents
- Hooks : https://code.claude.com/docs/en/hooks et https://code.claude.com/docs/en/hooks-guide
- MCP : https://code.claude.com/docs/en/mcp
- Manage costs effectively : https://code.claude.com/docs/en/costs
- Prompt caching : https://code.claude.com/docs/en/prompt-caching
- Security : https://code.claude.com/docs/en/security
- Data usage : https://code.claude.com/docs/en/data-usage
- Desktop : https://code.claude.com/docs/en/desktop
- Commands : https://code.claude.com/docs/en/commands

Autres sources :

- Böckeler, « Harness Engineering for Coding Agent Users », 2 avril 2026 : https://martinfowler.com/articles/harness-engineering.html
- Galster et coauteurs, étude sur les mécanismes de configuration : https://arxiv.org/abs/2602.14690
- Lulla et coauteurs, impact d'`AGENTS.md` sur l'efficacité : https://arxiv.org/abs/2601.20404
- Gloaguen et coauteurs, « Evaluating AGENTS.md » : https://arxiv.org/abs/2602.11988
- Cursor, règles : https://cursor.com/docs/context/rules
- GitHub, instructions de dépôt pour Copilot : https://docs.github.com/en/copilot/how-tos/configure-custom-instructions/add-repository-instructions
- CNIL, donnée personnelle : https://www.cnil.fr/fr/definition/donnee-personnelle
- Lopopolo, OpenAI, 11 février 2026 : https://openai.com/index/harness-engineering/ (accès refusé)

Sources locales : dépôt `devoxx-2026` (`AGENTS.md`, `CLAUDE.md`, `GEMINI.md`, `.cursor/rules/`, `.github/copilot-instructions.md`, `frontend/CLAUDE.md`, `docs/`), `cours/programme-detaille.md`, `cours/presentations/day-1/notes.html`, `cours/sources/agentic-engineering.md`, synthèse de recherche de la session. Vérifications locales : `claude --help`, `claude mcp add --help`, `flutter test --help` (Flutter 3.47.6), `jq`, `claude -p`.
