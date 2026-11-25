#!/usr/bin/env bash
# Calcule la prochaine version du livre (SemVer) à partir des commits qui
# touchent support-de-cours/ depuis le dernier tag livre-vX.Y.Z.
#   - aucun tag livre-v*            → 1.0.0 (première publication)
#   - « type(portée)!: » ou « BREAKING CHANGE » → version majeure
#   - « feat(portée): »             → version mineure
#   - tout autre commit             → correctif
# Usage : version-suivante.sh           affiche X.Y.Z
#         version-suivante.sh --notes   affiche la liste des commits concernés
#         version-suivante.sh --tag     affiche le dernier tag (vide s'il n'y en a pas)
# Code de sortie 3 : aucun commit ne touche le livre depuis le dernier tag.
set -euo pipefail

PREFIXE="livre-v"
DOSSIER="support-de-cours"
cd "$(git rev-parse --show-toplevel)"

dernier="$(git describe --tags --abbrev=0 --match "${PREFIXE}[0-9]*.[0-9]*.[0-9]*" 2>/dev/null || true)"
if [ "${1:-}" = "--tag" ]; then echo "$dernier"; exit 0; fi
plage="${dernier:+$dernier..}HEAD"

# Messages complets (sujet + corps) des commits qui touchent le livre
messages="$(git log --format='%B' "$plage" -- "$DOSSIER")"
if [ -z "${messages//[[:space:]]/}" ]; then
  depuis="${dernier:-le début}"
  echo "Aucun commit ne touche $DOSSIER depuis $depuis." >&2
  exit 3
fi

if [ "${1:-}" = "--notes" ]; then
  git log --no-merges --format='- %s' "$plage" -- "$DOSSIER"
  exit 0
fi

if [ -z "$dernier" ]; then echo "1.0.0"; exit 0; fi

IFS=. read -r majeure mineure correctif <<<"${dernier#"$PREFIXE"}"
if grep -q -E '^[a-z]+(\([^)]*\))?!:|^BREAKING[ -]CHANGE' <<<"$messages"; then
  echo "$((majeure + 1)).0.0"
elif grep -q -E '^feat(\([^)]*\))?:' <<<"$messages"; then
  echo "$majeure.$((mineure + 1)).0"
else
  echo "$majeure.$mineure.$((correctif + 1))"
fi
