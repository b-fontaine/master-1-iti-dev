#!/usr/bin/env bash
# Tests de preparer-seance-4.sh contre un faux `gh` local (ci-dessous), qui garde
# l'état de chaque dépôt dans des fichiers. Aucun appel réseau, rien n'est
# modifié sur GitHub.
# Usage : bash cours/scripts/test-preparer-seance-4.sh
set -u
ICI="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SCRIPT="$ICI/preparer-seance-4.sh"
MODELE="$ICI/../../depot-modele"
ORG="iti-test"
ECHECS=0

# --- Faux GitHub -----------------------------------------------------------

# Un dépôt est un dossier $FAUX_GITHUB/<organisation>/<dépôt>/ qui contient :
#   ci.yml           le workflow de main
#   CODEOWNERS       le fichier .github/CODEOWNERS de main, s'il existe
#   erreurs-codeowners  le nombre d'erreurs que GitHub y trouve (absent : aucune)
#   sans-admin       présent si le compte n'a pas les droits d'administration
#   pages            la source de GitHub Pages (« workflow » ou « legacy »), si Pages est activé
#   protection.json  le dernier corps reçu pour la protection de main
#   appels           la liste des appels qui modifient le dépôt
ecrire_faux_gh() {
  cat > "$1" <<'FAUX'
#!/usr/bin/env bash
set -euo pipefail
introuvable() { echo "gh: Not Found (HTTP 404)" >&2; exit 1; }
[ "$1" = "api" ] || { echo "faux gh : commande non prévue « $* »" >&2; exit 2; }
shift; methode=GET; chemin=""; champs=(); entree=""; filtre=""
while [ $# -gt 0 ]; do
  case "$1" in
    -X) methode="$2"; shift 2 ;;
    -f) champs+=("$2"); shift 2 ;;
    -H) shift 2 ;;
    --input) entree="$(cat)"; shift 2 ;;
    --jq) filtre="$2"; shift 2 ;;
    *) chemin="$1"; shift ;;
  esac
done
chemin="${chemin%%\?*}"   # ?ref=main : le faux dépôt n'a qu'une branche
IFS=/ read -r _ org nom reste <<< "$chemin"
d="$FAUX_GITHUB/$org/$nom"
[ -d "$d" ] || introuvable
if grep -qxF "$methode ${reste:-} $org/$nom" "$FAUX_GITHUB/panne" 2>/dev/null; then
  echo "gh: Server Error (HTTP 500)" >&2; exit 1
fi
[ "$methode" = "GET" ] || echo "$methode ${reste:-}" >> "$d/appels"
case "$methode ${reste:-}" in
  "GET ")
    if [ -f "$d/sans-admin" ]; then admin=false; else admin=true; fi
    printf '{"permissions": {"admin": %s}}\n' "$admin" | jq -r "${filtre:-.}" ;;
  "GET contents/.github/CODEOWNERS")
    [ -f "$d/CODEOWNERS" ] || introuvable
    cat "$d/CODEOWNERS" ;;
  "GET codeowners/errors")
    jq -n --argjson n "$(cat "$d/erreurs-codeowners" 2>/dev/null || echo 0)" '{errors: [range($n)]}' | jq -r "${filtre:-.}" ;;
  "GET pages")
    [ -f "$d/pages" ] || introuvable
    printf '{"build_type": "%s"}\n' "$(cat "$d/pages")" | jq -r "${filtre:-.}" ;;
  "POST pages")
    if [ -f "$d/pages" ]; then echo "gh: GitHub Pages is already enabled. (HTTP 409)" >&2; exit 1; fi
    printf '%s\n' "${champs[@]}" | sed -n 's/^build_type=//p' > "$d/pages" ;;
  "PUT pages")
    [ -f "$d/pages" ] || introuvable
    printf '%s\n' "${champs[@]}" | sed -n 's/^build_type=//p' > "$d/pages" ;;
  "GET contents/.github/workflows/ci.yml")
    [ -f "$d/ci.yml" ] || introuvable
    cat "$d/ci.yml" ;;
  "PUT branches/main/protection")
    printf '%s' "$entree" > "$d/protection.json" ;;
  *) echo "faux gh : appel non prévu « $methode $chemin »" >&2; exit 2 ;;
