from dictionnaireadjacencepondere import DictionnaireAdjacencePondere as Graph
from itertools import combinations, combinations_with_replacement
from collections import deque
import os
from tas import TasArcs as Tas
from unionfind import UnionFind
from math import log
import os

def dico_to_graphiz_format(g:Graph, filename: str) -> None:
    """
    Converts the graph to Graphviz format and writes it to a file, including edge weights.

    :param g: The graph to convert.
    :param filename: The name of the file to write to.
    """
    with open(os.path.join(os.getcwd(), filename), "w+") as f:
        f.write("graph G {\n")
        f.write("  node [shape=diamond, style=filled, color=lightblue];\n")
        f.write("  edge [color=red];\n")

        for sommet in g.sommets():
            f.write(f"  {sommet};\n")

        for u, v ,p in g.aretes():
            f.write(f'  {u} -- {v} [label="{g.poids_arete(u,v)}"];\n')  # Include weight as label

        f.write("}\n")


def bipartition_to_grahiz_format(g:Graph,bipartition,filename: str) -> None:
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
        for u, v ,p in g.aretes():
            f.write(f"  {u} -- {v};\n")
        f.write("}\n")
        
class Deq :
    def __init__(self):
        self.__deque = deque()
    def ajouter(self,s) :
        self.__deque.append(s)
    def extraire(self):
        return self.__deque.popleft()
    def __len__(self):
        """Implémenter cette méthode spéciale permet d'appeler len() sur une instance X de la
        classe, et également d'écrire `if x` ou `while x`."""
        return len(self.__deque)

class Stack :
    def __init__(self):
        self.__stack = list()
    def ajouter(self,s) :
        self.__stack.append(s)
    def extraire(self):
        return self.__stack.pop()
    def __len__(self):
        """Implémenter cette méthode spéciale permet d'appeler len() sur une instance X de la
        classe, et également d'écrire `if x` ou `while x`."""
        return len(self.__stack)
    

def parcoursGenerique(g,s,v,visited = None) :
    res = []
    if visited is None :
        visited = set()
    s.ajouter(v)
    while s :
        current = s.extraire()
        if current not in visited :
            res.append(current)
            visited.add(current)
            for n in g.voisins(current) : 
                if n not in visited :
                    s.ajouter(n)
    return res

def is_outside_tree(tree,e):
    v,u,p = e
    return v if v  not in tree else u if u not in tree else None

def arbre_parcours_generique(g,s,v) :
    tree = type(g)()
    tree.ajouter_sommet(v)
    for e in g.aretes_incidentes(v):
        s.ajouter(e)
    while s :
        e = s.extraire()
        current  = is_outside_tree(tree,e)
        if current is not None :
            u,v,p = e
            tree.ajouter_arete(u,v,p)
            for e1 in g.aretes_incidentes(current):
                is_present = is_outside_tree(tree,e1)
                if is_present is not None :
                    s.ajouter(e1)
    return tree
        
def prim(g,v):
    return arbre_parcours_generique(g,Tas(),v)
        
def kruskal(g):
    forest = type(g)()
    classes = UnionFind(g.sommets())
    for u,v,p in sorted(g.aretes(), key=lambda e : -e[2]):
        if classes.find(u) != classes.find(v) :
            forest.ajouter_arete(u,v,p)
            classes.union(u,v)
    return forest
         
    



def main():
    """Tests brefs de la classe DictionnaireAdjacencePondere."""
    graphe = Graph()
    graphe.ajouter_aretes(
        {(0, 1, 5), (0, 2, 7), (0, 3, 4), (0, 4, 2),
         (1, 4, 2), (2, 3, 9), (2, 5, 5),
         (3, 4, 3), (3, 5, 7), (3, 6, 4),
         (4, 6, 7), (5, 6, 12),(1,7,20)}
    )
    print(sorted(graphe.aretes()))
    print(sorted(graphe.sommets()))
    #print("Test de l'opérateur in pour les arêtes (ignore les poids)")
    #for a, b in combinations(range(0, 10), 2):
    #    print(f'{(a, b)} in graphe: {(a, b) in graphe}')

    print(parcoursGenerique(graphe,Stack(),0))
    print(parcoursGenerique(graphe,Deq(),0))
    tree_largeur = arbre_parcours_generique(graphe,Deq(),0)
    tree_profondeur = arbre_parcours_generique(graphe,Stack(),0)
    acmp = prim(graphe,0)
    acmp2 = kruskal(graphe)
    dico_to_graphiz_format(tree_largeur,"graphiz/tree_largeur.dot")
    dico_to_graphiz_format(tree_profondeur,"graphiz/tree_pronfondeur.dot")
    dico_to_graphiz_format(acmp,"graphiz/acmp_prim.dot")
    dico_to_graphiz_format(acmp2,"graphiz/acmp_kruskal.dot")
    dico_to_graphiz_format(graphe,"graphiz/graph_pondere.dot")

if __name__ == "__main__":
    main()
