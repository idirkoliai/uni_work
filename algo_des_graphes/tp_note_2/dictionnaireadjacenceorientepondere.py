"""
Anthony Labarre (c) 2024

Implémentation d'un graphe orienté pondéré à l'aide d'un dictionnaire : les
clés sont les sommets, et les valeurs sont les successeurs du sommet donné. Les
boucles sont autorisées.
"""
# Imports ---------------------------------------------------------------------
# ----- Imports standards -----------------------------------------------------
# ----- Mes modules -----------------------------------------------------------
from dictionnaireadjacenceoriente import DictionnaireAdjacenceOriente


class DictionnaireAdjacenceOrientePondere(DictionnaireAdjacenceOriente):
    def ajouter_arc(self, u, v, poids=None):
        """Ajoute un arc du sommmet u vers le sommet v, en créant les sommets
        manquants le cas échéant.

        Le paramètre poids est à None car la signature d'une méthode héritée doit correspondre avec
        celle de la méthode d'origine. En pratique, ajouter un arc de poids None à un graphe
        pondéré n'a pas de sens, et on s'attendra à ce que l'utilisateur fournisse explicitement un
        poids.
        """
        # ajout de v aux successeurs de u avec le poids donné
        self._dictionnaire[u][v] = poids
        # ajout du sommet v au dictionnaire s'il n'existe pas
        if v not in self._dictionnaire:
            self.ajouter_sommet(v)

    def ajouter_arcs(self, iterable):
        """Ajoute tous les arcs de l'itérable donné au graphe. N'importe
        quel type d'itérable est acceptable, mais il faut qu'il ne contienne
        que des triplets d'éléments (quel que soit le type du triplet).

        Contrairement à ajouter_arc, le poids doit ici être explicitement donné, sinon la méthode
        plantera.
        """
        for u, v, poids in iterable:
            self.ajouter_arc(u, v, poids)

    def arcs(self):
        """Renvoie l'ensemble des arcs du graphe. Un arc est représenté par un tuple (a, b, poids)."""
        return {
            (u, v, poids) for u in self._dictionnaire
            for v, poids in self._dictionnaire[u].items()
        }

    def boucles(self):
        """Renvoie les boucles du graphe, c'est-à-dire les arcs reliant un
        sommet à lui-même."""
        return {
            (u, u, self._dictionnaire[u][u]) for u in self._dictionnaire
            if u in self._dictionnaire[u]
        }

    def poids_arc(self, u, v):
        """Renvoie le poids de l'arc entre u et v, ou plante s'il n'existe pas.

        >>> G = DictionnaireAdjacenceOrientePondere()
        >>> G.ajouter_arc(1, 2, 3)
        >>> G.poids_arc(1, 2)
        3
        """
        return self._dictionnaire[u][v]

    def sous_graphe_induit(self, iterable):
        """Renvoie le sous-graphe induit par l'itérable de sommets donné."""
        retval = type(self)()
        retval.ajouter_sommets(iterable)
        for u, v, poids in self.arcs():
            if retval.contient_sommet(u) and retval.contient_sommet(v):
                retval.ajouter_arc(u, v, poids)

        return retval


def main():
    import doctest
    doctest.testmod()


if __name__ == "__main__":
    main()
