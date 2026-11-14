# II. Analyse Théorique des Hauteurs et Coûts d'Entrées/Sorties Physiques

L'excellence opérationnelle des B-Arbres au sein des architectures distribuées repose sur deux propriétés mathématiques fondamentales : la compression logarithmique stricte de leur hauteur et l'alignement géométrique des nœuds sur la granularité des blocs de stockage physiques.

## II.1 Démonstration Mathématique de la Hauteur Logarithmique Maximale

Pour garantir un temps de réponse prévisible et borné, le B-Arbre maintient son équilibre parfait en forçant toutes ses feuilles à résider à la même profondeur. Nous démontrons ici de façon immuable la borne supérieure de la hauteur $h$ d'un B-Arbre contenant $n$ clés, pour un degré minimal $t \ge 2$.

### Théorème de la Hauteur Maximale
Si un B-Arbre de hauteur $h$ contient $n$ clés et possède un degré minimal $t \ge 2$, alors sa hauteur vérifie rigoureusement l'inégalité de structure suivante :
$$h \le \log_{t} \left( \frac{n + 1}{2} \right)$$

### Démonstration Formelle
Pour maximiser la hauteur $h$ d'un arbre contenant un nombre fixe de clés, il faut minimiser le nombre de clés présentes à chaque niveau de la structure, conformément aux invariants définis par la convention CLRS :
*   **Niveau 0 (Racine) :** Contient au moins $1$ clé (et possède donc au moins $2$ enfants).
*   **Niveau 1 :** Contient au moins $2$ nœuds, chacun abritant le minimum autorisé de $t - 1$ clés.
*   **Niveau 2 :** Chaque nœud du niveau 1 possédant au moins $t$ enfants, le niveau 2 compte au moins $2t$ nœuds.
*   **Niveau $i$ (pour $1 \le i \le h$) :** Le nombre de nœuds présents est minoré par $2t^{i-1}$, chacun contenant au moins $t - 1$ clés.

Le nombre total de clés $n$ au sein de l'arbre est donc minoré par la somme des clés de chaque niveau :
$$n \ge 1 + \sum_{i=1}^{h} 2t^{i-1}(t - 1)$$

Exploitons la propriété mathématique des séries géométriques pour simplifier cette sommation :
$$n \ge 1 + 2(t - 1) \sum_{i=1}^{h} t^{i-1} = 1 + 2(t - 1) \left( \frac{t^{h} - 1}{t - 1} \right)$$
$$n \ge 1 + 2(t^{h} - 1) = 2t^{h} - 1$$

Isolons le terme exponentiel de hauteur $t^{h}$ afin d'en extraire la borne :
$$n + 1 \ge 2t^{h} \;\Rightarrow\; \frac{n + 1}{2} \ge t^{h}$$

En appliquant le logarithme en base $t$ de part et d'autre de l'inégalité (la fonction logarithme étant strictement croissante pour un degré minimal $t \ge 2$), nous validons la borne supérieure de manière universelle :
$$h \le \log_{t} \left( \frac{n + 1}{2} \right)$$

Cette démonstration prouve que la complexité de recherche dans le pire des cas est strictement confinée à $\Theta(\log_{t} n)$, garantissant une performance industrielle de premier ordre.

## II.2 Évaluation du Modèle de Coût Physique et Optimisation des Pages Disques

En ingénierie de stockage de masse, le coût d'une instruction CPU en mémoire vive (RAM) est négligeable face à la latence d'une opération d'Entrée/Sortie ($I/O$) sur disque secondaire. L'analyse algorithmique des structures multi-voies distingue donc deux indicateurs de performance stricts :

1.  **Le nombre d'accès disques ($I/O$) :** C'est le facteur dominant. Chaque nœud du B-Arbre est dimensionné pour occuper exactement la taille d'une page physique du disque (généralement 4 Ko ou 8 Ko). Un nœud est lu ou écrit en un seul accès matériel explicite via l'appel des primitives réglementaires `DISK-READ` et `DISK-WRITE`.
2.  **Le temps de calcul interne (Temps CPU) :** Une fois la page de 4 Ko chargée en RAM, le processeur exécute une recherche locale parmi les $m-1$ clés du nœud. L'usage de la recherche dichotomique au sein du nœud garantit un coût interne confiné à $\mathcal{O}(\log t)$.

### Tableau Matriciel d'Évaluation des Opérations
Le tableau ci-dessous synthétise la supériorité théorique et physique du B-Arbre face aux structures binaires classiques (arbres AVL, Rouge-Noir) pour un volume massif d'un milliard de clés ($n = 10^9$) :

| Paramètre d'Analyse | Arbre Binaire Auto-Équilibré (AVL / RBT) | B-Arbre / $B^+$-Arbre ($t = 100$) | Impact sur l'Infrastructure RSD |
| :--- | :--- | :--- | :--- |
| **Nombre d'enfants par nœud** | Strictement $2$ (Structure binaire) | Jusqu'à $m$ (Des centaines de fils) | Réduction drastique de la dispersion |
| **Hauteur maximale ($h$)** | Élevée ($30 \le h \le 43$ niveaux) | Compressée ($3 \le h \le 4$ niveaux) | Aplatissement de l'arbre de recherche |
| **Lectures physiques disques**| $30$ à $43$ accès disques distincts | **$3$ à $4$ accès disques maximum** | Élimination des goulots d'étranglement |
| **Temps de réponse moyen** | $\approx 400$ ms (Latence prohibitive) | **$\le 40$ ms (Performance temps-réel)**| Minimisation de la latence réseau |
| **Usage préférentiel** | Optimisé pour la mémoire vive (RAM) | **Souverain pour le stockage de masse**| Standard pour les SGBD et FS |

### Analyse de l'Espace et Taux de Remplissage Garanti
L'invariant de structure impose que chaque nœud (hors racine) soit maintenu rempli à au moins 50 % de sa capacité maximale. En environnement industriel, l'analyse empirique montre que le taux de remplissage moyen se stabilise autour de $69 \%$ ($\ln 2$) pour des insertions aléatoires, assurant une excellente densité de stockage et limitant le gaspillage d'espace disque secondaire sur le serveur.
