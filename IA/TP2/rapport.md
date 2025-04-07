#### koliai idir

# TP2 : Réseaux de neurones

## exercice 1 : 
## Question 1.1*
  * Question 1.3 Regarder les paramètres, les reconnaissez vous ?
    premier parametres : in_channels , second parametres : out_channels , troiseme parametres : kernel_size 
    torch.nn.Conv2d(in_channels, out_channels, kernel_size, stride=1, padding=0, dilation=1, groups=1, bias=True, padding_mode='zeros', device=None, dtype=None)

  * Question 1.4 Comparer la vitesse d’exécution entre votre implémentation et pytorch. A
votre avis, qu’est-ce qui peut faire la différence ?
    la variante pytorch est plus rapide que la variante numpy, car elle utilise des opérations vectorisées et des optimisations spécifiques au GPU. 

## exercice 2 : 
  * Question 2.1 Tester les kernel de détection de contours. Expliquer pourquoi cela  détecte les contours. 
    #explication du principe de detection de contour
    Le principe de la détection de contours repose sur l'identification des variations abruptes d'intensité lumineuse dans une image. Ces variations sont souvent associées à des transitions entre différentes régions de l'image, telles que les bords d'objets ou les changements de texture. Les kernels de détection de contours, tels que Sobel, Prewitt ou Canny, sont conçus pour mettre en évidence ces variations en appliquant des opérations de convolution sur l'image d'entrée.

  * Question 2.2 Essayer de faire un kernel qui ne détecte que les transitions haut-bas et gauche-droite.
    #explication du principe de detection de heaut-bas et gauche-droite
    Le principe de la détection de transitions haut-bas et gauche-droite repose sur l'identification des variations d'intensité lumineuse dans les directions verticales et horizontales. Pour ce faire, on peut utiliser des kernels spécifiques qui mettent en évidence ces transitions. 

  * Question 2.3 Tester le kernel d’augmentation de la netteté. Expliquer pourquoi il a cet 
  effet
    #explication du principe d'augmentation de la netteté
    L'augmentation de la netteté d'une image repose sur l'accentuation des détails et des contours présents dans l'image. Cela est généralement réalisé en appliquant un filtre de convolution qui amplifie les variations d'intensité lumineuse, rendant ainsi les bords et les textures plus prononcés.

    
   
  


