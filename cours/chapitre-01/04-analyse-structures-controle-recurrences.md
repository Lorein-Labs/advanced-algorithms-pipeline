# IV. Analyse des Structures de Contrôle et Relations de Récurrence

L'analyse de la complexité dans le pire des cas s'appuie sur le modèle théorique RAM (*Random Access Machine*) où chaque instruction élémentaire possède un coût opératoire unitaire invariant et borné par une constante $\mathcal{O}(1)$.

## IV.1 Algorithmes itératifs et sommes mathématiques

Pour évaluer une structure itérative de façon analytique, l'ingénierie documentaire de l'Université de Dschang applique les règles calculatoires universelles suivantes :
*   **Séquence (A ; B) :** $\text{coût}(A) + \text{coût}(B) \;\Rightarrow\; \mathcal{O}(\max(\text{coût}(A), \text{coût}(B)))$.
*   **Conditionnelle (Si C Alors A Sinon B) :** $\text{coût}(C) + \max(\text{coût}(A), \text{coût}(B))$.
*   **Boucle simple :** $\sum_{i=\text{début}}^{\text{fin}} \text{coût}(\text{itération})$.

### A. Analyse fine d'une boucle à pas multiplicatif

```{.pseudocode title="BOUCLE-MULTIPLICATIVE(n)" line-numbering="1"}
+ *procédure* [Boucle-Multiplicative]{.smallcaps} ($n$)
  + *entrée* : Un entier supérieur ou égal à 1
  + $i \leftarrow 1$
  + *tant que* $i < n$ *faire*
    + $i \leftarrow 2 \cdot i$ // Opération élémentaire de coût $\mathcal{O}(1)$
  + *fintantque*
```

Après $k$ itérations au sein de la structure de contrôle, la variable prend la valeur exacte $i = 2^k$. La boucle s'interrompt dès que l'invariant $2^k \ge n$ est vérifié, ce qui implique par glissement logarithmique $k = \lceil \log_2 n \rceil$. La complexité temporelle est donc logarithmique, notée $\Theta(\log n)$.

### B. Sommes classiques incontournables à connaître :

| Somme mathématique | Valeur exacte | Ordre de grandeur asymptotique |
| :--- | :--- | :--- |
| $\sum_{i=1}^{n} 1$ | $n$ | $\Theta(n)$ (Linéaire) |
| $\sum_{i=1}^{n} i$ | $\frac{n(n + 1)}{2}$ | $\Theta(n^2)$ (Quadratique) |
| $\sum_{i=1}^{n} i^2$ | $\frac{n(n + 1)(2n + 1)}{6}$ | $\Theta(n^3)$ (Cubique) |
| $\sum_{i=0}^{n} 2^i$ | $2^{n+1} - 1$ | $\Theta(2^n)$ (Exponentiel) |
| $\sum_{i=1}^{n} \frac{1}{i}$ | $\approx \ln n$ | $\Theta(\log n)$ (Logarithmique) |

## IV.2 Algorithmes récursifs et équations de récurrence

Le coût d'un algorithme récursif s'exprime de manière formelle par une relation de récurrence qui lie le coût d'un problème de taille $n$ au coût de ses sous-problèmes induits, complétée par des conditions initiales (cas de base).

*   **Exemple 1 (Factorielle récursive) :** $T(n) = T(n - 1) + c_0 \;\Rightarrow\; T(n) = \Theta(n)$.
*   **Exemple 2 (Tours de Hanoï — Portabilité Génie Logiciel) :** Déplacer $n$ disques requiert de diviser le problème pour déplacer deux fois $n-1$ disques plus le disque principal : $T(n) = 2T(n - 1) + 1$. Par dépliage de la série, on obtient $T(n) = 2^n - 1 \;\Rightarrow\; \Theta(2^n)$ (Complexité exponentielle).
*   **Exemple 3 (Arbres de Décision en Intelligence Artificielle) :** L'exploration récursive des sous-arbres d'un graphe de jeu (algorithme Minimax de l'option IA) engendre des relations de récurrence de type : $\text{Fib}(n) = \text{Fib}(n-1) + \text{Fib}(n-2) + 1 \;\Rightarrow\; T(n) = \Theta(\phi^n)$ où $\phi = \frac{1 + \sqrt{5}}{2} \approx 1,618$ (Nombre d'or). La récursion naïve calcule de manière redondante les mêmes valeurs, illustrant la nécessité d'optimisations par programmation dynamique.

## IV.3 Méthodes de résolution des récurrences

### a. La méthode par dépliage (Substitution itérative)
Elle consiste à remplacer successivement le terme récursif par son expression algébrique jusqu'à atteindre le cas de base afin de dégager un pattern de somme mathématique.

### b. La méthode par substitution
On devine la forme de la solution (par intuition ou via une devinette), puis on utilise une preuve par récurrence mathématique pour valider la constante $c$ (ex : supposer $T(k) \le c \cdot k \log_2 k$ pour démontrer la borne supérieure).

### c. La méthode de l'arbre de récurrence
On représente les appels sous forme d'arbre. Chaque niveau représente le coût cumulé du découpage et de la combinaison. Pour $T(n) = 2T(n/2) + n$, chaque niveau coûte exactement $n$. Comme il y a $\log_2 n$ niveaux, le coût total est de $\Theta(n \log n)$.

### d. Le Théorème Maître (Master Theorem)
S'applique aux récurrences de la forme $T(n) = aT(n/b) + f(n)$.

| Algorithme de référence | Équation de récurrence | Paramètres $a, b, f(n)$ | Cas du Théorème | Solution globale |
| :--- | :--- | :--- | :--- | :--- |
| **Recherche dichotomique** | $T(n) = T(n/2) + c$ | $1, 2, \Theta(1)$ | Cas 2 ($f(n) = \Theta(n^0)$) | $\Theta(\log n)$ |
| **Tri fusion (Merge Sort)** | $T(n) = 2T(n/2) + n$ | $2, 2, \Theta(n)$ | Cas 2 ($f(n) = \Theta(n^1)$) | $\Theta(n \log n)$ |
| **Multiplication de Karatsuba**| $T(n) = 3T(n/2) + n$ | $3, 2, \Theta(n)$ | Cas 1 ($f(n) = \mathcal{O}(n^{\log_2 3 - \epsilon})$) | $\Theta(n^{\log_2 3}) \approx \Theta(n^{1,585})$|
| **Parcours + fusion lourde** | $T(n) = T(n/2) + n$ | $1, 2, \Theta(n)$ | Cas 3 ($a f(n/b) \le c f(n)$) | $\Theta(n)$ |

### e. Récurrences linéaires à coefficients constants
Résolution par l'équation caractéristique $r^2 = a r + b$. Les racines permettent de formuler la solution sous la forme $T(n) = \lambda_1 r_1^n + \lambda_2 r_2^n$.
