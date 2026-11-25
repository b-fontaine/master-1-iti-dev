# Support de cours (livre Quarto)

Livre en français « Ingénierie logicielle à l'ère de l'IA agentique », compilé en PDF (LuaLaTeX) et en EPUB à partir des supports de `cours/`.

## Commandes

```bash
quarto render support-de-cours          # PDF et EPUB dans support-de-cours/_book/
task book                               # idem
task book:pdf                           # PDF seul
task book:epub                          # EPUB seul
task book:check                         # vérification complète (interdits, sources, rendu)
bash support-de-cours/scripts/verifier.sh --no-render   # contrôles sans rendu
```

Prérequis : Quarto (1.8 ou plus) et une distribution TeX avec LuaLaTeX (TinyTeX convient). Le PDF utilise TeX Gyre Pagella, TeX Gyre Heros et DejaVu Sans Mono. Un caractère absent des polices fait échouer la compilation.

Un rendu limité à un seul format vide `_book/` : lancer `task book` pour obtenir les deux fichiers.

## Ajouter un chapitre

1. Créer le fichier `.qmd` dans le dossier de la partie, avec en première ligne `<!-- source: <chemin(s)> · synchro: AAAA-MM-JJ -->` (`source: nouveau` pour un texte original).
2. Donner au titre `#` un identifiant stable : `# Titre {#sec-slug}`.
3. Déclarer le fichier dans `book.chapters` de `_quarto.yml`, sous la bonne entrée `part:`.
4. Ajouter la ligne correspondante à la table ci-dessous.
5. Lancer `task book:check`.

## Table de correspondance source → chapitre

| Source | Chapitre |
|---|---|
| _(à remplir au fil des tâches)_ | |

## Règles d'adaptation d'un support en chapitre

1. **Ton intemporel.** « Pendant l'atelier » devient « en formation » ou « en pratique » ; « avant le 27 novembre » disparaît ou devient « avant la séance 2 » ; les consignes adressées à la promotion 2026-2027 deviennent des conseils au lecteur.
2. **Dates conservées quand elles datent un fait.** « État des outils au 19 novembre 2026 » reste, dans un encadré en tête de chapitre.
3. **Renvois croisés Quarto.** « Chapitre 4 de la séance 1 » devient `@sec-guide-flutter` ; chaque chapitre a un identifiant `#sec-…` stable.
4. **Encadrés Quarto.** « À retenir » devient `callout-tip` ; les avertissements deviennent `callout-warning` ; les points non vérifiés deviennent `callout-note` titré.
5. **Liens imprimables.** Les URL des sources restent écrites en clair (le PDF imprimé n'a pas de lien cliquable).
6. **Nettoyage.** Pas de chemin local, pas de section interne, pas de donnée personnelle ; les liens relatifs vers `cours/` sont remplacés par des renvois internes.
7. **Fidélité.** Pas d'ajout de contenu factuel non sourcé ; on adapte la forme, pas le fond. Un fait du support qui paraît faux est signalé à l'enseignant, pas corrigé en silence.
8. **Diaporama vers prose.** Le contenu d'un diaporama et de ses notes devient un chapitre « La séance en bref » : objectifs, déroulé (tableau), idées clés en encadrés, schémas utiles redessinés ou capturés. Les consignes de régie (chronomètre, transitions) ne sont pas reprises.

## Interdits absolus dans les `.qmd`

Chemins `/tmp/`, mentions internes de préparation enseignant, formules de brouillon (« à compléter », « ne pas diffuser ») et adresses électroniques (sauf le domaine `users.noreply.github.com`, utilisé dans des exemples). La liste exacte est dans `scripts/verifier.sh`.
