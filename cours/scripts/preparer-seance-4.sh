#!/usr/bin/env bash
# Prépare les dépôts d'équipe pour la séance 4 : active GitHub Pages (source
# « GitHub Actions »), puis rend la CI obligatoire sur main et demande la
# relecture des propriétaires du code (fichier CODEOWNERS).
#
# usage : ./preparer-seance-4.sh <organisation> <themes.csv>
#   themes.csv : le fichier donné à creer-depots.sh, une équipe par ligne,
#   "numero_equipe,theme" (ex. 01,A). Seul le numéro est lu.
#
# Prérequis : bash 4 ou plus et GNU sed ; `gh` authentifié avec les droits
# d'administration sur les dépôts equipe_NN (les étudiants ne les ont pas :
# ni Pages ni la protection ne peuvent être réglés par eux).
#
# Pour chaque dépôt equipe_NN :
#   1. GitHub Pages est activé avec la source « GitHub Actions » (rien n'est
#      publié tant que le workflow complet n'a pas tourné sur main) ;
#   2. si le workflow complet (docs/seance-4/ci.yml du dépôt-modèle) est déjà
#      fusionné dans main, la protection de main exige en plus les contrôles
#      `analyse-et-tests`, `securite` et `site-web` et la relecture des
#      propriétaires du code ; sinon la protection n'est pas touchée et le
#      dépôt est signalé : exiger un contrôle qui n'existe pas encore
#      bloquerait toutes les PR ;
#   3. le fichier .github/CODEOWNERS est contrôlé : absent ou invalide, la
#      relecture des propriétaires du code est sans effet, et le dépôt est
#      signalé.
#
# Le script peut être relancé : ce qui est déjà fait n'est pas refait. Le
# lancer une première fois avant la séance (Pages), puis le relancer quand
# les équipes ont fusionné leur workflow (protection) et leur CODEOWNERS.
#
# À savoir :
#   - la protection de main est réécrite en entier à chaque lancement : un
#     réglage ajouté à la main dans l'interface serait effacé ;
#   - une PR ouverte avant la fusion du workflow complet n'a pas lancé les
#     nouveaux contrôles : elle reste en attente jusqu'à ce que sa branche
#     soit mise à jour (bouton « Update branch » ou nouveau commit).
set -euo pipefail

