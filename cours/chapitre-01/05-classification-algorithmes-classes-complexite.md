# V. Classification des Algorithmes et Hiérarchie des Complexités

Pour évaluer la faisabilité d'un traitement informatique à grande échelle, la théorie de la complexité regroupe les fonctions de croissance selon une hiérarchie asymptotique stricte.

## V.1 L'échelle des complexités usuelles

Soit $n$ la taille des données d'entrée. L'ordre de croissance des fonctions de complexité s'établit selon la chaîne d'inégalités immuable suivante :
$$1 < \log n < \sqrt{n} < n < n \log n < n^2 < n^3 < n^k < 2^n < n! < n^n$$

### Matrice de caractérisation des classes de croissance :

| Notation | Nom de la classe | Exemple typique d'application | Appréciation générale |
| :--- | :--- | :--- | :--- |
| $\mathcal{O}(1)$ | Constante | Accès à $T[i]$, ajout en tête de liste | Très favorable |
| $\mathcal{O}(\log n)$ | Logarithmique | Recherche dichotomique dans un dictionnaire trié | Très favorable |
| $\mathcal{O}(n)$ | Linéaire | Parcours simple d'un tableau, somme | Favorable |
| $\mathcal{O}(n \log n)$ | Quasi-linéaire | Tri fusion (*Merge Sort*), tri par tas | Favorable (grandes entrées) |
| $\mathcal{O}(n^2)$ | Quadratique | Tri à bulles, tri par insertion, boucles imbriquées | Peut devenir coûteux |
| $\mathcal{O}(n^3)$ | Cubique | Multiplication matricielle naïve | Coûteux |
| $\mathcal{O}(n^k)$ | Polynomiale ($k > 2$) | Multiplication de matrices généralisée | Coûteux et lourd |
| $\mathcal{O}(2^n)$ | Exponentielle | Énumération des sous-ensembles, Hanoï | Très coûteux / Explosion |
| $\mathcal{O}(n!)$ | Factorielle | Énumération des permutations, Voyageur de commerce | Extrêmement coûteux |

## V.2 Introduction aux Classes de Problèmes ($\text{P}$, $\text{NP}$, $\text{NP-Complet}$, $\text{NP-Difficile}$)

La classification ne s'applique pas uniquement aux algorithmes, mais caractérise la difficulté intrinsèque des **problèmes de décision** (problèmes dont la réponse est binaire : Oui/Non).

*   **Classe $\text{P}$ (Problèmes faciles/traitables) :** Ensemble des problèmes décidables par un algorithme déterministe en temps polynomial, c'est-à-dire en $\mathcal{O}(n^k)$ pour une constante $k$ (ex : Recherche d'un élément, calcul du PGCD, plus court chemin via Dijkstra).
*   **Classe $\text{NP}$ (Vérification polynomiale — Option Cybersécurité) :** Ensemble des problèmes pour lesquels il existe un algorithme polynomial capable de **vérifier la validité d'une solution candidate** fournie sous la forme d'une preuve textuelle appelée **certificat** (ex : Problème du sac à dos, coloration de graphe). Évidemment, $\text{P} \subseteq \text{NP}$. La sécurité des systèmes cryptographiques modernes (RSA, briques de chiffrement de l'option Cybersécurité) repose sur l'hypothèse de non-calculabilité polynomiale de la clé privée à partir de la clé publique.
*   **Problème $\text{NP-Difficile}$ :** Un problème est $\text{NP-difficile}$ s'il est au moins aussi difficile que tout problème de $\text{NP}$ (tout problème de $\text{NP}$ se réduit à lui en temps polynomial). Il n'appartient pas nécessairement à la classe $\text{NP}$.
*   **Problème $\text{NP-Complet}$ (Les plus difficiles de $\text{NP}$) :** Un problème est $\text{NP-complet}$ s'il appartient à la fois à la classe $\text{NP}$ et est $\text{NP-difficile}$. Ils concentrent la plus grande complexité combinatoire.

### Synthèse structurelle des classes de complexité :

| Classe | Caractéristique formelle | Exemples de référence |
| :--- | :--- | :--- |
| **$\text{P}$** | Résolution en temps polynomial | Tri, PGCD, Plus court chemin (Dijkstra) |
| **$\text{NP}$** | Vérification en temps polynomial | Factorisation d'entiers, Isomorphisme de graphes |
| **$\text{NP-Complet}$**| Le noyau le plus dur de $\text{NP}$ | SAT, 3-Coloration, Sac à dos, Voyageur de commerce |

### Question ouverte du millénaire :
La conjecture scientifique actuelle soutient que $\text{P} \neq \text{NP}$, signifiant que le pouvoir de résoudre un problème est fondamentalement distinct de celui de vérifier une solution. La preuve formelle de cette égalité ou inégalité est l'un des sept problèmes du prix Clay du millénaire, doté d'une récompense d'un million de dollars. Si un algorithme polynomial était découvert pour un unique problème $\text{NP-complet}$, alors $\text{P} = \text{NP}$, provoquant l'effondrement immédiat des systèmes de sécurité cryptographiques mondiaux.
