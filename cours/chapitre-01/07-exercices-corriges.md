# VII. Exercices Corrigés et Travaux Dirigés

## Exercice 1 : Preuves formelles de notations asymptotiques

### Énoncé :
Démontrer formellement, en utilisant la définition mathématique par quantificateurs logiques, que la fonction $f(n) = 3n^2 + 5n + 2$ appartient à la classe $\Theta(n^2)$.

### Résolution formelle :
Pour prouver que $f(n) = \Theta(n^2)$, nous devons trouver trois constantes strictement positives $c_1, c_2 > 0$ and un entier $n_0 \ge 0$ tels que :
$$c_1 \cdot n^2 \le 3n^2 + 5n + 2 \le c_2 \cdot n^2, \quad \forall n \ge n_0$$

1. **Borne supérieure ($c_2$) :** Pour tout $n \ge 1$, nous pouvons majorer les termes de plus bas degré par le terme dominant :
   $$3n^2 + 5n + 2 \le 3n^2 + 5n^2 + 2n^2 = 10n^2 \;\Rightarrow\; \text{On choisit } c_2 = 10$$
2. **Borne inférieure ($c_1$) :** Pour tout $n \ge 0$, les termes $5n$ et $2$ étant strictement positifs, nous pouvons minorer la fonction en ne conservant que le terme de plus haut degré :
   $$3n^2 \le 3n^2 + 5n + 2 \;\Rightarrow\; \text{On choisit } c_1 = 3$$
3. **Condition initiale ($n_0$) :** Les deux inégalités sont simultanément vérifiées dès lors que l'invariant de départ est respecté pour tout $n \ge 1$.

**Conclusion :** Pour $c_1 = 3, c_2 = 10$ et $n_0 = 1$, l'invariant $3n^2 \le 3n^2 + 5n + 2 \le 10n^2$ est rigoureusement respecté. L'ordre de grandeur de la fonction de croissance est étroitement borné. On valide donc que $3n^2 + 5n + 2 = \Theta(n^2)$.

## Exercice 2 : Calcul de complexités de boucles itératives complexes

### Énoncé :
Évaluer de façon analytique la complexité temporelle fine de la structure de contrôle imbriquée dépendante suivante :

```{.pseudocode title="STRUCTURE-IMBRIQUEE(n)" line-numbering="1"}
+ *procédure* [Structure-Imbriquée]{.smallcaps} ($n$)
  + *entrée* : Un entier $n$ représentant la taille du problème
  + *pour* $i \leftarrow 1$ *à* $n$ *faire*
    + *pour* $j \leftarrow 1$ *à* $i$ *faire*
      + $x \leftarrow x + 1$ // Opération élémentaire de coût $\mathcal{O}(1)$*
    + *finpour*
  + *finpour*
```

### Résolution formelle :
La boucle interne s'exécute exactement $i$ fois pour chaque passage de la boucle externe. Le dénombrement exact du nombre total d'exécutions de l'opération élémentaire interne s'évalue par le développement de la somme discrète arithmétique universelle :
$$T(n) = \sum_{i=1}^{n} \sum_{j=1}^{i} 1 = \sum_{i=1}^{n} i = \frac{n(n + 1)}{2} = \frac{1}{2}n^2 + \frac{1}{2}n$$

L'ordre dominant de cette fonction de comportement à l'infini est dicté par le terme de plus haut degré. La complexité temporelle globale de cette structure est quadratique, notée $\Theta(n^2)$.

## Exercice 3 : Résolution d'équations de récurrence par le Théorème Maître

### Énoncé :
Résoudre de manière formelle la relation de récurrence suivante modélisant un algorithme de type diviser-pour-régner : $T(n) = 3T(n/2) + n$.

### Résolution formelle :
L'équation est de la forme standard $T(n) = aT(n/b) + f(n)$ avec les paramètres de structure suivants : $a = 3, b = 2, f(n) = n$.
1. **Calcul de la fonction frontière :** L'évaluation de l'ordre asymptotique critique s'effectue par :
   $$n^{\log_b a} = n^{\log_2 3} \approx n^{1,585}$$
2. **Comparaison de $f(n)$ à la frontière :** Nous comparons le coût de la division/combinaison $f(n) = n$ à la fonction frontière obtenue :
   $$f(n) = n = \mathcal{O}(n^{1,585 - \epsilon}) \quad \text{pour} \quad \epsilon \approx 0,585 > 0$$
3. **Application du cas réglementaire :** La fonction $f(n)$ croît polynomialement plus lentement que la fonction frontière. Le système répond donc scrupuleusement aux critères du **Cas 1** du Théorème Maître.

**Conclusion :** La solution asymptotique globale est mathématiquement dominée par le coût des divisions récursives de l'arbre. Le coût total s'établit à : $T(n) = \Theta(n^{\log_2 3}) \approx \Theta(n^{1,585})$.

## Exercice 4 : Étude de cas d'arbitrage Temps-Machine vs Taille de données

### Énoncé :
Un ingénieur RSD compare un algorithme $A$ de complexité linéaire $T_A(n) = 100n$ et un algorithme $B$ de complexité quadratique $T_B(n) = n^2$. Déterminer le seuil d'évolutivité $n_0$ à partir duquel l'algorithme $A$ surclasse l'algorithme $B$.

### Résolution formelle :
L'algorithme $A$ devient plus efficace et économe que l'algorithme $B$ dès que son coût opératoire devient strictement inférieur :
$$T_A(n) < T_B(n) \;\Leftrightarrow\; 100n < n^2$$

Puisque la taille du problème impose $n > 0$, nous pouvons diviser par $n$ les deux membres de l'inéquation :
$$100 < n \;\Rightarrow\; n \ge 101$$

**Conclusion :** Pour toute instance de données de petite taille ($n \le 100$), l'algorithme quadratique $B$ est plus rapide en pratique car il n'est pas pénalisé par la constante multiplicative élevée de l'algorithme $A$. En revanche, pour toute entrée massive de paquets réseaux ou de clés ($n \ge 101$), l'algorithme linéaire $A$ surclasse définitivement $B$, illustrant l'impact des classes de complexité lors du passage à l'échelle.