esac
FAUX
  chmod +x "$1"
}

TEMPORAIRES=()
trap 'rm -rf "${TEMPORAIRES[@]}"' EXIT

nouveau_github() {
  FAUX_GITHUB="$(mktemp -d)"; TEMPORAIRES+=("$FAUX_GITHUB")
  export FAUX_GITHUB
  mkdir -p "$FAUX_GITHUB/bin"
  ecrire_faux_gh "$FAUX_GITHUB/bin/gh"
}

# depot <equipe> <minimal|complet> [sans-codeowners] : un dépôt dont main porte
# la CI minimale du dépôt-modèle, ou le workflow complet fourni pour la séance 4,
# et, sauf mention contraire, un fichier CODEOWNERS valide.
depot() {
  mkdir -p "$FAUX_GITHUB/$ORG/$1"
  case "$2" in
    minimal) cp "$MODELE/.github/workflows/ci.yml" "$FAUX_GITHUB/$ORG/$1/ci.yml" ;;
    complet) cp "$MODELE/docs/seance-4/ci.yml" "$FAUX_GITHUB/$ORG/$1/ci.yml" ;;
  esac
  if [ "${3:-}" = "sans-codeowners" ]; then rm -f "$FAUX_GITHUB/$ORG/$1/CODEOWNERS"
  else echo "/test/acceptance/ @alice @bob" > "$FAUX_GITHUB/$ORG/$1/CODEOWNERS"; fi
}

lancer() {
  SORTIE="$(PATH="$FAUX_GITHUB/bin:$PATH" bash "$SCRIPT" "$ORG" "$@" 2>&1)"
  CODE=$?
}

# --- Assertions ------------------------------------------------------------

echec() { echo "ÉCHEC - $1"; ECHECS=$((ECHECS + 1)); }
egal() { # egal <nom du cas> <valeur attendue> <valeur obtenue>
  if [ "$2" = "$3" ]; then echo "ok   - $1"
  else echec "$1 : attendu « $2 », obtenu « $3 »"; fi
}
vrai() { # vrai <nom du cas> <commande…>
  local nom="$1"; shift
  if "$@" >/dev/null 2>&1; then echo "ok   - $nom"; else echec "$nom"; fi
}
etat() { cat "$FAUX_GITHUB/$ORG/$1/$2" 2>/dev/null; }
protection() { etat "$1" protection.json | jq -r "$2"; }
# Les contrôles exigés, chacun lié à l'application GitHub Actions (15368).
controles() { protection "$1" '[.required_status_checks.checks[]? | "\(.context):\(.app_id)"] | join(" ")'; }
EXIGES="analyse-et-tests:15368 securite:15368 site-web:15368"

DONNEES="$(mktemp -d)"; TEMPORAIRES+=("$DONNEES")
# Le fichier donné à creer-depots.sh, tel qu'un tableur l'exporte.
printf '\xEF\xBB\xBF1;C\r\n2;A\r\n;\r\n' > "$DONNEES/themes.csv"

# --- Cas nominal : deux équipes dont le workflow complet est fusionné -------

nouveau_github
depot equipe_01 complet
depot equipe_02 complet
lancer "$DONNEES/themes.csv"
egal "cas nominal : le script réussit" "0" "$CODE"
[ "$CODE" -ne 0 ] && echo "$SORTIE"
for e in equipe_01 equipe_02; do
  egal "$e : GitHub Pages activé, source GitHub Actions" "workflow" "$(etat "$e" pages)"
  egal "$e : les trois contrôles sont exigés, liés à GitHub Actions" "$EXIGES" "$(controles "$e")"
  egal "$e : la branche n'a pas à être à jour pour fusionner" \
    "false" "$(protection "$e" '.required_status_checks.strict')"
  egal "$e : la relecture des propriétaires du code est exigée" \
    "true" "$(protection "$e" '.required_pull_request_reviews.require_code_owner_reviews')"
  egal "$e : une relecture approuvée reste exigée" \
    "1" "$(protection "$e" '.required_pull_request_reviews.required_approving_review_count')"
  egal "$e : la protection s'applique toujours aux administrateurs" \
    "true" "$(protection "$e" '.enforce_admins')"
