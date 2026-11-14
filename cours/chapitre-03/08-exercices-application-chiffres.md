# VIII. Exercices Corrigés et Travaux Dirigés — Les B-Arbres

## Exercice 1 : Calcul des bornes de remplissage selon l'Ordre $m$ et le Degré $t$

### Énoncé :
Soit un B-Arbre d'ordre $m = 5$ (selon la convention de Knuth).  
1. Donner l'équivalent du degré minimal $t$ selon la convention CLRS.  
2. Calculer le nombre minimal et maximal de clés tolérées dans un nœud interne non racine.  
3. Calculer le nombre minimal et maximal de pointeurs enfants qu'un tel nœud peut posséder.

### Résolution détaillée :
1. **Calcul du degré minimal $t$ :** La relation d'équivalence formelle impose :
   $$t = \lceil m/2 \rceil = \lceil 5/2 \rceil = \lceil 2,5 \rceil = 3$$
2. **Bornes des clés ($n_x$) :**  
   - *Minimum :* $t - 1 = 3 - 1 = \mathbf{2} \text{ clés}$.  
   - *Maximum :* $2t - 1 = (2 \times 3) - 1 = \mathbf{5 - 1 = 4} \text{ clés}$.  
3. **Bornes des pointeurs enfants ($c_x$) :** Un nœud contenant $n_x$ clés possède exactement $n_x + 1$ enfants.
   - *Minimum :* $(t - 1) + 1 = t = \mathbf{3} \text{ pointeurs}$.
   - *Maximum :* $(2t - 1) + 1 = 2t = \mathbf{5} \text{ pointeurs}$.

## Exercice 2 : Calculs de hauteurs maximales sur des volumes massifs ($10^6$ et $10^9$)

### Énoncé :
Soit un B-Arbre de degré minimal $t = 100$. Calculer la hauteur maximale théorique $h$ de l'arbre s'il stocke :
1. $n = 10^6$ (un million) de clés.
2. $n = 10^9$ (un milliard) de clés.

### Résolution détaillée :
La propriété de hauteur maximale garantie s'exprime par la borne display unifiée :
$$h \le \log_t \left( \frac{n + 1}{2} \right) = \frac{\log_{10} \left( \frac{n + 1}{2} \right)}{\log_{10} t}$$

1. Pour un volume d'un million d'éléments ($n = 10^6$) :
   $$\frac{10^6 + 1}{2} = 500\ 000,5 \;\Rightarrow\; \log_{10}(500\ 000,5) \approx 5,6989$$
   $$\log_{10}(100) = 2 \;\Rightarrow\; h \le \frac{5,6989}{2} = 2,849 \implies \mathbf{h_{\max} = 2}$$
2. Pour un volume d'un milliard d'éléments ($n = 10^9$) :
   $$\frac{10^9 + 1}{2} = 500\ 000\ 000,5 \;\Rightarrow\; \log_{10}(500\ 000\ 000,5) \approx 8,6989$$
   $$h \le \frac{8,6989}{2} = 4,349 \implies \mathbf{h_{\max} = 4}$$

**Analyse critique :** Même face à un milliard de lignes de logs protocolaires, l'infrastructure distribuée ne fera jamais plus de 4 accès disques physiques pour localiser une information.

## Exercice 3 : Dimensionnement d'une page disque physique de 8 Ko

### Énoncé :
Un ingénieur du pôle RSD configure un serveur de stockage avec des pages physiques de $B = 8\ 192$ octets. On indexe des enregistrements dont les clés font $K = 16$ octets, et les pointeurs de blocs font $P = 8$ octets. L'en-tête système fixe de bas niveau fait $H = 32$ octets.    
Calculer l'ordre maximal $m$ optimal pour que le nœud occupe exactement une page sans débordement.

### Résolution détaillée :
L'inéquation d'occupation physique d'un nœud plein à sa capacité maximale ($m-1$ clés et $m$ pointeurs) s'isole sous la forme :
$$H + ((m - 1) \cdot K) + (m \cdot P) \le B$$
$$32 + ((m - 1) \cdot 16) + (m \cdot 8) \le 8\ 192$$
$$32 + 16m - 16 + 8m \le 8\ 192 \;\Rightarrow\; 24m + 16 \le 8\ 192$$
$$24m \le 8\ 176 \;\Rightarrow\; m \le \frac{8\ 176}{24} \approx 340,66 \implies \mathbf{m = 340}$$

