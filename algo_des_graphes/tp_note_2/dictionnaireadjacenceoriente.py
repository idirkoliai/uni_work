"""
Anthony Labarre (c) 2024-2025

Implémentation d'un graphe orienté sur un modèle analogue au cas non orienté, pour les mêmes
raisons.

L'utilisation d'un dictionnaire unique pour les prédécesseurs et les
successeurs augmente la complexité des méthodes predecesseurs(sommet) et
degre_entrant(sommet). On peut les réduire en séparant le dictionnaire en deux
(self._predecesseurs et self._successeurs), ce qui n'a pas été fait car:

    1. ceci modifierait l'implémentation de nombreuses autres méthodes ;
    2. la représentation obtenue serait moins économe en mémoire ;
    3. les deux méthodes sus-citées sont relativement peu utilisées dans les
       algorithmes couverts dans le cours.

Pour des raisons de compatibilité, ce fichier ne contient pas de type hints.
"""
# Imports ---------------------------------------------------------------------
# ----- Imports standards -----------------------------------------------------
from collections import defaultdict
from itertools import chain


class DictionnaireAdjacenceOriente:
    def __init__(self):
        """Initialise un graphe sans arcs."""
        self._dictionnaire = defaultdict(lambda: defaultdict(None))

    def ajouter_arc(self, u, v, poids=None):
        """Ajoute un arc du sommet u vers le sommet v, en créant les sommets
        manquants le cas échéant."""
        # ajout de v parmi les successeurs de u
        self._dictionnaire[u][v] = poids
        # ajout du sommet v au dictionnaire s'il n'existe pas
        if v not in self._dictionnaire:
            self.ajouter_sommet(v)

    def ajouter_arcs(self, iterable):
        """Ajoute tous les arcs de l'itérable donné au graphe. N'importe
        quel type d'itérable est acceptable, mais il faut qu'il ne contienne
        que des couples d'éléments (quel que soit le type du couple)."""
        for u, v in iterable:
            self.ajouter_arc(u, v)

    def ajouter_sommet(self, sommet):
        """Ajoute un sommet (de n'importe quel type hashable) au graphe."""
        self._dictionnaire[sommet] = defaultdict(None)

    def ajouter_sommets(self, iterable):
        """Ajoute tous les sommets de l'itérable donné au graphe. N'importe
        quel type d'itérable est acceptable, mais il faut qu'il ne contienne
        que des éléments hashables."""
        for sommet in iterable:
            self.ajouter_sommet(sommet)

    def arcs(self):
        """Renvoie l'ensemble des arcs du graphe, représentés par des tuples.
        """
        return {
            (u, v) for u in self._dictionnaire for v in self._dictionnaire[u]
        }

    def arcs_sortants(self, v):
        """Renvoie l'ensemble des arcs sortant du sommet v, représentés par des
        tuples."""
        return {(v, w) for w in self._dictionnaire[v]}

    def boucles(self):
        """Renvoie les boucles du graphe, c'est-à-dire les arcs reliant un
        sommet à lui-même."""
        return {
            (u, u) for u in self._dictionnaire if u in self._dictionnaire[u]
        }

    def contient_arc(self, u, v):
        """Renvoie True si l'arc (u, v) existe, False sinon."""
        return v in self._dictionnaire[u]

    def contient_sommet(self, u):
        """Renvoie True si le sommet u existe, False sinon."""
        return u in self._dictionnaire

    def degre(self, sommet):
        """Renvoie le nombre de voisins du sommet ; s'il n'existe pas, provoque
        une erreur."""
        if sommet not in self._dictionnaire:
            raise ValueError("sommet " + str(sommet) + " inexistant")

        return self.degre_entrant(sommet) + self.degre_sortant(sommet)

    def degre_entrant(self, sommet):
        """Renvoie le nombre de prédécesseurs du sommet ; s'il n'existe pas,
        provoque une erreur."""
        if sommet not in self._dictionnaire:
            raise ValueError("sommet " + str(sommet) + " inexistant")

        return sum(
            sommet in self._dictionnaire[predecesseur]
            for predecesseur in self._dictionnaire
        )

    def degre_sortant(self, sommet):
        """Renvoie le nombre de successeurs du sommet ; s'il n'existe pas,
        provoque une erreur."""
        if sommet not in self._dictionnaire:
            raise ValueError("sommet " + str(sommet) + " inexistant")

        return len(self._dictionnaire[sommet])

    def nombre_arcs(self):
        """Renvoie le nombre d'arcs du graphe."""
        return sum(len(voisins) for voisins in self._dictionnaire.values())

    def nombre_boucles(self):
        """Renvoie le nombre d'arêtes de la forme {u, u}."""
        return len(self.boucles())

    def nombre_sommets(self):
        """Renvoie le nombre de sommets du graphe."""
        return len(self._dictionnaire)

    def predecesseurs(self, sommet):
        """Renvoie les prédécesseurs du sommet ; s'il n'existe pas, provoque une
        erreur."""
        if sommet not in self._dictionnaire:
            raise ValueError("sommet " + str(sommet) + " inexistant")

        return {
            predecesseur for predecesseur in self._dictionnaire
            if sommet in self._dictionnaire[predecesseur]
        }

    def retirer_arc(self, u, v):
        """Retire l'arc (u, v) s'il existe ; provoque une erreur sinon."""
        self._dictionnaire[u].pop(v)  # plante si u ou v n'existe pas

    def retirer_arcs(self, iterable):
        """Retire tous les arcs de l'itérable donné du graphe. N'importe
        quel type d'itérable est acceptable, mais il faut qu'il ne contienne
        que des couples d'éléments (quel que soit le type du couple)."""
        for u, v in iterable:
            self.retirer_arc(u, v)

    def retirer_sommet(self, sommet):
        """Efface le sommet du graphe, et retire tous les arcs qui lui
        sont incidents."""
        # retrait du sommet et de ses successeurs
        self._dictionnaire.pop(sommet)
        # retrait des arcs issus de ses prédécesseurs
        for u in self._dictionnaire:
            self._dictionnaire[u].pop(sommet)

    def retirer_sommets(self, iterable):
        """Efface les sommets de l'itérable donné du graphe, et retire toutes
        les arêtes incidentes à ces sommets."""
        for sommet in iterable:
            self.retirer_sommet(sommet)

    def sommets(self):
        """Renvoie l'ensemble des sommets du graphe."""
        return self._dictionnaire.keys()  # vue lecture seule

    def sous_graphe_induit(self, iterable):
        """Renvoie le sous-graphe induit par l'itérable de sommets donné."""
        retval = type(self)()
        retval.ajouter_sommets(iterable)
        retval.ajouter_arcs(
            (u, v) for u, v in self.arcs()
            if retval.contient_sommet(u) and retval.contient_sommet(v)
        )
        return retval

    def successeurs(self, sommet):
        """Renvoie les successeurs du sommet ; s'il n'existe pas, provoque une
        erreur."""
        if sommet not in self._dictionnaire:
            raise ValueError("sommet " + str(sommet) + " inexistant")

        return self._dictionnaire[sommet]

    def voisins(self, sommet):
        """Renvoie l'ensemble des voisins du sommet donné ; s'il n'existe pas,
        provoque une erreur."""
        return chain(self.successeurs(sommet), self.predecesseurs(sommet))

    def __contains__(self, arc_ou_sommet):
        """Renvoie True si l'arc ou le sommet appartient au graphe, False
        sinon. Implémenter cette méthode spéciale permet d'utiliser l'opérateur
        in, par exemple : sommet in G ou arc in G.

        >>> G = DictionnaireAdjacenceOriente()
        >>> G.ajouter_arc(3, 5)
        >>> (3, 5) in G
        True
        >>> (5, 3) in G
        False
        >>> 2 in G
        False
        """
        try:  # un itérable de taille 2 est censé être un arc
            u, v, *_ = arc_ou_sommet
            return self.contient_arc(u, v)

        except (ValueError, TypeError):  # sinon, ça doit être un sommet
            # selon les versions de Python, l'erreur provoquée est soit ValueError, soit TypeError;
            # on traite les deux pour assurer une plus grande compatibilité
            return self.contient_sommet(arc_ou_sommet)


def main():
    from doctest import testmod
    testmod()


if __name__ == "__main__":
    main()
