"""
Anthony Labarre (c) 2024-2025

Implémentation d'un graphe non orienté pondéré à l'aide d'un dictionnaire
indicé par les sommets. L'implémentation est identique à celle de la classe
DictionnaireAdjacence dont elle dérive.
"""
# Imports ---------------------------------------------------------------------
# ----- Imports standards -----------------------------------------------------
from itertools import combinations, combinations_with_replacement

# ----- Mes modules -----------------------------------------------------------
from dictionnaireadjacence import DictionnaireAdjacence


class DictionnaireAdjacencePondere(DictionnaireAdjacence):
    """Implémentation d'un graphe non orienté pondéré."""

    def ajouter_arete(self, u, v, poids=None):
        """Ajoute une arête entre les sommets u et v, en créant les sommets manquants le cas
        échéant.

        Le paramètre poids est à None car la signature d'une méthode héritée doit correspondre avec
        celle de la méthode d'origine. En pratique, ajouter une arête de poids None à un graphe
        pondéré n'a pas de sens, et on s'attendra à ce que l'utilisateur fournisse explicitement un
        poids.
        """
        # ajoute u (resp. v) aux voisins de v (resp. u)
        self._dictionnaire[u][v] = self._dictionnaire[v][u] = poids

    def ajouter_aretes(self, iterable):
        """Ajoute toutes les arêtes de l'itérable donné au graphe. N'importe
        quel type d'itérable est acceptable, mais il faut qu'il ne contienne
        que des triplets d'éléments (quel que soit le type du couple).

        Contrairement à ajouter_arete, le poids doit ici être explicitement donné, sinon la méthode
        plantera.
        """
        for u, v, poids in iterable:
            self.ajouter_arete(u, v, poids)

    def aretes(self):
        """Renvoie l'ensemble des arêtes du graphe. Une arête est représentée par un triplet
        (u, v, poids) avec u ≤ v.
        """
        return {
            (u, v, poids) if u <= v else (v, u, poids)
            for u in self._dictionnaire
            for v, poids in self._dictionnaire[u].items()
        }

    def aretes_incidentes(self, v):
        """Renvoie l'ensemble des arêtes incidentes à un sommet donné sous la
        forme de tuples (v, w, poids) avec v ≤ w."""
        return {
            (v, w, poids) if v <= w else (w, v, poids)
            for w, poids in self._dictionnaire[v].items()
        }

    def boucles(self):
        """Renvoie les boucles du graphe, c'est-à-dire les arêtes reliant un
        sommet à lui-même."""
        return {
            (u, u, self._dictionnaire[u][u])
            for u in self._dictionnaire if u in self._dictionnaire[u]
        }

    def poids_arete(self, u, v):
        """Renvoie le poids de l'arête {u, v} ; provoque une erreur si elle n'existe pas."""
        return self._dictionnaire[u][v]

    def sous_graphe_induit(self, iterable):
        """Renvoie le sous-graphe induit par l'itérable de sommets donné."""
        resultat = type(self)()
        resultat.ajouter_sommets(iterable)
        resultat.ajouter_aretes(
            (u, v, self.poids_arete(u, v))
            for u, v in combinations_with_replacement(resultat.sommets(), 2)
            if self.contient_arete(u, v)
        )
        return resultat


def main():
    """Tests brefs de la classe DictionnaireAdjacencePondere."""
    graphe = DictionnaireAdjacencePondere()
    graphe.ajouter_aretes(
        {(0, 1, 5), (0, 2, 7), (0, 3, 4), (0, 4, 2),
         (1, 4, 2), (2, 3, 9), (2, 5, 5),
         (3, 4, 3), (3, 5, 7), (3, 6, 4),
         (4, 6, 7), (5, 6, 12)}
    )
    print(sorted(graphe.aretes()))
    print("Test de l'opérateur in pour les arêtes (ignore les poids)")
    for a, b in combinations(range(0, 10), 2):
        print(f'{(a, b)} in graphe: {(a, b) in graphe}')


if __name__ == "__main__":
    main()
