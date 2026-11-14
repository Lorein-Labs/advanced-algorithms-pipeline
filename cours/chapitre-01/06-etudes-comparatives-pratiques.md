# VI. Études Comparatives Pratiques

L'application des cadres d'analyse prend tout son sens lors de la confrontation directe d'algorithmes résolvant une même problématique métier.

## VI.1 Algorithmes de recherche : Recherche séquentielle vs Recherche dichotomique

### A. Recherche séquentielle
Elle fonctionne sur un tableau quelconque (trié ou non) en parcourant les éléments du début à la fin.

```{.pseudocode title="RECHERCHE-SEQUENTIELLE(T, n, x)" line-numbering="1"}
+ *procédure* #smallcaps[Recherche-Séquentielle]\((T, n, x)\)
  + *pour* i ← 1 *à* n *faire*
    + *si* \(T[i] == x\) *alors*
      + retourner i
    + *fintsir*
  + *finpour*
  + retourner -1
```

*   **Meilleur cas :** $x$ est en première position $\;\rightarrow\; 1$ comparaison, $\Theta(1)$.
*   **Pire cas :** $x$ est en dernière position ou absent $\;\rightarrow\; n$ comparaisons, $\Theta(n)$.
*   **Cas moyen (présence équiprobable) :** $\frac{n+1}{2}$ comparaisons, $\Theta(n)$.
*   **Espace :** $\mathcal{O}(1)$ mémoire auxiliaire.

### B. Recherche dichotomique
Elle exige que le tableau soit préalablement trié. Elle procède par divisions successives de la zone de recherche.

```{.pseudocode title="RECHERCHE-DICHOTOMIQUE(T, n, x)" line-numbering="1"}
+ *procédure* [Recherche-Séquentielle]{.smallcaps}($T$, $n$, $x$)
  + $g \leftarrow 1$
  + $d \leftarrow n$
  + *tant que* $(g \le d)$ *faire*
    + $m \leftarrow \lfloor (g + d) / 2 \rfloor$
    + *si* $(T[m] == x)$ *alors*
      + retourner m
    + *sinon si* $(T[m] < x)$ *alors*
      + $g \leftarrow m + 1$
    + *sinon*
      + $d \leftarrow m - 1$
    + *finsi*
  + *fintantque*
  + retourner -1
```

À chaque itération, la taille de la zone est divisée par 2 ($n, n/2, n/4, \dots, 1$). Le nombre maximal d'itérations est donné par $\lfloor \log_2 n \rfloor + 1$.
*   **Meilleur cas :** $x$ au milieu $\;\rightarrow\; 1$ comparaison, $\Theta(1)$.
*   **Pire cas :** $\lfloor \log_2 n \rfloor + 1$ comparaisons, $\Theta(\log n)$. Récurrence : $T(n) = T(n/2) + 1$.
*   **Cas moyen :** $\Theta(\log n)$.
*   **Espace :** $\mathcal{O}(1)$ en version itérative, $\mathcal{O}(\log n)$ en version récursive (pile d'appels).

### C. Tableau comparatif du nombre de comparaisons dans le pire des cas :

| Taille des données ($n$) | Recherche séquentielle ($\Theta(n)$) | Recherche dichotomique ($\Theta(\log n)$) |
| :--- | :--- | :--- |
| **$10^3$ (mille)** | $1\ 000$ | $10$ |
| **$10^6$ (un million)** | $1\ 000\ 000$ | $20$ |
| **$10^9$ (un milliard)** | $1\ 000\ 000\ 000$ | **$30$** |

*Remarque d'ingénierie :* Si l'on n'effectue qu'une **seule recherche**, trier le tableau d'abord ($\mathcal{O}(n \log n)$) est inutilement coûteux. La dichotomie devient rentable lorsque le tableau est statique et subit de **nombreuses recherches concurrentes**.

## VI.2 Étude de cas : Algorithmes de tri (Axe Génie Logiciel)
L'évaluation des performances des tris confirme cette hiérarchie :
*   **Tri par Insertion :** Simple à implémenter, complexité de $\Theta(n)$ si le tableau est déjà trié, mais quadratique en $\Theta(n^2)$ dans le pire et cas moyen.
*   **Tri Fusion (*Merge Sort*) :** Diviser pour régner rigoureux, garantit un coût stable de $\Theta(n \log n)$ dans tous les cas, mais requiert un espace mémoire additionnel de $\mathcal{O}(n)$.
*   **Tri Rapide (*Quicksort*) :** Complexité moyenne de $\Theta(n \log n)$ avec une constante multiplicative très faible (tri "en place"), mais dégénère en $\Theta(n^2)$ dans le pire des cas si le choix du pivot est malheureux.

## VI.3 Limites de l'analyse théorique

L'analyse asymptotique, bien que robuste, présente des abstractions par rapport aux architectures physiques :
*   **Les constantes sont ignorées :** Un algorithme en $1000n$ est asymptotiquement meilleur qu'un algorithme en $n^2$, mais reste plus lent pour toutes les entrées $n < 1000$.
*   **Le modèle RAM est idéalisé :** Il suppose que l'accès est immédiat et uniforme. En réalité, l'effet de la **mémoire cache CPU** et les architectures de bus favorisent la contiguïté des données.
*   **Le pire cas peut être trop pessimiste :** Le Tri Rapide est quadratique au pire, mais ses performances moyennes en font le tri le plus rapide en pratique sur les machines réelles.
