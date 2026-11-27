#!/usr/bin/env bash
# Crée les dépôts d'équipe dans l'organisation GitHub de la formation, à partir
# du dépôt-modèle, puis invite les membres de chaque équipe.
#
# usage : ./creer-depots.sh <organisation> <modele> <equipes.csv> <themes.csv>
#   modele      : nom du dépôt-modèle dans l'organisation (sans le nom de l'organisation)
#   equipes.csv : un membre par ligne, "numero_equipe,login_github" (ex. 01,monlogin)
#   themes.csv  : une équipe par ligne, "numero_equipe,theme" (ex. 01,A ; thème A, B ou C)
#   Aucune ligne d'en-tête. Séparateur virgule ou point-virgule (export d'Excel).
#   Les deux fichiers s'obtiennent avec gabarit-equipes.xlsx (même dossier) :
#   enregistrer en CSV ses onglets export-equipes et export-themes.
#
# Prérequis : bash 4 ou plus et GNU sed ; `gh` authentifié sur l'organisation,
# avec le droit d'y créer des dépôts ; `git` avec une identité (user.name,
# user.email) ; le dépôt-modèle marqué comme modèle, branche par défaut `main`.
#
# Le script peut être relancé : ce qui est déjà fait n'est pas refait. Après une
# erreur, corriger la cause puis relancer la même commande. Deux choses ne se
# corrigent pas par une relance : le thème d'un dépôt déjà créé (le script
# s'arrête et le dit) et une invitation envoyée à un mauvais identifiant (à
# retirer à la main dans les réglages du dépôt).
set -euo pipefail

