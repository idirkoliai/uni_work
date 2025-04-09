from dictionnaireadjacenceorientepondere import DictionnaireAdjacenceOrientePondere as DAOP
from dictionnaireadjacencepondere import DictionnaireAdjacencePondere as DAP
from dictionnaireadjacenceoriente import DictionnaireAdjacenceOriente as DAO
from tas import TasArcs
import os
from collections import deque
from heapq import heapify, heappush, heappop

def dico_DAOP_to_graphviz_format(g:DAOP, filename: str) -> None:
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

def dico_to_graphiz_format(g:DAP, filename: str) -> None:
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


def bipartition_DAOP_to_graphviz_format(g, bipartition, filename: str) -> None:
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

def rebuild_DAP(parents : dict) :
    G = DAP()
    for v in parents.keys():
        if parents[v] is not None:
            u,w = parents[v]
            G.ajouter_arete(v,u,w)
    return G

def rebuild_DAOP(parents : dict) :
    G = DAOP()
    for v in parents.keys():
        if parents[v] is not None:
            u,w = parents[v]
            G.ajouter_arc(u,v,w)
    return G
        
    

def Djikstra(G : DAP ,source) :
    dist = {v:None for v in G.sommets()}
    dist[source] = 0
    visited = set()
    todo = TasArcs([(source,source,0)])
    parents= {v:None for v in G.sommets()}
    while todo :
        s,u,d = todo.extraire()
        if u not in visited :
            visited.add(u)
            for v in G.voisins(u):
                if v not in visited :
                    new_dist = dist[u] + G.poids_arete(u,v)
                    if dist[v] is None or new_dist < dist[v] :
                        dist[v] = new_dist
                        parents[v] = (u,G.poids_arete(u,v))
                        todo.ajouter((u,v,new_dist))
    return (parents,dist)

def profondeurOriente(G:DAOP,v,visited = None,parents = None) :
    if visited is None :
        visited = set()
    if parents is None :
        parents = {v:None for v in G.sommets()}
    res = list()
    res.append(v)
    visited.add(v)
    for u in G.successeurs(v) :
        if u not in visited :
            parents[u] = (v,G.poids_arc(v,u))
            res.extend(profondeurOriente(G,u,visited,parents)[0])
    return res,parents

def reconstruire_cycle(v,parents) :
    cycle = DAOP()
    cycle.ajouter_arc(parents[v],v)
    tmp = parents[v]
    while tmp != v :
        cycle.ajouter_arc(parents[tmp],tmp)
        tmp = parents[tmp]
    return cycle

def ContientCycleOriente(G:DAOP,v,status = None,parents=None):
    if status is None :
        status = {v:None for v in G.sommets()}
    if parents is None :
        parents = {v:None for v in G.sommets()}
    if status[v] == False :
        return (True,reconstruire_cycle(v,parents))
    if status[v] == True :
        return False,None
    status[v] = False
    for u in G.successeurs(v) :
        parents[u] = v
        detected ,cycle = ContientCycleOriente(G,u,status,parents)
        if  detected :
            return detected,cycle
    status[v] = True

    return False,None

def arc_retour(G:DAOP,v,status,parents):
    status[v] = False
    for u in G.successeurs(v):
        if status[u] is None:
            parents[u] = v
            arc = arc_retour(G, u, status, parents)
            if arc is not None:
                return arc
        elif status[u] == False:
            parents[u] = v
            return (v, u)
    status[v] = True
    return None

def detect_cycle(G:DAOP):
    parents = {v:None for v in G.sommets()}
    status = {v:None for v in G.sommets()}
    for v in G.sommets():
        if status[v] is None:
            arc = arc_retour(G, v, status, parents)
            if arc is not None:
                cycle = DAOP()
                cycle.ajouter_arc(arc[0], arc[1])
                tmp = arc[0]
                while tmp != arc[1]:
                    cycle.ajouter_arc(parents[tmp], tmp)
                    tmp = parents[tmp]
                return True, cycle
    return False, None

