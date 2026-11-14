# VI. Confrontation technique : B-Arbres vs Arbres AVL vs Arbres Rouge-Noir

Les structures arborescentes auto-équilibrées en mémoire centrale (arbres AVL et Rouge-Noir) partagent la même complexité asymptotique théorique que les B-Arbres ($\mathcal{O}(\log n)$). Cependant, dès que l'échelle des données impose un stockage sur mémoire secondaire, l'architecture multi-voie se révèle indispensable.

## VI.1 Matrice d'évaluation structurelle et comportementale

| Critère d'analyse | Arbre AVL | Arbre Rouge-Noir | B-Arbre / $B^+$-Arbre |
| :--- | :--- | :--- | :--- |
| **Fils par nœud** | Strictement $2$ (Binaire) | Strictement $2$ (Binaire) | **Jusqu'à $m$ (Des centaines)** |
| **Hauteur maximale** | Strictement équilibrée ($< 1,44 \log_2 n$) | Plus lâche ($\le 2 \log_2 (n + 1)$) | **Ultra-compacte ($\sim \log_t n$)** |
| **Équilibrage** | Rotations fréquentes | Rotations + Récolorations | Éclatements / Fusions de pages |
| **Utilisation idéale** | Mémoire centrale, lectures fréquentes | Mémoire centrale, modifications fréquentes | **Disque secondaire, volumes massifs** |
| **Requête par intervalle**| Nécessite un parcours infixe complet | Nécessite un parcours infixe complet | **Excellente (Surtout $B^+$ via la liste)** |

## VI.2 Impact sur l'efficacité de la mémoire cache CPU et les E/S disques

La différence critique réside dans le modèle de coût physique : une opération d'E/S disque prend environ 10 ms, soit le temps d'exécuter des millions d'instructions CPU.

### Exemple chiffré pour un volume massif de $n = 10^9$ clés (Un milliard) :
*   **Arbres AVL & Rouge-Noir (Pôle RAM - Bureau) :** Leur nature binaire engendre une hauteur vertigineuse comprise entre 30 et 43 niveaux. Rechercher une clé implique de traverser jusqu'à 43 nœuds éparpillés en mémoire secondaire, provoquant 30 à 43 accès disques distincts. Le temps de réponse total avoisine les 400 ms.
*   **B-Arbre / $B^+$-Arbre (Stockage Cloud et RSD) :** Sa hauteur est compressée à seulement 3 ou 4 niveaux. Localiser la clé requiert uniquement 3 à 4 accès disques. Le temps de traitement descend sous la barre des 40 ms, offrant un gain d'un facteur 10.

## VI.3 Justification du choix architectural du B-Arbre

Le B-Arbre surclasse ses homologues binaires car chaque nœud forme un bloc contigu de données triées parfaitement aligné sur la taille des pages physiques du stockage (4 Ko ou 8 Ko). Lors d'un `DISK-READ`, le processeur charge d'un coup des centaines de clés en mémoire cache CPU. La recherche interne au nœud s'effectue alors à la vitesse de la RAM par dichotomie, éliminant les défauts de page (*page faults*) qui paralysent les arbres binaires. Les arbres binaires sont optimisés pour les structures en mémoire vive, tandis que les B-Arbres sont les rois incontestés de la persistance distribuée.