done

# Les contrôles exigés portent le nom de jobs du workflow fourni.
for controle in analyse-et-tests securite site-web; do
  vrai "le workflow fourni a un job « $controle »" grep -q "^  $controle:" "$MODELE/docs/seance-4/ci.yml"
done
vrai "la CI minimale du modèle a déjà le job « analyse-et-tests »" \
  grep -q "^  analyse-et-tests:" "$MODELE/.github/workflows/ci.yml"

# --- Relance : Pages n'est pas réactivé -------------------------------------

lancer "$DONNEES/themes.csv"
egal "relance : le script réussit" "0" "$CODE"
egal "relance : Pages n'est activé qu'une fois" "1" "$(etat equipe_01 appels | grep -c '^POST pages$')"

# --- Pages déjà activé avec l'ancienne source (une branche) ------------------

nouveau_github
depot equipe_01 complet
echo legacy > "$FAUX_GITHUB/$ORG/equipe_01/pages"
printf '01,B\n' > "$DONNEES/une.csv"
lancer "$DONNEES/une.csv"
egal "ancienne source de Pages : le script réussit" "0" "$CODE"
egal "ancienne source de Pages : elle devient GitHub Actions" "workflow" "$(etat equipe_01 pages)"

# --- Une équipe n'a pas encore fusionné le workflow complet -------------------

nouveau_github
depot equipe_01 minimal
depot equipe_02 complet
lancer "$DONNEES/themes.csv"
egal "workflow pas encore fusionné : le script finit en erreur" "1" "$CODE"
vrai "workflow pas encore fusionné : la sortie nomme le dépôt" grep -q "equipe_01" <<< "$SORTIE"
egal "workflow pas encore fusionné : Pages est quand même activé" "workflow" "$(etat equipe_01 pages)"
egal "workflow pas encore fusionné : la protection n'est pas touchée" "" "$(etat equipe_01 protection.json)"
egal "workflow pas encore fusionné : l'autre équipe est protégée" \
  "$EXIGES" "$(controles equipe_02)"

# L'équipe fusionne son workflow, l'enseignant relance.
depot equipe_01 complet
lancer "$DONNEES/themes.csv"
egal "relance après la fusion : le script réussit" "0" "$CODE"
egal "relance après la fusion : l'équipe 01 est protégée" \
  "$EXIGES" "$(controles equipe_01)"

# Le workflow de l'équipe a des fins de ligne Windows : il est reconnu quand même.
nouveau_github
depot equipe_01 complet
sed -i 's/$/\r/' "$FAUX_GITHUB/$ORG/equipe_01/ci.yml"
lancer "$DONNEES/une.csv"
egal "workflow en fins de ligne Windows : le script réussit" "0" "$CODE"
egal "workflow en fins de ligne Windows : l'équipe est protégée" "$EXIGES" "$(controles equipe_01)"

# --- Fichier CODEOWNERS absent ou invalide ----------------------------------

nouveau_github
depot equipe_01 complet sans-codeowners
depot equipe_02 complet
lancer "$DONNEES/themes.csv"
egal "CODEOWNERS absent : le script finit en erreur" "1" "$CODE"
vrai "CODEOWNERS absent : la sortie nomme le dépôt" grep -q "CODEOWNERS" <<< "$SORTIE"
vrai "CODEOWNERS absent : seul le dépôt concerné est nommé" bash -c '! grep -q "equipe_02" <<< "$0"' "$SORTIE"
egal "CODEOWNERS absent : la protection est posée quand même" "$EXIGES" "$(controles equipe_01)"

