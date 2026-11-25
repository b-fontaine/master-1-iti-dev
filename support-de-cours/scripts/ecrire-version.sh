#!/usr/bin/env bash
# Écrit support-de-cours/_version.yml et styles/version.tex : numéro de version
# et date imprimés dans le livre (avant-propos, page de titre, verso du titre du PDF).
# Usage : ecrire-version.sh <version> [AAAA-MM-JJ]   (date du jour par défaut)
# Les fichiers versionnés contiennent la version « de travail » ;
# la CI les réécrit avant chaque compilation.
set -euo pipefail

version="${1:?usage : ecrire-version.sh <version> [AAAA-MM-JJ]}"
jour="${2:-$(date +%Y-%m-%d)}"
[[ "$jour" =~ ^([0-9]{4})-([0-9]{2})-([0-9]{2})$ ]] || { echo "date invalide : $jour" >&2; exit 2; }

mois=(janvier février mars avril mai juin juillet août septembre octobre novembre décembre)
annee="${BASH_REMATCH[1]}"
m=$((10#${BASH_REMATCH[2]}))
j=$((10#${BASH_REMATCH[3]}))
{ [ "$m" -ge 1 ] && [ "$m" -le 12 ]; } || { echo "mois invalide : $jour" >&2; exit 2; }
[ "$j" -eq 1 ] && j="1er"
date_fr="$j ${mois[$((m - 1))]} $annee"

racine="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

cat >"$racine/_version.yml" <<FIN
# Généré par scripts/ecrire-version.sh : ne pas modifier à la main.
version: "$version"
version-date: "$date_fr"
book:
  date: "$jour"
FIN

cat >"$racine/styles/version.tex" <<FIN
% Généré par scripts/ecrire-version.sh : ne pas modifier à la main.
\\def\\versionlivre{$version}
\\def\\datelivre{$date_fr}
FIN

echo "version $version du $date_fr écrite dans _version.yml et styles/version.tex"
