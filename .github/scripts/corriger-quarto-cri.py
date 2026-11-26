"""Corrige une course dans le pilotage de Chrome par Quarto 1.8.x.

Pour rendre les schémas Mermaid en image (PDF, EPUB), Quarto ouvre une page
locale dans Chrome via le protocole DevTools : il appelle `Page.navigate`,
puis seulement ensuite s'abonne à `Page.loadEventFired`. Quand la page se
charge avant l'abonnement, l'événement est perdu et le rendu attend sans fin
(blocage intermittent observé sur les runners GitHub).

Le correctif s'abonne avant de naviguer. Le script échoue si le passage
attendu est introuvable : une autre version de Quarto doit être réexaminée.

Usage : python3 corriger-quarto-cri.py /opt/quarto/bin/quarto.js
"""
import sys

AVANT = """      await Page2.navigate({ url });
      return new Promise((fulfill, _reject) => {
        Page2.loadEventFired(() => {
          fulfill(null);
        });
      });"""

APRES = """      const loaded = new Promise((fulfill, _reject) => {
        Page2.loadEventFired(() => {
          fulfill(null);
        });
      });
      await Page2.navigate({ url });
      return loaded;"""

chemin = sys.argv[1]
with open(chemin, encoding="utf-8") as f:
    source = f.read()

if APRES in source:
    print(f"{chemin} : déjà corrigé")
    sys.exit(0)
if source.count(AVANT) != 1:
    sys.exit(f"{chemin} : passage Page.navigate/loadEventFired introuvable ou multiple ; "
             "revoir le correctif pour cette version de Quarto")

with open(chemin, "w", encoding="utf-8") as f:
    f.write(source.replace(AVANT, APRES))
print(f"{chemin} : abonnement à loadEventFired placé avant Page.navigate")
