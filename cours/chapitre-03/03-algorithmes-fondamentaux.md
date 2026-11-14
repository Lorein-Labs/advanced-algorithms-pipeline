# III. Algorithmes Fondamentaux — Recherche, Insertion et Éclatement

La manipulation des B-Arbres repose sur des primitives d'accès disques rigoureuses destinées à maintenir les invariants structurels lors des phases de modification de l'arbre.

## III.1 Algorithme de Recherche Unitaire

La recherche d'une clé $k$ au sein d'un B-Arbre est une généralisation directe de la recherche dans un Arbre Binaire de Recherche. Elle s'effectue par une descente itérative de la racine vers les feuilles. À chaque nœud $x$, une recherche dichotomique locale détermine l'indice minimal $i$ tel que $k \le x.key_i$.

## III.2 Algorithme d'Éclatement de Nœud (*Node Splitting*)

L'insertion d'une clé exige d'anticiper la saturation des nœuds. Lorsqu'une clé doit être insérée dans un nœud enfant $y$ déjà plein ($2t-1$ clés), ce nœud doit être scindé en deux nœuds distincts contenant chacun $t-1$ clés, tandis que la clé médiane remonte vers le nœud parent $x$.

Le pseudo-code impératif standardisé de cette opération critique s'isole au sein de la fente sémantique suivante :

```{.pseudocode title="B-TREE-SPLIT-CHILD(x, i, y)" line-numbering="1"}
+ *procédure* [B-Tree-Split-Child]{.smallcaps}($x$, $i$, $y$)
  + *entrée* : Un nœud parent $x$, un indice $i$, et un nœud enfant saturé $y$
  + Allouer un nouveau nœud complet $z$
  + $z.leaf \leftarrow y.leaf$ // Hérite du type de structure de y
  + $z.n \leftarrow t - 1$
  + *pour* $j \leftarrow 1$ *à* $t - 1$ *faire*
    + $z.key[j] \leftarrow y.key[j + t]$
  + *finpour*
  + *si* non $y.leaf$ *alors*
    + *pour* $j \leftarrow 1$ *à* $t$ *faire*
      + $z.c[j] \leftarrow y.c[j + t]$
    + *finpour*
  + *finsi*
  + $y.n \leftarrow t - 1$
  + *pour* $j \leftarrow x.n + 1$ *bas à* $i + 1$ *faire*
    + $x.c[j + 1] \leftarrow x.c[j]$
  + *finpour*
  + $x.c[i + 1] \leftarrow z$
  + *pour* $j \leftarrow x.n$ *bas à* $i$ *faire*
    + $x.key[j + 1] \leftarrow x.key[j]$
  + *finpour*
  + $x.key[i] \leftarrow y.key[t]$
  + $x.n \leftarrow x.n + 1$
  + Écrire le bloc physique `DISK-WRITE`($y$)
  + Écrire le bloc physique `DISK-WRITE`($z$)
  + Écrire le bloc physique `DISK-WRITE`($x$)
```

## III.3 Insertion préventive à la descente (*Proactive Insertion*)

Pour garantir une efficacité maximale en un seul passage sans remontée récursive complexe, l'algorithme d'insertion de Lorein applique une stratégie **préventive**. Lors de la descente vers la feuille d'insertion, si l'algorithme rencontre un nœud saturé, il l'éclate immédiatement à la volée avant de poursuivre son parcours, assurant qu'aucun nœud parent ne débordera lors de la remontée de la clé médiane.
