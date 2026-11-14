# V. Applications Systèmes, Services Distribués et Big Data (Master RSD / IA)

Les structures d'arbres multi-voies constituent la fondation technologique incontournable des infrastructures modernes de persistance de données distribuées et de gestion de volumes de fichiers massifs à l'échelle internationale.

## V.1 Moteurs d'indexation dans les SGBD Relationnels et NoSQL

Pour éviter d'examiner linéairement des millions d'enregistrements (coût prohibif en $\mathcal{O}(n)$), les Systèmes de Gestion de Bases de Données (SGBD) déploient des index basés majoritairement sur les variantes de B-Arbres :
*   **Index Primaires et Secondaires (Moteur MySQL InnoDB) :** La table elle-même est organisée sous forme de $B^+$-Arbre indexé selon la clé primaire (concept d'index clustérisé). Les index secondaires stockent des clés pointant vers l'index primaire. Une requête unitaire effectue une recherche en $\mathcal{O}(\log_t n)$, réduisant le balayage de la table à seulement 3 ou 4 lectures de pages physiques.
*   **Optimisation des requêtes complexes :** Le chaînage horizontal des feuilles des $B^+$-Arbres est exploité nativement pour accélérer les opérations de tri (`ORDER BY`), la recherche des bornes (`MIN`/`MAX`) et le balayage des intervalles (clauses `BETWEEN`).
*   **Écosystème industriel :** Cette architecture est partagée par les leaders relationnels (PostgreSQL, Oracle, SQLite) et NoSQL (MongoDB pour le partitionnement des données réparties).

## V.2 Organisation des métadonnées dans les Systèmes de Fichiers modernes

Un système de fichiers doit localiser instantanément les blocs de données d'un fichier parmi des millions de répertoires stockés sur le disque secondaire.

### Matrice d'utilisation des B-Arbres par les Systèmes de Fichiers :

| Système de fichiers | OS de référence | Architecture d'implémentation du B-Arbre / $B^+$-Arbre |
| :--- | :--- | :--- |
| **NTFS** | Windows | Indexation des répertoires et de la *Master File Table* (MFT) en $B^+$-Arbres. |
| **Btrfs** | Linux | Structure globale unifiée en arbres B-Arbres *Copy-on-Write* (CoW). |
| **XFS** | Linux | Profilage et exploitation des $B^+$-Arbres pour la gestion des extents, des inodes et des répertoires. |
| **HFS+ / APFS** | Apple macOS / iOS | Catalogue des fichiers et métadonnées structuré entièrement en B-Arbres. |
| **ext4** | Linux | Indexation des répertoires via la structure **HTree** (B-Arbre de profondeur limitée indexé par hachage). |

## V.3 B-Arbres dans les architectures distribuées et le stockage clé-valeur de masse

Au sein des infrastructures de l'option **Réseaux et Services Distribués (RSD)**, l'usage des B-Arbres s'étend aux magasins de stockage orientés clé-valeur distribués de haute performance (Big Table, Cassandra, HBase du pôle Big Data / IA). Ils permettent de structurer efficacement les caches de métadonnées au niveau des routeurs ou des nœuds de stockage cloud. L'architecture multi-voie exploite idéalement la localité des blocs mémoire et interagit de façon transparente avec les caches du processeur pour réduire l'overhead de communication lors des accès concurrents massifs, assurant le maintien des débits sur les liaisons de télécommunication.
