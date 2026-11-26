#!/usr/bin/env bash
# Tests de creer-depots.sh contre un faux GitHub local : un faux `gh` (ci-dessous)
# qui crée de vrais dépôts git sur disque, clonés et poussés par le script.
# Aucun appel réseau, rien n'est créé sur GitHub.
# Usage : bash cours/scripts/test-creer-depots.sh
set -u
ICI="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SCRIPT="$ICI/creer-depots.sh"
MODELE="$ICI/../../depot-modele"
ORG="iti-test"
ECHECS=0

# Les tests ne dépendent pas de la configuration git du poste.
export GIT_CONFIG_GLOBAL=/dev/null GIT_CONFIG_SYSTEM=/dev/null
export GIT_AUTHOR_NAME=test GIT_AUTHOR_EMAIL=test@example.invalid
export GIT_COMMITTER_NAME=test GIT_COMMITTER_EMAIL=test@example.invalid

# --- Faux GitHub -----------------------------------------------------------

# Écrit le faux `gh` : il ne connaît que les appels dont le script a besoin et
# échoue (code 2) sur tout autre appel.
ecrire_faux_gh() {
  cat > "$1" <<'FAUX'
#!/usr/bin/env bash
set -euo pipefail
F="$FAUX_GITHUB"
depot() { echo "$F/depots/$1.git"; }
etat() { echo "$F/etat/$1"; }
existe() { [ -d "$(depot "$1")" ]; }
introuvable() { echo "gh: Not Found (HTTP 404)" >&2; exit 1; }

case "$1 ${2:-}" in
  "repo create")
    nom="$3"; shift 3; modele=""; visibilite=""
    while [ $# -gt 0 ]; do
      case "$1" in
        --public) visibilite=public; shift ;;
        --template) modele="$2"; shift 2 ;;
        *) echo "faux gh : option inconnue « $1 »" >&2; exit 2 ;;
      esac
    done
    if [ -z "$visibilite" ]; then
      echo "--public, --private, or --internal required when not running interactively" >&2; exit 1
    fi
    if existe "$nom"; then echo "GraphQL: Name already exists on this account" >&2; exit 1; fi
    if [ "$modele" != "$FAUX_MODELE" ]; then echo "GraphQL: Could not resolve to a Repository" >&2; exit 1; fi
    git init -q --bare -b main "$(depot "$nom")"
    copie="$(mktemp -d)"
    cp -r "$F/modele/." "$copie"
    git -C "$copie" init -q -b main
    git -C "$copie" add -A
    git -C "$copie" commit -q -m "Initial commit"
    git -C "$copie" push -q "$(depot "$nom")" main
    rm -rf "$copie"
    mkdir -p "$(etat "$nom")"
    ;;
  "repo clone")
    existe "$3" || introuvable
    git clone -q "$(depot "$3")" "$4"
    ;;
  "api "*)
    shift; methode=GET; chemin=""; champs=(); types=(); entree=""; filtre="."
    while [ $# -gt 0 ]; do
      case "$1" in
        -X) methode="$2"; shift 2 ;;
        # Comme le vrai gh : -f envoie une chaîne, -F un booléen ou un nombre.
        -f) champs+=("$2"); types+=("${2%%=*}=\"${2#*=}\""); shift 2 ;;
        -F) champs+=("$2"); types+=("$2"); shift 2 ;;
        --input) entree="$(cat)"; shift 2 ;;
        --jq) filtre="$2"; shift 2 ;;
        *) chemin="$1"; shift ;;
      esac
    done
    IFS=/ read -r _ org nom reste <<< "$chemin"
    d="$org/$nom"
    if [ "$d" = "$FAUX_MODELE" ] && [ "$methode ${reste:-}" = "GET " ]; then
      [ -f "$F/modele.json" ] || introuvable
      jq -r "$filtre" "$F/modele.json"
      exit 0
    fi
    existe "$d" || introuvable
    # Panne simulée : une ligne « MÉTHODE chemin organisation/dépôt » dans $F/panne.
    if grep -qxF "$methode ${reste:-} $d" "$F/panne" 2>/dev/null; then
      echo "gh: Server Error (HTTP 500)" >&2; exit 1
    fi
    case "$methode ${reste:-}" in
      "GET ") ;;
      "GET branches/main")
        git -C "$(depot "$d")" rev-parse -q --verify refs/heads/main >/dev/null || introuvable ;;
      "GET labels/"*)
        grep -qx "${reste#labels/}" "$(etat "$d")/labels" 2>/dev/null || introuvable ;;
      "POST labels")
        label=""
        for c in "${champs[@]}"; do case "$c" in name=*) label="${c#name=}" ;; esac; done
        if grep -qx "$label" "$(etat "$d")/labels" 2>/dev/null; then
          echo "gh: Validation Failed (HTTP 422)" >&2; exit 1
        fi
        echo "$label" >> "$(etat "$d")/labels" ;;
      "PATCH ")
        printf '%s\n' "${types[@]}" > "$(etat "$d")/reglages" ;;
      "PUT branches/main/protection")
        printf '%s' "$entree" > "$(etat "$d")/protection.json"
        # Comme GitHub avec enforce_admins : plus aucun push direct sur main.
        printf '#!/bin/sh\necho "GH006: Protected branch update failed" >&2\nexit 1\n' \
          > "$(depot "$d")/hooks/pre-receive"
        chmod +x "$(depot "$d")/hooks/pre-receive" ;;
      "PUT collaborators/"*)
        login="${reste#collaborators/}"
        if grep -qx "$login" "$F/logins-inconnus" 2>/dev/null; then introuvable; fi
        permission=""
        for c in "${champs[@]}"; do case "$c" in permission=*) permission="${c#permission=}" ;; esac; done
        # Comme GitHub : inviter deux fois la même personne ne change rien.
        grep -qx "$login $permission" "$(etat "$d")/collaborateurs" 2>/dev/null \
          || echo "$login $permission" >> "$(etat "$d")/collaborateurs" ;;
      *) echo "faux gh : appel non prévu « $methode $chemin »" >&2; exit 2 ;;
    esac
    ;;
  *) echo "faux gh : commande non prévue « $* »" >&2; exit 2 ;;
