# Supports de cours · Séance 5 · Retouches et soutenance

Quatre chapitres pour la séance du vendredi 29 janvier 2027 après-midi, la dernière. Elle arrive au bout d'un sprint d'un peu plus de six semaines : l'équipe arrête ce qu'elle livre, le fige, puis le présente. La séance n'est pas un cours : après un briefing, des retouches bloquantes et le gel (`v1.0`), elle est occupée par les soutenances, en deux salles. Les diapositives (`cours/presentations/day-5/`) cadrent le briefing, les ateliers et le format d'un passage ; les chapitres 1 à 3 expliquent chaque geste et chaque règle de l'évaluation, et le chapitre 4 rassemble les fiches à garder sous les yeux. Chaque chapitre contient un résumé, un glossaire, des sources et une liste des points non vérifiés.

| # | Chapitre | Contenu | Blocs de la séance |
|---|---|---|---|
| 1 | [Geler et livrer : de `v1.0-rc` à `v1.0`](01-geler-et-livrer.md) | Le calendrier de la fin du sprint, geler les fonctionnalités et assumer ce qu'on laisse de côté, le dossier de rendu pièce par pièce avec la preuve qui va avec, poser `v1.0-rc` (vérifier avant de pousser, prouver après), vérifier le rendu comme un évaluateur, le briefing, les retouches bloquantes, le gel et `v1.0`, quand ça coince | Fin du sprint ; 1, 2 et 3 |
| 2 | [La soutenance d'équipe](02-la-soutenance-d-equipe.md) | Le dispositif (deux salles, budget indicatif, variante à 7 équipes, format dégradé), la partie commune en trois temps, la démonstration en direct, le plan de secours, « sous le capot », compiler les mesures et les deux cas `erreur-agent`, le point de conformité, le regard critique, répéter, le passage | 4 et 5 |
| 3 | [L'oral individuel et la note](03-l-oral-individuel-et-la-note.md) | Les deux questions, la PR tirée au sort, la préparer par les preuves, l'échelle de 0 à 4, la question 2, les cinq règles d'usage de l'IA, la grille sur 20 critère par critère, la contribution vérifiée et l'évaluation par les pairs, plafonnement et bonus, l'étudiant absent, après les passages | 5, 6, 7 et 8 |
| 4 | [Les fiches de la séance](04-fiches-de-seance.md) | Avant la séance (`v1.0-rc` et dossier de rendu), retouches bloquantes, gel et `v1.0`, répétition et soutenance d'équipe, oral individuel, fiche des pairs et livrable (fiches W à Z, les dernières) | Fin du sprint ; 1 à 8 |

Ces chapitres ne redisent pas ce qui existe déjà : ils y renvoient. Supports de la séance 2 (`cours/supports/day-2/`) : poser un tag (chapitre 3, section 11.2), le modèle de PR et ses lignes de suivi (chapitre 3, section 9). Supports de la séance 3 (`cours/supports/day-3/`) : la relecture par les preuves (chapitre 1, section 4), les droits des personnes (chapitre 3, section 5). Supports de la séance 4 (`cours/supports/day-4/`) : la valeur faussée et le test d'acceptation (chapitre 1), la CI complète, la publication et la release `v0.1` (chapitre 2), le test à froid de l'audit (chapitre 3), la décision du RSSI et la rubrique 13 de la fiche (chapitre 4, sections 9 et 10). La grille sur 20, l'échelle de compréhension orale et le format de la soutenance sont ceux du programme (`cours/programme-detaille.md`, séance 5 et section 7), qui fait foi.

Les documents papier de la soutenance (fiches de notation, échelle, grille d'équipe, fiche d'observation, fiche d'évaluation par les pairs, ordre de passage) sont dans `cours/imprimables/seance-5.html`.

## Lecture conseillée

- Une semaine avant la séance : le chapitre 1, sections 2 à 6, et la fiche W. Le tag `v1.0-rc` et le dossier de rendu sont déposés l'avant-veille de la séance à 18h, soit le mercredi 27 janvier 2027 à 18h.
- Avant la répétition de l'équipe : le chapitre 2, sections 3 à 10, et la fiche Y.
- La veille de la séance, quand la PR tirée au sort est communiquée (avant 9h, soit le jeudi 28 janvier 2027) : le chapitre 3, sections 2 à 6, et la fiche Z.
- Pendant la séance : le chapitre 4, fiches X, Y et Z. C'est le seul à imprimer.
- Pour comprendre sa note : le chapitre 3, sections 8 à 11.

## Ce que la séance vise

| Objectif du programme | Où le travailler |
|---|---|
| 1. Geler un périmètre et livrer une version stable (`v1.0`), en assumant ce qui est laissé de côté | Chapitre 1 ; fiches W et X |
| 2. Présenter une démonstration en direct, chronométrée et robuste (avec plan de secours) | Chapitre 2, sections 4, 5, 10 et 11 ; fiche Y |
| 3. Expliquer les choix de son équipe (données, qualité, conformité) en s'appuyant sur l'historique git et la fiche | Chapitre 2, sections 6 à 8 ; fiche Y |
| 4. Répondre à des questions individuelles sur une PR de son équipe et sur la compréhension du projet | Chapitre 3, sections 2 à 7 ; fiche Z |
| 5. Porter un regard critique sur son usage de l'IA et sur les limites de son outil, chiffres à l'appui | Chapitre 2, sections 7 et 9 |

Le livrable de fin de séance et la definition of done sont repris mot pour mot dans la fiche Z.

## Réserves

Rédigés et relus avec l'aide d'un assistant, les chapitres sont sourcés, mais **chaque chapitre signale ses points non vérifiés** en fin de document. Six réserves valent pour l'ensemble.

- **Vérifié sous Linux seulement, et sans GitHub.** Les commandes git ont été exécutées le 27 novembre 2026 sous Linux (git 2.53.0, gh 2.100.0, Flutter 3.50.1, Dart 3.14.0), sur une copie du dépôt-modèle placée hors du dépôt du cours, avec un dépôt distant local. Rien n'a été écrit sur GitHub : la fusion d'un correctif est simulée par une fusion locale, et ni la page des tags, ni la pastille de CI d'un commit tagué, ni une PR de correctif sous la protection de `main`, ni le site publié n'ont été observés pour cette séance. Quelques commandes `gh` ont été essayées en lecture seule sur le dépôt du cours, pas sur un dépôt d'équipe. `flutter run -d chrome` n'a pas été rejoué.
- **Aucune soutenance n'a été jouée.** Le dispositif, le budget d'un passage, l'oral individuel et la notation sont repris du programme ; rien n'a été essayé avec une équipe, un jury ou un chronomètre.
- **Trois dates sont déduites.** Le programme fixe la séance au vendredi 29 janvier 2027 et situe trois échéances par rapport à elle ; les supports écrivent la date calculée après la formule du programme : « une semaine avant » (vendredi 22 janvier 2027), « l'avant-veille à 18h » (mercredi 27 janvier 2027), « la veille avant 9h » (jeudi 28 janvier 2027). Le programme fait foi.
- **Les trois questions de la fiche d'évaluation par les pairs ne sont pas écrites.** Le programme les annonce (« trois questions fixes ») sans les donner : les supports renvoient à la fiche distribuée en séance, et la fiche à imprimer les laisse en blanc.
- **Des textes restent des propositions des supports**, à valider par l'enseignant ; chaque chapitre les signale dans le texte et les liste en « Points non vérifiés ». Chapitre 1 : la prudence entre `v1.0-rc` et la séance, la façon d'écrire ce qu'on abandonne, la preuve observable de chaque pièce du dossier, les conditions avant de taguer, ce qui est « bloquant ». Chapitre 2 : ce que la démonstration montre, la composition du plan de secours, la décision sur les données en quatre points, le tableau de compilation des mesures, la répartition de la parole. Chapitre 3 : toute la préparation de la PR par les preuves, les exemples de réponses par niveau, les lectures de l'échelle et de la grille. Chapitre 4 : les gestes des tableaux « Si ça coince ».
- **Le programme laisse des points à trancher par l'enseignant**, que les supports signalent sans les trancher. Les principaux : une PR (question 1) ou trois PR (contribution vérifiée) tirées au sort ; une moyenne des deux questions alors que la question 1 « porte l'essentiel de la note » ; une échelle écrite pour une PR lue ligne à ligne, appliquée à un public non développeur et à la question 2 ; une médiane à 2,5 ou 4,5 pour l'évaluation par les pairs ; le moment où les fiches des pairs se remplissent ; ce qui est permis entre `v1.0-rc` et la séance ; ce qu'on fait si la CI est rouge à l'heure du gel ; le test à froid de la definition of done, qui omet `build_runner` ; la façon de constater l'heure de dépôt de `v1.0-rc` ; le seuil de 20 lignes « hors fichiers générés ».
