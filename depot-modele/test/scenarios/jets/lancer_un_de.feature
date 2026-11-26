# language: fr
Fonctionnalité: Lancer un dé contre un degré de difficulté

  Scénario: un jet égal au degré de difficulté est une réussite
    Soit le dé va donner {10}
    Et l'écran des jets est ouvert
    Quand je lance le dé
    Alors je vois le texte {'Dernier jet : 10 · Réussite'}

  Scénario: un jet inférieur au degré de difficulté est un échec
    Soit le dé va donner {9}
    Et l'écran des jets est ouvert
    Quand je lance le dé
    Alors je vois le texte {'Dernier jet : 9 · Échec'}
