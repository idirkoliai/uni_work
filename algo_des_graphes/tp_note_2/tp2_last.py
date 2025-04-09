from dictionnaireadjacenceorientepondere import DictionnaireAdjacenceOrientePondere as DAOP
from dictionnaireadjacence import DictionnaireAdjacence as DA
from dictionnaireadjacencepondere import DictionnaireAdjacencePondere as DAP
from dictionnaireadjacenceoriente import DictionnaireAdjacenceOriente as DAO
from tas import TasArcs
from collections import deque
import os

def dico_DAOP_to_dot_format(g:DAOP, filename: str) -> None:
    """
    Convertit un graphe orienté pondéré en format Graphviz et l'écrit dans un fichier.

    :param g: Instance de DictionnaireAdjacenceOrientePondere.
    :param filename: Nom du fichier de sortie.
    """
    with open(os.path.join(os.getcwd(), filename), "w+", encoding="utf-8") as f:
        f.write("digraph G {\n")
        f.write("  node [shape=diamond, style=filled, color=lightblue];\n")
        f.write("  edge [color=red];\n")

        for sommet in g.sommets():
            f.write(f"  {sommet};\n")

        for u, v, poids in g.arcs():
            f.write(f'  {u} -> {v} [label="{poids}"];\n')
        f.write("}\n")
        os.system(f"dot -Tpng {filename} -o {filename[:-4]}.png")  # Convertit le fichier .dot en .png


def dico_to_dot_format(g:DAP, filename: str) -> None:
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

        for u, v  in g.aretes():
            f.write(f'  {u} -- {v};\n')#[label="{g.poids_arete(u,v)}"];\n')  # Include weight as label

        f.write("}\n")
        os.system(f"dot -Tpng {filename} -o {filename}.png")


def bipartition_DAOP_to_dot_format(g, bipartition, filename: str) -> None:
    """
    Convertit une bipartition d'un graphe orienté pondéré en format Graphviz.

    :param g: Instance de DictionnaireAdjacenceOrientePondere.
    :param bipartition: Dictionnaire associant un sommet à True ou False (pour la couleur).
    :param filename: Nom du fichier de sortie.
    """
    clusters = {True: set(), False: set()}
    for sommet, cluster in bipartition.items():
        clusters[cluster].add(sommet)

    with open(os.path.join(os.getcwd(), filename), "w+", encoding="utf-8") as f:
        f.write("digraph G {\n")
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
            f.write(f"    {repr(sommet)};\n")
        f.write("  }\n")

        for u, v, _ in g.arcs():
            poids = g.poids_arc(u, v)
            f.write(f'  {repr(u)} -> {repr(v)} [label="{poids}"];\n')
        f.write("}\n")
        os.system(f"dot -Tpng {filename} -o {filename[:-4]}.png")

def rebuiltDA (pred : dict,name) :
    G = DA()
    for key in pred.keys():
        if pred[key] is not None :
            G.ajouter_arete(key,pred[key])
    dico_to_dot_format(G,name)


def dfs_aux(G:DA,v,pred,visited = None):
    res = list()
    todo = deque()
    todo.append(v)
    if visited is None :
        visited = set()
    while todo :
        u = todo.pop()
        if u not in visited :
            visited.add(u)
            res.append(u)
            for v in G.voisins(v):
                if v not in visited :
                    todo.append(v)
                    if pred[v] is None :
                        pred[v] = u
    return res

def dfs(G:DA):
    visited = set()
    pred = {v:None for v in G.sommets()}
    res = list()
    for v in G.sommets():
        if v not in visited :
            res.extend(dfs_aux(G,v,pred,visited))

    return res,pred

def Lfs_aux(G:DA,v,pred,visited = None):
    res = list()
    todo = deque()
    todo.append(v)
    if visited is None :
        visited = set()
    while todo :
        u = todo.popleft()
        if u not in visited :
            visited.add(u)
            res.append(u)
            for v in G.voisins(v):
                print(u,v)
                if v not in visited :
                    todo.append(v)
                    if pred[v] is None :
                        pred[v] = u
    return res

def Lfs(G:DA):
    visited = set()
    pred = {v:None for v in G.sommets()}
    res = list()
    for v in G.sommets():
        if v not in visited :
            res.append(Lfs_aux(G,v,pred,visited))

    return res,pred





def main():
    """
    Tests brefs de la classe DictionnaireAdjacence.

    :return:
    """
    print("Construction de l'exemple du cours sur les parcours.")
    G = DA()
    G.ajouter_aretes(
        [(2, 5), (3, 6), (3, 8), (4, 7), (5, 6), (5, 7),(0, 1), (0, 3), (0, 6), (1, 4), (1, 6)]
    )
    print(G.voisins(1))
    res,pred = Lfs(G)
    print(res)
    print(pred)
    rebuiltDA(pred,"dot/dfs.dot")

if __name__ == "__main__":  
    main()