if [ $# -ne 4 ]; then
  sed -n '2,21p' "$0" >&2
  exit 2
fi
ORG="$1"; MODELE="$2"; EQUIPES="$3"; THEMES="$4"

refus() { echo "Erreur : $*" >&2; exit 1; }

# Lit un CSV d'export de tableur et le ramène à des lignes "NN,valeur" : retire
# le BOM UTF-8 et les fins de ligne Windows, accepte le point-virgule, retire
# les espaces autour des champs (un espace à l'intérieur d'un champ reste, et
# fera refuser la ligne), remet le zéro de tête d'un numéro à un chiffre et
# ignore les lignes vides. grep termine la dernière ligne si son saut manque.
lire() {
  sed -e '1s/^\xEF\xBB\xBF//' -e 's/\r$//' "$1" \
    | sed -E -e 's/;/,/g' -e 's/^[[:space:]]+//' -e 's/[[:space:]]+$//' \
        -e 's/[[:space:]]*,[[:space:]]*/,/g' -e 's/^([0-9]),/0\1,/' \
    | grep -v '^,*$'
}

# --- Lecture et contrôle des deux fichiers, avant toute création -----------

[ -r "$EQUIPES" ] || refus "fichier des équipes illisible : $EQUIPES"
[ -r "$THEMES" ] || refus "fichier des thèmes illisible : $THEMES"

declare -A THEME_DE=() A_DES_MEMBRES=() EQUIPE_DE=()

while IFS=, read -r num theme reste; do
  [[ "$num" =~ ^[0-9]{2}$ && -z "$reste" ]] \
    || refus "$THEMES : ligne « $num,$theme${reste:+,$reste} » mal formée (attendu : 01,A)"
  [[ "$theme" =~ ^[ABC]$ ]] || refus "$THEMES : thème « $theme » inconnu pour l'équipe $num (A, B ou C)"
  [ -z "${THEME_DE[$num]:-}" ] || refus "$THEMES : l'équipe $num a deux thèmes"
  THEME_DE[$num]="$theme"
done < <(lire "$THEMES")

while IFS=, read -r num login reste; do
  [[ "$num" =~ ^[0-9]{2}$ && "$login" =~ ^[A-Za-z0-9-]+$ && -z "$reste" ]] \
    || refus "$EQUIPES : ligne « $num,$login${reste:+,$reste} » mal formée (attendu : 01,monlogin)"
  [ -n "${THEME_DE[$num]:-}" ] || refus "l'équipe $num de $EQUIPES n'a pas de thème dans $THEMES"
  # GitHub ne distingue pas la casse des identifiants.
  [ -z "${EQUIPE_DE[${login,,}]:-}" ] \
    || refus "$EQUIPES : l'identifiant $login figure deux fois (équipes ${EQUIPE_DE[${login,,}]} et $num)"
  EQUIPE_DE[${login,,}]="$num"
  A_DES_MEMBRES[$num]=oui
done < <(lire "$EQUIPES")

[ "${#THEME_DE[@]}" -gt 0 ] || refus "$THEMES ne contient aucune équipe"
for num in "${!THEME_DE[@]}"; do
  [ -n "${A_DES_MEMBRES[$num]:-}" ] || refus "l'équipe $num de $THEMES n'a aucun membre dans $EQUIPES"
done

# --- Contrôle du poste et du modèle, avant toute création ------------------

if ! { git var GIT_AUTHOR_IDENT && git var GIT_COMMITTER_IDENT; } >/dev/null 2>&1; then
  refus "git n'a pas d'identité : régler user.name et user.email (git config --global)"
fi

ETAT_MODELE="$(gh api "repos/$ORG/$MODELE" --jq '"\(.is_template) \(.default_branch)"' 2>/dev/null)" \
  || refus "dépôt-modèle $ORG/$MODELE introuvable (ou gh non authentifié : gh auth status)"
[ "$ETAT_MODELE" = "true main" ] \
  || refus "$ORG/$MODELE doit être marqué comme modèle (Settings, « Template repository ») avec main pour branche par défaut ; trouvé : « $ETAT_MODELE »"

# --- Création et réglage de chaque dépôt -----------------------------------

# Début du message du commit qui installe PROJET.md ; la lettre du thème le suit.
MESSAGE_PROJET="docs: PROJET.md du thème"

# Remplace PROJET.md par la version du thème et supprime themes/, en un commit
# poussé sur main. À faire avant la protection de main, qui refuse ce push.
# Si c'est déjà fait (relance), vérifie que le thème installé est le bon.
installer_projet() { # installer_projet <dépôt> <thème>
  local repo="$1" theme="$2" copie installe
  copie="$(mktemp -d)"
  gh repo clone "$repo" "$copie" -- --quiet
  if [ -d "$copie/themes" ]; then
    git -C "$copie" mv -f "themes/PROJET-$theme.md" PROJET.md
    git -C "$copie" rm -r -q themes
    git -C "$copie" commit -q -m "$MESSAGE_PROJET $theme"
    # Le push s'authentifie avec le jeton de gh, même si git n'est pas configuré pour.
    git -C "$copie" -c credential.helper= -c 'credential.helper=!gh auth git-credential' \
      push -q origin main
  else
    installe="$(git -C "$copie" log --format=%s | sed -n "s/^$MESSAGE_PROJET //p" | head -n 1)"
    if [ -n "$installe" ] && [ "$installe" != "$theme" ]; then
      rm -rf "$copie"
      refus "$repo existe déjà avec le PROJET.md du thème $installe, alors que $THEMES demande le thème $theme. Supprimer ce dépôt puis relancer, ou corriger PROJET.md par une PR."
    fi
  fi
  rm -rf "$copie"
}

mapfile -t NUMEROS < <(printf '%s\n' "${!THEME_DE[@]}" | sort)

for num in "${NUMEROS[@]}"; do
  REPO="$ORG/equipe_$num"
  echo "== $REPO (thème ${THEME_DE[$num]})"

  if ! gh api "repos/$REPO" >/dev/null 2>&1; then
    gh repo create "$REPO" --public --template "$ORG/$MODELE"
  fi
  # La création depuis un modèle est asynchrone : attendre l'existence de main.
  for _ in $(seq 1 30); do
    gh api "repos/$REPO/branches/main" >/dev/null 2>&1 && break
    sleep 2
  done
  gh api "repos/$REPO/branches/main" >/dev/null   # échoue (set -e) si main n'existe toujours pas

  installer_projet "$REPO" "${THEME_DE[$num]}"

  if ! gh api "repos/$REPO/labels/erreur-agent" >/dev/null 2>&1; then
    gh api -X POST "repos/$REPO/labels" -f name="erreur-agent" -f color="d73a4a" \
      -f description="Erreur de l'agent repérée et documentée" >/dev/null
  fi
  gh api -X PATCH "repos/$REPO" -F allow_merge_commit=true -F allow_squash_merge=false \
    -F allow_rebase_merge=false -F delete_branch_on_merge=true >/dev/null
  gh api -X PUT "repos/$REPO/branches/main/protection" --input - >/dev/null <<'JSON'
{
  "required_status_checks": null,
  "enforce_admins": true,
  "required_pull_request_reviews": { "required_approving_review_count": 1 },
  "restrictions": null
}
JSON
done

# --- Invitation des membres comme collaborateurs de leur dépôt -------------

# Un identifiant refusé (faute de frappe) ne bloque pas les autres invitations.
INVITATIONS_EN_ECHEC=()
while IFS=, read -r num login <&3; do
  if ! gh api -X PUT "repos/$ORG/equipe_$num/collaborators/$login" -f permission="push" >/dev/null; then
    INVITATIONS_EN_ECHEC+=("$num,$login")
  fi
done 3< <(lire "$EQUIPES")

if [ "${#INVITATIONS_EN_ECHEC[@]}" -gt 0 ]; then
  echo "Dépôts créés, mais ces invitations ont échoué (numero_equipe,login_github) :" >&2
  printf '  %s\n' "${INVITATIONS_EN_ECHEC[@]}" >&2
  echo "Corriger les identifiants dans $EQUIPES puis relancer la même commande." >&2
  exit 1
fi
echo "Terminé : ${#NUMEROS[@]} dépôt(s) prêt(s), membres invités."
