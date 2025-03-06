from dictionnaireadjacence import DictionnaireAdjacence as Graph
from itertools import combinations, combinations_with_replacement
from collections import deque
import os
def dico_to_grahiz_format(g, filename: str) -> None:
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

def profondeur(g:Graph,start) :
    result = list()  
    visited = set()
    todo = list()
    todo.append(start)
    while todo :
        current = todo.pop()
        if current not in visited :
            visited.add(current)
            result.append(current)
            for v in g.voisins(current) :
                if v not in visited :
                    todo.append(v)
    return result

def largeur(g:Graph,start) :
    result = list()  
    visited = set()
    todo = list()
    todo.append(start)
    while todo :
        current = todo.pop(0)
        if current not in visited :
            visited.add(current)
            result.append(current)
            for v in g.voisins(current) :
                if v not in visited :
                    todo.append(v)
    return result

def composante_connexes_profondeur(g:Graph) :
    visited = set()
    result = list()
    for s in g.sommets() :
        if s not in visited :
            composante = profondeur(g,s)
            visited.update(composante)
            for s in composante :
                result.append(s)
    return result

def composantes_connexes_largeur(g:Graph) :
    visited = set()
    result = list()
    for s in g.sommets() :
        if s not in visited :
            composante = largeur(g,s)
            visited.update(composante)
            for s in composante :
                result.append(s)
    return result
            
            
def arbre_parcours_profondeur(g: Graph, start, visited, result):
    stack = [(None, start)]
    while stack:
        parent, node = stack.pop()
        if node not in visited:
            visited.add(node)
            if parent is not None:
                result.ajouter_arete(parent, node)
            for neighbor in g.voisins(node):
                if neighbor not in visited:
                    stack.append((node, neighbor))

                    
                    
def arbre_composantes_connexes_profondeur(g:Graph):
    result = Graph()
    visited = set()
    for s in g.sommets() :
        if s not in visited :
            arbre_parcours_profondeur(g,s,visited,result)
    return result

def arbre_parcours_largeur(g:Graph,start,visited,result):
    todo = list()
    todo.append(start)
    adopted = set()
    while todo :
        current = todo.pop(0)
        if current not in visited :
            visited.add(current)
            for v in g.voisins(current) :
                if v not in visited :
                    todo.append(v)
                    if v not in adopted :
                        adopted.add(v)
                        result.ajouter_arete(current,v)
                    
                    
def arbre_composantes_connexes_largeur(g:Graph):
    result = Graph()
    visited = set()
    for s in g.sommets() :
        if s not in visited :
            arbre_parcours_largeur(g,s,visited,result)
    return result


def estBiparti(g:Graph,depart,visited):
    bipartition = {v : None for v in g.sommets()}
    todo  = deque()
    todo.append(depart)
    bipartition[depart] = False
    while todo :
        current = todo.popleft()
        visited.add(current)
        for v in g.voisins(current):
            if bipartition[v] is None :
                todo.append(v)
                bipartition[v] = not bipartition[current]
            elif bipartition[current] == bipartition[v] :
                return False   
    return True     

def estBiparti_composantes_connexes(g:Graph) :
    visited = set()
    for s in g.sommets() :
        if not estBiparti(g,s,visited) :
            return False
    return True
    
def bipartition(g:Graph):
    visited = set()
    bipartition = {v:None for v in g.sommets()}
    for v in g.sommets() :
        if v not in visited :
            todo = deque()
            bipartition[v] = True
            todo.append(v)
            while todo :
                current = todo.popleft()
                visited.add(current) 
                for n in g.voisins(current) :
                    if n not in visited :
                        todo.append(n)
                        bipartition[n] = not bipartition[current]
    return bipartition
                        
            
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
        for u, v in g.aretes():
            f.write(f"  {u} -- {v};\n")
        f.write("}\n")


def detecter_cycle(graphe):
    """Détecte et renvoie un cycle dans le graphe s'il en existe un, sinon renvoie None."""
    def dfs(v, parent):
        visited.add(v)
        stack.append(v)
        for voisin in graphe.voisins(v):
            if voisin not in visited:
                if dfs(voisin, v):
                    return True
            elif voisin != parent:
                # Cycle detected, reconstruct the cycle path
                cycle_start_index = stack.index(voisin)
                cycle.extend(stack[cycle_start_index:])
                return True
        stack.pop()
        return False

    visited = set()
    stack = []
    cycle = []

    for sommet in graphe.sommets():
        if sommet not in visited:
            if dfs(sommet, None):
                return cycle

    return None

# Example usage:
# graphe = DictionnaireAdjacence()
# graphe.ajouter_aretes([(1, 2), (2, 3), (3, 4), (4, 2)])
# cycle = detecter_cycle(graphe)
# print("Cycle detected:", cycle)
                    
def main():
    """
    Tests brefs de la classe DictionnaireAdjacence.

    :return:
    """
    print("Construction de l'exemple du cours sur les parcours.")
    graphe = Graph()
    graphe.ajouter_aretes(
        {(0, 1), (0, 3), (0, 6), (1, 4), (1, 6), (2, 5), (3, 6), (3, 8), (4, 7), (5, 6), (5, 7)}
    )
    print("Arêtes triées:", graphe.aretes())
    print("graphe.sommets():", graphe.sommets())
    print("Test de l'opérateur in pour les sommets")
    #for i in map(str, range(0, 10)):
    #    print(f'{i} in graphe: {i in graphe}')
    #print("Test de l'opérateur in pour les arêtes")
    #for a, b in combinations(range(0, 10), 2):
    #    print(f'{(str(a), str(b))} in graphe: {(str(a), str(b)) in graphe}')
    print(profondeur(graphe,0))
    print(largeur(graphe,0))
    graphe.ajouter_aretes({(11,12),(12,14),(13,14)})
    print(composante_connexes_profondeur(graphe))
    print(composantes_connexes_largeur(graphe))
    dico_to_grahiz_format(graphe,"graphe_exemple.dot")
    dico_to_grahiz_format(arbre_composantes_connexes_profondeur(graphe),"arbre_profondeur.dot")
    dico_to_grahiz_format(arbre_composantes_connexes_largeur(graphe),"arbre_largeur.dot")
    g2 = Graph()
    g2.ajouter_aretes({(0,3),(3,5),(0,2),(2,5),(5,6),(0,1),(1,4),(4,6),(7,8),(8,9),(9,10)})
    print(estBiparti_composantes_connexes(graphe))
    print(estBiparti_composantes_connexes(g2))
    dico_to_grahiz_format(g2,"graphe_exemple2.dot")
    dico_to_grahiz_format(arbre_composantes_connexes_profondeur(g2),"arbre_profondeur2.dot")
    dico_to_grahiz_format(arbre_composantes_connexes_largeur(g2),"arbre_largeur2.dot")
    bipartition_to_grahiz_format(g2,bipartition(g2),"bipartitiong2.dot")
    cycle = detecter_cycle(graphe)
    print(cycle)

    

if __name__ == "__main__":
    main()

                 
