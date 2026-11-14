# I. Typologie des Complexités et Arbitrages Systèmes

L'analyse de l'efficacité d'un algorithme requiert l'évaluation quantitative des ressources physiques consommées lors de son exécution. Conformément aux principes de l'informatique théorique formalisés dans `[CLRS-2022]`, ces ressources se divisent en deux grandes catégories distinctes et complémentaires : la ressource temporelle et la ressource spatiale.

## I.1 Complexité temporelle (Dénombrement des opérations élémentaires)

La complexité temporelle $T(n)$ quantifie le nombre d'opérations élémentaires exécutées par un algorithme en fonction de la taille $n$ de l'instance d'entrée. Une opération est dite élémentaire si son coût d'exécution est invariant et borné par une constante.

### Exemple 1 : Analyse fine d'une boucle simple (Recherche linéaire)

```{.pseudocode title="CHERCHER-MAXIMUM(tableau)" line-numbering="1"}
+ *procédure* [Chercher-Maximum]{.smallcaps}($T$, $n$)
  + *entrée* : Un tableau $T$ de taille $n$
  + *sortie* : La valeur maximale stockée dans le tableau
  + $maximum \leftarrow T[1]$ // S'exécute si la condition est vraie
  + *pour* $i \leftarrow 2$ *à* $n$ *faire*
    + *si* $T[i] > maximum$ *alors*
      + $maximum \leftarrow T[i]$ // S'exécute si la condition est vraie
    + *finsi*
  + *finpour*
  + retourner $maximum$   
```

Dans le pire des cas (lorsque le tableau est trié dans un ordre strictement croissant), la ligne interne s'exécute à chaque itération. Le coût opératoire total s'établit à :
$$T(n) = 1 + 2(n - 1) = 2n - 1$$

Le nombre d'opérations croît de manière strictement proportionnelle à la taille $n$. La complexité temporelle est linéaire, notée $\Theta(n)$.

### Exemple 2 : Analyse fine de deux boucles imbriquées

```{.pseudocode title="VERIFIER-DUPLICATES(tableau)" line-numbering="1"}
+ *procédure* #smallcaps[Vérifier-Duplicates]\(\$T\$, \(n\)\)
  + *entrée* : Un tableau T de taille n
  + *sortie* : Un booléen (Vrai si un doublon existe, Faux sinon)
  + *pour* i ← 1 *à* n *faire*
    + *pour* j ← i + 1 *à* n *faire*
      + *si* \(T[i] == T[j]\) *alors*
        + retourner Vrai
      + *finsi*
    + *finpour*
  + *finpour*
  + retourner Faux
```

Dans le pire des cas (lorsqu'aucun doublon n'est présent dans le tableau), le dénombrement exact des passages dans la condition logique suit le développement de la somme arithmétique universelle :
$$\sum_{i=1}^{n} \sum_{j=i+1}^{n} 1 = \sum_{i=1}^{n} (n - i) = \frac{n(n - 1)}{2} = \frac{1}{2}n^2 - \frac{1}{2}n$$

L'ordre dominant de cette fonction de croissance est dicté par le terme de plus haut degré. La complexité temporelle dans le pire des cas est quadratique, notée $\Theta(n^2)$.

## I.2 Complexité spatiale

La complexité spatiale $S(n)$ mesure la quantité de mémoire vive nécessaire à l'exécution d'un algorithme en fonction de la taille $n$ des données d'entrée. Elle s'articule autour de deux vecteurs d'analyse distincts :

### a. Empreinte mémoire locale (RAM et pile d'exécutions)
Elle englobe l'espace requis par les variables locales, les structures auxiliaires allouées dynamiquement au cours du traitement, et la pile d'appels récursifs (*Call Stack*). Si un algorithme résout un problème sans allouer de mémoire dépendante de la taille $n$, sa complexité spatiale auxiliaire est constante, notée $\mathcal{O}(1)$ (algorithme qualifié d'exécution "en place"). Si un algorithme récursif engendre une profondeur d'appels de hauteur $n$, sa complexité spatiale est modélisée par $\mathcal{O}(n)$ en raison de l'empilement du contexte d'exécution.

### b. Overhead réseau et sérialisation des paquets (Spécificité RSD)
Pour les ingénieurs de l'option Réseaux et Services Distribués (RSD), la complexité spatiale transcende les limites physiques de la machine locale. Elle intègre la taille des métadonnées protocolaires et la structure des objets sérialisés transitant sur les liaisons de communication. Concevoir un protocole distribué scalable implique de minimiser cet *overhead* pour prévenir l'effondrement de la bande passante lors du passage à l'échelle.

## I.3 Arbitrage Temps / Espace (*Space-Time Tradeoff*)

Il existe un compromis structurel permanent entre le temps de calcul et l'espace mémoire. Un algorithme peut économiser du temps CPU en pré-calculant et en stockant des résultats intermédiaires dans des tables de hachage ou des index (augmentation de la complexité spatiale pour réduire la complexité temporelle). Inversement, si la mémoire est saturée (contrainte forte sur les routeurs ou les systèmes embarqués), l'algorithme doit recalculer les informations à chaque itération, augmentant le coût temporel pour préserver l'espace. Le choix d'architecture dépend des exigences industrielles du système.
