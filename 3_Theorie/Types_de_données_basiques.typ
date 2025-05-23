#import "../src/theorem.typ" : *
#import "@preview/curryst:0.5.1": rule, prooftree
#import "../src/rules.typ"

== Types de données basiques

Nous allons représenter les données qu'on voit habituellement en algèbre linéaire et voir comment ceux-ci s'articulent dans le concept de notre langage. 

Aujourd'hui les réseaux de neurones sont l'outil le plus populaire utilisé jusqu'à présent dans les sciences de données ou le machine learning. J'ai trouvé intéressant de voir ce que notre nouveau système de type est capable de faire pour ce type de cas. 

Pour la réalisation de notre projet, il nous faut d'abord définir les éléments nécessaires à l'établissement de ce module, à savoir, les matrices, les vecteurs et les scalaires. 

Les matrices sont à la base de l'algèbre linéaire et sont grandement utilisées pour simuler des réseaux de neurones. Dans notre cas, une matrice peut simplement être représentée comme un vecteur de vecteurs. 

En sciences des données un tenseur est une généralisation des vecteurs et matrices. Il permet d'avoir une représentation homogène des données et de simplifier certains calculs. En effet, une matrice est un tenseur de 2 dimensions, un vecteur est un tenseur de 1 dimension et un scalaire est un tenseur de dimension 0. De plus, un hypercube est en fait un tenseur de dimension 3. C'est une façon de représenter les données de façon efficace. 

Bien qu'on puisse travailler avec des tenseurs de plusieurs dimensions, on se rend compte en réalité que les datascientistes travaillent le plus souvent avec des tenseurs allant jusqu'à la dimension 5 au maximum. En effet, prendre de plus grandes dimensions rend les données difficiles à interpréter. De plus, l'essentiel des opérations se réalise au niveau du calcul matriciel, le reste des dimensions servant principalement de listes pour la représentation des informations. 

On peut partir de l'hypothèse qu'un simple tableau (array) est un vecteur. Ce qui va nous permettre de sauter directement aux matrices. 

#Exemple()[exemplte de type Scalaire et tenseurs
```
int = Scalaire  
[1, int] = Vecteur d'une ligne et d'une colonne  
[2, [3, int]] = matrice de deux lignes et 3 colonnes  
[3, [3, [3, bool]]] = tenseur de degré 3 cubique  
```
]

L'un des éléments fondamentaux de l'algèbre linéaire sont les matrices. En effet, les concepts de statistiques, de probabilité et de mathématiques sont représentés à l'aide de calculs sur les matrices. Le vecteur de vecteurs est la façon la plus simple de représenter les matrices. En effet les matrices ont une forme rectangulaire au carré ce qui fait que les sous vecteurs sont tous de la même taille ce qui va faciliter la représentation par des types. 

Une matrice:

#Exemple()[Simple matrice
$ mat(2, 2; 2, 2) $
]

Peut-être représentée comme ceci: 

#Exemple()[Représentation d'une simple matrice dans le langage système C3PO
```typescript
[[2, 2], [2, 2]]
```
]

Il n'y a pas d'évaluation intéressante pour une valeur. Le typage est simple:

#Exemple()[Exemple de la sémantique de typage d'une matrice
  $ #prooftree(rules.typing("T-ARR",
    $Gamma tack.r "[[2, 2], [2, 2]]" : "[2, [2, int]]"$,
    $"len([[2, 2], [2, 2]])" => "2"$,
    $tack.r 2 "index"$,
    rules.typing("T-ARR",
      $Gamma tack.r "[2, 2]" : "[2, int]"$,
      $"len([2, 2])" => "2"$,
      $tack.r 2 "index"$,
      $Gamma tack.r 2 : "int"$
    )
)) $
]

Plus loin nous traitons la notion de broadcasting qui est beaucoup utilisé dans le domaine des sciences des données et vu comment celle-ci peut-être représentée avec notre système de type. Ici nous nous intéressons à des opérations simples et faciles à typer. 

Par la représentation actuelle des matrices il est facile de représenter les opérations d'addition ou de multiplication. En effet il faut que les matrices aient la même forme pour fonctionner ce qui équivaut à voir deux matrices de même type. 

Pour ce faire, nous devons définir la notion de mapping. Notre langage est tiré du lambda calculus et exploite donc les notions de programmation fonctionnelle. Nous n'utilisons pas de boucle mais nous avons la notion de récursivité. Imaginons que nous voulions incrémenter de 1 tout les éléments d'un tableau avec notre langage. Le système de type nous prévient de faire des opération erronées comme: 

