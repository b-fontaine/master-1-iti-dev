# Règles du dépôt

Dépôt d'un cours (Master ITI) : les sources vivent dans `cours/`, le livre Quarto qui les reprend dans `support-de-cours/`. Le livre ne reste juste que si chaque changement de source y est reporté.

## Où écrire

- Nouveau support : `cours/supports/day-N/` (un fichier numéroté `NN-sujet.md`).
- Nouveau diaporama : `cours/presentations/<deck>/` avec `index.html` et `notes.html`, une entrée dans `cours/presentations/package.json` et une tâche dans `Taskfile.yml`, comme les diaporamas existants.

## Règle de synchronisation (même PR)

Tout support ou diaporama créé ou modifié est aussi adapté dans `support-de-cours/`, dans la même PR, sinon le livre diffuse un contenu périmé :

1. Chapitre nouveau, ou mise à jour du chapitre existant (retrouvé par la table de `support-de-cours/README.md`).
2. Date `synchro:` du commentaire de tête du chapitre mise à jour.
3. Table de correspondance source → chapitre de `support-de-cours/README.md` mise à jour.
4. Quand les chapitres réels d'une séance existent, la page « à paraître » correspondante (`partie-5-a-venir/`) est remplacée par eux et retirée de `_quarto.yml`.

Les règles d'adaptation (ton, renvois, encadrés, nettoyage, fidélité) sont dans `support-de-cours/README.md` : les lire avant d'écrire un chapitre, ne pas les recopier ici.

## Interdits dans le livre

- Aucun contenu interne (checklist enseignant, notes de préparation), chemin local ni donnée personnelle : le livre est diffusé tel quel.
- Ne jamais modifier à la main `support-de-cours/_book/` : il est régénéré par le rendu et n'est pas versionné.

## Avant de conclure

`task book:check` doit être vert (interdits, sources, rendu PDF et EPUB). Un rendu non vérifié n'est pas une preuve : coller le résultat, pas l'intention.