if [ $# -ne 2 ]; then
  sed -n '2,36p' "$0" >&2
  exit 2
fi
ORG="$1"; THEMES="$2"

refus() { echo "Erreur : $*" >&2; exit 1; }

# Même lecture que creer-depots.sh : BOM, fins de ligne Windows, point-virgule,
# espaces autour des champs, zéro de tête d'un numéro à un chiffre, lignes vides.
lire() {
  sed -e '1s/^\xEF\xBB\xBF//' -e 's/\r$//' "$1" \
    | sed -E -e 's/;/,/g' -e 's/^[[:space:]]+//' -e 's/[[:space:]]+$//' \
        -e 's/[[:space:]]*,[[:space:]]*/,/g' -e 's/^([0-9]),/0\1,/' \
    | grep -v '^,*$'
}

[ -r "$THEMES" ] || refus "fichier des thèmes illisible : $THEMES"

NUMEROS=()
while IFS=, read -r num _; do
  [[ "$num" =~ ^[0-9]{2}$ ]] || refus "$THEMES : numéro d'équipe « $num » mal formé (attendu : 01)"
  NUMEROS+=("$num")
done < <(lire "$THEMES")
[ "${#NUMEROS[@]}" -gt 0 ] || refus "$THEMES : aucune équipe"

# Tous les dépôts doivent exister, avec les droits d'administration, avant
# qu'on en modifie un seul (un dépôt public répond même sans aucun droit).
for num in "${NUMEROS[@]}"; do
  admin="$(gh api "repos/$ORG/equipe_$num" --jq .permissions.admin 2>/dev/null)" \
    || refus "dépôt $ORG/equipe_$num introuvable : rien n'a été modifié"
  [ "$admin" = "true" ] \
    || refus "droits d'administration absents sur $ORG/equipe_$num : rien n'a été modifié"
done

SANS_WORKFLOW=(); SANS_CODEOWNERS=()
for num in "${NUMEROS[@]}"; do
  REPO="$ORG/equipe_$num"

  # 1. GitHub Pages, source « GitHub Actions ».
  if type_pages="$(gh api "repos/$REPO/pages" --jq .build_type 2>/dev/null)"; then
    if [ "$type_pages" != "workflow" ]; then
      gh api -X PUT "repos/$REPO/pages" -f build_type=workflow >/dev/null \
        || refus "$REPO : la source de GitHub Pages n'a pas pu être changée. Corriger puis relancer la même commande."
    fi
  else
    gh api -X POST "repos/$REPO/pages" -f build_type=workflow >/dev/null \
      || refus "$REPO : GitHub Pages n'a pas pu être activé. Corriger puis relancer la même commande."
  fi

  # 2. Protection de main, seulement si le workflow complet est dans main.
  # 15368 est l'identifiant de l'application GitHub Actions : un contrôle du
  # même nom posté par un autre moyen ne compte pas.
  workflow="$(gh api "repos/$REPO/contents/.github/workflows/ci.yml?ref=main" \
    -H "Accept: application/vnd.github.raw" 2>/dev/null || true)"
  if grep -Eq '^[[:space:]]+securite:' <<< "$workflow" && grep -Eq '^[[:space:]]+site-web:' <<< "$workflow"; then
    gh api -X PUT "repos/$REPO/branches/main/protection" --input - >/dev/null <<'JSON' \
      || refus "$REPO : la protection de main n'a pas pu être posée. Corriger puis relancer la même commande."
{
  "required_status_checks": {
    "strict": false,
    "checks": [
      { "context": "analyse-et-tests", "app_id": 15368 },
      { "context": "securite", "app_id": 15368 },
      { "context": "site-web", "app_id": 15368 }
    ]
  },
  "enforce_admins": true,
  "required_pull_request_reviews": {
    "required_approving_review_count": 1,
    "require_code_owner_reviews": true
  },
  "restrictions": null
}
JSON
  else
    SANS_WORKFLOW+=("equipe_$num")
  fi

  # 3. CODEOWNERS présent dans main et sans erreur (identifiant inconnu ou
  # sans droit d'écriture, ligne mal formée).
  erreurs="$(gh api "repos/$REPO/codeowners/errors?ref=main" --jq '.errors | length' 2>/dev/null || echo "?")"
  if ! gh api "repos/$REPO/contents/.github/CODEOWNERS?ref=main" >/dev/null 2>&1 || [ "$erreurs" != "0" ]; then
    SANS_CODEOWNERS+=("equipe_$num")
  fi
done

if [ "${#SANS_WORKFLOW[@]}" -gt 0 ]; then
  echo "GitHub Pages est activé partout, mais ces dépôts n'ont pas encore le workflow complet dans main :" >&2
  printf '  %s\n' "${SANS_WORKFLOW[@]}" >&2
  echo "Leur protection n'a pas été modifiée. Relancer la même commande après la fusion de leur workflow." >&2
fi
if [ "${#SANS_CODEOWNERS[@]}" -gt 0 ]; then
  echo "Ces dépôts n'ont pas de fichier .github/CODEOWNERS valide dans main :" >&2
  printf '  %s\n' "${SANS_CODEOWNERS[@]}" >&2
  echo "La relecture des propriétaires du code y est sans effet. Relancer la même commande après la fusion du fichier." >&2
fi
[ "${#SANS_WORKFLOW[@]}" -eq 0 ] && [ "${#SANS_CODEOWNERS[@]}" -eq 0 ] || exit 1
echo "Terminé : ${#NUMEROS[@]} dépôt(s), GitHub Pages activé, CI et propriétaires du code exigés sur main."
