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

"""
# Imports ---------------------------------------------------------------------
from collections import defaultdict
from itertools import combinations, combinations_with_replacement
from typing import Hashable, Iterable, Tuple, Self, KeysView


class DictionnaireAdjacence:
    """Implémentation d'un graphe non orienté."""

    def __init__(self) -> None:
        """Initialise un graphe sans arêtes."""
        self._dictionnaire = defaultdict(lambda: defaultdict(None))

    def ajouter_arete(self, u: Hashable, v: Hashable, _: None = None) -> None:
        """Ajoute une arête entre les sommets u et v, en créant les sommets
        manquants le cas échéant.

        Le paramètre _ ne sert qu'à s'aligner sur la méthode du même nom dans
        les graphes pondérés, où il sera remplacé par un poids.
        """
        # ajoute u aux voisins de v et v aux voisins de u
        self._dictionnaire[u][v] = self._dictionnaire[v][u] = None

    def ajouter_aretes(self, iterable: Iterable) -> None:
        """Ajoute toutes les arêtes de l'itérable donné au graphe. N'importe
        quel type d'itérable est acceptable, mais il faut qu'il ne contienne
        que des couples d'éléments (quel que soit le type du couple)."""
        for u, v in iterable:
            self.ajouter_arete(u, v)

    def ajouter_sommet(self, sommet: Hashable) -> None:
        """Ajoute un sommet (de n'importe quel type hashable) au graphe."""
        self._dictionnaire[sommet] = defaultdict(None)

    def ajouter_sommets(self, iterable: Iterable[Hashable]) -> None:
        """Ajoute tous les sommets de l'itérable donné au graphe. N'importe
        quel type d'itérable est acceptable, mais il faut qu'il ne contienne
        que des éléments hashables."""
        for sommet in iterable:
            self.ajouter_sommet(sommet)

    def aretes(self) -> set[Tuple[Hashable, Hashable]]:
        """Renvoie l'ensemble des arêtes du graphe. Une arête est représentée
        par un tuple (a, b) avec a ≤ b afin de permettre le renvoi de boucles.

        Attention, cette méthode plante si le graphe contient des sommets de
        types incomparables.
        """
        return {
            (u, v) if u <= v else (v, u) for u in self._dictionnaire
            for v in self._dictionnaire[u]
        }

    def aretes_incidentes(self, v: Hashable) -> set:
        """Renvoie l'ensemble des arêtes incidentes au sommet v. Une arête est
        représentée par un tuple (a, b) avec a ≤ b afin de permettre le renvoi
        de boucles.

        Attention, cette méthode plante si le graphe contient des sommets de
        types incomparables.
        """
        return {(u, v) if u <= v else (v, u) for u in self._dictionnaire[v]}

    def boucles(self) -> set[Tuple[Hashable, Hashable]]:
        """Renvoie les boucles du graphe, c'est-à-dire les arêtes reliant un
        sommet à lui-même."""
        return {
            (u, u) for u in self._dictionnaire if u in self._dictionnaire[u]
        }

    def contient_arete(self, u: Hashable, v: Hashable) -> bool:
        """Renvoie True si l'arête {u, v} existe, False sinon."""
        return u in self._dictionnaire[v]  # ou v in self.__dictionnaire[u]

    def contient_sommet(self, u: Hashable) -> bool:
        """Renvoie True si le sommet u existe, False sinon."""
        return u in self._dictionnaire

    def degre(self, sommet: Hashable) -> int:
        """Renvoie le nombre de voisins du sommet ; s'il n'existe pas, provoque
        une erreur."""
        return len(self._dictionnaire[sommet])

    def nombre_aretes(self) -> int:
        """Renvoie le nombre d'arêtes du graphe."""
        return sum(
            len(voisins) for voisins in self._dictionnaire.values()
        ) // 2

    def nombre_boucles(self) -> int:
        """Renvoie le nombre d'arêtes de la forme {u, u}."""
        return sum(1 for u in self._dictionnaire if u in self._dictionnaire[u])

    def nombre_sommets(self) -> int:
        """Renvoie le nombre de sommets du graphe."""
        return len(self._dictionnaire)

    def retirer_arete(self, u: Hashable, v: Hashable) -> None:
        """Retire l'arête {u, v} si elle existe ; provoque une erreur sinon."""
        self._dictionnaire[u].pop(v)  # plante si v n'existe pas
        self._dictionnaire[v].pop(u)  # plante si u n'existe pas

    def retirer_aretes(self, iterable: set[Tuple[Hashable, Hashable]]) -> None:
        """Retire toutes les arêtes de l'itérable donné du graphe. N'importe
        quel type d'itérable est acceptable, mais il faut qu'il ne contienne
        que des couples d'éléments (quel que soit le type du couple)."""
        for u, v in iterable:
            self.retirer_arete(u, v)

    def retirer_sommet(self, sommet: Hashable) -> None:
        """Efface le sommet du graphe, et retire toutes les arêtes qui lui
        sont incidentes."""
        # parcourir d'abord les voisins pour supprimer le sommet de leurs dictionnaires
        for voisin in self._dictionnaire[sommet]:
            self._dictionnaire[voisin].pop(sommet)

        # puis supprimer le dictionnaire de voisins du sommet
        self._dictionnaire.pop(sommet)  # plante si le sommet n'existe pas

    def retirer_sommets(self, iterable: set[Hashable]) -> None:
        """Efface les sommets de l'itérable donné du graphe, et retire toutes
        les arêtes incidentes à ces sommets."""
        for sommet in iterable:
            self.retirer_sommet(sommet)

    def sommets(self) -> KeysView:
        """Renvoie les sommets du graphe."""
        return self._dictionnaire.keys()  # vue lecture seule

    def sous_graphe_induit(self, iterable: set[Hashable]) -> Self:
        """Renvoie le sous-graphe induit par l'itérable de sommets donné."""
        resultat = type(self)()
        resultat.ajouter_sommets(iterable)
        resultat.ajouter_aretes(
            (u, v) for u, v in combinations_with_replacement(resultat.sommets(), 2)
            if self.contient_arete(u, v)
        )
        return resultat

    def voisins(self, sommet: Hashable) -> KeysView:
        """Renvoie l'ensemble des voisins du sommet donné."""
        return self._dictionnaire[sommet].keys()  # vue lecture seule

    def __contains__(self, arete_ou_sommet: Iterable | Hashable) -> bool:
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
        try:  # un itérable de taille 2 est censé être une arête
            u, v, *_ = arete_ou_sommet
            return self.contient_arete(u, v)

        except ValueError:  # sinon, ça doit être un sommet
            return self.contient_sommet(arete_ou_sommet)