esac
FAUX
  chmod +x "$1"
}

TEMPORAIRES=()
trap 'rm -rf "${TEMPORAIRES[@]}"' EXIT

# Repart d'un faux GitHub vide, avec comme modèle les fichiers versionnés du
# dépôt-modèle réel, publié comme dépôt modèle sur la branche main.
nouveau_github() {
  FAUX_GITHUB="$(mktemp -d)"; TEMPORAIRES+=("$FAUX_GITHUB")
  export FAUX_GITHUB FAUX_MODELE="$ORG/modele"
  mkdir -p "$FAUX_GITHUB/bin" "$FAUX_GITHUB/depots/$ORG" "$FAUX_GITHUB/modele"
  (cd "$MODELE" && git ls-files -z | xargs -0 cp --parents -t "$FAUX_GITHUB/modele")
  modele_json true main
  ecrire_faux_gh "$FAUX_GITHUB/bin/gh"
}

modele_json() { # modele_json <is_template> <default_branch>
  printf '{"name": "modele", "full_name": "%s/modele", "private": false, "is_template": %s, "default_branch": "%s"}\n' \
    "$ORG" "$1" "$2" > "$FAUX_GITHUB/modele.json"
}

# lancer <equipes.csv> [<themes.csv>] : lance le script, garde code et sortie.
lancer() {
  SORTIE="$(PATH="$FAUX_GITHUB/bin:$PATH" bash "$SCRIPT" "$ORG" modele "$@" 2>&1)"
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

git_depot() { local equipe="$1"; shift; git --git-dir="$FAUX_GITHUB/depots/$ORG/$equipe.git" "$@"; }
etat() { cat "$FAUX_GITHUB/etat/$ORG/$1/$2" 2>/dev/null; }
depots_crees() { find "$FAUX_GITHUB/depots/$ORG" -mindepth 1 -maxdepth 1 | wc -l | tr -d ' '; }

# projet_du_theme <equipe> <lettre> : PROJET.md de main est celui du thème.
projet_du_theme() {
  git_depot "$1" show main:PROJET.md 2>/dev/null | cmp -s - "$MODELE/themes/PROJET-$2.md"
}

# --- Cas nominal : deux équipes, thèmes dans le désordre -------------------

DONNEES="$(mktemp -d)"; TEMPORAIRES+=("$DONNEES")
# Fins de ligne Windows, espaces et dernière ligne sans saut : un export de tableur.
printf '01,alice\r\n01, bob\r\n02,carol\r\n02,dave' > "$DONNEES/equipes.csv"
printf '01,C\r\n02,A' > "$DONNEES/themes.csv"

nouveau_github
lancer "$DONNEES/equipes.csv" "$DONNEES/themes.csv"
egal "cas nominal : le script réussit" "0" "$CODE"
[ "$CODE" -ne 0 ] && echo "$SORTIE"
vrai "équipe 01 (thème C) : PROJET.md est celui du thème C" projet_du_theme equipe_01 C
vrai "équipe 02 (thème A) : PROJET.md est celui du thème A" projet_du_theme equipe_02 A
egal "équipe 01 : le dossier themes/ a disparu, le reste du modèle est intact" \
  "$(cd "$MODELE" && git ls-files | grep -v '^themes/' | LC_ALL=C sort | tr '\n' ' ')" \
  "$(git_depot equipe_01 ls-tree -r --name-only main | LC_ALL=C sort | tr '\n' ' ')"
for e in equipe_01 equipe_02; do
  egal "$e : une relecture approuvée exigée sur main" \
    "1" "$(etat "$e" protection.json | jq -r '.required_pull_request_reviews.required_approving_review_count')"
  egal "$e : protection appliquée aussi aux administrateurs" \
    "true" "$(etat "$e" protection.json | jq -r '.enforce_admins')"
  egal "$e : fusion par merge commit seulement, branche supprimée après fusion" \
    "allow_merge_commit=true allow_rebase_merge=false allow_squash_merge=false delete_branch_on_merge=true " \
    "$(etat "$e" reglages | sort | tr '\n' ' ')"
  egal "$e : label erreur-agent créé" "erreur-agent" "$(etat "$e" labels)"
done
egal "équipe 01 : ses deux membres invités en écriture" \
  "alice push bob push " "$(etat equipe_01 collaborateurs | tr '\n' ' ')"
egal "équipe 02 : ses deux membres invités en écriture" \
  "carol push dave push " "$(etat equipe_02 collaborateurs | tr '\n' ' ')"

# --- Relance sur des dépôts déjà créés -------------------------------------

lancer "$DONNEES/equipes.csv" "$DONNEES/themes.csv"
egal "relance : le script réussit sur des dépôts déjà créés" "0" "$CODE"
[ "$CODE" -ne 0 ] && echo "$SORTIE"
vrai "relance : PROJET.md de l'équipe 01 reste celui du thème C" projet_du_theme equipe_01 C
egal "relance : aucun commit de plus sur main" "2" "$(git_depot equipe_01 rev-list --count main)"

# Thème corrigé après coup : la relance ne peut plus le changer, elle doit le dire.
printf '01,B\n02,A\n' > "$DONNEES/themes-change.csv"
lancer "$DONNEES/equipes.csv" "$DONNEES/themes-change.csv"
egal "thème changé après création : le script finit en erreur" "1" "$CODE"
vrai "thème changé après création : la sortie nomme le dépôt et les deux thèmes" \
  grep -q "equipe_01.*thème C.*thème B" <<< "$SORTIE"
vrai "thème changé après création : PROJET.md reste celui du thème C" projet_du_theme equipe_01 C

# --- Panne en cours de route, puis relance ---------------------------------

nouveau_github
echo "PUT branches/main/protection $ORG/equipe_01" > "$FAUX_GITHUB/panne"
lancer "$DONNEES/equipes.csv" "$DONNEES/themes.csv"
egal "panne sur la protection de l'équipe 01 : le script finit en erreur" "1" "$CODE"
rm "$FAUX_GITHUB/panne"
lancer "$DONNEES/equipes.csv" "$DONNEES/themes.csv"
egal "relance après la panne : le script réussit" "0" "$CODE"
[ "$CODE" -ne 0 ] && echo "$SORTIE"
vrai "relance après la panne : PROJET.md de l'équipe 01 est celui du thème C" projet_du_theme equipe_01 C
egal "relance après la panne : main de l'équipe 01 est protégée" \
  "true" "$(etat equipe_01 protection.json | jq -r '.enforce_admins')"
vrai "relance après la panne : l'équipe 02 est créée avec le thème A" projet_du_theme equipe_02 A
egal "relance après la panne : les membres de l'équipe 02 sont invités" \
  "carol push dave push " "$(etat equipe_02 collaborateurs | tr '\n' ' ')"

# --- Export d'Excel en français --------------------------------------------

# BOM UTF-8, point-virgule, zéro de tête perdu, ligne vide en fin de tableau.
printf '\xEF\xBB\xBF1;alice\r\n1;bob\r\n2;carol\r\n;\r\n' > "$DONNEES/equipes-excel.csv"
printf '\xEF\xBB\xBF1;C\r\n2;A\r\n;\r\n' > "$DONNEES/themes-excel.csv"
nouveau_github
lancer "$DONNEES/equipes-excel.csv" "$DONNEES/themes-excel.csv"
egal "export Excel français : le script réussit" "0" "$CODE"
[ "$CODE" -ne 0 ] && echo "$SORTIE"
vrai "export Excel français : l'équipe 1 devient equipe_01, thème C" projet_du_theme equipe_01 C
egal "export Excel français : membres de l'équipe 01 invités" \
  "alice push bob push " "$(etat equipe_01 collaborateurs | tr '\n' ' ')"

# --- Identifiant GitHub inconnu --------------------------------------------

nouveau_github
echo bob > "$FAUX_GITHUB/logins-inconnus"
lancer "$DONNEES/equipes.csv" "$DONNEES/themes.csv"
egal "identifiant inconnu : le script finit en erreur" "1" "$CODE"
vrai "identifiant inconnu : la sortie nomme l'équipe et l'identifiant" grep -q "01,bob" <<< "$SORTIE"
egal "identifiant inconnu : les autres membres de l'équipe sont invités" \
  "alice push " "$(etat equipe_01 collaborateurs | tr '\n' ' ')"
egal "identifiant inconnu : l'équipe suivante est invitée" \
  "carol push dave push " "$(etat equipe_02 collaborateurs | tr '\n' ' ')"

# --- Fichiers d'entrée incohérents : rien n'est créé -----------------------

rien_cree() { # rien_cree <nom du cas> : le dernier lancement a échoué sans rien créer
  if [ "$CODE" -ne 0 ] && [ "$(depots_crees)" = "0" ]; then echo "ok   - $1"
  else echec "$1 : code $CODE, $(depots_crees) dépôt(s) créé(s)"; fi
}

refuse() { # refuse <nom du cas> <contenu de equipes.csv> <contenu de themes.csv>
  nouveau_github
  printf '%s' "$2" > "$DONNEES/e.csv"
  printf '%s' "$3" > "$DONNEES/t.csv"
  lancer "$DONNEES/e.csv" "$DONNEES/t.csv"
  rien_cree "$1"
}

refuse "équipe sans thème : refus avant toute création" \
  $'01,alice\n02,carol\n' $'01,A\n'
refuse "thème inconnu : refus avant toute création" \
  $'01,alice\n02,carol\n' $'01,A\n02,D\n'
refuse "thème sans aucun membre : refus avant toute création" \
  $'01,alice\n' $'01,A\n02,B\n'
refuse "numéro d'équipe mal formé : refus avant toute création" \
  $'123,alice\n' $'123,A\n'
refuse "espace dans un identifiant GitHub : refus avant toute création" \
  $'01,jean dupont\n' $'01,A\n'
refuse "colonne en trop : refus avant toute création" \
  $'01,alice,Alice Martin\n' $'01,A\n'
refuse "même identifiant dans deux équipes : refus avant toute création" \
  $'01,alice\n02,alice\n' $'01,A\n02,B\n'
refuse "identifiant GitHub mal formé : refus avant toute création" \
  $'01,alice dupont@exemple\n' $'01,A\n'
refuse "deux thèmes pour une même équipe : refus avant toute création" \
  $'01,alice\n' $'01,A\n01,B\n'

nouveau_github
lancer "$DONNEES/equipes.csv"
rien_cree "fichier des thèmes oublié : refus avant toute création"

# --- Poste ou modèle pas prêt : rien n'est créé ----------------------------

nouveau_github
modele_json false main
lancer "$DONNEES/equipes.csv" "$DONNEES/themes.csv"
rien_cree "dépôt non marqué comme modèle : refus avant toute création"

nouveau_github
modele_json true master
lancer "$DONNEES/equipes.csv" "$DONNEES/themes.csv"
rien_cree "branche par défaut du modèle autre que main : refus avant toute création"

nouveau_github
rm "$FAUX_GITHUB/modele.json"
lancer "$DONNEES/equipes.csv" "$DONNEES/themes.csv"
rien_cree "modèle introuvable dans l'organisation : refus avant toute création"

nouveau_github
printf '[user]\n\tuseConfigOnly = true\n' > "$DONNEES/gitconfig-sans-identite"
SORTIE="$(env -u GIT_AUTHOR_NAME -u GIT_AUTHOR_EMAIL -u GIT_COMMITTER_NAME -u GIT_COMMITTER_EMAIL \
  GIT_CONFIG_GLOBAL="$DONNEES/gitconfig-sans-identite" PATH="$FAUX_GITHUB/bin:$PATH" \
  bash "$SCRIPT" "$ORG" modele "$DONNEES/equipes.csv" "$DONNEES/themes.csv" 2>&1)"
CODE=$?
rien_cree "git sans identité : refus avant toute création"

echo
if [ "$ECHECS" -eq 0 ]; then echo "Tous les tests passent."
else echo "$ECHECS test(s) en échec."; exit 1; fi
