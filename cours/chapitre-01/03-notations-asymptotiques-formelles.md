# III. Les Notations Asymptotiques Formelles

L'analyse asymptotique décrit le comportement d'une fonction de complexité $f(n)$ lorsque la taille des données devient très grande ($n \rightarrow \infty$), en s'affranchissant des constantes multiplicatives et des détails matériels.

## III.1 Définitions formelles des Notations Asymptotiques

### Notation Grand $\mathcal{O}$ (Borne supérieure asymptotique)
$$f(n) = \mathcal{O}(g(n)) \;\Leftrightarrow\; \exists c > 0, \exists n_{0} \ge 0, \forall n \ge n_{0}, 0 \le f(n) \le c \cdot g(n)$$

### Notation Grand $\Omega$ (Borne inférieure asymptotique)
$$f(n) = \Omega(g(n)) \;\Leftrightarrow\; \exists c > 0, \exists n_{0} \ge 0, \forall n \ge n_{0}, 0 \le c \cdot g(n) \le f(n)$$

### Notation Grand $\Theta$ (Borne asymptotique étroite)
$$f(n) = \Theta(g(n)) \;\Leftrightarrow\; \exists c_{1} > 0, \exists c_{2} > 0, \exists n_{0} \ge 0, \forall n \ge n_{0}, 0 \le c_{1} \cdot g(n) \le f(n) \le c_{2} \cdot g(n)$$

### Notation petit $o$ (Domination stricte)
$$f(n) = o(g(n)) \;\Leftrightarrow\; \forall c > 0, \exists n_{0} \ge 0, \forall n \ge n_{0}, 0 \le f(n) < c \cdot g(n)$$

### Notation petit $\omega$ (Minoration stricte)
$$f(n) = \omega(g(n)) \;\Leftrightarrow\; \forall c > 0, \exists n_{0} \ge 0, \forall n \ge n_{0}, 0 \le c \cdot g(n) < f(n)$$

## III.2 Caractérisation mathématique par les limites

| Notation | Sens Intuitif | Analogie | Caractérisation par la limite |
| :--- | :--- | :--- | :--- |
| $f = \mathcal{O}(g)$ | $f \le g$ (à une constante près) | $\le$ | $\lim_{n \to \infty} \frac{f(n)}{g(n)} < +\infty$ |
| $f = o(g)$ | $f < g$ (strictement) | $<$ | $\lim_{n \to \infty} \frac{f(n)}{g(n)} = 0$ |
| $f = \Theta(g)$ | $f = g$ (même ordre de grandeur) | $=$ | $0 < \lim_{n \to \infty} \frac{f(n)}{g(n)} < +\infty$ |
| $f = \Omega(g)$ | $f \ge g$ (à une constante près) | $\ge$ | $\lim_{n \to \infty} \frac{f(n)}{g(n)} > 0$ |

## III.3 Propriétés algébriques et règles de calcul

Pour manipuler sereinement les fonctions lors des calculs de complexité avancés, l'analyse mathématique s'appuie sur les lois algébriques universelles suivantes :

*   **Réflexivité :** $f = \mathcal{O}(f)$, $f = \Omega(f)$ et $f = \Theta(f)$.
*   **Transitivité :** Si $f = \mathcal{O}(g)$ et $g = \mathcal{O}(h)$, alors $f = \mathcal{O}(h)$ (propriété identique pour $\Omega$ et $\Theta$).
*   **Symétrie de $\Theta$ :** $f = \Theta(g) \Leftrightarrow g = \Theta(f)$.
*   **Dualité :** $f = \mathcal{O}(g) \Leftrightarrow g = \Omega(f)$ et $f = o(g) \Leftrightarrow g = \omega(f)$.
*   **Règle de la Somme :** $\mathcal{O}(f(n)) + \mathcal{O}(g(n)) = \mathcal{O}(\max(f(n), g(n)))$.
*   **Règle du Produit :** $\mathcal{O}(f(n)) \cdot \mathcal{O}(g(n)) = \mathcal{O}(f(n) \cdot g(n))$.

---

Pour valider l'exactitude des démonstrations de ces bornes, le lecteur se reportera aux protocoles de vérification scientifique basés sur le Chapitre 3 de `[CLRS-2022]`.