def Khan(G:DAOP):
    res = list()
    source = deque()
    deg_entrants = {v:0 for v in G.sommets()}
    for v in G.sommets():
        deg_entrants[v] = G.degre_entrant(v)
        if deg_entrants[v] == 0 :
            source.append(v)
    while source :
        u = source.popleft()
        res.append(u)
        for v in G.successeurs(u):
            deg_entrants[v] -=1
            if deg_entrants[v] == 0 :
                source.append(v)
    return res
        
def fermeture_transitive(G:DAOP):
    F = type(G)()
    for arc in G.arcs():
        F.ajouter_arc(arc[0],arc[1],arc[2])
    for u in F.sommets():
        res = profondeurOriente(F,u,None,None)[0]
        print(res)
        for v in res:
            if u != v :
                F.ajouter_arc(u,v,1)
    return F


def dfs_post_order(graph: DAOP, v, result, visited):
    visited.add(v)
    for u in graph.successeurs(v):
        if u not in visited:
            dfs_post_order(graph, u, result, visited)
    result.append(v)

def compute_post_order_stack(graph: DAOP) -> list:
    result = []
    visited = set()
    for v in graph.sommets():
        if v not in visited:
            dfs_post_order(graph, v, result, visited)
    return result

def reverse_dfs(graph: DAOP, v, visited):
    visited.add(v)
    result = [v]
    for u in graph.predecesseurs(v):
        if u not in visited:
            result.extend(reverse_dfs(graph, u, visited))
    return result

def kosaraju(graph: DAOP):
    sccs = []
    stack = compute_post_order_stack(graph)
    print(stack)
    visited = set()
    while stack:
        u = stack.pop()
        if u not in visited:
            sccs.append(reverse_dfs(graph, u, visited))
    return sccs


def BellmanFord(G:DAOP,source):
    dist = {v:None for v in G.sommets()}
    parents = {v:None for v in G.sommets()}
    dist[source] = 0
    for i in range(len(G.sommets())-1):
        for u,v,p in G.arcs():
            if dist[u] is not None and (dist[v] is None or dist[u] + p < dist[v]):
                dist[v] = dist[u] + p
                parents[v] = (u,p)
    for u,v,p in G.arcs():
        if dist[u] is not None and (dist[v] is None or dist[u] + p < dist[v]):
            return False,None
    return dist,parents

def FloydWarshall(G:DAOP):
    dist = {v:{u:float('inf') for u in G.sommets()} for v in G.sommets()}
    parents = {v:{u:None for u in G.sommets()} for v in G.sommets()}
    for i in G.sommets():
        dist[i][i] = 0
    for u,v,p in G.arcs():
        dist[u][v] = p
        parents[u][v] = (u,p)
    for k in G.sommets():
        for i in G.sommets():
            for j in G.sommets():
                if dist[i][j] > dist[i][k] + dist[k][j]:
                    dist[i][j] = dist[i][k] + dist[k][j]
                    parents[i][j] = (parents[k][j][0],dist[k][j])
        
    return dist,parents





