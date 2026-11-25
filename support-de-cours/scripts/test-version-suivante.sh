#!/usr/bin/env bash
# Tests de version-suivante.sh sur des dépôts git jetables.
# Usage : bash support-de-cours/scripts/test-version-suivante.sh
set -u
SCRIPT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/version-suivante.sh"
ECHECS=0

# Crée un dépôt vide dans un dossier temporaire et s'y place.
nouveau_depot() {
  cd "$(mktemp -d)" || exit 1
  git init -q -b main
  git config user.name test
  git config user.email test@example.invalid
  mkdir -p support-de-cours autre
}

# commit <dossier> <message> : modifie un fichier du dossier et commite.
commit() {
  echo "$RANDOM" >> "$1/fichier.txt"
  git add "$1/fichier.txt"
  git commit -q -m "$2"
}

attendu() { # attendu <nom du cas> <valeur attendue> <commande…>
  local nom="$1" voulu="$2"; shift 2
  local obtenu code
  obtenu="$("$@" 2>/dev/null)"; code=$?
  [ "$code" -ne 0 ] && obtenu="code:$code"
  if [ "$obtenu" = "$voulu" ]; then echo "ok   - $nom"
  else echo "ÉCHEC - $nom : attendu « $voulu », obtenu « $obtenu »"; ECHECS=$((ECHECS + 1)); fi
}

nouveau_depot
commit support-de-cours "feat(livre): premier jet"
attendu "sans tag, première version 1.0.0" "1.0.0" bash "$SCRIPT"

git tag livre-v1.0.0
attendu "rien depuis le tag : code 3" "code:3" bash "$SCRIPT"

commit autre "feat: hors du livre"
attendu "commit hors du livre ignoré : code 3" "code:3" bash "$SCRIPT"

commit support-de-cours "fix(livre): coquille"
attendu "fix → correctif" "1.0.1" bash "$SCRIPT"

commit support-de-cours "docs(livre): reformulation"
attendu "autre type → correctif" "1.0.1" bash "$SCRIPT"

commit support-de-cours "feat(livre): séance 3"
attendu "feat → mineure (remet le correctif à 0)" "1.1.0" bash "$SCRIPT"

commit support-de-cours "feat(livre)!: nouvelle structure"
attendu "! → majeure" "2.0.0" bash "$SCRIPT"

git tag livre-v2.0.0
commit support-de-cours "$(printf 'fix(livre): renvois\n\nBREAKING CHANGE: identifiants renommés')"
attendu "BREAKING CHANGE dans le corps → majeure" "3.0.0" bash "$SCRIPT"

git tag 2025-2026
attendu "un tag étranger est ignoré" "3.0.0" bash "$SCRIPT"

attendu "--notes liste les sujets touchant le livre" "- fix(livre): renvois" bash "$SCRIPT" --notes

nouveau_depot
commit support-de-cours "feat(livre): a"
git tag livre-v1.4.2
commit support-de-cours "Merge pull request #9 from x/y"
attendu "commit de fusion seul → correctif" "1.4.3" bash "$SCRIPT"

if [ "$ECHECS" -eq 0 ]; then echo "Tous les cas passent."; else echo "$ECHECS cas en échec."; fi
exit "$ECHECS"
