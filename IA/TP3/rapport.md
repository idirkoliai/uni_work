# Exercice 01 

###  Question 1.1 Avant d’implémenter le réseau lui même, écrire sous la forme
NxCxHxW (N est la taille du batch, C le nombre de canaux) de chaque volume de
sortie de chaque couche, en partant de l’entrée de taille Nx1x28x28.

    * image d'entrée  : N * 1 x 28 x 28 
    * premiére couche de convolution : N x 8 x 28 x 28 
    * deuxieme couche maxpool : N x 8 x 14 x 14
    * troisieme couche de convolution : N x 16 x 14 x 14
    * quatrieme couche fully connected : 
        entrée : N x 3136
        sortie : N x 120
    * cinquieme couche fully connected :
        entrée : N x 120
        sortie : N x 84
    * couche de sortie : 
        entrée : N x 84
        sortie : N x 10
    
 