#Exemple()[Opération non valide dans le système de type
$ #prooftree(rules.typing("PLUS",
  $"[1, 2, 3, 4] + 1 : ?"$,
  $"[1, 2, 3, 4]" : "[4, int]"$,
  $"1" : "int"$,
)) $
]

Car l'opération d'addition du langage système C3PO ne peut seulement se faire qu'entre deux entiers. Pour être en mesure d'appliquer le "+ 1" pour chaque membre, il va falloir itérer dessus à l'aide de la récursivité.

#Exemple()[Fonction définie par l'utilisateur
```typescript
let tableau_plus_1: ([N, int]) -> [N, int] = 
  func<N>(tableau: [N, int]){
      if tableau == [] then
        []
      else
        [first(tableau) + 1] :: plus_1(rest(tableau))
  } in ...
```
]

Notez qu'on utilise déjà les notions de généricité pour travailler avec des tableaux de taille différentes. On pourrait refaire la même chose avec pour l'opérateur multiplication pour les entiers et "and" et "or" pour les booléens, mais le plus facile serait de créer la fonction map qui va nous permettre de simplifier les futures opérations avec les vecteurs et les matrices. La fonction map pourrait être définie comme:

#Exemple()[Création de la fonction map pour les tableaux
```typescript
let map: ((T) -> U, [N, T]) -> [N, U] = 
  func<T, U, N>(f: (T) -> U, tableau: [N, T]) -> [N, U] {
      if tableau == [] then
        []
      else
        [f(first(tableau))] :: (map(f, rest(tableau)))
  } in ...
```
]

Comme l'application de "+ 1" n'est pas une fonction, on peut en créer une spécialisée:

#Exemple()[Fonction unaire utilisable avec la fonction map
```typescript
let plus_1: (int) -> int = 
  func<>(num: int) -> int { N + 1 }
```
]

On est donc en mesure d'appeler la fonction de mapping avec cette fonction: 

#Exemple()[Évaluation de l'addition d'un tableau avec un scalaire à l'aide des fonctions map et plus_1
$ #prooftree(rules.evaluate("", "map(plus_1, [1, 2, 3, 4]) => [2, 3, 4, 5]", "")) $
]

#Exemple()[Typage de l'addition d'un tableau avec un scalaire à l'aide des fonctions map et plus_1

$ #prooftree(rules.typing("", "map(plus_1, [1, 2, 3, 4]) : [4, int]")) $
]

Cette expression est correctement typée et donne [2, 3, 4, 5]. 

Si nous voulons faire le même type d'opération sur les matrices (donc des tableaux de tableau), il va nous falloir définir une fonction de mappage d'un degré plus haut. En s'appuyant sur la définition de notre fonction map préalablement établie, on peut créer notre fonction map2 comme suite: 

#Exemple()[Fonction map pour une matrice
```typescript
let map2: ((T) -> U, [N, [M, T]]) -> [N, [M, T]] =
  func<>(f: (T) -> U, mat: [N, [M, T]]) -> [N, [M, T]]{
      if mat == [] then
        []
      else
        [map(f, first(mat))] :: (map2(f, rest(mat)))
  }
```
]

L'avantage de la définition choisie des tenseurs se présente dans la similarité entre les deux fonctions "map" et "map2". Faire la fonction map3 donnerait un résultat similaire, il suffirait juste de faire appel à "map3" à la place de "map2" et de "map2" à la place de "map1". Malheureusement notre langage ne supporte pas assez de fonctionnalité pour faire un mapping généralisé pour tout les tenseurs. 

Une autre chose intéressante serait de pouvoir appliquer des opérations entres différents tenseurs. En algèbre linéaire, il faut que les matrices aient la même forme. Notre système de type peut assurer ça. On verra un peu plus loin le cas particulier du broadcasting. On aimerait être en mesure d'additionner ou de multiplier des matrices de même forme. Comme vu tout à l'heure, faire des calculs en utilisant directement l'opérateur ne marche pas et est prévenu par notre système de type: 

#Exemple()[Comment faire une addition entre deux tableaux ?
$ #prooftree(rules.typing("", "[1, 2, 3, 4] + [4, 3, 2, 1] : ?")) $
]

Une solution serait d'appliquer la notion de mapping mais pour les fonctions binaires (à deux opérateurs). Il y aurait un moyen de réutiliser les fonctions map définies précédemment à l'aide de tuple, mais comme notre langage ne l'implémente pas, on se contentera de simplement créer des des fonctions binaires et une fonction "map_op". 
La fonction map_op est assez simple à réaliser, il suffit d'augmenter ce qu'on a déjà:

#Definition()[Fonction pour appliquer une opération sur deux tableaux
```typescript
let map_op: ((T, T) -> U, [M, T], [M, T]) -> [M, U] =
  func<T: Type, U: Type, M: Dim>(
    f: (T, T) -> U,
    tableau1: [M, T],
    tableau2: [M, T]) -> [M, U] {
      if and(tableau1 == [], tableau2 == []) then
        []
      else
      (f(first(tableau1), first(tableau2))) :: (map_op(f, rest(tableau1), rest(tableau2)))
  }
```
]

On part du principe que la fonction "f" prend deux éléments du même type "T", mais on pourrait la généraliser davantage. On peut alors définir des fonctions binaires à l'aide des opérateurs de base. 

#Exemple()[Fonction d'addition à partir de l'opérateur d'addition
```typescript
let plus: (int, int) -> int = 
  func<>(a: int, b: int) -> int {
    a + b
  }
```
]

#Exemple()[Fonction de multiplication à partir de l'opérateur de multiplication
```typescript
let mul: (int, int) -> int =
  func<>(a: int, b: int) -> int {
    a * b
  }
```
]

#Exemple()[Fonction band à partir de l'opérateur and
```typescript
let band: (bool, bool) -> bool = 
  func<>(a: bool, b: bool) -> bool {
    a and b
  }
```
]

#Exemple()[Fonction bor à partir de l'opérateur or
```typescript
let bor: (bool, bool) -> bool =
  func<>(a: bool, b: bool) -> bool {
    a or b
  }
```
]


L'addition entre deux vecteurs donnerait:

#Exemple()[Addition entre deux tableaux avec les fonctions map_op et plus
  map_op(plus, [1, 2, 3, 4], [4, 3, 2, 1]) => [5, 5, 5, 5]
]

Pour faire la même chose avec les matrice, il suffirait de reproduire "map_op" en "map_op2". 

#Exemple()[Opération pour les matrices
```typescript
let map_op2: ((T, T) -> U, [M, [N, T]], [M, [N, T]]) -> [M, [N, U]] = 
  func<T, U, M, N>(f: (T, T) -> U, tableau1: [N, T], tableau2: [N, T]) -> [N, U] {
    (map_op(first(tableau1), first(tableau2))) :: (map_op2(f, rest(tableau1), rest(tableau2)))
  }
```
]

Ici encore, il suffit juste de reprendre la fonction "map_op" et de remplacer toutes les instance de "map_op" en "map_op2". Nous pouvons maintenant utiliser les opérations de bases sur les matrices.

#Exemple()[Évaluation
#prooftree(rules.typing("",
  $Gamma tack.r "map_op2<int, int, 2, 2>(minus, [[2, 2], [2, 2]], [[1, 1], [1, 1]]) : [[1, 1], [1, 1]]"$,
))
]

Nous avons été capable de représenter les opérateur de base ("+", "\*", "and", "or") entre un scalaire et un vecteur, un scalaire et une matrice ainsi qu'un vecteur avec un vecteur et une matrice avec une matrice. Les opérations entre matrices et vecteurs sont en général traitées par le broadcasting. Nous laissons ce sujet pour la suite. 

Nous pouvons voir un exemple avec la librairie numpy de python: 

#Exemple()[Broadcasting avec numpy
```python  
import numpy as np  
  
col = np.array([1, 2, 3, 4])  
lin = np.array([[4, 3, 2, 1]])  
  
res1 = np.dot(lin, col)  = 20  
res1 = np.dot(col, lin)  = error  
  
= ValueError: shapes (4,) and (1,4)   
= not aligned: 4 (dim 0) != 1 (dim 0)  
```  
]


Un autre exemple avec la librairie de pytorch:
  
#Exemple()[Broadcasting avec pytorch 1
```python  
import torch  
  
col = torch.tensor([1, 2, 3, 4])  
lin = torch.tensor([[4, 3, 2, 1]])  
  
res1 = torch.dot(lin, col)  = error  
res2 = torch.dot(col, lin)  = error  
  
= RuntimeError: 1D tensors expected,  
= but got 2D and 1D tensors  
```  
]
  
#Exemple()[Broadcasting avec pytorch 2
```python  
import torch  
  
col = torch.tensor([1, 2, 3, 4])  
lin = torch.tensor([[4, 3, 2, 1]])  
  
res1 = lin + col  = tensor([[5, 5, 5, 5]])  
res2 = col + lin  = tensor([[5, 5, 5, 5]])  
  
print("res1:", res1)  
print("res2:", res2)  
```  
]