def parcours_profondeur(g: DictionnaireAdjacence, sommet: Hashable) -> list[Hashable]:
    """
    Depth-first traversal of the graph starting from the given vertex.

    :param g: The graph to traverse.
    :param sommet: The starting vertex.
    :return: A list of vertices in the order they were visited.
    """
    result = list()
    visited = {v: False for v in g.sommets()}
    stack = list()
    stack.append(sommet)
    while stack:
        current = stack.pop()
        if not visited[current]:
            print(current)
            result.append(current)
            visited[current] = True
            for v in g.voisins(current):
                if not visited[v]:
                    stack.append(v)
    return result
import os 
def parcours_profondeur_arbre(g: DictionnaireAdjacence, sommet: Hashable) -> DictionnaireAdjacence:
    """
    Constructs a depth-first traversal tree of the graph starting from the given vertex.
    :param g: The graph to traverse.
    :param sommet: The starting vertex.
    :return: A new graph representing the depth-first traversal tree.
    """
    result = DictionnaireAdjacence()
    result.ajouter_sommets(g.sommets())
    visited = {v: False for v in g.sommets()}
    linked = {v: False for v in g.sommets()}
    stack = list()
    stack.append(sommet)
    linked[sommet] = True
    while stack:
        current = stack.pop()
        if not visited[current]:
            visited[current] = True
            for v in g.voisins(current):
                if not visited[v]:
                    stack.append(v)
                    if not linked[v]:
                        linked[v] = True
                        result.ajouter_arete(current, v)
    return result

def parcours_largeur(g: DictionnaireAdjacence, sommet: Hashable) -> list[Hashable]:
    """
    width-first traversal of the graph starting from the given vertex.

    :param g: The graph to traverse.
    :param sommet: The starting vertex.
    :return: A list of vertices in the order they were visited.
    """
    result = list()
    visited = {v: False for v in g.sommets()}
    queue = list()
    queue.append(sommet)
    while queue:
        current = queue.pop(0)
        if not visited[current]:
            print(current)
            result.append(current)
            visited[current] = True
            for v in g.voisins(current):
                if not visited[v]:
                    queue.append(v)
    return result

def parcours_largeur_arbre(g: DictionnaireAdjacence, sommet: Hashable) -> DictionnaireAdjacence:
    """
    Constructs a width-first traversal tree of the graph starting from the given vertex.

    :param g: The graph to traverse.
    :param sommet: The starting vertex.
    :return: A new graph representing the width-first traversal tree.
    """
    result = DictionnaireAdjacence()
    result.ajouter_sommets(g.sommets())
    visited = {v: False for v in g.sommets()}
    linked = {v: False for v in g.sommets()}
    queue = list()
    queue.append(sommet)
    linked[sommet] = True
    while queue:
        current = queue.pop(0)
        if not visited[current]:
            visited[current] = True
            for v in g.voisins(current):
                if not visited[v]:
                    queue.append(v)
                    if not linked[v]:
                        linked[v] = True
                        result.ajouter_arete(current, v)
    return result

