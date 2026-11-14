# X. Références Normatives & Sources

La liste ci-dessous recense de façon unitaire les spécifications techniques de bas niveau, articles de recherche d'autorité et manuels d'ingénierie consultés pour l'élaboration de ce module sur les structures multi-voies.

::: {#chap3-bayer}
- [BAY-1972] Bayer R., McCreight E. M., "Organization and Maintenance of Large Ordered Indexes", Acta Informatica, 1972. [Springer Portal](https://springer.com)
:::

::: {#chap3-knuth3}
- [KNU-1998] Knuth D. E., "The Art of Computer Programming, Volume 3: Sorting and Searching (Second Edition)", Addison-Wesley, 1998. [Stanford Portal](https://stanford.edu)
:::

::: {#chap3-mysql}
- [ORAC-2024] Oracle Corporation, "MySQL 8.4 Reference Manual: InnoDB Page Structure and B-Tree Indexes", Oracle Standards, 2024. [MySQL Dev Documentation](https://mysql.com)
:::

::: {#chap3-avl}
- [AVL-1962] Adelson-Velsky G., Landis E., "An algorithm for the organization of information", Soviet Mathematics Doklady, 1962. [ACM Digital Library](https://acm.org)
:::

::: {#chap3-zfs}
- [BON-2013] Bonwick J., "ZFS: The Last Word in File Systems", Oracle/Sun Microsystems Specifications, 2013. [OpenZFS Repository](https://github.com)
:::

### Protocoles de vérification scientifique
- **Invariants et primitives de base des B-Arbres :** Les algorithmes originaux d'éclatement et de balance parfaite sont explicités dans l'article de recherche `[BAY-1972]`.
- **Variantes B+ et B* Arbres :** L'analyse du chaînage des feuilles et des éclatements différés $2 \to 3$ est vérifiable dans la **Section 6.2.4** de `[KNU-1998]`.
- **Applications aux systèmes de fichiers et SGBD :** Les architectures d'index clustérisés physiques sont auditables dans les manuels d'ingénierie `[ORAC-2024]` (moteur InnoDB) et `[BON-2013]` (Copy-on-Write d'OpenZFS).
