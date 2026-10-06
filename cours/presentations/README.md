# Présentations

Deux diaporamas HTML (sans dépendance, Node ≥ 18 pour le lanceur) avec une fenêtre de notes synchronisée.

```bash
npm run day-1     # séance 1 : diaporama + notes
npm run themes    # présentation des trois projets : diaporama + notes
```

(Aussi disponibles depuis la racine du dépôt.) La commande démarre un petit serveur local, ouvre le diaporama dans une fenêtre du navigateur et les notes dans une **autre fenêtre** (même profil de navigateur, indispensable à la synchronisation). Options : `npm run day-1 -- --browser firefox`, `--no-notes`, `--no-open` (ou `npm run day-1:serve`), `--port 5000`. Variable `BROWSER` reconnue.

## Synchronisation

- Diaporama → notes : chaque changement de slide ou d'étape met à jour les notes (section en surbrillance, défilement, « Ensuite », chronomètre).
- Notes → diaporama : boutons ← →, flèches / espace / Début / Fin du clavier, clic sur un titre dans la liste de gauche.
- `F` dans les notes : mode focus (seule la slide courante). `F` dans le diaporama : plein écran. `N` dans le diaporama : (ré)ouvre les notes dans une fenêtre.

## Organisation

| Chemin | Rôle |
|---|---|
| `shared/deck.css`, `shared/deck.js` | Moteur commun des diaporamas (mise en page, apparitions, vue d'ensemble, synchronisation) |
| `shared/notes.css`, `shared/notes.js` | Vue présentateur commune |
| `<deck>/index.html`, `<deck>/deck.css` | Slides et styles propres au diaporama |
| `<deck>/notes.html` | Notes : une `<section class="s" id="…">` par slide, `id` = `data-id` de la slide. La navigation est générée |
| `scripts/present.mjs` | Serveur et lanceur de fenêtres |

Ajouter un diaporama : créer `<deck>/index.html` (`<body data-deck="<deck>" data-notes="notes.html">`) et `<deck>/notes.html`, puis une entrée dans `package.json`.