Ce qui va nous intéresser maintenant est l'utilisation du produit matriciel. C'est une propriété fondamentale de l'algèbre linéaire qui nous servira à l'établissement de la librairie de réseaux de neurones. Si nous avons deux matrice $A_("MxP")$ et $B_("PxN")$ le produit matriciel A \* B donnera $C_("MxN")$. Par exemple: 

#Exemple()[Produit matriciel $"A" dot.op "B"$
$ mat(1, 2, 0; 4, 3, -1) dot.op mat(5, 1; 2, 3; 3, 4) = mat(9, 7; 23, 9) $
]

#Exemple()[Produit matriciel $"B" dot.op "A"$
$ mat(5, 1; 2, 3; 3, 4) dot.op mat(1, 2, 0; 4, 3, -1)  = mat(9, 13, -1; 14, 13, -3; 19, 18, -4) $
]

La signature de cette fonction est simple à représenter:

#Exemple()[Signature générale du produit matriciel
```typescript
func<M, P, N>(A: [M, [P, int]], B: [P, [N, int]]) -> [M, [N, int]]
```
]

Pour définir le corps de la fonctions, il nous faudrait developper d'autres fonctions comme la transposition (car le produit matriciel est un produit ligne colonne) et modifier map_op pour être en mesure d'avoir des opérateurs qui prennent des type différent (signature (T1, T2) -> T3 ). Par soucis de simplicité, on ne le définira pas ici.

#Exemple()[Création du corps de la fonction dot
```typescript
let reduce_op : <T, U, N>((T, T) -> U, [N, T], [N, T]) = 
  func<T, N>(op: (T, T) -> U, a: [N, T], b: [N, T]) -> U {
     If and(a == [], b == []) then
        []
     else
        prepend(op(first(a), first(b)), reduce(op, rest(a), rest(b))
      end
}

let scalar_dot : <N, T>([N, T], [N, T]) -> T = 
  func<N, T>(a: [N, T], b: [N, T]) -> T {
     reduce(plus, map_op(mul, a, b))
}

let right_dot : <M, N, T>(B: [M, [N, T]], a: [N, T]) = 
  func<M, N, T>(B: [M, [N, T]], a: [N, T]) {
   map_op(scalar_dot, a, B)
}

let dot : <M, N, T>(A: [M, [N, T]], B: [M, [N, T]]) = 
  func<M, N, T>(A: [M, [N, T]], B: [M, [N, T]]) {
    map_op(right_dot, transpose(B), A)
}
```
]

Pour faire le produit matriciel (ici appellé dot) on doit utiliser la fonction de transposition ainsi que les fonctions définis right_dot, scalar_dot et la méthode reduce qu'on défini pour ce cas d'usage. Ainsi on va faire une boucle entre chaque ligne de la matrice de gauche et pour chacune de ces ligne faire une boucle avec les colonnes de la matrice de droit en faisant simplement la some du produit, élément par élément des deux tableaux.

Avec ces restrictions, nous sommes en mesure de représenter le typage concrèt de cette fonctions. 

Dans le domaine des sciences des données, nous avons aussi un ensemble de constructeures que nous pouvons utiliser. Notre langage ne nous permet pas la génération de nombre aléatoire donc on aura pas de générateur de matrice avec des éléments aléatoire bien que cela est assez pratique dans la création de réseaux de neurones.

#Exemple()[Constructeurs de matrice
```typescript
let vector: <T,M>(int, T) -> [M, T] =
  func <T, M>(len: int, value: T) -> [M, T] {
    if len == 0 then
      []
    else
      [value] :: vector(len-1, value)
  }
    
let matrix: <T, M, N>(int, int, T) -> [M, [N, T]] =
  func <int, M, N>(dim1: int, dim2: int, value: T) {
    if dim1 == 0 then
      []
    else
     vector(dim2, value) :: matrix(dim1-1, value)
  } in 

let zeros: (int, int) -> [M, [N, int]] =
  func <>(dim1: int, dim2: int) -> int {
    matrix(N1, N2, 0)
  } in

let ones: (int, int) -> [M, [N, int]] = 
  func <>(dim1: int, dim2: int) -> [M, [N, int]]{
    matrix(dim1, dim2, 1)
  } in

let trues: (int, int) -> [M, [N, bool]] =
  func <M, N>(dim1: int, dim2: int) -> [M, [N, bool]] {
    matrix(dim1, dim2, true)
  } in

let falses: (int, int) -> [M, [N, bool]] =
  func <M, N>(dim1: int, dim2: int) -> [M, [N, bool]] {
    matrix(dim1, dim2, false)
  }
```
]

