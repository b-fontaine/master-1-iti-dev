# Installation et Configuration de Flutter

## Table des matières

1. [Introduction](#1-introduction)
2. [Installation de Flutter par plateforme](#2-installation-de-flutter-par-plateforme)
    - [Windows](#21-installation-sur-windows)
    - [macOS](#22-installation-sur-macos)
    - [Linux](#23-installation-sur-linux)
3. [Configuration de VS Code](#3-configuration-de-vs-code)
4. [Vérification et tests](#4-vérification-et-tests)
5. [Créer votre premier écran rapidement](#5-créer-votre-premier-écran-rapidement)
6. [Référence rapide](#6-référence-rapide)

---

## 1. Introduction

### Qu'est-ce que Flutter ?

**Flutter** est un framework open-source développé par Google pour créer des applications natives multi-plateformes (
iOS, Android, Web, Desktop) à partir d'une seule base de code.

### Pourquoi Flutter ?

✅ **Un seul code, plusieurs plateformes** : iOS, Android, Web, Windows, macOS, Linux
✅ **Performance native** : Compilation en code natif ARM/x64
✅ **Hot Reload** : Voir les changements instantanément sans recompiler
✅ **Widgets riches** : Interface utilisateur moderne et personnalisable
✅ **Dart** : Langage moderne, facile à apprendre
✅ **Communauté active** : Packages, tutoriels, support

### Prérequis

Avant de commencer, assurez-vous d'avoir :

- Un ordinateur avec au moins **8 Go de RAM** (16 Go recommandé)
- Au moins **10 Go d'espace disque libre** (20 Go recommandé)
- Une connexion Internet stable pour télécharger les outils
- Des droits administrateur sur votre machine

### Vue d'ensemble du processus d'installation

```
1. Installer Flutter SDK
   ↓
2. Installer VS Code + Extensions
   ↓
3. Installer les outils de développement (Android Studio / Xcode)
   ↓
4. Configurer les émulateurs/simulateurs
   ↓
5. Vérifier l'installation avec `flutter doctor`
   ↓
6. Créer et lancer votre première application
```

**Temps estimé :** 1-2 heures selon votre plateforme et votre connexion Internet.

---

## 2. Installation de Flutter par plateforme

### 2.1. Installation sur Windows

#### 2.1.1. Configuration système requise

**Minimum :**

- Windows 10 ou supérieur (64-bit)
- 8 Go de RAM
- 10 Go d'espace disque

**Recommandé :**

- Windows 11 (64-bit)
- 16 Go de RAM
- 20 Go d'espace disque (SSD de préférence)
- Processeur Intel i5 ou équivalent

#### 2.1.2. Installation du Flutter SDK

**Étape 1 : Télécharger Flutter**

1. Visitez [https://docs.flutter.dev/get-started/install/windows](https://docs.flutter.dev/get-started/install/windows)
2. Téléchargez le fichier ZIP du Flutter SDK (environ 1.5 Go)
3. Extrayez le fichier ZIP dans un emplacement permanent, par exemple :
   ```
   C:\src\flutter
   ```

> ⚠️ **Important** : N'installez PAS Flutter dans un répertoire nécessitant des privilèges élevés (comme
`C:\Program Files\`)

**Étape 2 : Ajouter Flutter au PATH**

1. Recherchez "Variables d'environnement" dans le menu Démarrer
2. Cliquez sur "Modifier les variables d'environnement système"
3. Cliquez sur "Variables d'environnement..."
4. Dans "Variables utilisateur", sélectionnez "Path" et cliquez sur "Modifier"
5. Cliquez sur "Nouveau" et ajoutez :
   ```
   C:\src\flutter\bin
   ```
6. Cliquez sur "OK" pour fermer toutes les fenêtres

**Étape 3 : Vérifier l'installation**

Ouvrez un nouveau terminal PowerShell ou Command Prompt et exécutez :

```bash
flutter --version
```

Vous devriez voir la version de Flutter s'afficher.

#### 2.1.3. Installation d'Android Studio

**Étape 1 : Télécharger Android Studio**

1. Visitez [https://developer.android.com/studio](https://developer.android.com/studio)
2. Téléchargez Android Studio (environ 1 Go)
3. Lancez l'installateur et suivez les instructions

**Étape 2 : Configuration initiale**

1. Lancez Android Studio
2. Suivez l'assistant de configuration
3. Sélectionnez "Standard" pour le type d'installation
4. Attendez que tous les composants soient téléchargés (SDK, émulateur, etc.)

**Étape 3 : Installer les outils de ligne de commande**

1. Dans Android Studio, allez dans **File > Settings** (ou **Android Studio > Preferences** sur Mac)
2. Naviguez vers **Appearance & Behavior > System Settings > Android SDK**
3. Sélectionnez l'onglet **SDK Tools**
4. Cochez :
    - ✅ Android SDK Command-line Tools
    - ✅ Android SDK Platform-Tools
    - ✅ Android SDK Build-Tools
5. Cliquez sur "Apply" et attendez l'installation

**Étape 4 : Accepter les licences Android**

Ouvrez un terminal et exécutez :

```bash
flutter doctor --android-licenses
```

Tapez `y` pour accepter toutes les licences.

#### 2.1.4. Configuration de l'émulateur Android

**Étape 1 : Créer un appareil virtuel**

#### 2.1.5. Dépannage Windows

**Problème : "flutter: command not found"**

✅ **Solution :**

1. Vérifiez que Flutter est bien dans le PATH
2. Redémarrez votre terminal
3. Si le problème persiste, redémarrez votre ordinateur

**Problème : "Unable to locate Android SDK"**

✅ **Solution :**

1. Définissez la variable d'environnement `ANDROID_HOME` :
   ```
   C:\Users\VotreNom\AppData\Local\Android\Sdk
   ```
2. Ajoutez au PATH :
   ```
   %ANDROID_HOME%\platform-tools
   %ANDROID_HOME%\tools
   ```

**Problème : L'émulateur est très lent**

✅ **Solutions :**

1. Activez la virtualisation dans le BIOS (Intel VT-x ou AMD-V)
2. Installez Intel HAXM (Hardware Accelerated Execution Manager)
3. Allouez plus de RAM à l'émulateur (4 Go minimum)

**Problème : "cmdline-tools component is missing"**

✅ **Solution :**

1. Ouvrez Android Studio
2. Allez dans **File > Settings > Android SDK > SDK Tools**
3. Cochez **Android SDK Command-line Tools (latest)**
4. Cliquez sur **Apply**

---

### 2.2. Installation sur macOS

#### 2.2.1. Configuration système requise

**Minimum :**

- macOS 10.14 (Mojave) ou supérieur
- 8 Go de RAM
- 10 Go d'espace disque

**Recommandé :**

- macOS 13 (Ventura) ou supérieur
- 16 Go de RAM
- 20 Go d'espace disque (SSD)
- Processeur Apple Silicon (M1/M2/M3) ou Intel i5+

> 💡 **Note** : Flutter fonctionne nativement sur Apple Silicon (M1/M2/M3) et Intel.

#### 2.2.2. Installation du Flutter SDK

**Méthode 1 : Téléchargement direct (Recommandé)**

**Étape 1 : Télécharger Flutter**

1. Visitez [https://docs.flutter.dev/get-started/install/macos](https://docs.flutter.dev/get-started/install/macos)
2. Téléchargez le fichier ZIP correspondant à votre architecture :
    - **Apple Silicon (M1/M2/M3)** : `flutter_macos_arm64_X.X.X-stable.zip`
    - **Intel** : `flutter_macos_X.X.X-stable.zip`

**Étape 2 : Extraire et déplacer Flutter**

Ouvrez le Terminal et exécutez :

```bash
# Créer un répertoire pour Flutter
mkdir -p ~/development

# Extraire le fichier ZIP (remplacez le chemin par votre fichier téléchargé)
cd ~/Downloads
unzip flutter_macos_*.zip

# Déplacer Flutter vers le répertoire de développement
mv flutter ~/development/
```

**Étape 3 : Ajouter Flutter au PATH**

Déterminez quel shell vous utilisez :

```bash
echo $SHELL
```

**Si vous utilisez Zsh (par défaut sur macOS Catalina+) :**

```bash
# Ouvrir le fichier de configuration
nano ~/.zshrc

# Ajouter cette ligne à la fin du fichier :
export PATH="$PATH:$HOME/development/flutter/bin"

# Sauvegarder (Ctrl+O, Enter, Ctrl+X)

# Recharger la configuration
source ~/.zshrc
```

**Si vous utilisez Bash :**

```bash
# Ouvrir le fichier de configuration
nano ~/.bash_profile

# Ajouter cette ligne à la fin du fichier :
export PATH="$PATH:$HOME/development/flutter/bin"

# Sauvegarder (Ctrl+O, Enter, Ctrl+X)

# Recharger la configuration
source ~/.bash_profile
```

**Étape 4 : Vérifier l'installation**

```bash
flutter --version
```

**Méthode 2 : Installation via Homebrew (Alternative)**

```bash
# Installer Homebrew si ce n'est pas déjà fait
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Installer Flutter
brew install --cask flutter

# Vérifier l'installation
flutter --version
```

#### 2.2.3. Installation de Xcode (pour iOS)

**Étape 1 : Installer Xcode**

1. Ouvrez l'App Store
2. Recherchez "Xcode"
3. Cliquez sur "Obtenir" puis "Installer" (environ 12 Go, peut prendre du temps)

Ou via le terminal :

```bash
xcode-select --install
```

**Étape 2 : Configurer Xcode**

```bash
# Accepter la licence Xcode
sudo xcodebuild -license accept

# Configurer les outils de ligne de commande
sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer

# Vérifier la configuration
sudo xcodebuild -runFirstLaunch
```

**Étape 3 : Installer CocoaPods**

CocoaPods est nécessaire pour gérer les dépendances iOS.

```bash
# Installer CocoaPods
sudo gem install cocoapods

# Vérifier l'installation
pod --version
```

> ⚠️ **Note pour Apple Silicon** : Si vous rencontrez des problèmes, utilisez :
> ```bash
> sudo gem install ffi
> sudo gem install cocoapods
> ```

#### 2.2.4. Installation d'Android Studio (pour Android)

Suivez les mêmes étapes que pour Windows (section 2.1.3), mais :

1. Téléchargez la version macOS d'Android Studio
2. Glissez Android Studio dans le dossier Applications
3. Lancez Android Studio et suivez l'assistant de configuration

**Configuration du PATH pour Android SDK :**

Ajoutez à votre `~/.zshrc` ou `~/.bash_profile` :

```bash
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/platform-tools
```

Puis rechargez :

```bash
source ~/.zshrc  # ou source ~/.bash_profile
```

#### 2.2.5. Configuration du simulateur iOS

**Étape 1 : Lister les simulateurs disponibles**

```bash
xcrun simctl list devices
```

**Étape 2 : Lancer un simulateur**

```bash
# Ouvrir le simulateur par défaut
open -a Simulator
```

Ou depuis Flutter :

```bash
# Lister les simulateurs Flutter
flutter emulators

# Lancer un simulateur spécifique
flutter emulators --launch apple_ios_simulator
```

**Étape 3 : Créer un nouveau simulateur (optionnel)**

1. Ouvrez Xcode
2. Allez dans **Window > Devices and Simulators**
3. Cliquez sur l'onglet **Simulators**
4. Cliquez sur le bouton **+** en bas à gauche
5. Sélectionnez un appareil (ex: iPhone 15 Pro)
6. Sélectionnez une version iOS (la plus récente)
7. Cliquez sur **Create**

#### 2.2.6. Dépannage macOS

**Problème : "xcrun: error: invalid active developer path"**

✅ **Solution :**

```bash
xcode-select --install
```

**Problème : "CocoaPods not installed"**

✅ **Solution :**

```bash
sudo gem install cocoapods
pod setup
```

**Problème : "Unable to boot simulator" sur Apple Silicon**

✅ **Solution :**

1. Assurez-vous d'utiliser un simulateur compatible ARM64
2. Mettez à jour Xcode vers la dernière version
3. Redémarrez votre Mac

**Problème : "ffi gem installation failed" sur Apple Silicon**

✅ **Solution :**

```bash
sudo arch -x86_64 gem install ffi
sudo gem install cocoapods
```

---

### 2.3. Installation sur Linux

#### 2.3.1. Configuration système requise

**Minimum :**

- Ubuntu 20.04 LTS ou équivalent (Debian, Fedora, Arch)
- 8 Go de RAM
- 10 Go d'espace disque

**Recommandé :**

- Ubuntu 22.04 LTS ou supérieur
- 16 Go de RAM
- 20 Go d'espace disque (SSD)
- Processeur Intel i5 ou AMD équivalent

**Distributions supportées :**

- Ubuntu / Debian
- Fedora
- Arch Linux
- Manjaro
- Linux Mint

#### 2.3.2. Installation des dépendances

**Pour Ubuntu/Debian :**

```bash
# Mettre à jour les paquets
sudo apt update

# Installer les dépendances requises
sudo apt install -y curl git unzip xz-utils zip libglu1-mesa

# Installer les bibliothèques supplémentaires pour le développement
sudo apt install -y clang cmake ninja-build pkg-config libgtk-3-dev
```

**Pour Fedora :**

```bash
# Installer les dépendances
sudo dnf install -y curl git unzip xz zip mesa-libGLU

# Installer les bibliothèques supplémentaires
sudo dnf install -y clang cmake ninja-build gtk3-devel
```

**Pour Arch Linux :**

```bash
# Installer les dépendances
sudo pacman -S curl git unzip xz zip glu

# Installer les bibliothèques supplémentaires
sudo pacman -S clang cmake ninja gtk3
```

#### 2.3.3. Installation du Flutter SDK

**Étape 1 : Télécharger Flutter**

```bash
# Créer un répertoire pour Flutter
mkdir -p ~/development
cd ~/development

# Télécharger Flutter (remplacez X.X.X par la version actuelle)
wget https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.16.0-stable.tar.xz

# Extraire l'archive
tar xf flutter_linux_*.tar.xz

# Supprimer l'archive (optionnel)
rm flutter_linux_*.tar.xz
```

**Étape 2 : Ajouter Flutter au PATH**

Déterminez quel shell vous utilisez :

```bash
echo $SHELL
```

**Pour Bash (par défaut sur Ubuntu) :**

```bash
# Ouvrir le fichier de configuration
nano ~/.bashrc

# Ajouter cette ligne à la fin du fichier :
export PATH="$PATH:$HOME/development/flutter/bin"

# Sauvegarder (Ctrl+O, Enter, Ctrl+X)

# Recharger la configuration
source ~/.bashrc
```

**Pour Zsh :**

```bash
# Ouvrir le fichier de configuration
nano ~/.zshrc

# Ajouter cette ligne à la fin du fichier :
export PATH="$PATH:$HOME/development/flutter/bin"

# Sauvegarder (Ctrl+O, Enter, Ctrl+X)

# Recharger la configuration
source ~/.zshrc
```

**Étape 3 : Vérifier l'installation**

```bash
flutter --version
```

#### 2.3.4. Installation d'Android Studio

**Étape 1 : Télécharger Android Studio**

**Pour Ubuntu/Debian (via Snap) :**

```bash
sudo snap install android-studio --classic
```

**Ou téléchargement manuel :**

1. Visitez [https://developer.android.com/studio](https://developer.android.com/studio)
2. Téléchargez le fichier `.tar.gz` pour Linux
3. Extrayez l'archive :

```bash
cd ~/Downloads
tar -xzf android-studio-*.tar.gz
sudo mv android-studio /opt/
```

4. Lancez Android Studio :

```bash
/opt/android-studio/bin/studio.sh
```

**Étape 2 : Configuration initiale**

1. Suivez l'assistant de configuration
2. Sélectionnez "Standard" pour le type d'installation
3. Attendez que tous les composants soient téléchargés

**Étape 3 : Configurer les variables d'environnement**

Ajoutez à votre `~/.bashrc` ou `~/.zshrc` :

```bash
export ANDROID_HOME=$HOME/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/platform-tools
export PATH=$PATH:$ANDROID_HOME/cmdline-tools/latest/bin
```

Rechargez la configuration :

```bash
source ~/.bashrc  # ou source ~/.zshrc
```

**Étape 4 : Accepter les licences Android**

```bash
flutter doctor --android-licenses
```

#### 2.3.5. Configuration de l'émulateur Android

**Étape 1 : Activer la virtualisation KVM**

Vérifiez si KVM est supporté :

```bash
egrep -c '(vmx|svm)' /proc/cpuinfo
```

Si le résultat est > 0, KVM est supporté.

Installez KVM :

```bash
# Ubuntu/Debian
sudo apt install -y qemu-kvm libvirt-daemon-system libvirt-clients bridge-utils

# Fedora
sudo dnf install -y @virtualization

# Arch
sudo pacman -S qemu libvirt virt-manager
```

Ajoutez votre utilisateur au groupe KVM :

```bash
sudo usermod -aG kvm $USER
sudo usermod -aG libvirt $USER
```

> ⚠️ **Important** : Déconnectez-vous et reconnectez-vous pour que les changements prennent effet.

**Étape 2 : Créer un appareil virtuel**

1. Lancez Android Studio
2. Cliquez sur **Tools > Device Manager**
3. Cliquez sur **Create Device**
4. Sélectionnez un appareil (recommandé : **Pixel 6**)
5. Cliquez sur **Next**
6. Sélectionnez une image système (recommandé : **API 34** - Android 14)
7. Cliquez sur **Download** si nécessaire, puis **Next**
8. Donnez un nom à votre émulateur
9. Cliquez sur **Finish**

**Étape 3 : Lancer l'émulateur**

```bash
flutter emulators --launch <nom_de_votre_emulateur>
```

#### 2.3.6. Dépannage Linux

**Problème : "flutter: command not found"**

✅ **Solution :**

1. Vérifiez que Flutter est dans le PATH
2. Rechargez votre shell : `source ~/.bashrc`
3. Redémarrez votre terminal

**Problème : "Unable to locate Android SDK"**

✅ **Solution :**

```bash
# Vérifiez que ANDROID_HOME est défini
echo $ANDROID_HOME

# Si vide, ajoutez à ~/.bashrc :
export ANDROID_HOME=$HOME/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/platform-tools
```

**Problème : L'émulateur ne démarre pas (KVM)**

✅ **Solution :**

```bash
# Vérifier que KVM est chargé
lsmod | grep kvm

# Si vide, charger le module
sudo modprobe kvm
sudo modprobe kvm_intel  # ou kvm_amd pour AMD

# Vérifier les permissions
ls -l /dev/kvm

# Ajouter l'utilisateur au groupe kvm
sudo usermod -aG kvm $USER
```

**Problème : "libGL error" lors du lancement de l'émulateur**

✅ **Solution :**

```bash
# Ubuntu/Debian
sudo apt install -y libgl1-mesa-glx libgl1-mesa-dri

# Fedora
sudo dnf install -y mesa-libGL mesa-dri-drivers
```

---

## 3. Configuration de VS Code

### 3.1. Installation de VS Code

**Windows :**

1. Téléchargez depuis [https://code.visualstudio.com/](https://code.visualstudio.com/)
2. Lancez l'installateur et suivez les instructions

**macOS :**

```bash
# Via Homebrew
brew install --cask visual-studio-code
```

**Linux (Ubuntu/Debian) :**

```bash
# Via Snap
sudo snap install code --classic

# Ou via apt
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
sudo apt update
sudo apt install code
```

### 3.2. Installation des extensions Flutter et Dart

**Méthode 1 : Via l'interface VS Code**

1. Ouvrez VS Code
2. Cliquez sur l'icône Extensions (ou `Ctrl+Shift+X` / `Cmd+Shift+X`)
3. Recherchez "Flutter"
4. Cliquez sur "Install" pour l'extension **Flutter** (par Dart Code)
    - Cela installera automatiquement l'extension **Dart** aussi

**Méthode 2 : Via la ligne de commande**

```bash
code --install-extension Dart-Code.flutter
code --install-extension Dart-Code.dart-code
```

### 3.3. Extensions recommandées supplémentaires

```bash
# Awesome Flutter Snippets (raccourcis de code)
code --install-extension Nash.awesome-flutter-snippets

# Pubspec Assist (aide pour pubspec.yaml)
code --install-extension jeroen-meijer.pubspec-assist

# Error Lens (affiche les erreurs inline)
code --install-extension usernamehw.errorlens

# Bracket Pair Colorizer (colore les parenthèses)
code --install-extension CoenraadS.bracket-pair-colorizer-2

# GitLens (meilleur support Git)
code --install-extension eamodio.gitlens
```

### 3.4. Configuration recommandée de VS Code

Créez ou modifiez le fichier `.vscode/settings.json` dans votre projet Flutter :

```json
{
  // Formatage automatique à la sauvegarde
  "editor.formatOnSave": true,
  // Utiliser le formateur Dart
  "editor.defaultFormatter": "Dart-Code.dart-code",
  // Longueur de ligne recommandée
  "dart.lineLength": 80,
  // Activer le hot reload automatique
  "dart.flutterHotReloadOnSave": "always",
  // Afficher les types inférés
  "dart.showInferredTypes": true,
  // Activer les suggestions de code
  "dart.enableCompletionCommitCharacters": true,
  // Fermer automatiquement les labels
  "dart.closingLabels": true,
  // Activer Flutter DevTools
  "dart.openDevTools": "flutter",
  // Exclure certains dossiers de la recherche
  "files.exclude": {
    "**/.dart_tool": true,
    "**/.flutter-plugins": true,
    "**/.flutter-plugins-dependencies": true,
    "**/.packages": true,
    "**/build": true
  }
}
```

### 3.5. Raccourcis clavier utiles

**Raccourcis Flutter essentiels :**

| Raccourci                        | Action                 | Description                          |
|----------------------------------|------------------------|--------------------------------------|
| `Ctrl+Shift+P` / `Cmd+Shift+P`   | Palette de commandes   | Accès à toutes les commandes Flutter |
| `F5`                             | Démarrer le débogage   | Lance l'application en mode debug    |
| `Ctrl+F5` / `Cmd+F5`             | Démarrer sans débogage | Lance l'application en mode release  |
| `Shift+F5`                       | Arrêter le débogage    | Arrête l'application                 |
| `Ctrl+Shift+F5` / `Cmd+Shift+F5` | Hot Restart            | Redémarre l'application              |
| `Ctrl+S` / `Cmd+S`               | Sauvegarder            | Déclenche le hot reload              |

**Raccourcis d'édition :**

| Raccourci                     | Action                          |
|-------------------------------|---------------------------------|
| `Ctrl+Space` / `Cmd+Space`    | Autocomplétion                  |
| `Ctrl+.` / `Cmd+.`            | Quick Fix (corrections rapides) |
| `F2`                          | Renommer un symbole             |
| `Ctrl+Click` / `Cmd+Click`    | Aller à la définition           |
| `Alt+Shift+F` / `Opt+Shift+F` | Formater le document            |
| `Ctrl+/` / `Cmd+/`            | Commenter/décommenter           |

**Commandes Flutter via la palette (`Ctrl+Shift+P`) :**

- `Flutter: New Project` - Créer un nouveau projet
- `Flutter: Run Flutter Doctor` - Vérifier l'installation
- `Flutter: Select Device` - Choisir l'appareil cible
- `Flutter: Hot Reload` - Recharger l'application
- `Flutter: Hot Restart` - Redémarrer l'application
- `Flutter: Open DevTools` - Ouvrir les outils de développement
- `Dart: Add Dependency` - Ajouter une dépendance

### 3.6. Configuration de Flutter DevTools

Flutter DevTools est un ensemble d'outils de performance et de débogage.

**Lancer DevTools :**

1. Démarrez votre application Flutter (`F5`)
2. Ouvrez la palette de commandes (`Ctrl+Shift+P` / `Cmd+Shift+P`)
3. Tapez "Flutter: Open DevTools"
4. Sélectionnez "Open DevTools in Web Browser"

**Ou via la ligne de commande :**

```bash
flutter pub global activate devtools
flutter pub global run devtools
```

**Fonctionnalités de DevTools :**

- 🔍 **Inspector** : Visualiser l'arbre des widgets
- 📊 **Performance** : Analyser les performances de l'application
- 💾 **Memory** : Détecter les fuites mémoire
- 🐛 **Debugger** : Déboguer le code Dart
- 📡 **Network** : Surveiller les requêtes réseau
- 📝 **Logging** : Voir les logs de l'application

---

## 4. Vérification et tests

### 4.1. Exécuter Flutter Doctor

La commande `flutter doctor` vérifie que tout est correctement installé.

```bash
flutter doctor -v
```

**Sortie attendue (exemple) :**

```
[✓] Flutter (Channel stable, 3.16.0, on macOS 14.0 23A344 darwin-arm64, locale fr-FR)
    • Flutter version 3.16.0 on channel stable
    • Upstream repository https://github.com/flutter/flutter.git
    • Framework revision db7ef5bf9f (il y a 2 semaines), 2023-11-15 11:25:44 -0800
    • Engine revision 74d16627b9
    • Dart version 3.2.0
    • DevTools version 2.28.2

[✓] Android toolchain - develop for Android devices (Android SDK version 34.0.0)
    • Android SDK at /Users/username/Library/Android/sdk
    • Platform android-34, build-tools 34.0.0
    • Java binary at: /Applications/Android Studio.app/Contents/jbr/Contents/Home/bin/java
    • Java version OpenJDK Runtime Environment (build 17.0.6+0-17.0.6b829.9-10027231)
    • All Android licenses accepted.

[✓] Xcode - develop for iOS and macOS (Xcode 15.0)
    • Xcode at /Applications/Xcode.app/Contents/Developer
    • Build 15A240d
    • CocoaPods version 1.13.0

[✓] Chrome - develop for the web
    • Chrome at /Applications/Google Chrome.app/Contents/MacOS/Google Chrome

[✓] Android Studio (version 2023.1)
    • Android Studio at /Applications/Android Studio.app
    • Flutter plugin version 77.1.2
    • Dart plugin version 231.8770
    • Java version OpenJDK Runtime Environment (build 17.0.6+0-17.0.6b829.9-10027231)

[✓] VS Code (version 1.84.2)
    • VS Code at /Applications/Visual Studio Code.app/Contents
    • Flutter extension version 3.76.0

[✓] Connected device (3 available)
    • iPhone 15 Pro (mobile) • 12345678-ABCD-1234-ABCD-123456789ABC • ios • com.apple.CoreSimulator.SimRuntime.iOS-17-0 (simulator)
    • macOS (desktop)        • macos                                • darwin-arm64 • macOS 14.0 23A344 darwin-arm64
    • Chrome (web)           • chrome                               • web-javascript • Google Chrome 119.0.6045.105

[✓] Network resources
    • All expected network resources are available.

• No issues found!
```

### 4.2. Interpréter les résultats

**Symboles :**

- `[✓]` : Tout est OK
- `[!]` : Avertissement (non bloquant)
- `[✗]` : Erreur (à corriger)

**Problèmes courants :**

**`[✗] Android toolchain`**

```
✅ Solution : Exécutez `flutter doctor --android-licenses`
```

**`[!] Android Studio (not installed)`**

```
✅ Solution : Installez Android Studio (voir section 2.1.3 / 2.2.4 / 2.3.4)
```

**`[✗] Xcode (not installed)` (macOS uniquement)**

```
✅ Solution : Installez Xcode depuis l'App Store
```

**`[!] CocoaPods not installed` (macOS uniquement)**

```
✅ Solution : Exécutez `sudo gem install cocoapods`
```

### 4.3. Créer un projet de test

**Via VS Code :**

1. Ouvrez VS Code
2. Appuyez sur `Ctrl+Shift+P` / `Cmd+Shift+P`
3. Tapez "Flutter: New Project"
4. Sélectionnez "Application"
5. Choisissez un emplacement pour le projet
6. Donnez un nom au projet (ex: `test_flutter`)
7. Attendez que le projet soit créé

**Via la ligne de commande :**

```bash
# Créer un nouveau projet
flutter create test_flutter

# Aller dans le répertoire du projet
cd test_flutter

# Ouvrir dans VS Code
code .
```

### 4.4. Lancer l'application de test

**Étape 1 : Sélectionner un appareil**

1. En bas à droite de VS Code, cliquez sur "No Device Selected"
2. Sélectionnez un émulateur/simulateur ou un appareil physique

Ou via la ligne de commande :

```bash
# Lister les appareils disponibles
flutter devices

# Lancer un émulateur Android
flutter emulators --launch <nom_emulateur>

# Lancer le simulateur iOS (macOS uniquement)
open -a Simulator
```

**Étape 2 : Lancer l'application**

**Via VS Code :**

- Appuyez sur `F5` ou cliquez sur "Run > Start Debugging"

**Via la ligne de commande :**

```bash
flutter run
```

**Résultat attendu :**

Vous devriez voir l'application de démonstration Flutter avec un compteur qui s'incrémente quand vous appuyez sur le
bouton `+`.

### 4.5. Tester le Hot Reload

1. Avec l'application en cours d'exécution, ouvrez `lib/main.dart`
2. Modifiez le texte à la ligne ~11 :
   ```dart
   title: 'Flutter Demo Home Page',
   ```
   en :
   ```dart
   title: 'Mon Application Test',
   ```
3. Sauvegardez le fichier (`Ctrl+S` / `Cmd+S`)
4. Observez l'application se mettre à jour instantanément !

> 💡 **Hot Reload** : Les changements apparaissent en moins d'une seconde sans perdre l'état de l'application.

### 4.6. Tester sur un appareil physique (optionnel)

**Android :**

1. Activez le mode développeur sur votre téléphone :
    - Allez dans **Paramètres > À propos du téléphone**
    - Tapez 7 fois sur "Numéro de build"
2. Activez le débogage USB :
    - Allez dans **Paramètres > Options pour les développeurs**
    - Activez "Débogage USB"
3. Connectez votre téléphone via USB
4. Autorisez le débogage USB sur votre téléphone
5. Vérifiez que l'appareil est détecté :
   ```bash
   flutter devices
   ```

**iOS (macOS uniquement) :**

1. Connectez votre iPhone/iPad via USB
2. Faites confiance à votre ordinateur sur l'appareil
3. Ouvrez Xcode et allez dans **Window > Devices and Simulators**
4. Vérifiez que votre appareil est listé
5. Dans VS Code, sélectionnez votre appareil
6. Lancez l'application (`F5`)

> ⚠️ **Note** : Pour déployer sur un appareil iOS physique, vous aurez besoin d'un compte développeur Apple (gratuit
> pour les tests).

---

## 5. Créer votre premier écran rapidement

### 5.1. Créer un nouveau projet

```bash
flutter create ma_premiere_app
cd ma_premiere_app
code .
```

### 5.2. Comprendre la structure du projet

```
ma_premiere_app/
├── android/          # Code spécifique Android
├── ios/              # Code spécifique iOS
├── lib/              # 📁 Code Dart de votre application
│   └── main.dart     # 📄 Point d'entrée de l'application
├── test/             # Tests unitaires
├── pubspec.yaml      # 📦 Dépendances et configuration
└── README.md         # Documentation
```

**Fichiers importants :**

- **`lib/main.dart`** : Point d'entrée de l'application
- **`pubspec.yaml`** : Gestion des dépendances (comme `package.json` en Node.js)
- **`android/` et `ios/`** : Configuration native (rarement modifiés)

### 5.3. Créer un écran personnalisé simple

Remplacez tout le contenu de `lib/main.dart` par ce code :

```dart
import 'package:flutter/material.dart';

// Point d'entrée de l'application
void main() {
  runApp(const MonApplication());
}

// Widget racine de l'application
class MonApplication extends StatelessWidget {
  const MonApplication({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ma Première App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const EcranAccueil(),
    );
  }
}

// Écran d'accueil avec état (StatefulWidget)
class EcranAccueil extends StatefulWidget {
  const EcranAccueil({super.key});

  @override
  State<EcranAccueil> createState() => _EcranAccueilState();
}

// État de l'écran d'accueil
class _EcranAccueilState extends State<EcranAccueil> {
  // Variable d'état : compteur
  int _compteur = 0;

  // Méthode pour incrémenter le compteur
  void _incrementer() {
    setState(() {
      _compteur++;
    });
  }

  // Méthode pour réinitialiser le compteur
  void _reinitialiser() {
    setState(() {
      _compteur = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Barre d'application en haut
      appBar: AppBar(
        backgroundColor: Theme
            .of(context)
            .colorScheme
            .inversePrimary,
        title: const Text('Mon Premier Écran'),
        actions: [
          // Bouton pour réinitialiser
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _reinitialiser,
            tooltip: 'Réinitialiser',
          ),
        ],
      ),

      // Corps de l'écran
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icône
            Icon(
              Icons.favorite,
              size: 100,
              color: Colors.red[400],
            ),

            const SizedBox(height: 20),

            // Titre
            const Text(
              'Bienvenue dans Flutter !',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            // Sous-titre
            const Text(
              'Vous avez appuyé sur le bouton :',
              style: TextStyle(fontSize: 16),
            ),

            const SizedBox(height: 10),

            // Affichage du compteur
            Text(
              '$_compteur',
              style: Theme
                  .of(context)
                  .textTheme
                  .headlineLarge
                  ?.copyWith(
                color: Colors.deepPurple,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            // Texte conditionnel
            Text(
              _compteur == 0
                  ? 'Appuyez sur le bouton +'
                  : _compteur == 1
                  ? 'Première fois !'
                  : 'Vous êtes motivé ! 🎉',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
                fontStyle: FontStyle.italic,
              ),
            ),

            const SizedBox(height: 30),

            // Bouton personnalisé
            ElevatedButton.icon(
              onPressed: _incrementer,
              icon: const Icon(Icons.add),
              label: const Text('Incrémenter'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 15,
                ),
              ),
            ),

            const SizedBox(height: 10),

            // Bouton secondaire
            OutlinedButton.icon(
              onPressed: () {
                // Afficher un message
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Bouton secondaire cliqué !'),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
              icon: const Icon(Icons.info),
              label: const Text('Afficher un message'),
            ),
          ],
        ),
      ),

      // Bouton flottant en bas à droite
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementer,
        tooltip: 'Incrémenter',
        child: const Icon(Icons.add),
      ),
    );
  }
}
```

### 5.4. Comprendre le code

**Structure de base :**

```dart
void main() => runApp(const MonApplication());
```

- Point d'entrée de l'application
- `runApp()` lance l'application Flutter

**Widget racine (StatelessWidget) :**

```dart
class MonApplication extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(...);
  }
}
```

- `StatelessWidget` : Widget sans état (ne change pas)
- `MaterialApp` : Configuration de l'application (thème, routes, etc.)

**Widget avec état (StatefulWidget) :**

```dart
class EcranAccueil extends StatefulWidget {
  @override
  State<EcranAccueil> createState() => _EcranAccueilState();
}

class _EcranAccueilState extends State<EcranAccueil> {
  int _compteur = 0; // Variable d'état

  void _incrementer() {
    setState(() { // Mise à jour de l'état
      _compteur++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(...);
  }
}
```

- `StatefulWidget` : Widget avec état (peut changer)
- `setState()` : Déclenche la reconstruction du widget
- Variables privées : préfixe `_`

**Widgets de mise en page :**

- `Scaffold` : Structure de base d'un écran (AppBar, Body, FAB)
- `Column` : Disposition verticale
- `Row` : Disposition horizontale
- `Center` : Centre son enfant
- `SizedBox` : Espace vide de taille fixe

**Widgets d'affichage :**

- `Text` : Affiche du texte
- `Icon` : Affiche une icône
- `ElevatedButton` : Bouton avec élévation
- `OutlinedButton` : Bouton avec bordure
- `FloatingActionButton` : Bouton flottant

### 5.5. Lancer l'application

1. Sélectionnez un appareil (émulateur/simulateur)
2. Appuyez sur `F5` ou exécutez :
   ```bash
   flutter run
   ```

3. Testez les fonctionnalités :
    - Appuyez sur le bouton `+` (en bas à droite ou au centre)
    - Cliquez sur "Afficher un message"
    - Cliquez sur l'icône de rafraîchissement en haut à droite

### 5.6. Démonstration du Hot Reload

**Essayez ces modifications en direct :**

1. **Changer la couleur de l'icône** (ligne ~78) :
   ```dart
   color: Colors.red[400],  // Essayez: Colors.blue, Colors.green, etc.
   ```

2. **Modifier le texte** (ligne ~84) :
   ```dart
   'Bienvenue dans Flutter !',  // Changez le message
   ```

3. **Changer la taille de l'icône** (ligne ~76) :
   ```dart
   size: 100,  // Essayez: 150, 200, etc.
   ```

4. **Modifier le thème** (ligne ~17) :
   ```dart
   seedColor: Colors.deepPurple,  // Essayez: Colors.teal, Colors.orange, etc.
   ```

Sauvegardez après chaque modification (`Ctrl+S` / `Cmd+S`) et observez les changements instantanés !

### 5.7. Ajouter la navigation (optionnel)

Créez un deuxième écran. Ajoutez ce code à la fin de `lib/main.dart` :

```dart
// Deuxième écran
class EcranDetails extends StatelessWidget {
  final int compteur;

  const EcranDetails({super.key, required this.compteur});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Détails'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.info_outline,
              size: 80,
              color: Colors.blue,
            ),
            const SizedBox(height: 20),
            const Text(
              'Écran de détails',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              'Valeur du compteur : $compteur',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pop(context); // Retour à l'écran précédent
              },
              icon: const Icon(Icons.arrow_back),
              label: const Text('Retour'),
            ),
          ],
        ),
      ),
    );
  }
}
```

Puis, dans `_EcranAccueilState`, ajoutez un bouton pour naviguer :

```dart
// Ajoutez ce bouton dans la Column, après OutlinedButton
const SizedBox
(
height: 10),

FilledButton.icon(
onPressed: () {
// Navigation vers le deuxième écran
Navigator.push(
context,
MaterialPageRoute(
builder: (context) => EcranDetails(compteur: _compteur),
),
);
},
icon: const Icon(Icons.arrow_forward),
label: const Text('Voir les détails'),
)
,
```

**Testez la navigation :**

1. Cliquez sur "Voir les détails"
2. Observez le deuxième écran avec la valeur du compteur
3. Cliquez sur "Retour" ou utilisez le bouton retour du système

---

## 6. Référence rapide

### 6.1. Commandes Flutter essentielles

```bash
# Vérifier l'installation
flutter doctor
flutter doctor -v

# Créer un nouveau projet
flutter create nom_projet
flutter create --org com.monentreprise nom_projet

# Lancer l'application
flutter run
flutter run -d <device_id>
flutter run --release  # Mode release (optimisé)

# Gérer les appareils
flutter devices
flutter emulators
flutter emulators --launch <emulator_id>

# Gestion des dépendances
flutter pub get          # Télécharger les dépendances
flutter pub add <package>  # Ajouter une dépendance
flutter pub upgrade      # Mettre à jour les dépendances
flutter pub outdated     # Voir les dépendances obsolètes

# Nettoyage et build
flutter clean            # Nettoyer le projet
flutter build apk        # Build Android APK
flutter build ios        # Build iOS (macOS uniquement)
flutter build web        # Build Web

# Tests
flutter test             # Lancer les tests
flutter test --coverage  # Avec couverture de code

# Analyse du code
flutter analyze          # Analyser le code
flutter format .         # Formater le code

# Mise à jour de Flutter
flutter upgrade          # Mettre à jour Flutter
flutter channel          # Voir les canaux disponibles
flutter channel stable   # Changer de canal
```

### 6.2. Raccourcis VS Code pour Flutter

| Raccourci                        | Action                   |
|----------------------------------|--------------------------|
| `Ctrl+Shift+P` / `Cmd+Shift+P`   | Palette de commandes     |
| `F5`                             | Lancer en mode debug     |
| `Ctrl+F5` / `Cmd+F5`             | Lancer sans debug        |
| `Shift+F5`                       | Arrêter                  |
| `Ctrl+Shift+F5` / `Cmd+Shift+F5` | Hot Restart              |
| `Ctrl+S` / `Cmd+S`               | Sauvegarder (Hot Reload) |
| `Ctrl+.` / `Cmd+.`               | Quick Fix                |
| `F2`                             | Renommer                 |
| `Ctrl+Space` / `Cmd+Space`       | Autocomplétion           |
| `Alt+Shift+F` / `Opt+Shift+F`    | Formater                 |

### 6.3. Snippets utiles dans VS Code

Tapez ces raccourcis puis `Tab` :

- `stless` → StatelessWidget
- `stful` → StatefulWidget
- `build` → Méthode build
- `initState` → Méthode initState
- `dispose` → Méthode dispose
- `setState` → setState(() {})

### 6.4. Ressources et documentation

**Documentation officielle :**

- 📚 [Flutter.dev](https://flutter.dev) - Documentation officielle
- 📖 [API Reference](https://api.flutter.dev) - Référence API complète
- 🎓 [Flutter Codelabs](https://docs.flutter.dev/codelabs) - Tutoriels interactifs
- 🎬 [Flutter YouTube](https://www.youtube.com/c/flutterdev) - Vidéos officielles

**Packages et plugins :**

- 📦 [pub.dev](https://pub.dev) - Dépôt de packages Dart/Flutter
- 🔌 [Flutter Awesome](https://flutterawesome.com) - Liste de packages populaires

**Communauté :**

- 💬 [Stack Overflow](https://stackoverflow.com/questions/tagged/flutter) - Questions/Réponses
- 💬 [Reddit r/FlutterDev](https://reddit.com/r/FlutterDev) - Communauté Reddit
- 💬 [Discord Flutter](https://discord.gg/flutter) - Chat en direct
- 🐦 [Twitter #FlutterDev](https://twitter.com/hashtag/FlutterDev) - Actualités

**Outils de développement :**

- 🛠️ [DartPad](https://dartpad.dev) - Éditeur Dart en ligne
- 🛠️ [FlutLab](https://flutlab.io) - IDE Flutter en ligne
- 🛠️ [Zapp!](https://zapp.run) - Éditeur Flutter en ligne

**Tutoriels et cours :**

- 🎓 [Flutter by Example](https://flutterbyexample.com)
- 🎓 [Flutter Crash Course](https://www.youtube.com/watch?v=1xipg02Wu8s) (Traversy Media)
- 🎓 [The Net Ninja - Flutter](https://www.youtube.com/playlist?list=PL4cUxeGkcC9jLYyp2Aoh6hcWuxFDX6PBJ)

### 6.5. Prochaines étapes

**Pour approfondir Flutter :**

1. **Semaine 1-2 : Bases**
    - Comprendre les widgets (Stateless vs Stateful)
    - Maîtriser les layouts (Column, Row, Stack, etc.)
    - Apprendre la navigation

2. **Semaine 3-4 : Intermédiaire**
    - Gestion d'état (Provider, Riverpod, Bloc)
    - Appels API et JSON
    - Formulaires et validation

3. **Semaine 5-6 : Avancé**
    - Animations
    - Base de données locale (SQLite, Hive)
    - Tests (unitaires, widgets, intégration)

4. **Semaine 7-8 : Production**
    - Architecture (Clean Architecture, MVVM)
    - CI/CD
    - Publication sur les stores

**Projets pratiques suggérés :**

1. **Todo List** : CRUD basique, gestion d'état
2. **Application météo** : API, affichage de données
3. **Chat** : Firebase, temps réel
4. **E-commerce** : Navigation complexe, panier
5. **Jeu simple** : Animations, gestures

---

## Conclusion

🎉 **Félicitations !** Vous avez maintenant :

✅ Installé Flutter sur votre système
✅ Configuré VS Code pour le développement Flutter
✅ Vérifié votre installation avec `flutter doctor`
✅ Créé et lancé votre première application Flutter
✅ Compris les bases des widgets et de la gestion d'état
✅ Expérimenté le Hot Reload

### Points clés à retenir

1. **Flutter = Multi-plateforme** : Un code, plusieurs plateformes
2. **Hot Reload = Productivité** : Voir les changements instantanément
3. **Tout est widget** : L'interface est construite avec des widgets
4. **StatelessWidget vs StatefulWidget** : Avec ou sans état
5. **`setState()`** : Pour mettre à jour l'interface

### En cas de problème

1. **Consultez `flutter doctor`** : Il détecte la plupart des problèmes
2. **Cherchez sur Stack Overflow** : La communauté est très active
3. **Lisez la documentation officielle** : Elle est excellente
4. **Rejoignez Discord Flutter** : Aide en temps réel

### Message final

Flutter est un framework puissant et moderne. La courbe d'apprentissage est douce, et vous serez rapidement productif.
N'hésitez pas à expérimenter, à casser des choses, et à apprendre de vos erreurs.

**"The best way to learn Flutter is to build something with it."**

Bon développement ! 🚀

---

**Document créé pour le cours Master 1 ITI - Génie Logiciel Moderne**
**Dernière mise à jour : 2025**

> 💡 **Astuce** : Vous pouvez aussi lancer l'émulateur depuis le terminal :
> ```bash
> flutter emulators --launch Pixel_6_API_34
> ```
