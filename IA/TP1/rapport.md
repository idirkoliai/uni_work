# exercice 01 : 

 * Question 1.4 Faire varier la ligne de la séparation en modifiant les poids du neurone.
D’après vous quel paramètre devrait faire varier quel aspect de la droite ?
    * **when w_1 is higher the separation is more horizontal** 
    * **when w_0 is higher the separation is more vertical** 

# exercice 02 : 

 * Question 2.1 Que vaut C si ¯y = y ? Si ¯y = 0 et y = 1 ? Si ¯y = 1 et y = 0 ? Expliquer
* Question 2.1 Que vaut C si ¯y = y ? Si ¯y = 0 et y = 1 ? Si ¯y = 1 et y = 0 ? Expliquer
pourquoi c’est une fonction de coût. 
    * **C = 0 si ¯y = y**
    * **C = f(i0, i1) = b + w<sub>0</sub>i<sub>0</sub> + w<sub>1</sub>i<sub>1</sub> si ¯y = 0 et y = 1**
    * **C = -f(i0, i1) = b - w<sub>0</sub>i<sub>0</sub> - w<sub>1</sub>i<sub>1</sub> si ¯y = 1 et y = 0**
    * **C'est une fonction de coût car elle permet de mesurer l'erreur entre la prédiction et la réalité.**

* uestion 2.2 A partir de l’équation (4), calculer ∂f
∂w0 , ∂f
∂w1 et ∂f
∂b .
    * **∂f/∂w<sub>0</sub> = i<sub>0</sub>**
    * **∂f/∂w<sub>1</sub> = i<sub>1</sub>**
    * **∂f/∂b = 1**

* Question 2.5 Faire varier le learning rate. Que se passe-t-il avec des valeurs très
grandes ? Très petites ?
    *  **pour des valeurs très petites, le modèle converge très lentement**
    *  **pour des valeurs très grandes, peut ne pas converger**

* Question 2.6 Faire varier l’initialisation. A la place d’une initialisation au hasard,
essayez le neurone exemple du début. Que remarquez-vous ?

 * **l'initialisation de l'exo 1 est déjà une solution optimale.**

* Question 2.7 Utiliser les autres jeux de données non_separable_*. Que remarquez vous ? D’après vous, pourquoi ?
    * **Les données non séparables ne peuvent pas être séparées par une droite.**
    * **Le modèle ne peut pas converger.**

* Implémenter la fonction d’activation sigmoïde s(x) = 1
1+e−x (créer une
fonction sigmoid et afficher ses valeurs). Quelle est sa dérivée ? Pourquoi est-ce intéressant 
de l’utiliser ?
   