if __name__ == "__main__":
    
    G = DAP()
    G.ajouter_aretes([(0,1,7),(0,4,10),(0,3,5),(1,2,6),(4,2,1),(2,3,9),(3,4,2)])
    parents,dist = Djikstra(G,0)
    print(dist)
    dico_to_graphiz_format(G,"dot/cours_djikstra_initial.dot")
    dico_to_graphiz_format(rebuild_DAP(parents),"dot/djikstara_cours.dot")
    os.system("dot -Tpng dot/cours_djikstra_initial.dot -o dot/cours_djikstra_initial.png")
    os.system("dot -Tpng dot/djikstara_cours.dot -o dot/djikstara_cours.png")

    G = DAOP()
    G.ajouter_arcs([(0,1,7),(0,4,10),(0,3,5),(1,2,6),(4,2,1),(2,3,9),(3,4,2)])
    res,parents = profondeurOriente(G,0)
    print(res)
    print(parents)
    dico_DAOP_to_graphviz_format(G,"dot/cours_profondeur_oriente.dot")
    dico_DAOP_to_graphviz_format(rebuild_DAOP(parents),"dot/profondeur_oriente.dot")
    os.system("dot -Tpng dot/cours_profondeur_oriente.dot -o dot/cours_profondeur_oriente.png")
    os.system("dot -Tpng dot/profondeur_oriente.dot -o dot/profondeur_oriente.png")
    res,cycle = detect_cycle(G)
    print(res)
    print(cycle.arcs())
    print(res)
    if cycle is not None :
        dico_DAOP_to_graphviz_format(cycle,"dot/cycle.dot")
        os.system("dot -Tpng dot/cycle.dot -o dot/cycle.png")
    else :
        print("Pas de cycle")
        
    DAG = DAOP()
    DAG.ajouter_arcs([('a','d',1),('a','e',1),('a','f',1),('b','d',1),('b','e',1),('b','f',1),('c','e',1),('c','f',1),('c','d',1),('d','f',1),('e','f',1)])
    dico_DAOP_to_graphviz_format(DAG,"dot/cours_dag.dot")
    os.system("dot -Tpng dot/cours_dag.dot -o dot/cours_dag.png")
    print(Khan(DAG))
    print(Khan(G))


    g2 = DAOP()
    g2.ajouter_arcs([(0,1,1),(1,2,1),(2,3,1),(3,1,1)])
    F = fermeture_transitive(g2)
    dico_DAOP_to_graphviz_format(g2,"dot/cours_fermeture_transitive_initial.dot")   
    dico_DAOP_to_graphviz_format(F,"dot/fermeture_transitive.dot")
    os.system("dot -Tpng dot/cours_fermeture_transitive_initial.dot -o dot/cours_fermeture_transitive_initial.png")
    os.system("dot -Tpng dot/fermeture_transitive.dot -o dot/fermeture_transitive.png")
    print("Fermeture transitive")
    print(F.arcs())
    print("Initial")
    print(g2.arcs())
    print("Fermeture transitive")
    
    
    g3 = DAOP()
    g3.ajouter_arcs([(0,1,1),(1,4,1),(4,0,1),(1,5,1),(4,5,1),(5,6,1),(6,5,1),(1,2,1),(2,3,1),(3,7,1),(6,7,1),(2,6,1),(3,2,1)])
    res = kosaraju(g3)
    print(res)
    dico_DAOP_to_graphviz_format(g3,"dot/cours_kosaraju_initial.dot")
    os.system("dot -Tpng dot/cours_kosaraju_initial.dot -o dot/cours_kosaraju_initial.png")
    
    
    #g4 = DAOP()
    #g4.ajouter_arcs([('t','x',5),('t','y',8),('t','z',-4),('x','t',-2),('s','x',6),('s','y',7),('y','z',9),
    #                 ('y','x',-3),('z','x',7)])
    #
    #res,parents = BellmanFord(g4,'s')
    #print(res)
    #resDaop = rebuild_DAOP(parents)
    #dico_DAOP_to_graphviz_format(g4,"dot/cours_bellman_initial.dot")
    #dico_DAOP_to_graphviz_format(resDaop,"dot/bellman_initial.dot")
    #os.system("dot -Tpng dot/cours_bellman_initial.dot -o dot/cours_bellman_initial.png")
    #os.system("dot -Tpng dot/bellman_initial.dot -o dot/bellman_initial.png")
    #
    #g5 = DAOP()
    #g5.ajouter_arcs([(1,3,-2),(2,3,3),(4,2,-1),(3,4,2),(2,1,4)])
    #res,parents = FloydWarshall(g5)
    #print(parents)
    #i = 0
    #for parent in parents.values():
    #    #print(parent)
    #    tmp = rebuild_DAOP(parent)
    #    path = "dot/fw"+str(i)+".dot"
    #    print(path)
    #    dico_DAOP_to_graphviz_format(tmp,path)
    #    os.system(f"dot -Tpng dot/fw{i}.dot -o dot/fw{i}.png")
    #    i += 1
    #dico_DAOP_to_graphviz_format(g5,"dot/cours_fw_initial.dot")
    #os.system("dot -Tpng dot/cours_fw_initial.dot -o dot/cours_fw_initial.png")
    #print(res)
    #
    os.system("rm -f dot/*.dot")
    #
    

    