#Exemple()[Autres fonctions utilitaires pour les matrices
```typescript
let length: <M, N, T>([M, [N, T]]) -> int = 
  func <M, N, T>(m: [M, [N, T]]) -> int {
    M * N
} in

let fill: <M, N, T>([M, [N, T]], T) -> [M, [N, T]] =
  func <M, N, T>(m: [M, [N, T]], value: T) -> [N1, [N2, T]] {
    matrix(M, N, value)
} in

let reduce : <T, U, N>((T) -> U, [N, T]) = 
  func<T, N>(op: (T, T) -> U, a: [N, T], b: [N, T]) -> U {
     If and(a == [], b == []) then
        []
     else
        prepend(op(first(a), first(b)), reduce(op, rest(a), rest(b))
      end
} in

let concat: <M, T, N>([M, T], [N, T]) -> [M+N, T] = 
func <M, T, N>(m1: [M, T], m2: [N, T]) -> [M+N, T] {
  m1 :: m2
}

let linearize: <M, N, T, O>([M, [N, T]]) -> [O, T] =
  func <M, N, T, O>(m: [M, [N, T]]) -> [O, T] {
    reduce(concat, m)
  }
```
]

En algèbre linéaire on est capable de faire un produit matriciel entre des vecteurs et des matrices un produit matriciel entre un vecteur ligne à gauche une matrice à droite aussi donner un vecteur colonne le produit matriciel entre une matrice à gauche et un vecteur colonne à droite va donner un vecteur à ligne. 

Le souci est que la définition actuelle du vecteur est un tableau d'une seule ligne mais la définition du produit matricielle demande l'implémentation de deux matrices. 

On pourrait créer une fonction matricielle dédiée mais on peut faire quelque chose de plus malin. En effet on peut représenter les vecteurs lignes et colonne comme des cas particuliers de matrice. Un vecteur ligne serait matrice de une ligne et de N colonne. Avec cœur colonne serait une matrice de une colonne et de n lignes. 

Avec cette représentation on est non seulement capable de faire une distinction entre les vecteurs lignes et les vecteurs colonnes mais on les rend aussi compatibles avec l'opération du produit matriciel. 

Les vecteurs sont maintenant compatibles avec toutes les opérations qu'on a défini sur les matrices. On peut donc additionner ou multiplier les vecteurs avec les même fonctions.

C'est pourquoi nous ferons donc une distinction entre les tableaux et les vecteurs au vu de tout les avantages que cela nous apporte.

Pour aller plus loin on pourrait essayer de représenter les scalaires en tant que matrices. La représentation la plus évidente serait de prendre une matrice de une ligne et de une colonne. C'est ce qu'on va faire. 

Encore une fois, si les scalaires sont un cas particulier de matrice. Ils bénéficient de toutes les fonctions qu'on a établies pour les matrices. Ce qui nous intéresse le plus est de voir leur comportement face au produit matriciel. Étant donné qu'un scalair est une matrice $A_("1x1")$, le produit scalaire demanderai que l'autre matrice soit de la forme 1xN si elle se trouve à droite et Mx1 si elle se trouve à gauche.

Cela signifie qu'un produit matriciel entre un scalaire et un vecteur peut être vu comme la multiplication classique entre un scalaire et un vecteur en algèbre linéaire classique. On pourrait tenter d'étendre cette fonctionnalité sur les matrices en général mais on se rend compte qu'il nous faudrait alors une matrice scalaire carré. Elle contiendra toujours la même valeur mais devra changer de forme. 

Nous avons donc une représentation pour les scalaires des vecteurs et les matrices. Les scalaires sont un cas particulier des matrices étant des matrices carrées. Les vecteurs dans votre carte particulier des matrices ayant l'une de leurs dimensions signalées à un. La natation générale de la matrice représente tout.

Nous nous rendons compte que dans les sciences des données nous utilisons aussi des danseurs qui vont au-delà de la dimension 2. Généralement c'est danseur en plus un rôle de représentation car les calculs qui se font se feront souvent au niveau matriciel. 

Un tenseur de dimension 3 représente souvent une image nous avons la dimension des coordonnées X la dimension des coordonnées y ainsi que la dimension pour les couleurs RGB qui est généralement de longueur 3. 

Un tenseur des dimensions 3 peut aussi représenter une liste de matrices. Cela peut aider pour définir une application de filtre sur une image comme par exemple. Cela peut aussi être une liste d'images en noir et blanc. Donc les représentations peuvent être vraiment multiples. parfois on peut attendre les dimensions 5 ou  6 parce que nous pouvons travailler avec des objets 3D en tant que liste avec aussi l'ajout d'un batch size bien même des vidéos, etc. Les calculs fait sur ces tenseurs prélève souvent d'une application matricielle combiné au broadcasting.
