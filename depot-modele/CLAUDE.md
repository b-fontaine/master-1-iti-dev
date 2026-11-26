# Projet d'équipe (Flutter, Clean Architecture)

## Commandes
- Installer : `flutter pub get`
- Générer le code : `dart run build_runner build --delete-conflicting-outputs`
- Tests : `flutter test` · Analyse : `flutter analyze` · Format : `dart format .`
- Lancer : `flutter run -d chrome`
- Migrations de la base : `dart run drift_dev make-migrations`

## Règles
- Une fonctionnalité = un dossier `lib/features/<nom>/`, avec `domain/`, `data/`, `presentation/` ; ce qui est commun va dans `lib/core/`.
- `domain/` n'importe jamais `data/` ni `presentation/`, ni Flutter.
- Un Cubit ou un BLoC ne reçoit que des cas d'usage, jamais un repository (sinon la garde `RequireRole` est contournée).
- Interface : importer `package:material_ui/material_ui.dart` ; `package:flutter/material.dart` est interdit (déprécié, `flutter analyze` échoue).
- Les tests suivent la même arborescence sous `test/` ; scénarios `.feature` dans `test/scenarios/`, étapes dans `test/steps/`.
- Test d'abord : un test qui échoue, puis le code minimal qui le fait passer.
- Voir `docs/ARCHITECTURE.md` avant de créer un fichier ; la feature `lib/features/jets/` sert d'exemple.
- Toute modification d'une table drift = `schemaVersion` + 1 et la procédure de `docs/ARCHITECTURE.md` (section 7, migrations).

## Interdits
- Ne jamais modifier, désactiver ni supprimer un test pour le faire passer.
- Ne jamais modifier `test/acceptance/`.
- Ne jamais modifier à la main `drift_schemas/` ni les fichiers `*.steps.dart`.
- Aucune donnée réelle, aucun secret, aucun nom de personne dans le dépôt.

## Avant de dire « c'est terminé »
Lancer les commandes de vérification du `README.md` (« Vérifier avant une PR »), dont `dart format .` (la CI contrôle la mise en forme), `flutter analyze` et `flutter test`, et coller le résultat.
