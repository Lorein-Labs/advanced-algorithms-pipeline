---
unnumbered: true
---

#  {#intro-chap3 .unnumbered .unlisted}

```{=typst}
#pagebreak()
#v(5cm)
#align(center)[
  #text(size: 26pt, weight: "bold", fill: rgb("#1d4ed8"))[Chapitre 3 : Les B-Arbres]
  
  #v(1cm)
  #text(size: 14pt, style: "italic", fill: gray)[Indexation de masse, invariants structurels et applications aux services distribués]
]
#pagebreak()
```

# Introduction {.unnumbered}

L'ingénierie des données à grande échelle se heurte à une barrière physique fondamentale : l'écart de performance abyssal entre la vitesse de la mémoire vive (RAM) et celle des disques de stockage de masse (SSD, disques magnétiques). Alors que le traitement processeur s'évalue en nanosecondes, une seule opération d'entrée/sortie ($I/O$) sur disque requiert plusieurs millisecondes. Pour les applications manipulant des téraoctets de données, le défi technologique ne réside plus dans le calcul pur, mais dans la réduction drastique du nombre d'accès physiques aux disques.

Les structures de données classiques en mémoire, telles que les Arbres Binaires de Recherche (ABR), les AVL ou les arbres Rouge-Noir, s'avèrent inefficaces pour le stockage de masse. Leur nature binaire limite chaque nœud à deux enfants maximum, ce qui engendre une hauteur d'arbre importante ($log_{2}n$) et multiplie d'autant les accès disques distincts à chaque niveau traversé. De plus, ces structures provoquent une fragmentation majeure de la mémoire secondaire.

Pour lever ce verrou structurel, Rudolf Bayer et Edward M. McCreight ont introduit les B-Arbres. En permettant à chaque nœud de contenir un grand nombre de clés et de pointeurs sous forme de structures multi-voies alignées sur la taille des pages physiques du disque (ex : 4 Ko ou 8 Ko), le B-Arbre aplatit littéralement sa hauteur. Cela permet de localiser n'importe quelle information parmi des milliards d'enregistrements en seulement 3 ou 4 accès disques. Ce chapitre explore en détail ces structures, leurs algorithmes fondamentaux et leurs variantes industrielles ($B^+$ et $B^*$-arbres), constituant la fondation immuable des bases de données et des systèmes de fichiers distribués.