def dico_to_grahiz_format(g: DictionnaireAdjacence, filename: str) -> None:
    """
    Converts the graph to Graphviz format and writes it to a file.

    :param g: The graph to convert.
    :param filename: The name of the file to write to.
    """
    with open(os.getcwd() + "/" + filename, "w+") as f:
        f.write("graph G {\n")
        f.write("  node [shape=diamond, style=filled, color=lightblue];\n")
        f.write("  edge [color=red];\n")
        for sommet in g.sommets():
            f.write(f"  {sommet};\n")
        for u, v in g.aretes():
            f.write(f"  {u} -- {v};\n")
        f.write("}\n")

def composante_connexes(g : DictionnaireAdjacence) -> DictionnaireAdjacence :
    resultat = DictionnaireAdjacence()
    resultat.ajouter_sommets(g.sommets())
    visited = {v: False for v in g.sommets()}
    for sommet in g.sommets():
        if not visited[sommet]:
            arbre = parcours_largeur_arbre(g, sommet)
            resultat.ajouter_aretes(arbre.aretes())
            visited.update({v: True for v in (u for u in arbre.aretes())})
    return resultat   

def isBipartite_connexe_part(g: DictionnaireAdjacence, start_vertex: Hashable, visited: dict[Hashable, bool]) -> bool:
    bipartition = {v: None for v in g.sommets()}
    todo = list()
    todo.append(start_vertex)
    visited[start_vertex] = True
    bipartition[start_vertex] = True
    while todo:
        current_vertex = todo.pop(0)
        for v in g.voisins(current_vertex):
            if bipartition[v] is None:
                bipartition[v] = not bipartition[current_vertex]
                todo.append(v)
                visited[v] = True
            elif bipartition[v] == bipartition[current_vertex]:
                return False
    return True

def isBipartite(g: DictionnaireAdjacence) -> bool:
    visited = {v: False for v in g.sommets()}
    for sommet in g.sommets():
        if not visited[sommet]:
            if not isBipartite_connexe_part(g, sommet, visited):
                return False
    return True

def bipartition(g: DictionnaireAdjacence) -> dict[Hashable, bool]:
    visited = {v: False for v in g.sommets()}
    bipartition = {v: None for v in g.sommets()}
    stack = list()
    for sommet in g.sommets():
        if not visited[sommet]:
            stack.append(sommet)
            bipartition[sommet] = True
            while stack:
                current = stack.pop()
                visited[current] = True
                for voisin in g.voisins(current):
                    if not visited[voisin]:
                        bipartition[voisin] = not bipartition[current]
                        stack.append(voisin)
    return bipartition

def bipartition_to_grahiz_format(g:DictionnaireAdjacence,bipartition: dict[Hashable, bool], filename: str) -> None:
    clusters = {True: set(), False: set()}
    for sommet, cluster in bipartition.items():
        clusters[cluster].add(sommet)
    with open(os.getcwd() + "/" + filename, "w+") as f:
        f.write("graph G {\n")
        f.write("  node [shape=diamond, style=filled, color=lightgrey];\n")
        f.write("  edge [color=red];\n")
        f.write("  subgraph cluster_0 {\n")
        f.write("    style=filled;\n")
        f.write("    color=lightblue;\n")
        for sommet in clusters[False]:
            f.write(f"    {sommet};\n")
        f.write("  }\n")
        f.write("  subgraph cluster_1 {\n")
        f.write("    style=filled;\n")
        f.write("    color=lightpink;\n")
        for sommet in clusters[True]:
            f.write(f"    {sommet};\n")
        f.write("  }\n")
        for u, v in g.aretes():
            f.write(f"  {u} -- {v};\n")
        f.write("}\n")
        

    




def main() -> None:
    """
    Tests brefs de la classe DictionnaireAdjacence.

    :return:
    """
    print("Construction de l'exemple du cours sur les parcours.")
    graphe = DictionnaireAdjacence()
    graphe.ajouter_aretes(
        {"01", "03", "06", "14", "16", "25", "36", "38", "47", "56", "57"}
        #{"03","02","35","25","14","46","65","01"}
    )
    print("Arêtes triées:", sorted(graphe.aretes()))
    print("graphe.sommets():", graphe.sommets())
    print("Test de l'opérateur in pour les sommets")
    #for i in map(str, range(0, 10)):
    #    print(f'{i} in graphe: {i in graphe}')
    #print("Test de l'opérateur in pour les arêtes")
    #for a, b in combinations(range(0, 10), 2):
    #    print(f'{(str(a), str(b))} in graphe: {(str(a), str(b)) in graphe}')
    graphe.ajouter_aretes({("9","10"),("10","11"),("11","12")})
    composantes = composante_connexes(graphe)
    print(isBipartite(graphe))
    print(isBipartite_connexe_part(graphe, "10", {v: False for v in graphe.sommets()}))
    dico_to_grahiz_format(composantes, "composantes_connexes.dot") 
    bipart = bipartition(graphe)
    bipartition_to_grahiz_format(graphe, bipart, "bipartition.dot")



if __name__ == "__main__":
    main()