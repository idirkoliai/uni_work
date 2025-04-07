"""
Anthony Labarre (c) 2024-2025

Implémentation d'un graphe non orienté à l'aide d'un dictionnaire indicé par
les sommets. À chaque sommet est associé un dictionnaire dont les clés sont ses
voisins et les valeurs à None. Ce choix d'implémentation permet :

    - de dériver aisément une autre classe pour les graphes non orientés
      pondérés ;
    - de renvoyer en O(1) l'ensemble des sommets sous la forme d'une référence
      non modifiable.

Une arête {u, v} sera donc présente deux fois dans le dictionnaire : v est dans
les voisins de u, et u est dans les voisins de v.

Pour des raisons de compatibilité, ce fichier ne contient pas de type hints.
"""
# Imports ---------------------------------------------------------------------
from collections import defaultdict
from itertools import combinations, combinations_with_replacement


class DictionnaireAdjacence:
    """Implémentation d'un graphe non orienté."""

    def __init__(self):
        """Initialise un graphe sans arêtes."""
        self._dictionnaire = defaultdict(lambda: defaultdict(None))

    def ajouter_arete(self, u, v, _=None):
        """Ajoute une arête entre les sommets u et v, en créant les sommets
        manquants le cas échéant.

        Le paramètre _ ne sert qu'à s'aligner sur la méthode du même nom dans
        les graphes pondérés, où il sera remplacé par un poids.
        """
        # ajoute u aux voisins de v et v aux voisins de u
        self._dictionnaire[u][v] = self._dictionnaire[v][u] = None

    def ajouter_aretes(self, iterable):
        """Ajoute toutes les arêtes de l'itérable donné au graphe. N'importe
        quel type d'itérable est acceptable, mais il faut qu'il ne contienne
        que des couples d'éléments (quel que soit le type du couple)."""
        for u, v in iterable:
            self.ajouter_arete(u, v)

    def ajouter_sommet(self, sommet):
        """Ajoute un sommet (de n'importe quel type hashable) au graphe."""
        self._dictionnaire[sommet] = defaultdict(None)

    def ajouter_sommets(self, iterable):
        """Ajoute tous les sommets de l'itérable donné au graphe. N'importe
        quel type d'itérable est acceptable, mais il faut qu'il ne contienne
        que des éléments hashables."""
        for sommet in iterable:
            self.ajouter_sommet(sommet)

    def aretes(self):
        """Renvoie l'ensemble des arêtes du graphe. Une arête est représentée
        par un tuple (a, b) avec a ≤ b afin de permettre le renvoi de boucles.

        Attention, cette méthode plante si le graphe contient des sommets de
        types incomparables.
        """
        return {
            (u, v) if u <= v else (v, u) for u in self._dictionnaire
            for v in self._dictionnaire[u]
        }

    def aretes_incidentes(self, v):
        """Renvoie l'ensemble des arêtes incidentes au sommet v. Une arête est
        représentée par un tuple (a, b) avec a ≤ b afin de permettre le renvoi
        de boucles.

        Attention, cette méthode plante si le graphe contient des sommets de
        types incomparables.
        """
        return {(u, v) if u <= v else (v, u) for u in self._dictionnaire[v]}

    def boucles(self):
        """Renvoie les boucles du graphe, c'est-à-dire les arêtes reliant un
        sommet à lui-même."""
        return {
            (u, u) for u in self._dictionnaire if u in self._dictionnaire[u]
        }

    def contient_arete(self, u, v):
        """Renvoie True si l'arête {u, v} existe, False sinon."""
        return u in self._dictionnaire[v]  # ou v in self.__dictionnaire[u]

    def contient_sommet(self, u):
        """Renvoie True si le sommet u existe, False sinon."""
        return u in self._dictionnaire

    def degre(self, sommet):
        """Renvoie le nombre de voisins du sommet ; s'il n'existe pas, provoque
        une erreur."""
        return len(self._dictionnaire[sommet])

    def nombre_aretes(self):
        """Renvoie le nombre d'arêtes du graphe."""
        return sum(
            len(voisins) for voisins in self._dictionnaire.values()
        ) // 2

    def nombre_boucles(self):
        """Renvoie le nombre d'arêtes de la forme {u, u}."""
        return sum(1 for u in self._dictionnaire if u in self._dictionnaire[u])

    def nombre_sommets(self):
        """Renvoie le nombre de sommets du graphe."""
        return len(self._dictionnaire)

    def retirer_arete(self, u, v):
        """Retire l'arête {u, v} si elle existe ; provoque une erreur sinon."""
        self._dictionnaire[u].pop(v)  # plante si v n'existe pas
        self._dictionnaire[v].pop(u)  # plante si u n'existe pas

    def retirer_aretes(self, iterable):
        """Retire toutes les arêtes de l'itérable donné du graphe. N'importe
        quel type d'itérable est acceptable, mais il faut qu'il ne contienne
        que des couples d'éléments (quel que soit le type du couple)."""
        for u, v in iterable:
            self.retirer_arete(u, v)

    def retirer_sommet(self, sommet):
        """Efface le sommet du graphe, et retire toutes les arêtes qui lui
        sont incidentes."""
        # parcourir d'abord les voisins pour supprimer le sommet de leurs dictionnaires
        for voisin in self._dictionnaire[sommet]:
            self._dictionnaire[voisin].pop(sommet)

        # puis supprimer le dictionnaire de voisins du sommet
        self._dictionnaire.pop(sommet)  # plante si le sommet n'existe pas

    def retirer_sommets(self, iterable):
        """Efface les sommets de l'itérable donné du graphe, et retire toutes
        les arêtes incidentes à ces sommets."""
        for sommet in iterable:
            self.retirer_sommet(sommet)

    def sommets(self):
        """Renvoie les sommets du graphe."""
        return self._dictionnaire.keys()  # vue lecture seule

    def sous_graphe_induit(self, iterable):
        """Renvoie le sous-graphe induit par l'itérable de sommets donné."""
        resultat = type(self)()
        resultat.ajouter_sommets(iterable)
        resultat.ajouter_aretes(
            (u, v) for u, v in combinations_with_replacement(resultat.sommets(), 2)
            if self.contient_arete(u, v)
        )
        return resultat

    def voisins(self, sommet):
        """Renvoie l'ensemble des voisins du sommet donné."""
        return self._dictionnaire[sommet].keys()  # vue lecture seule

    def __contains__(self, arete_ou_sommet):
        """Renvoie True si l'arête ou le sommet appartient au graphe, False
        sinon. Implémenter cette méthode spéciale permet d'utiliser l'opérateur
        in, par exemple : sommet in G ou arete in G.

        >>> from dictionnaireadjacence import DictionnaireAdjacence as Graphe
        >>> G = Graphe(); G.ajouter_arete(1, 2)
        >>> [i in G for i in range(4)]  # test d'appartenance d'un sommet
        [False, True, True, False]
        >>> [{0, 1} in G, {1, 2} in G, {1, 3} in G]  # test d'appartenance d'une arête
        [False, True, False]
        >>> [(1, 2) in G, (2, 1) in G, [1, 2] in G]  # ordre et type indifférents
        [True, True, True]
        """
        try:  # un itérable de taille >= 2 est censé être une arête
            u, v, *_ = arete_ou_sommet
            return self.contient_arete(u, v)

        except (ValueError, TypeError):  # sinon, ça doit être un sommet
            # selon les versions de Python, l'erreur provoquée est soit ValueError, soit TypeError;
            # on traite les deux pour assurer une plus grande compatibilité
            return self.contient_sommet(arete_ou_sommet)


def main():
    """
    Tests brefs de la classe DictionnaireAdjacence.

    :return:
    """
    print("Construction de l'exemple du cours sur les parcours.")
    graphe = DictionnaireAdjacence()
    graphe.ajouter_aretes(
        {"01", "03", "06", "14", "16", "25", "36", "38", "47", "56", "57"}
    )
    print("Arêtes triées:", sorted(graphe.aretes()))
    print("graphe.sommets():", graphe.sommets())
    print("Test de l'opérateur in pour les sommets")
    for i in map(str, range(0, 10)):
        print(f'{i} in graphe: {i in graphe}')
    print("Test de l'opérateur in pour les arêtes")
    for a, b in combinations(range(0, 10), 2):
        print(f'{(str(a), str(b))} in graphe: {(str(a), str(b)) in graphe}')


if __name__ == "__main__":
    main()
