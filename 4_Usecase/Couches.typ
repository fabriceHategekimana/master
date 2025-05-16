#import "../src/theorem.typ" : *

#pagebreak()

= Librairie de réseaux de neurones

Maintenant que nous avons été capable d'établire un formalisme pour la création et la manipulation de nos tableaux multidimensionnels. Nous pouvons nous lancer le défi de définir la base d'une librairie de réseaux de neuronnes et voir comment notre système de type peut nous aider à créer ce type de construction. Nous n'entrerons pas en détail sur les notions comme la backpropagation.

Dans son article, Joyes Xu @towardsdatascienceFunctionalProgramming a mentionné la possibilité de créer des réseaux de neuronnes par le biais de la programmation fonctionnelle. Nous allons faire la démonstration avec notre langage.
// lien de l'article: https://towardsdatascience.com/functional-programming-for-deep-learning-bc7b80e347e9

== Couches de réseaux de neurones

Un réseau de neurones en machine learning est un modèle computationnel inspiré du cerveau humain, conçu pour reconnaître des motifs et effectuer des tâches d'apprentissage automatique. Il est constitué de neurones artificiels, ou nœuds, organisés en couches. Chaque neurone reçoit des signaux d'entrée, les traite, et transmet une sortie aux neurones de la couche suivante. Les réseaux de neurones sont particulièrement efficaces pour des tâches complexes comme la reconnaissance d'images, la traduction de langues et la prédiction de séries temporelles.

Les couches d'un réseau de neurones peuvent être représentées à l'aide de matrices, facilitant ainsi les calculs mathématiques nécessaires pour l'apprentissage et l'inférence. Considérons un réseau de neurones simple avec une couche d'entrée, une couche cachée et une couche de sortie. La couche d'entrée reçoit les données initiales, souvent représentées par un vecteur x de dimension n, où n est le nombre de caractéristiques des données d'entrée.

Les neurones de la couche cachée effectuent des transformations linéaires sur les entrées, suivies de l'application de fonctions d'activation non linéaires. Les poids et biais de cette couche peuvent être représentés par une matrice W de dimension m \* n (où m est le nombre de neurones dans la couche cachée) et un vecteur de biais b de dimension m. Le calcul des activations pour la couche cachée est donné par z = Wx + b, où z est un vecteur de dimension m.

Enfin, la couche de sortie produit la sortie finale du réseau. Si cette couche a p neurones, elle a une matrice de poids W' de dimension p \* m et un vecteur de biais b de dimension p. Les sorties sont calculées de manière similaire : y = W' z + b', où y est le vecteur de sortie. 

Chaque couche du réseau effectue donc une transformation linéaire suivie d'une application de fonction d'activation, ces transformations étant exprimées sous forme de multiplications matricielles et d'additions vectorielles. En empilant plusieurs couches de ce type, les réseaux de neurones peuvent modéliser des relations complexes dans les données. Les paramètres (poids et biais) de ces matrices sont ajustés durant l'entraînement du réseau via des algorithmes comme la rétropropagation, qui minimise l'erreur de prédiction en ajustant progressivement les poids et les biais.

On peut en premier lieu tenter de représenter une couche à l'aide de notre système de type. Une couche peut avoir N entrées et O sorties et peut être construite à l'aide d'une matrice $M_{"NxO"}$ et d'un vecteur v de taille O. On peut représenter ça comme une fonction qui prend en entrée une matrice et un vecteur puis retourn une fonction layer qui respecte ce protocole. Cette fonction prend un vecteur ligne et ne fera seulement que d'appliquer l'opération linéaire et retourner un vecteur colonne.

#Exemple()[Création d'une couche de réseau de neurones
```typescript
let NNLayer: ([N, [O, T]], [O, T]) -> [1, [O, T]] =
  func <N, O, T>(m: [N, [O, T]], b: [O, T]) {
    func <N, T>(v: [1, [N, T]]){
        plus2(dot(v, m), b)
    }
  } 
```
]

Pour éviter que les applications faites dans les réseaux de neurones restent linéaires (car ceci peut entraîner le fameux "vanishing gradient"), les fonction non linéaires ont étés inventée. Nous avons notamment la fonction sigmoïde, la fonction ReLU, etc. Dans notre cas, le langage prototype que nous avons à notre disposition ne peut pas émuler ce comportement. Nous allons donc faire une fonction d'activation faussement linéaire. Le but est juste de montrer que ce type d'opération peut être typé et donc protégé.

#Exemple()[Pseudo fonction sigmoïd
```typescript
let p_sigmoid: ([N, T]) -> ([1, [N, T]]) -> [N, [1, T]] =
  func<N, T>(v: [N, T]){
    transpose(V)
  }
```
]

La pseudo fonction d'activation "p_sigmoid" prendra un vecteur colonne et retourner a un vecteur ligne de même longueur qui sera passé à la prochaine couche. Ici on ne fera que de transposer le vecteur par soucis de simplicité.

