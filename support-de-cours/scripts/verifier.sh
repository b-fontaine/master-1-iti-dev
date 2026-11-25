#!/usr/bin/env bash
# Vérifie le livre : interdits absolus, commentaires source, rendu PDF et EPUB.
# Usage : verifier.sh [--no-render]
set -u
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
RENDER=1
[ "${1:-}" = "--no-render" ] && RENDER=0
ERR=0
fail() { echo "ERREUR : $*" >&2; ERR=1; }

[ -f "$DIR/_quarto.yml" ] || { echo "ERREUR : _quarto.yml introuvable dans $DIR" >&2; exit 1; }

mapfile -t QMD < <(find "$DIR" -name '*.qmd' -not -path '*/_book/*' -not -path '*/.quarto/*' | sort)

# 1. Interdits absolus
for f in "${QMD[@]}"; do
  rel="${f#"$DIR"/}"
  grep -n -F -e '/tmp/' -e 'Checklist enseignant' "$f" | sed "s|^|$rel:|" | while read -r l; do echo "ERREUR interdit : $l" >&2; done
  grep -n -i -e 'à compléter' -e 'ne pas diffuser' "$f" | sed "s|^|$rel:|" | while read -r l; do echo "ERREUR interdit : $l" >&2; done
  if grep -n -i -e '/tmp/' -e 'Checklist enseignant' -e 'à compléter' -e 'ne pas diffuser' "$f" >/dev/null; then ERR=1; fi
  # adresses électroniques, sauf users.noreply.github.com
  if grep -n -o -E '[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}' "$f" | grep -v -E '@users\.noreply\.github\.com$' | sed "s|^|$rel:|" | grep . >&2; then
    fail "adresse électronique interdite dans $rel"
  fi
done

# 2. Commentaire source en tête de chaque .qmd
for f in "${QMD[@]}"; do
  rel="${f#"$DIR"/}"
  head -n 12 "$f" | grep -q -E '^<!-- source: .+ · synchro: [0-9]{4}-[0-9]{2}-[0-9]{2} -->$' \
    || fail "commentaire « source: » manquant ou mal formé : $rel"
done

# 3. Tournures de séance (avertissement)
for f in "${QMD[@]}"; do
  rel="${f#"$DIR"/}"
  grep -n -i -E 'pendant la séance|pendant l.atelier|aujourd.hui|avant le [0-9]|chapitre [0-9]+ de la séance' "$f" \
    | sed "s|^|AVERTISSEMENT tournure : $rel:|" || true
done

# 4. Rendu
if [ "$RENDER" = 1 ]; then
  LOG="$(mktemp)"
  # un seul rendu pour les deux formats : un rendu isolé vide _book/
  if ! quarto render "$DIR" >"$LOG" 2>&1; then
    cat "$LOG" >&2; fail "échec du rendu"
  fi
  if grep -n -E 'Unable to resolve crossref|WARNING|Missing character' "$LOG" >&2; then
    fail "avertissements dans le rendu"
  fi
  rm -f "$LOG"
  ls "$DIR"/_book/*.pdf "$DIR"/_book/*.epub >/dev/null 2>&1 || fail "PDF ou EPUB absent de _book/"
fi

if [ "$ERR" = 0 ]; then echo "OK : vérification réussie."; else echo "ÉCHEC de la vérification." >&2; fi
exit "$ERR"
