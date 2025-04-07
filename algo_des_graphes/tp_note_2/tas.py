"""
Anthony Labarre (c) 2024-2025

Structure implémentant un tas d'arcs pondérés. Compatible avec les arêtes.

Pour des raisons de compatibilité, ce fichier ne contient pas de type hints.
"""
# Imports ---------------------------------------------------------------------
# ----- Imports standards -----------------------------------------------------
from heapq import heapify, heappush, heappop


class TasArcs:
    """Implémentation d'un tas d'arêtes ou arcs, donnant la priorité aux éléments de poids minimum.

    Comme Python compare les tuples sur base du premier élément, on stocke les arcs sous la forme
    (poids, origine, destination). Ils sont acceptés et renvoyés au format traditionnel
    (u, v, poids).

    TasArcs est a priori utilisable avec des triplets contenant n'importe quoi, avec le poids en
    dernière position. C'est pourquoi les type hints font référence à Any plutôt qu'à Hashable
    comme pour les graphes.
    """

    def __init__(self, arcs=None):
        """Copie les arcs et les organise sous la forme d'un tas."""
        self.donnees = [] if arcs is None else [
            (poids, u, v) for u, v, poids in arcs
        ]
        heapify(self.donnees)

    def ajouter(self, arc):
        """Insère un nouvel arc en préservant la propriété du tas."""
        u, v, poids = arc
        heappush(self.donnees, (poids, u, v))

    def extraire(self):
        """Extrait et renvoie l'arc de poids minimum en préservant la
        propriété du tas."""
        poids, u, v = heappop(self.donnees)
        return u, v, poids

    def __len__(self):
        """Implémenter cette méthode spéciale permet d'appeler len() sur une instance X de la
        classe, et également d'écrire `if x` ou `while x`."""
        return len(self.donnees)
