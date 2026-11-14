# VII. Évaluation Globale : Avantages et Limites des B-Arbres

L'utilisation des structures arborescentes multi-voies au sein des architectures de stockage massives répond à des compromis d'ingénierie stcrits qu'il convient de synthétiser.

## VII.1 Les Avantages

1.  **Nombre d'accès disques minimal :** Grâce au facteur de ramification massif ($2t$), la hauteur reste confinée entre 3 et 4 niveaux pour des milliards de clés, limitant les opérations physiques d'E/S.
2.  **Garantie d'équilibre parfait :** L'invariant structurel force toutes les feuilles à résider à la même profondeur, assurant des performances stables et prévisibles en $\Theta(\log n)$ dans le pire des cas.
3.  **Optimisation des E/S par blocs :** Un nœud correspond exactement à une page physique (4 Ko, 8 Ko), permettant de charger des centaines de clés en un seul accès matériel, exploitant idéalement la localité spatiale.
4.  **Opérations dynamiques performantes :** L'insertion et la suppression s'exécutent localement par éclatement (*splitting*) ou fusion (*merging*) de blocs sans nécessiter de réorganisation globale de la structure.
5.  **Excellent parcours par intervalles :** Les variantes comme le $B^+$-Arbre permettent, grâce au chaînage linéaire des feuilles, d'exécuter les requêtes par plages (clauses `BETWEEN`) sans remontées CPU vers les parents.

## VII.2 Les Limites

1.  **Complexité d'implémentation algorithmique :** La gestion bas niveau des cas aux limites (débordements, sous-dépassements, fusions et redistributions) impose un code difficile à programmer et sensible aux régressions.
2.  **Sous-utilisation de l'espace mémoire (Fragmentation interne) :** L'invariant du degré minimal garantit uniquement que les nœuds sont remplis à la moitié ($50\%$). Dans le pire des cas d'insertions aléatoires, jusqu'à 50 % de l'espace de chaque page disque peut rester vide, représentant une surcharge de stockage notable.
3.  **Coût CPU intra-nœud résiduel (Pénalisation de l'IA) :** Une fois le bloc chargé en RAM, le processeur doit balayer les clés locales par recherche linéaire ou dichotomique, ce qui engendre un coût de calcul non nul si $t$ est très grand, ce qui peut ralentir le traitement des algorithmes d'apprentissage automatique de l'option IA s'ils accèdent massivement aux métadonnées.
4.  **Amplification d'écriture sur disques SSD :** Insérer une simple clé de 32 octets dans un nœud plein impose l'éclatement et la réécriture complète de deux pages de 4 Ko (soit 8 192 octets) sur le disque secondaire. Cette amplification d'écriture fatigue prématurément les cellules flash des disques SSD modernes. Les charges à écriture intensive s'orientent parfois vers des structures de type **LSM-Tree** (*Log-Structured Merge-Tree*).
5.  **Gestion de la concurrence (Verrous) :** La modification d'un nœud impose de poser des verrous (*latches*) sur le chemin de descente pour éviter les incohérences lors d'accès concurrents massifs, limitant la scalabilité horizontale si l'arbre subit de nombreuses écritures simultanées.
6.  **Inadapté aux petites collections :** Pour une petite collection de données tenant entièrement en RAM, un arbre AVL, un arbre Rouge-Noir ou une simple table de hachage s'avèrent plus simples et performants (accès en $\mathcal{O}(1)$ en moyenne pour le hachage).
