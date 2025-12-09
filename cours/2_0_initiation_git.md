# Initiation à Git et à la gestion de code source

## Table des matières

1. [Histoire des systèmes de gestion de code source](#1-histoire-des-systèmes-de-gestion-de-code-source)
2. [Histoire détaillée de Git](#2-histoire-détaillée-de-git)
3. [Fonctionnement interne de Git](#3-fonctionnement-interne-de-git)
4. [Commandes principales et outils](#4-commandes-principales-et-outils)
5. [GitHub : description et guide d'utilisation](#5-github--description-et-guide-dutilisation)
6. [Glossaire](#6-glossaire)
7. [Problèmes courants et dépannage](#7-problèmes-courants-et-dépannage)
8. [Ressources et références](#8-ressources-et-références)

---

## 1. Histoire des systèmes de gestion de code source

### 1.1 L'ère pré-VCS : la gestion manuelle (avant 1970)

#### Les débuts chaotiques

Avant l'apparition des systèmes de gestion de versions, les développeurs utilisaient des méthodes **manuelles** et **artisanales** pour gérer leurs fichiers source :

**Méthodes courantes :**

- **Copies de fichiers** : `projet_v1.c`, `projet_v2.c`, `projet_final.c`, `projet_final_vraiment_final.c`
- **Dossiers datés** : `backup_2024-01-15/`, `backup_2024-01-16/`
- **Bandes magnétiques** : archivage physique des versions importantes
- **Cahiers de notes** : documentation manuelle des modifications

**Problèmes majeurs :**

- Aucune traçabilité des modifications
- Impossibilité de collaborer efficacement
- Perte fréquente de travail
- Conflits lors de modifications simultanées
- Espace disque gaspillé par les copies multiples

### 1.2 Première génération : les VCS locaux (1972-1990)

#### SCCS - Source Code Control System (1972)

**SCCS** est le premier système de gestion de versions, développé par **Marc Rochkind** chez **Bell Labs**.

**Caractéristiques :**

- Stockage des **deltas** (différences entre versions)
- Verrouillage des fichiers pour éviter les conflits
- Un seul utilisateur peut modifier un fichier à la fois
- Fonctionne uniquement en local

#### RCS - Revision Control System (1982)

**RCS**, créé par **Walter Tichy** à l'Université Purdue, améliore SCCS :

**Améliorations :**

- Stockage plus efficace des deltas (deltas inversés)
- Interface plus simple
- Meilleure gestion des branches
- Toujours local, un fichier à la fois

**Exemple de commandes RCS :**

```bash
ci -l fichier.c    # Check-in (enregistrer) avec verrouillage
co -l fichier.c    # Check-out (récupérer) avec verrouillage
rlog fichier.c     # Afficher l'historique
```

**Limitations des VCS locaux :**

- Pas de collaboration réseau
- Verrouillage exclusif des fichiers
- Pas de vision globale du projet
- Risque de perte si le disque local est endommagé

### 1.3 Deuxième génération : les VCS centralisés (1986-2005)

#### CVS - Concurrent Versions System (1986)

**CVS**, créé par **Dick Grune**, révolutionne la gestion de versions en permettant le **travail concurrent**.

**Innovations majeures :**

- **Serveur central** : un dépôt unique pour toute l'équipe
- **Travail concurrent** : plusieurs développeurs peuvent modifier le même fichier
- **Fusion automatique** : résolution des modifications non-conflictuelles
- **Branches** : développement parallèle de fonctionnalités

**Architecture CVS :**

```
┌─────────────────────────────────────────────────────────────┐
│                    SERVEUR CENTRAL                          │
│                    (Dépôt CVS)                              │
└─────────────────────────────────────────────────────────────┘
         ↑              ↑              ↑              ↑
         │              │              │              │
    ┌────┴────┐    ┌────┴────┐    ┌────┴────┐    ┌────┴────┐
    │ Dev 1   │    │ Dev 2   │    │ Dev 3   │    │ Dev 4   │
    │ (copie) │    │ (copie) │    │ (copie) │    │ (copie) │
    └─────────┘    └─────────┘    └─────────┘    └─────────┘
```

**Limitations de CVS :**

- Pas de suivi des renommages de fichiers
- Commits non-atomiques (risque d'état incohérent)
- Branches lourdes et difficiles à fusionner
- Performance dégradée sur les gros projets

#### Subversion - SVN (2000)

**Subversion**, développé par **CollabNet** (puis Apache), corrige les défauts de CVS.

**Améliorations par rapport à CVS :**

- **Commits atomiques** : tout ou rien, pas d'état intermédiaire
- **Suivi des renommages** : les fichiers déplacés conservent leur historique
- **Versionnement des répertoires** : pas seulement les fichiers
- **Meilleure gestion des binaires**
- **Protocole réseau efficace**

**Exemple de workflow SVN :**

```bash
svn checkout https://svn.example.com/projet    # Récupérer le projet
svn update                                      # Mettre à jour
svn add nouveau_fichier.c                       # Ajouter un fichier
svn commit -m "Ajout d'une fonctionnalité"     # Envoyer les modifications
svn log                                         # Voir l'historique
```

**Limitations des VCS centralisés :**

- **Point unique de défaillance** : si le serveur tombe, personne ne peut travailler
- **Connexion réseau obligatoire** : impossible de commiter hors ligne
- **Branches coûteuses** : créer une branche copie tout le projet
- **Historique centralisé** : pas d'historique local complet

### 1.4 Troisième génération : les VCS distribués (2005-présent)

#### Le paradigme distribué

Les **VCS distribués (DVCS)** représentent un changement fondamental : chaque développeur possède une **copie complète** du dépôt, incluant tout l'historique.

**Caractéristiques clés :**

- **Pas de serveur central obligatoire** : chaque clone est un dépôt complet
- **Travail hors ligne** : commits, branches, historique disponibles localement
- **Branches légères** : créer une branche est instantané
- **Flexibilité des workflows** : centralisé, distribué, hiérarchique...

**Architecture DVCS :**

```
┌─────────────────────────────────────────────────────────────┐
│                    DÉPÔT DISTANT                            │
│                    (GitHub, GitLab...)                      │
└─────────────────────────────────────────────────────────────┘
         ↑↓             ↑↓             ↑↓             ↑↓
    ┌─────────┐    ┌─────────┐    ┌─────────┐    ┌─────────┐
    │ Dev 1   │    │ Dev 2   │    │ Dev 3   │    │ Dev 4   │
    │ (clone  │←──→│ (clone  │    │ (clone  │    │ (clone  │
    │ complet)│    │ complet)│    │ complet)│    │ complet)│
    └─────────┘    └─────────┘    └─────────┘    └─────────┘
```

#### Les principaux DVCS

**BitKeeper (2000)** :
- Premier DVCS commercial populaire
- Utilisé par le noyau Linux de 2002 à 2005
- Licence propriétaire controversée

**Git (2005)** :
- Créé par Linus Torvalds
- Open source et gratuit
- Devenu le standard de l'industrie

**Mercurial (2005)** :
- Créé par Matt Mackall
- Interface plus simple que Git
- Utilisé par Facebook, Mozilla (historiquement)

**Bazaar (2005)** :
- Développé par Canonical (Ubuntu)
- Focus sur la facilité d'utilisation
- Moins populaire aujourd'hui

### 1.5 Évolution des paradigmes

#### Tableau comparatif des générations

| Aspect | Local (RCS) | Centralisé (SVN) | Distribué (Git) |
|--------|-------------|------------------|-----------------|
| **Serveur** | Aucun | Obligatoire | Optionnel |
| **Travail hors ligne** | Oui | Non | Oui |
| **Historique local** | Fichier seul | Non | Complet |
| **Branches** | Limitées | Coûteuses | Légères |
| **Collaboration** | Impossible | Via serveur | Flexible |
| **Sauvegarde** | Manuelle | Serveur | Chaque clone |
| **Performance** | Rapide | Réseau | Très rapide |

#### Chronologie synthétique

```
1972 ─── SCCS (Bell Labs) - Premier VCS
1982 ─── RCS (Purdue) - Amélioration de SCCS
1986 ─── CVS - Premier VCS concurrent
1994 ─── CVS devient open source
2000 ─── Subversion (SVN) - Successeur de CVS
2000 ─── BitKeeper - Premier DVCS populaire
2005 ─── Git et Mercurial - DVCS open source
2008 ─── GitHub - Hébergement Git en ligne
2011 ─── GitLab - Alternative open source
2018 ─── Microsoft rachète GitHub
2024 ─── Git domine avec >95% de parts de marché
```

---

## 2. Histoire détaillée de Git

### 2.1 Origines et contexte (2002-2005)

#### Le noyau Linux et BitKeeper

Le **noyau Linux** est l'un des plus grands projets open source au monde :

- **Des milliers de contributeurs** à travers le monde
- **Des millions de lignes de code**
- **Développement très actif** : des centaines de commits par jour

De **2002 à 2005**, le projet Linux utilisait **BitKeeper**, un DVCS propriétaire. Larry McVoy, créateur de BitKeeper, offrait une licence gratuite aux développeurs open source.

**Avantages de BitKeeper pour Linux :**

- Gestion efficace des branches
- Performance sur les gros projets
- Travail distribué adapté à la communauté mondiale

#### La crise de 2005

En **avril 2005**, une controverse éclate :

1. **Andrew Tridgell** (créateur de Samba) tente de faire du reverse engineering sur le protocole BitKeeper
2. **Larry McVoy** révoque la licence gratuite pour la communauté Linux
3. **Linus Torvalds** se retrouve sans outil de gestion de versions

### 2.2 La création de Git (avril 2005)

#### Les motivations de Linus Torvalds

Linus Torvalds décide de créer son propre outil. Ses critères :

**Objectifs techniques :**

1. **Vitesse** : les opérations doivent être quasi-instantanées
2. **Design simple** : architecture claire et compréhensible
3. **Support des développements non-linéaires** : milliers de branches parallèles
4. **Complètement distribué** : pas de dépendance à un serveur central
5. **Capable de gérer de très gros projets** : comme le noyau Linux

**Citation de Linus Torvalds :**

> "I'm an egotistical bastard, and I name all my projects after myself. First 'Linux', now 'Git'."
> (Git signifie "idiot" en argot britannique)

#### Développement éclair

**Chronologie du développement initial :**

- **3 avril 2005** : Début du développement
- **6 avril 2005** : Première annonce du projet
- **7 avril 2005** : Git peut gérer son propre code source
- **18 avril 2005** : Première fusion de branches
- **29 avril 2005** : Performance atteinte : 6.7 patches/seconde
- **16 juin 2005** : Git gère la version 2.6.12 du noyau Linux

**En moins de 3 mois**, Git était fonctionnel et utilisé en production !

### 2.3 Évolution et adoption (2005-2015)

#### Les premières années (2005-2008)

**Juillet 2005** : Junio Hamano devient le mainteneur principal de Git, rôle qu'il occupe encore aujourd'hui.

**Améliorations majeures :**

- **2005** : Commandes de base (init, add, commit, branch, merge)
- **2006** : `git-rebase`, amélioration des performances
- **2007** : `git-stash`, sous-modules, interface graphique `gitk`
- **2008** : Lancement de **GitHub** (février 2008)

#### L'explosion de popularité (2008-2015)

**GitHub** transforme Git en phénomène :

- **2008** : GitHub lance avec quelques milliers d'utilisateurs
- **2009** : 100 000 utilisateurs sur GitHub
- **2010** : 1 million de dépôts
- **2011** : GitLab apparaît comme alternative open source
- **2012** : 2.5 millions d'utilisateurs GitHub
- **2013** : 10 millions de dépôts
- **2015** : Git devient le VCS dominant dans l'industrie

### 2.4 Git aujourd'hui (2015-2025)

#### Adoption massive

**Statistiques actuelles (2024-2025) :**

- **>95%** des développeurs utilisent Git
- **>100 millions** de développeurs sur GitHub
- **>400 millions** de dépôts sur GitHub
- Git est enseigné dans pratiquement toutes les formations en informatique

#### Acquisitions et consolidation

- **2018** : Microsoft rachète GitHub pour **7.5 milliards de dollars**
- **2021** : GitLab entre en bourse (valorisation >10 milliards)
- Les grandes entreprises (Google, Microsoft, Amazon, Meta) utilisent toutes Git

#### Écosystème moderne

**Plateformes d'hébergement :**

- **GitHub** : leader du marché, propriété de Microsoft
- **GitLab** : alternative open source, CI/CD intégré
- **Bitbucket** : intégration Atlassian (Jira, Confluence)
- **Azure DevOps** : solution Microsoft entreprise
- **Gitea/Forgejo** : solutions auto-hébergées légères

**Intégrations :**

- Tous les IDE modernes intègrent Git
- CI/CD (GitHub Actions, GitLab CI, Jenkins)
- Outils de revue de code
- Gestion de projet (issues, projets, wikis)

---

## 3. Fonctionnement interne de Git

### 3.1 Architecture fondamentale

#### Les trois zones de travail

Git organise votre travail en **trois zones distinctes** :

```
┌─────────────────────────────────────────────────────────────┐
│                    WORKING DIRECTORY                        │
│                 (Répertoire de travail)                     │
│                                                             │
│  Vos fichiers tels que vous les voyez et les modifiez      │
└─────────────────────────────────────────────────────────────┘
                           │
                           │ git add
                           ↓
┌─────────────────────────────────────────────────────────────┐
│                     STAGING AREA                            │
│                   (Zone de transit / Index)                 │
│                                                             │
│  Préparation du prochain commit                             │
└─────────────────────────────────────────────────────────────┘
                           │
                           │ git commit
                           ↓
┌─────────────────────────────────────────────────────────────┐
│                      REPOSITORY                             │
│                   (Dépôt / .git)                            │
│                                                             │
│  Historique complet des commits                             │
└─────────────────────────────────────────────────────────────┘
```

**1. Working Directory (Répertoire de travail)** :
- Les fichiers que vous voyez dans votre explorateur
- Où vous éditez, créez et supprimez des fichiers
- État "non suivi" ou "modifié"

**2. Staging Area (Zone de transit)** :
- Aussi appelée "Index"
- Prépare le contenu du prochain commit
- Permet de sélectionner précisément ce qui sera commité
- État "staged" (indexé)

**3. Repository (Dépôt)** :
- Le dossier `.git` contenant tout l'historique
- Stocke les commits, branches, tags
- État "committed" (validé)

### 3.2 Les objets Git

Git stocke tout sous forme de **quatre types d'objets**, identifiés par leur **hash SHA-1** (40 caractères hexadécimaux).

#### Blob (Binary Large Object)

Un **blob** représente le **contenu d'un fichier** :

```
┌─────────────────────────────────────┐
│              BLOB                   │
│  SHA-1: a1b2c3d4e5...               │
│                                     │
│  Contenu brut du fichier            │
│  (sans nom, sans métadonnées)       │
└─────────────────────────────────────┘
```

**Caractéristiques :**
- Ne contient que le contenu, pas le nom du fichier
- Deux fichiers identiques = un seul blob
- Compressé avec zlib

#### Tree (Arbre)

Un **tree** représente un **répertoire** :

```
┌─────────────────────────────────────┐
│              TREE                   │
│  SHA-1: f6g7h8i9j0...               │
│                                     │
│  100644 blob a1b2c3... README.md    │
│  100644 blob d4e5f6... main.py      │
│  040000 tree k1l2m3... src/         │
└─────────────────────────────────────┘
```

**Contenu d'un tree :**
- Mode (permissions)
- Type (blob ou tree)
- SHA-1 de l'objet référencé
- Nom du fichier ou répertoire

#### Commit

Un **commit** est un **instantané** du projet à un moment donné :

```
┌─────────────────────────────────────┐
│             COMMIT                  │
│  SHA-1: n4o5p6q7r8...               │
│                                     │
│  tree f6g7h8i9j0...                 │
│  parent s9t0u1v2w3...               │
│  author Alice <alice@ex.com>        │
│  committer Alice <alice@ex.com>     │
│  date 2024-01-15 10:30:00           │
│                                     │
│  Message de commit                  │
└─────────────────────────────────────┘
```

**Contenu d'un commit :**
- Référence vers un tree (état du projet)
- Référence vers le(s) parent(s) (historique)
- Auteur et date
- Committer et date
- Message de commit

#### Tag (Étiquette)

Un **tag** est une **référence nommée** vers un commit :

```
┌─────────────────────────────────────┐
│              TAG                    │
│  SHA-1: x3y4z5a6b7...               │
│                                     │
│  object n4o5p6q7r8... (commit)      │
│  type commit                        │
│  tag v1.0.0                         │
│  tagger Bob <bob@example.com>       │
│                                     │
│  Release version 1.0.0              │
└─────────────────────────────────────┘
```

**Types de tags :**
- **Lightweight** : simple pointeur vers un commit
- **Annotated** : objet complet avec métadonnées

### 3.3 Visualisation des objets

#### Exemple concret

Imaginons un projet simple :

```
mon-projet/
├── README.md
├── main.py
└── src/
    └── utils.py
```

**Structure des objets Git :**

```
                    ┌─────────────┐
                    │   COMMIT    │
                    │  abc123...  │
                    └──────┬──────┘
                           │
                           ↓
                    ┌─────────────┐
                    │    TREE     │
                    │  (racine)   │
                    │  def456...  │
                    └──────┬──────┘
                           │
          ┌────────────────┼────────────────┐
          ↓                ↓                ↓
    ┌───────────┐    ┌───────────┐    ┌───────────┐
    │   BLOB    │    │   BLOB    │    │   TREE    │
    │ README.md │    │  main.py  │    │   src/    │
    │ 789abc... │    │ 012def... │    │ 345ghi... │
    └───────────┘    └───────────┘    └─────┬─────┘
                                            │
                                            ↓
                                      ┌───────────┐
                                      │   BLOB    │
                                      │ utils.py  │
                                      │ 678jkl... │
                                      └───────────┘
```

### 3.4 Branches et HEAD

#### Qu'est-ce qu'une branche ?

Une **branche** est simplement un **pointeur mobile** vers un commit :

```
                    ┌─────────────┐
                    │    main     │ ← branche (pointeur)
                    └──────┬──────┘
                           │
                           ↓
    ┌────────┐    ┌────────┐    ┌────────┐
    │ Commit │───→│ Commit │───→│ Commit │
    │   A    │    │   B    │    │   C    │
    └────────┘    └────────┘    └────────┘
```

**Caractéristiques :**
- Une branche = un fichier de 41 octets (SHA-1 + newline)
- Créer une branche est instantané
- Pas de copie de fichiers

#### Le pointeur HEAD

**HEAD** indique **où vous êtes** dans l'historique :

```
                              HEAD
                                │
                                ↓
                    ┌─────────────┐
                    │    main     │
                    └──────┬──────┘
                           │
                           ↓
    ┌────────┐    ┌────────┐    ┌────────┐
    │ Commit │───→│ Commit │───→│ Commit │
    │   A    │    │   B    │    │   C    │
    └────────┘    └────────┘    └────────┘
```

**HEAD pointe généralement vers une branche**, qui elle-même pointe vers un commit.

#### Branches multiples

```
                              HEAD
                                │
                                ↓
                    ┌─────────────┐
                    │   feature   │
                    └──────┬──────┘
                           │
                           ↓
                         ┌────────┐
                         │ Commit │
                         │   D    │
                         └────┬───┘
                              │
    ┌────────┐    ┌────────┐  │  ┌────────┐
    │ Commit │───→│ Commit │──┴─→│ Commit │
    │   A    │    │   B    │     │   C    │
    └────────┘    └────────┘     └────┬───┘
                                      │
                              ┌───────┴───────┐
                              │     main      │
                              └───────────────┘
```

### 3.5 Snapshots vs Deltas

#### L'approche traditionnelle : les deltas

Les VCS traditionnels (CVS, SVN) stockent les **différences** entre versions :

```
Version 1 ──→ Delta 1-2 ──→ Delta 2-3 ──→ Delta 3-4
   │              │              │              │
   ↓              ↓              ↓              ↓
Fichier A    +3 lignes     -1 ligne      +5 lignes
complet      +2 lignes     +4 lignes     -2 lignes
```

**Inconvénients :**
- Reconstruire une version ancienne nécessite d'appliquer tous les deltas
- Performance dégradée sur l'historique long

#### L'approche Git : les snapshots

Git stocke des **instantanés complets** (snapshots) :

```
Commit 1        Commit 2        Commit 3        Commit 4
    │               │               │               │
    ↓               ↓               ↓               ↓
┌───────┐       ┌───────┐       ┌───────┐       ┌───────┐
│ A (v1)│       │ A (v1)│       │ A (v2)│       │ A (v2)│
│ B (v1)│       │ B (v2)│       │ B (v2)│       │ B (v3)│
│ C (v1)│       │ C (v1)│       │ C (v1)│       │ C (v1)│
└───────┘       └───────┘       └───────┘       └───────┘
```

**Optimisation :** Git ne duplique pas les fichiers inchangés, il réutilise les blobs existants.

**Avantages :**
- Accès instantané à n'importe quelle version
- Branches légères (juste des pointeurs)
- Intégrité garantie par les hash SHA-1

### 3.6 Le répertoire .git

#### Structure du répertoire .git

```
.git/
├── HEAD                 # Pointeur vers la branche courante
├── config               # Configuration du dépôt
├── description          # Description (pour GitWeb)
├── hooks/               # Scripts automatiques
│   ├── pre-commit
│   ├── post-commit
│   └── ...
├── index                # Staging area (binaire)
├── info/
│   └── exclude          # Patterns à ignorer (local)
├── logs/                # Historique des références
│   ├── HEAD
│   └── refs/
├── objects/             # Tous les objets Git
│   ├── pack/            # Objets compressés
│   ├── info/
│   └── [00-ff]/         # Objets loose (2 premiers caractères du SHA)
└── refs/                # Références (branches, tags)
    ├── heads/           # Branches locales
    │   └── main
    ├── remotes/         # Branches distantes
    │   └── origin/
    └── tags/            # Tags
```

#### Fichiers importants

**HEAD** :
```bash
$ cat .git/HEAD
ref: refs/heads/main
```

**Branche** :
```bash
$ cat .git/refs/heads/main
a1b2c3d4e5f6g7h8i9j0k1l2m3n4o5p6q7r8s9t0
```

**Config** :
```ini
[core]
    repositoryformatversion = 0
    filemode = true
    bare = false
[remote "origin"]
    url = git@github.com:user/repo.git
    fetch = +refs/heads/*:refs/remotes/origin/*
[branch "main"]
    remote = origin
    merge = refs/heads/main
```

---

## 4. Commandes principales et outils

### 4.1 Configuration initiale

#### Identité

```bash
# Configuration globale (tous les projets)
git config --global user.name "Votre Nom"
git config --global user.email "votre.email@example.com"

# Configuration locale (projet courant uniquement)
git config user.name "Nom Projet"
git config user.email "email.projet@example.com"

# Vérifier la configuration
git config --list
git config user.name
```

#### Éditeur et outils

```bash
# Définir l'éditeur par défaut
git config --global core.editor "code --wait"  # VS Code
git config --global core.editor "vim"          # Vim
git config --global core.editor "nano"         # Nano

# Outil de diff
git config --global diff.tool vscode
git config --global difftool.vscode.cmd 'code --wait --diff $LOCAL $REMOTE'

# Outil de merge
git config --global merge.tool vscode
git config --global mergetool.vscode.cmd 'code --wait $MERGED'
```

#### Alias utiles

```bash
# Créer des raccourcis
git config --global alias.st status
git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.ci commit
git config --global alias.lg "log --oneline --graph --all"
git config --global alias.last "log -1 HEAD"
git config --global alias.unstage "reset HEAD --"
```

### 4.2 Commandes de base

#### Initialisation et clonage

```bash
# Créer un nouveau dépôt
git init
git init mon-projet  # Crée le dossier et initialise

# Cloner un dépôt existant
git clone https://github.com/user/repo.git
git clone git@github.com:user/repo.git           # SSH
git clone https://github.com/user/repo.git mon-dossier  # Nom personnalisé
git clone --depth 1 https://github.com/user/repo.git    # Clone superficiel
```

#### Cycle de base : add, commit, push

```bash
# Voir l'état des fichiers
git status
git status -s  # Format court

# Ajouter des fichiers à la staging area
git add fichier.txt           # Un fichier
git add dossier/              # Un dossier
git add .                     # Tout le répertoire courant
git add -A                    # Tout (y compris suppressions)
git add -p                    # Mode interactif (patch)

# Créer un commit
git commit -m "Message de commit"
git commit                    # Ouvre l'éditeur pour le message
git commit -a -m "Message"    # Add + commit (fichiers suivis uniquement)
git commit --amend            # Modifier le dernier commit

# Envoyer vers le dépôt distant
git push
git push origin main          # Explicite
git push -u origin main       # Définir l'upstream
git push --force              # Forcer (⚠️ dangereux)
git push --force-with-lease   # Forcer de manière sécurisée
```

#### Récupérer les modifications

```bash
# Récupérer sans fusionner
git fetch
git fetch origin
git fetch --all               # Tous les remotes

# Récupérer et fusionner
git pull
git pull origin main
git pull --rebase             # Rebase au lieu de merge

# Différence fetch vs pull
# fetch : télécharge les commits distants
# pull  : fetch + merge (ou rebase)
```

### 4.3 Gestion des branches

#### Créer et naviguer

```bash
# Lister les branches
git branch                    # Branches locales
git branch -r                 # Branches distantes
git branch -a                 # Toutes les branches
git branch -v                 # Avec dernier commit

# Créer une branche
git branch nouvelle-branche
git branch nouvelle-branche commit-sha  # À partir d'un commit

# Changer de branche
git checkout ma-branche       # Ancienne syntaxe
git switch ma-branche         # Nouvelle syntaxe (Git 2.23+)

# Créer et basculer
git checkout -b nouvelle-branche
git switch -c nouvelle-branche

# Supprimer une branche
git branch -d ma-branche      # Supprime si fusionnée
git branch -D ma-branche      # Force la suppression
git push origin --delete ma-branche  # Supprimer sur le distant
```

#### Fusionner (merge)

```bash
# Fusionner une branche dans la branche courante
git merge feature-branch

# Types de merge
git merge --ff feature        # Fast-forward si possible (défaut)
git merge --no-ff feature     # Toujours créer un commit de merge
git merge --squash feature    # Squash tous les commits

# Annuler un merge en cours
git merge --abort
```

**Visualisation des types de merge :**

```
AVANT :
main:     A ── B ── C
                     \
feature:              D ── E

APRÈS (fast-forward) :
main:     A ── B ── C ── D ── E

APRÈS (no-ff) :
main:     A ── B ── C ────────── M (merge commit)
                     \         /
feature:              D ── E ─┘
```

#### Rebaser

```bash
# Rebaser la branche courante sur main
git rebase main

# Rebase interactif (modifier l'historique)
git rebase -i HEAD~3          # Les 3 derniers commits
git rebase -i main            # Depuis main

# Annuler un rebase en cours
git rebase --abort

# Continuer après résolution de conflit
git rebase --continue
```

**Visualisation du rebase :**

```
AVANT :
main:     A ── B ── C
                \
feature:         D ── E

APRÈS rebase :
main:     A ── B ── C
                     \
feature:              D' ── E'
```

### 4.4 Historique et inspection

#### Consulter l'historique

```bash
# Log basique
git log
git log --oneline             # Format compact
git log --graph               # Graphe ASCII
git log --all                 # Toutes les branches
git log -n 5                  # Les 5 derniers commits
git log --since="2024-01-01"  # Depuis une date
git log --author="Alice"      # Par auteur
git log -- fichier.txt        # Historique d'un fichier
git log -p                    # Avec les diffs

# Format personnalisé
git log --pretty=format:"%h %an %ar - %s"

# Rechercher dans les commits
git log --grep="bug fix"      # Dans les messages
git log -S "fonction"         # Dans le code (pickaxe)
```

#### Voir les différences

```bash
# Différences non indexées
git diff

# Différences indexées (staging)
git diff --staged
git diff --cached             # Synonyme

# Entre deux commits
git diff commit1 commit2
git diff HEAD~3 HEAD

# Pour un fichier spécifique
git diff fichier.txt
git diff HEAD~1 -- fichier.txt

# Statistiques
git diff --stat
```

#### Inspecter des objets

```bash
# Voir un commit
git show commit-sha
git show HEAD
git show HEAD~2               # 2 commits avant HEAD

# Voir un fichier à une version donnée
git show HEAD:fichier.txt
git show main:src/app.py

# Qui a modifié chaque ligne ?
git blame fichier.txt
git blame -L 10,20 fichier.txt  # Lignes 10 à 20
```

### 4.5 Annuler des modifications

#### Avant le commit

```bash
# Annuler les modifications d'un fichier (working directory)
git checkout -- fichier.txt   # Ancienne syntaxe
git restore fichier.txt       # Nouvelle syntaxe (Git 2.23+)

# Retirer de la staging area
git reset HEAD fichier.txt    # Ancienne syntaxe
git restore --staged fichier.txt  # Nouvelle syntaxe

# Annuler toutes les modifications locales
git checkout -- .
git restore .
```

#### Après le commit

```bash
# Modifier le dernier commit
git commit --amend            # Modifier message ou contenu
git commit --amend --no-edit  # Garder le même message

# Annuler un commit (crée un nouveau commit inverse)
git revert HEAD               # Annule le dernier commit
git revert commit-sha         # Annule un commit spécifique
git revert HEAD~3..HEAD       # Annule plusieurs commits

# Revenir à un état précédent (⚠️ modifie l'historique)
git reset --soft HEAD~1       # Garde les modifications staged
git reset --mixed HEAD~1      # Garde les modifications unstaged (défaut)
git reset --hard HEAD~1       # Supprime tout (⚠️ dangereux)
```

**Comparaison reset vs revert :**

| Aspect | `git reset` | `git revert` |
|--------|-------------|--------------|
| Modifie l'historique | Oui | Non |
| Crée un nouveau commit | Non | Oui |
| Sûr pour branches partagées | Non | Oui |
| Récupérable | Difficile | Facile |

### 4.6 Stash (remisage)

```bash
# Mettre de côté les modifications
git stash
git stash push -m "Description"
git stash push fichier.txt    # Fichier spécifique

# Lister les stash
git stash list

# Récupérer un stash
git stash pop                 # Applique et supprime
git stash apply               # Applique sans supprimer
git stash apply stash@{2}     # Un stash spécifique

# Supprimer des stash
git stash drop                # Le plus récent
git stash drop stash@{1}      # Un stash spécifique
git stash clear               # Tous les stash

# Voir le contenu d'un stash
git stash show
git stash show -p             # Avec le diff
```

### 4.7 Tags

```bash
# Créer un tag
git tag v1.0.0                # Tag léger
git tag -a v1.0.0 -m "Version 1.0.0"  # Tag annoté

# Lister les tags
git tag
git tag -l "v1.*"             # Avec pattern

# Voir un tag
git show v1.0.0

# Pousser les tags
git push origin v1.0.0        # Un tag
git push origin --tags        # Tous les tags

# Supprimer un tag
git tag -d v1.0.0             # Local
git push origin --delete v1.0.0  # Distant
```

### 4.8 Outils graphiques

#### Outils intégrés à Git

```bash
# Interface graphique pour l'historique
gitk
gitk --all

# Interface graphique pour staging
git gui
```

#### Applications tierces

**GitKraken** :
- Interface moderne et intuitive
- Visualisation graphique de l'historique
- Intégration GitHub, GitLab, Bitbucket
- Version gratuite disponible

**SourceTree** :
- Gratuit (Atlassian)
- Interface claire
- Bon pour les débutants
- Windows et macOS

**GitHub Desktop** :
- Gratuit et simple
- Intégration parfaite avec GitHub
- Idéal pour les débutants
- Windows et macOS

**Fork** :
- Rapide et léger
- Interface épurée
- Windows et macOS
- Gratuit pour évaluation

#### Extensions IDE

**VS Code** :
- GitLens : historique, blame, comparaisons
- Git Graph : visualisation de l'historique
- Git History : navigation dans l'historique

**JetBrains (IntelliJ, PyCharm, WebStorm...)** :
- Intégration Git native excellente
- Résolution de conflits visuelle
- Historique et blame intégrés

### 4.9 Bonnes pratiques

#### Messages de commit

**Format recommandé :**

```
<type>(<scope>): <sujet>

<corps>

<footer>
```

**Types courants :**
- `feat` : nouvelle fonctionnalité
- `fix` : correction de bug
- `docs` : documentation
- `style` : formatage (pas de changement de code)
- `refactor` : refactoring
- `test` : ajout/modification de tests
- `chore` : maintenance

**Exemples :**

```
feat(auth): ajouter la connexion OAuth2

Implémente la connexion via Google et GitHub.
Utilise la bibliothèque passport.js.

Closes #123
```

```
fix(api): corriger le timeout sur les requêtes longues

Le timeout était de 5s, augmenté à 30s pour les exports.
```

#### Workflow recommandé

```bash
# 1. Mettre à jour main
git checkout main
git pull

# 2. Créer une branche de feature
git checkout -b feature/ma-fonctionnalite

# 3. Travailler et commiter régulièrement
git add .
git commit -m "feat: première partie"
# ... continuer ...

# 4. Mettre à jour avec main
git fetch origin
git rebase origin/main

# 5. Pousser et créer une Pull Request
git push -u origin feature/ma-fonctionnalite
```

---

## 5. GitHub : description et guide d'utilisation

### 5.1 Présentation de GitHub

#### Qu'est-ce que GitHub ?

**GitHub** est une plateforme d'hébergement de code source basée sur Git, lancée en **février 2008** par Tom Preston-Werner, Chris Wanstrath et PJ Hyett.

**Évolution :**
- **2008** : Lancement
- **2012** : 2 millions d'utilisateurs
- **2018** : Rachat par Microsoft pour 7.5 milliards $
- **2024** : Plus de 100 millions de développeurs

#### Fonctionnalités principales

**Hébergement de code :**
- Dépôts publics (gratuits, illimités)
- Dépôts privés (gratuits depuis 2019)
- Gestion des branches et tags
- Interface web pour naviguer le code

**Collaboration :**
- Pull Requests (revue de code)
- Issues (suivi des bugs et tâches)
- Discussions
- Wikis
- Projects (gestion de projet)

**Automatisation :**
- GitHub Actions (CI/CD)
- Webhooks
- GitHub Apps
- Dependabot (mises à jour de sécurité)

**Communauté :**
- Profils développeurs
- Contributions et graphe d'activité
- Stars et forks
- Sponsors

### 5.2 Concepts clés de GitHub

#### Repository (Dépôt)

Un **repository** (ou "repo") est un projet hébergé sur GitHub.

**Éléments d'un repository :**
- Code source
- Historique Git complet
- README.md (page d'accueil)
- Issues et Pull Requests
- Wiki et documentation
- Actions et workflows
- Paramètres et collaborateurs

#### Fork

Un **fork** est une **copie personnelle** d'un dépôt d'un autre utilisateur.

```
┌─────────────────────────────────────────────────────────────┐
│              DÉPÔT ORIGINAL                                 │
│         user-original/projet                                │
└─────────────────────────────────────────────────────────────┘
                           │
                           │ Fork
                           ↓
┌─────────────────────────────────────────────────────────────┐
│              VOTRE FORK                                     │
│         votre-username/projet                               │
└─────────────────────────────────────────────────────────────┘
```

**Utilité :**
- Contribuer à des projets open source
- Expérimenter sans affecter l'original
- Proposer des modifications via Pull Request

#### Pull Request (PR)

Une **Pull Request** est une **demande de fusion** de vos modifications dans un autre dépôt ou branche.

**Workflow typique :**

```
1. Fork du projet
2. Clone de votre fork
3. Création d'une branche
4. Modifications et commits
5. Push vers votre fork
6. Création de la Pull Request
7. Revue de code
8. Merge (si approuvé)
```

**Éléments d'une PR :**
- Titre et description
- Commits inclus
- Fichiers modifiés (diff)
- Commentaires et discussions
- Revues et approbations
- Checks (CI/CD)

#### Issues

Les **Issues** sont le système de **suivi des tâches** de GitHub.

**Types d'issues :**
- Bugs à corriger
- Fonctionnalités à implémenter
- Questions
- Documentation à améliorer

**Fonctionnalités :**
- Labels (catégorisation)
- Milestones (jalons)
- Assignees (responsables)
- Projets (tableaux Kanban)
- Références croisées (#123)

### 5.3 Workflow de contribution

#### Contribuer à un projet open source

**Étape 1 : Fork et clone**

```bash
# Sur GitHub : cliquer sur "Fork"

# Cloner votre fork
git clone git@github.com:votre-username/projet.git
cd projet

# Ajouter le dépôt original comme remote
git remote add upstream git@github.com:original/projet.git
```

**Étape 2 : Créer une branche**

```bash
# Mettre à jour depuis l'original
git fetch upstream
git checkout main
git merge upstream/main

# Créer une branche de travail
git checkout -b fix/correction-bug-123
```

**Étape 3 : Faire les modifications**

```bash
# Modifier les fichiers
# ...

# Commiter
git add .
git commit -m "fix: corriger le bug de connexion (#123)"
```

**Étape 4 : Pousser et créer la PR**

```bash
# Pousser vers votre fork
git push -u origin fix/correction-bug-123

# Sur GitHub : créer la Pull Request
```

**Étape 5 : Répondre aux commentaires**

```bash
# Si des modifications sont demandées
git add .
git commit -m "fix: appliquer les suggestions de revue"
git push
```

#### Diagramme du workflow

```
┌─────────────────────────────────────────────────────────────┐
│                    DÉPÔT ORIGINAL                           │
│                  (upstream/main)                            │
└─────────────────────────────────────────────────────────────┘
         ↑                                    │
         │ Pull Request                       │ Fork
         │                                    ↓
┌─────────────────────────────────────────────────────────────┐
│                    VOTRE FORK                               │
│                  (origin/main)                              │
└─────────────────────────────────────────────────────────────┘
         ↑                                    │
         │ Push                               │ Clone
         │                                    ↓
┌─────────────────────────────────────────────────────────────┐
│                    LOCAL                                    │
│              (votre ordinateur)                             │
└─────────────────────────────────────────────────────────────┘
```

### 5.4 GitHub Actions

#### Qu'est-ce que GitHub Actions ?

**GitHub Actions** est le système de **CI/CD** (Continuous Integration / Continuous Deployment) intégré à GitHub.

**Concepts :**
- **Workflow** : processus automatisé défini en YAML
- **Event** : déclencheur (push, PR, schedule...)
- **Job** : ensemble d'étapes exécutées sur un runner
- **Step** : action individuelle
- **Action** : composant réutilisable

#### Exemple de workflow

```yaml
# .github/workflows/ci.yml
name: CI

on:
  push:
    branches: [main]
  pull_request:
    branches: [main]

jobs:
  test:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout code
        uses: actions/checkout@v4

      - name: Setup Node.js
        uses: actions/setup-node@v4
        with:
          node-version: '20'

      - name: Install dependencies
        run: npm ci

      - name: Run tests
        run: npm test

      - name: Run linter
        run: npm run lint
```

#### Événements courants

```yaml
on:
  push:                    # À chaque push
  pull_request:            # À chaque PR
  schedule:
    - cron: '0 0 * * *'    # Tous les jours à minuit
  workflow_dispatch:       # Déclenchement manuel
  release:
    types: [published]     # À chaque release
```

### 5.5 Organisations et équipes

#### Organisations

Une **organisation** est un compte partagé pour les équipes et entreprises.

**Fonctionnalités :**
- Dépôts partagés
- Équipes avec permissions
- Facturation centralisée
- Audit logs
- SSO (Single Sign-On)

#### Équipes

Les **équipes** permettent de gérer les permissions par groupe.

**Niveaux de permission :**
- **Read** : voir le code
- **Triage** : gérer les issues
- **Write** : pousser du code
- **Maintain** : gérer le dépôt (sans accès admin)
- **Admin** : accès complet

### 5.6 Bonnes pratiques GitHub

#### README.md

Un bon README contient :

```markdown
# Nom du Projet

Description courte du projet.

## Installation

```bash
npm install mon-projet
```

## Utilisation

```javascript
const projet = require('mon-projet');
projet.faire();
```

## Contribution

Voir [CONTRIBUTING.md](CONTRIBUTING.md)

## Licence

MIT
```

#### Templates

**Issue template** (`.github/ISSUE_TEMPLATE/bug_report.md`) :

```markdown
---
name: Bug Report
about: Signaler un bug
---

## Description
Description claire du bug.

## Étapes pour reproduire
1. Aller sur '...'
2. Cliquer sur '...'
3. Voir l'erreur

## Comportement attendu
Ce qui devrait se passer.

## Screenshots
Si applicable.

## Environnement
- OS: [ex: macOS 14.0]
- Version: [ex: 1.2.3]
```

**Pull Request template** (`.github/pull_request_template.md`) :

```markdown
## Description
Description des changements.

## Type de changement
- [ ] Bug fix
- [ ] Nouvelle fonctionnalité
- [ ] Breaking change
- [ ] Documentation

## Checklist
- [ ] Tests ajoutés/mis à jour
- [ ] Documentation mise à jour
- [ ] Code formaté
```

---

## 6. Glossaire

### Termes essentiels

| Terme | Définition |
|-------|------------|
| **Repository (Dépôt)** | Espace de stockage contenant le code et son historique |
| **Commit** | Instantané des modifications à un moment donné |
| **Branch (Branche)** | Ligne de développement indépendante |
| **Merge (Fusion)** | Combiner deux branches |
| **Clone** | Copie complète d'un dépôt distant |
| **Fork** | Copie personnelle d'un dépôt sur GitHub |
| **Pull Request (PR)** | Demande de fusion de modifications |
| **Remote** | Dépôt distant (ex: sur GitHub) |
| **Origin** | Nom par défaut du remote principal |
| **HEAD** | Pointeur vers le commit/branche actuel |
| **Staging Area** | Zone de préparation avant commit |
| **Working Directory** | Répertoire de travail local |

### Termes avancés

| Terme | Définition |
|-------|------------|
| **Rebase** | Réécrire l'historique en déplaçant des commits |
| **Cherry-pick** | Appliquer un commit spécifique sur une autre branche |
| **Stash** | Mettre de côté temporairement des modifications |
| **Tag** | Marque nommée sur un commit (souvent pour les versions) |
| **Upstream** | Dépôt original d'un fork |
| **Fast-forward** | Merge sans commit de fusion (historique linéaire) |
| **Detached HEAD** | HEAD pointant directement vers un commit (pas une branche) |
| **Blob** | Objet Git contenant le contenu d'un fichier |
| **Tree** | Objet Git représentant un répertoire |
| **SHA-1** | Hash cryptographique identifiant les objets Git |
| **Reflog** | Journal des modifications de HEAD |
| **Submodule** | Dépôt Git imbriqué dans un autre |

---

## 7. Problèmes courants et dépannage

### 7.1 Conflits de merge

#### Comprendre les conflits

Un conflit survient quand Git ne peut pas fusionner automatiquement deux modifications.

**Exemple de conflit :**

```
<<<<<<< HEAD
console.log("Version de main");
=======
console.log("Version de feature");
>>>>>>> feature
```

#### Résoudre un conflit

```bash
# 1. Identifier les fichiers en conflit
git status

# 2. Ouvrir et éditer les fichiers
# Choisir la bonne version ou combiner

# 3. Marquer comme résolu
git add fichier-resolu.js

# 4. Continuer le merge
git commit
# ou pour un rebase
git rebase --continue
```

#### Outils de résolution

```bash
# Utiliser un outil graphique
git mergetool

# Accepter une version entière
git checkout --ours fichier.js    # Garder notre version
git checkout --theirs fichier.js  # Garder leur version
```

### 7.2 Récupérer du travail perdu

#### Reflog : votre filet de sécurité

```bash
# Voir l'historique de HEAD
git reflog

# Exemple de sortie :
# a1b2c3d HEAD@{0}: commit: dernier commit
# e4f5g6h HEAD@{1}: checkout: moving from feature to main
# i7j8k9l HEAD@{2}: commit: commit perdu

# Récupérer un commit "perdu"
git checkout i7j8k9l
# ou
git cherry-pick i7j8k9l
```

#### Récupérer un fichier supprimé

```bash
# Trouver le commit où le fichier existait
git log --all --full-history -- chemin/fichier.txt

# Restaurer le fichier
git checkout commit-sha -- chemin/fichier.txt
```

#### Annuler un reset --hard

```bash
# Trouver l'état précédent dans le reflog
git reflog

# Revenir à cet état
git reset --hard HEAD@{1}
```

### 7.3 Problèmes de push

#### "Updates were rejected"

```bash
# Erreur : le distant a des commits que vous n'avez pas

# Solution 1 : Pull puis push
git pull --rebase
git push

# Solution 2 : Force push (⚠️ si vous êtes sûr)
git push --force-with-lease
```

#### "Permission denied"

```bash
# Vérifier la configuration SSH
ssh -T git@github.com

# Vérifier le remote
git remote -v

# Changer le remote si nécessaire
git remote set-url origin git@github.com:user/repo.git
```

### 7.4 Nettoyer l'historique

#### Supprimer un fichier de tout l'historique

```bash
# ⚠️ Réécrit l'historique - à utiliser avec précaution

# Avec git filter-branch (ancienne méthode)
git filter-branch --force --index-filter \
  'git rm --cached --ignore-unmatch chemin/fichier-sensible' \
  --prune-empty --tag-name-filter cat -- --all

# Avec git filter-repo (recommandé, à installer)
git filter-repo --path chemin/fichier-sensible --invert-paths
```

#### Squash des commits

```bash
# Combiner les 3 derniers commits
git rebase -i HEAD~3

# Dans l'éditeur, changer "pick" en "squash" (ou "s")
# pour les commits à fusionner
```

### 7.5 Problèmes courants

#### Fichier trop gros

```bash
# Erreur : fichier > 100 MB

# Solution : utiliser Git LFS
git lfs install
git lfs track "*.psd"
git add .gitattributes
git add fichier.psd
git commit -m "Ajouter fichier avec LFS"
```

#### Mauvais email dans les commits

```bash
# Changer pour les futurs commits
git config user.email "bon.email@example.com"

# Corriger le dernier commit
git commit --amend --author="Nom <bon.email@example.com>"

# Corriger plusieurs commits (rebase interactif)
git rebase -i HEAD~5
# Marquer les commits avec "edit", puis pour chacun :
git commit --amend --author="Nom <bon.email@example.com>"
git rebase --continue
```

---

## 8. Ressources et références

### 8.1 Documentation officielle

- **Git** : [git-scm.com/doc](https://git-scm.com/doc)
- **Pro Git Book** (gratuit) : [git-scm.com/book](https://git-scm.com/book/fr/v2)
- **GitHub Docs** : [docs.github.com](https://docs.github.com)
- **GitHub Skills** : [skills.github.com](https://skills.github.com)

### 8.2 Tutoriels interactifs

- **Learn Git Branching** : [learngitbranching.js.org](https://learngitbranching.js.org/?locale=fr_FR)
- **Oh My Git!** (jeu) : [ohmygit.org](https://ohmygit.org)
- **Katacoda Git** : scénarios interactifs
- **GitHub Learning Lab** : parcours guidés

### 8.3 Aide-mémoire (Cheat Sheets)

- **GitHub Git Cheat Sheet** : [education.github.com/git-cheat-sheet-education.pdf](https://education.github.com/git-cheat-sheet-education.pdf)
- **Atlassian Git Cheat Sheet** : [atlassian.com/git/tutorials/atlassian-git-cheatsheet](https://www.atlassian.com/git/tutorials/atlassian-git-cheatsheet)

### 8.4 Livres recommandés

| Livre | Auteur | Description |
|-------|--------|-------------|
| **Pro Git** | Scott Chacon, Ben Straub | Référence complète, gratuit en ligne |
| **Git Pocket Guide** | Richard Silverman | Guide compact et pratique |
| **Version Control with Git** | Jon Loeliger | Approfondi et technique |

### 8.5 Vidéos et cours

- **The Coding Train - Git and GitHub** : tutoriels vidéo accessibles
- **Traversy Media - Git & GitHub Crash Course** : introduction rapide
- **freeCodeCamp - Git and GitHub for Beginners** : cours complet gratuit

### 8.6 Communauté

- **Stack Overflow** : tag `git` pour les questions
- **Reddit** : r/git, r/github
- **Discord** : serveurs de développeurs
- **Twitter/X** : #git, #github

---

## Annexe : Diagrammes de workflow

### Workflow Git Flow

```
main        ─────●─────────────────────●─────────────────●─────
                 │                     ↑                 ↑
                 │                     │                 │
develop     ─────●───●───●───●───●─────●───●───●───●─────●─────
                     │       ↑         │       ↑
                     │       │         │       │
feature/A            ●───●───┘         │       │
                                       │       │
feature/B                              ●───●───┘
```

### Workflow GitHub Flow

```
main        ─────●─────────────●─────────────●─────────────●─────
                 │             ↑             ↑             ↑
                 │             │             │             │
feature-1        ●───●───●─────┘             │             │
                                             │             │
feature-2                      ●───●─────────┘             │
                                                           │
bugfix-1                                     ●───●─────────┘
```

### Cycle de vie d'un fichier

```
┌─────────────┐     git add      ┌─────────────┐    git commit    ┌─────────────┐
│  Untracked  │ ───────────────→ │   Staged    │ ───────────────→ │  Committed  │
│  (nouveau)  │                  │  (indexé)   │                  │  (validé)   │
└─────────────┘                  └─────────────┘                  └─────────────┘
                                       ↑                                │
                                       │                                │
                                       │         modification          │
                                       │                                ↓
                                 ┌─────────────┐                  ┌─────────────┐
                                 │   Staged    │ ←──────────────  │  Modified   │
                                 │  (indexé)   │     git add      │  (modifié)  │
                                 └─────────────┘                  └─────────────┘
```

---
# Cheat Sheet Git
![](./images/git_cheat_sheet.png)