Le degré minimal CLRS équivalent s'établit à : $t = \lceil 340/2 \rceil = \mathbf{170}$.

## Exercice 4 : Déroulement pas à pas d'insertions avec éclatements successifs

### Énoncé :
Soit un B-Arbre initialement vide de degré minimal $t = 2$ (ordre $m=4$, max 3 clés par nœud). Tracer l'évolution de la structure lors de l'insertion de la séquence ordonnée : $10, 20, 30, 40, 50$.

### Évolution pas à pas :
1. **Insertion de $10, 20, 30$ :** Les clés s'allouent directement dans la racine-feuille.
   $$\text{Nœud racine : } [10, 20, 30] \quad (\text{Le nœud est saturé})$$
2. **Insertion de $40$ :** Détection préventive du nœud plein $\rightarrow$ Éclatement de la racine. La clé médiane `20` monte pour former une nouvelle racine. Les clés `10` (gauche) et `30` (droite) forment deux feuilles sœurs. La hauteur passe à $h=2$. En raison de l'inéquation $40 > 20$, il descend à droite.
   $$\text{Racine : } [20]$$
   $$\text{Enfant gauche : } [10] \quad \text{Enfant droit : } [30, 40]$$
3. **Insertion de $50$ :** L'algorithme descend dans l'enfant droit $[30, 40]$. Comme il reste de la place ($2 \le 3$), il s'insère à la suite de la feuille contiguë.
   $$\text{Racine : } [20]$$  
   $$\text{Enfant gauche : } [10] \quad \text{Enfant droit : } [30, 40, 50] \quad (\text{Saturé})$$

## Exercice 5 : Déroulement pas à pas de suppressions (Emprunt et Fusion)

### Énoncé :
Soit la structure finale obtenue à l'exercice précédent : Racine $[20]$, gauche $[10]$, droite $[30, 40, 50]$ ($t=2$). Supprimer la clé $10$, puis la clé $20$.

### Évolution pas à pas :
1. **Suppression de $10$ :** La clé $10$ est dans la feuille gauche. Supprimer $10$ ferait descendre le nœud à $0$ clé, violant la borne minimale ($t-1 = 1$ clé).
   - *Mécanisme d'Emprunt (Redistribution) :* Le frère adjacent $[30, 40, 50]$ possède $3$ clés ($\ge t$). On effectue une rotation dans la racine.
     $$\text{Enfant gauche : } [20] \quad \text{Enfant droit : } [40, 50]$$
2. **Suppression de $20$ :** Elle est située dans la feuille gauche, qui contient exactement le minimum ($1$ clé). Sa suppression déclenche un underflow. Comme le frère $[40, 50]$ n'a plus de clé en excès (il a $2$ clés, le minimum étant $1$ après retrait), l'emprunt est impossible.
   - *Mécanisme de Fusion (Merging) :* On fusionne le nœud gauche, le nœud droit et la clé séparatrice de la racine ($30$). La racine se vide, l'arbre perd un niveau ($h=1$).
     $$\text{Nœud unique racine-feuille : } [30, 40, 50]$$

## Exercice 6 : Comparaison B-Arbre vs $B^+$-Arbre sur une requête avec clause `BETWEEN`

### Énoncé :
Expliquer géométriquement pourquoi l'exécution de la requête SQL `SELECT * FROM USERS WHERE id BETWEEN 100 AND 105` est plus performante sur un $B^+$-Arbre que sur un B-Arbre classique, en détaillant le nombre de parcours de branches requis.

### Analyse comparative :
*   **Dans un B-Arbre classique :** Les clés et les données sont réparties sur tous les niveaux. L'algorithme doit d'abord rechercher la clé $100$ par descente arborescente. Pour trouver $101, 102, \dots$, il doit effectuer des remontées compliquées vers les nœuds parents (parcours infixe) et redescendre dans d'autres branches, multipliant les opérations CPU et le rechargement de pages en RAM.
*   **Dans un $B^+$-Arbre :** L'indexation est strictement confinée au dernier niveau, et toutes les feuilles sont chaînées horizontalement. L'algorithme descend **une seule fois** de la racine vers la feuille pour localiser la borne inférieure $100$ (coût $\mathcal{O}(\log_t n)$). Une fois sur la feuille, il lui suffit de lire séquentiellement les éléments contigus via la liste chaînée horizontale jusqu'à lire la clé $105$. Le nombre d'accès disques est optimisé au maximum pour les bases de données distribuées.