nouveau_github
depot equipe_01 complet
echo 1 > "$FAUX_GITHUB/$ORG/equipe_01/erreurs-codeowners"
lancer "$DONNEES/une.csv"
egal "CODEOWNERS avec une erreur (identifiant inconnu) : le script finit en erreur" "1" "$CODE"
vrai "CODEOWNERS avec une erreur : la sortie nomme le dépôt" grep -q "equipe_01" <<< "$SORTIE"

# --- Panne en cours de route, puis relance ---------------------------------

nouveau_github
depot equipe_01 complet
depot equipe_02 complet
echo "PUT branches/main/protection $ORG/equipe_01" > "$FAUX_GITHUB/panne"
lancer "$DONNEES/themes.csv"
egal "panne sur la protection de l'équipe 01 : le script finit en erreur" "1" "$CODE"
vrai "panne sur la protection : la sortie nomme le dépôt" grep -q "equipe_01 : la protection" <<< "$SORTIE"
rm "$FAUX_GITHUB/panne"
lancer "$DONNEES/themes.csv"
egal "relance après la panne : le script réussit" "0" "$CODE"
egal "relance après la panne : l'équipe 02 est protégée" \
  "true" "$(protection equipe_02 '.required_pull_request_reviews.require_code_owner_reviews')"

# --- Entrées incohérentes : rien n'est modifié ------------------------------

rien_modifie() { # rien_modifie <nom du cas> : échec sans aucun appel qui modifie
  if [ "$CODE" -ne 0 ] && [ -z "$(cat "$FAUX_GITHUB/$ORG"/*/appels 2>/dev/null)" ]; then echo "ok   - $1"
  else echec "$1 : code $CODE, appels : $(cat "$FAUX_GITHUB/$ORG"/*/appels 2>/dev/null | tr '\n' ' ')"; fi
}

nouveau_github
depot equipe_01 complet
lancer "$DONNEES/themes.csv"
rien_modifie "un dépôt introuvable (equipe_02) : refus avant toute modification"
vrai "un dépôt introuvable : la sortie le nomme" grep -q "equipe_02" <<< "$SORTIE"

nouveau_github
depot equipe_01 complet
depot equipe_02 complet
touch "$FAUX_GITHUB/$ORG/equipe_02/sans-admin"
lancer "$DONNEES/themes.csv"
rien_modifie "droits d'administration absents sur un dépôt : refus avant toute modification"
vrai "droits d'administration absents : la sortie nomme le dépôt" grep -q "administration.*equipe_02" <<< "$SORTIE"

nouveau_github
depot equipe_01 complet
echo "POST pages $ORG/equipe_01" > "$FAUX_GITHUB/panne"
lancer "$DONNEES/une.csv"
egal "panne à l'activation de Pages : le script finit en erreur" "1" "$CODE"
vrai "panne à l'activation de Pages : la sortie nomme le dépôt" grep -q "equipe_01 : GitHub Pages" <<< "$SORTIE"

nouveau_github
depot equipe_01 complet
printf '123,A\n' > "$DONNEES/mal.csv"
lancer "$DONNEES/mal.csv"
rien_modifie "numéro d'équipe mal formé : refus avant toute modification"

nouveau_github
depot equipe_01 complet
lancer "$DONNEES/absent.csv"
rien_modifie "fichier des thèmes absent : refus avant toute modification"

nouveau_github
SORTIE="$(PATH="$FAUX_GITHUB/bin:$PATH" bash "$SCRIPT" "$ORG" 2>&1)"; CODE=$?
egal "argument manquant : le script rappelle l'usage (code 2)" "2" "$CODE"

echo
if [ "$ECHECS" -eq 0 ]; then echo "Tous les tests passent."
else echo "$ECHECS test(s) en échec."; exit 1; fi
