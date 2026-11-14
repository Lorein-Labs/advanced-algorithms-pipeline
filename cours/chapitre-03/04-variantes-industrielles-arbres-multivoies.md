# IV. Variantes Industrielles des Arbres Multi-voies

Pour s'adapter de façon optimale aux contraintes des bases de données réparties et des index de systèmes de fichiers à grande échelle, l'architecture des structures multi-voies se décline en deux variantes industrielles majeures.

## IV.1 Le $B^+$-Arbre : Séparation stricte de l'index et des données

Dans un $B^+$-Arbre, l'information subit une ségrégation fonctionnelle totale entre les niveaux de routage et les zones de stockage :
*   **Les nœuds internes (Index) :** Ils contiennent uniquement des clés de routage (copies servant d'index) et des pointeurs de blocs vers les nœuds enfants. Aucune donnée ou enregistrement applicatif n'y est toléré.
*   **Les nœuds feuilles (Données) :** Ils regroupent l'intégralité des clés couplées à leurs enregistrements de données réels.
*   **Chaînage horizontal :** Toutes les feuilles sont interconnectées horizontalement par une liste chaînée linéaire, permettant des pointeurs directs de feuille à feuille successives.

### Mécanisme spécifique d'éclatement :
Lorsqu'une feuille déborde dans un $B^+$-Arbre, la clé médiane est **copiée** dans le parent (elle reste présente dans la feuille gauche pour préserver l'intégrité de la séquence de données), alors que dans un B-arbre classique, la clé médiane est déplacée. Toute recherche, même réussie, descend obligatoirement jusqu'au niveau de la feuille, garantissant un temps d'accès prévisible et constant de hauteur $h$.

## IV.2 Le $B^*$-Arbre : Optimisation du taux de remplissage minimal à $\frac{2}{3}$

Le $B^*$-Arbre pousse l'exigence d'économie d'espace et de compacité plus loin que le B-Arbre classique :
*   **Remplissage garanti :** Chaque nœud interne (hors racine) doit être maintenu rempli à au moins **$2/3$ (soit $66\%$)** de sa capacité maximale, au lieu de $1/2$ ($50\%$) pour le standard.
*   **Éclatement différé par redistribution :** Lorsqu'un nœud s'apprête à déborder, l'algorithme n'exécute pas immédiatement une scission. Il examine le nœud frère adjacent et y **redistribue** d'abord les clés excédentaires via le parent. Ce n'est que lorsque les deux frères adjacents sont saturés qu'un éclatement combiné intervient, transformant 2 nœuds pleins en 3 nœuds remplis à $2/3$ (éclatement de structure unitaire $$2 \to 3$$).

## IV.3 Matrice comparative globale des structures multi-voies

| Critère d'évaluation | B-Arbre Classique | $B^+$-Arbre | $B^*$-Arbre |
| :--- | :--- | :--- | :--- |
| **Données stockées** | Dans tous les nœuds (internes/feuilles) | **Uniquement dans les feuilles** | Uniquement dans les feuilles |
| **Contenu des nœuds internes** | Clés + Données + Pointeurs | Clés de routage uniquement | Clés de routage uniquement |
| **Feuilles chaînées** | Non, pas de lien horizontal | **Oui (Liste chaînée continue)** | Oui (Liste chaînée continue) |
| **Remplissage minimal** | $\approx 1/2$ ($50\%$ des emplacements) | $\approx 1/2$ ($50\%$ des emplacements) | **$\approx 2/3$ ($66\%$ des emplacements)** |
| **Recherche unitaire** | Peut s'arrêter à un nœud interne | Descend toujours jusqu'à la feuille | Descend toujours jusqu'à la feuille |
| **Éclatement standard** | La clé médiane monte et est déplacée | La clé médiane est copiée dans le parent | Éclatement différé (Mécanisme $$2 \to 3$$) |
| **Usage préférentiel** | Structures de stockage génériques | **Index de SGBD (MySQL, Oracle)** | Systèmes de fichiers haute densité |
