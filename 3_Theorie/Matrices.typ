Aujourd'hui les réseaux de neuronnes sont l'outil le plus populaire utilisés jusqu'à présent dans les sciences de données ou le machine learning. J'ai trouvé intéressant de voir ce que notre nouveau système de type est capable de faire pour ce type de cas.

Pour la réalisation de notre projet, il nous faut d'abord définir les éléments nécessaire à l'établissement de ce module, à savoir, les matrices, les vecteurs et les scalaires.

Les matrices sont à la base de l'algèbre linéaire et sont grandement utilisé pour émuler des réseaux de neurones. Dans notre cas, une matrice peut simplement être représenté comme un vecteur de vecteur.

== Tenseurs (Shape compatibility)
En sciences des données un tenseur est une généralisation des vecteurs et matrices. Il permet d'avoir une représentation homogène des données et de simplifier certains calcules. En effet, une matrice est un tenseur de 2 dimensions, un vecteur est un tenseur de 1 dimension et un scalaire est un tenseur de dimension 0. De plus un hypercube est en fait un tenseur de dimension 3. C'est une façon de représenter les données de façon efficace.

Bien qu'on puisse travailler avec des tenseurs de plusieurs dimensions, on se rend compte en réalité que les datascientistes travail le plus souvent avec des tenseur allant jusqu'à la dimension 4. En effet, prendre de plus grande dimension rend les données difficile à interpréter.



## Introduction
type([...]) = int[type(...)]

## Exemple
```r
int # Scalaire  
int[1,1] # Vecteur d'une ligne et d'une colonne  
int[2, 3] # matrice de deux lignes et 3 colonnes  
bool[3,3,3] # tenseur de degré 3 cubique  
```

# Tenseurs (Shape compatibility)

## Opérations de base
type(e1) = int[A1], type(e2) = int[A2], A1 = A2 = A -- type(e1 + e2) = type[A]  
type(e1) = int[A1], type(e2) = int[A2], A1 = A2 = A -- type(e1 - e2) = type[A]  
type(e1) = int[A1], type(e2) = int[A2], A1 = A2 = A -- type(e1 * e2) = type[A]  
type(e1) = int[A1], type(e2) = int[A2], A1 = A2 = A -- type(e1 / e2) = type[A]  

# Tenseurs (Shape compatibility)
## Produit matriciel
type(e1 %*% e2) = type[]  
type[3,3] dot type[3,3] = type[3,3]  
type[2,3] dot type[3,2] = type[2,2]   
type[3,2] dot type[2,3] = type[3,3]  

## Règles
type[N,M]  dot type[M,N] = type[N,N]  
type[N1,M]  dot type[M,N2] = type[N1,N2]  



# Concatenation  
  
## Restrictions actuelles  
On peut concatener que si les MDA sont de même dimension.  
La concatenation crée une "addition" sur les paramètres tout à droite.  
  
## Exemples  
concat(1, 1) faux car concat(int, int)  
concat([1, 2], 1) faux car concat(<int, 2>, int)  
concat([1, 2], [3]) juste car concat(<int, 2>, <int, 1>) -> <int, 3>  
concat([1; 2], [3, 4]) faux car concat(<int, 2, 1>, <int 2>)  
concat([1; 2], [3 4; 5 6]) vrai car concat(<int, 2, 1>, <int, 2, 2>) -> <int, 2, 3>  
  
# Typing rules  
## Default types  
$$  
\infer{\Gamma \vdash Value : logical}{%  
    Value \in Logical  
}  
$$  
  
$$  
\infer{\Gamma \vdash Value : integer}{%  
    Value \in Integer  
}  
$$  
  
$$  
\infer{\Gamma \vdash Value : float}{%  
    Value \in Float  
}  
$$  
  
$$  
\infer{\Gamma \vdash Value : complex}{%  
    Value \in Complex  
}  
$$  
  
$$  
\infer{\Gamma \vdash Value : character}{%  
    Value \in Character  
}  
$$  
  
# Typing rules  
## Typing of a variable  
  
$$  
\infer{\Gamma \vdash Variable }{%  
    Variable : Type \in \Gamma  
}  
$$  
  
# Typing rules  
## Typing of a variable declaration  
  
$$  
\infer{\Gamma \vdash Variable : Type -> \Gamma'   
}{%  
}  
$$  
  
# Typing rules  
## Typing of an assignation  
$$  
\infer{\Gamma \vdash Variable : Type = Value -> \Gamma'  
}{%  
Value \in Type  
}  
$$  

### Constructors
let matrix = func <T, N1, N2>(dim: (N1, N2), value: T) -> [[T, N2], N1]  
let zeros = func <N1, N2>(dim: (N1, N2)) -> [[int, N2,] N1]  
let ones = func <N1, N2>(dim: (N1, N2)) -> [[int, N2,] N1]  
let trues = func <N1, N2>(dim: (N1, N2)) -> [[bool, N2,] N1]  
let falses = func <N1, N2>(dim: (N1, N2)) -> [[bool, N2,] N1]  


## Matrices
### arithmetic operations
let add = func <T>(a: T, b: T) -> T  
let sub = func <T>(a: T, b: T) -> T  
let mul = func <T>(a: T, b: T) -> T  
let div = func <T>(a: T, b: T) -> T  

### Structure operations
let length = func <T, N1, N2>(m: [[T, N2], N1]) -> int  
let shape = func <T, N1, N2>(m: [[T, N2], N1]) -> (int, int)  
let eltype = func <T, N1, N2>(m: [[T, N2], N1]) -> T 

## Matrices
### Miscellanious
let dot = func <P, M, N>(m1: [[int, P], M], m2: [[int, N], P]) -> [[int, N], M]  
let fill = func <T, N1, N2>(m: [[T, N2], N1], e: T) -> [[T, N2], N1]  

### Hooray !
let linearize = func <T, N1, N2>(m1: [[T, N2], N1]) -> [T, N1*N2]  

**Must specify the shape:**  
let reshape = func <T1, T2, T3>(m1: [[T1, N2], N1], shape: T2) -> T3  

- T1 is any type
- T2 is a tuple
- T3 is an Array


## Neural network layer

![](images/nn_layer.png)

## Layer

### Definition
let NNLayer = type <T, N1, N2> -> (m: [[T, N2], N1], b: [T, N1])  
let forward = func <T, N, N1, N2>(input: [T, N], layer: ([[T, N2], N1], [T, N1]))

## Neural network layers

![](images/nn_layers.png)

## Questions


### How to represent a networks of layers ?
- Array of layers

### How to represent a networks of different layers ?
- How to check the compatibility of layers of multiple sizes


## Dot product  
  
### Matrix MxN  
[[T, N], M]  
  
### Dot product  
let dot = func <P, M, N>(m1: [[int, P], M], m2: [[int, N], P]) -> [[int, N], M]    
  
## Dot product with vectors  
  
![](images/vectors_dot_product_scalar.png)  
![](images/vectors_dot_product_matrix.png)  
  
## Observation (numpy)  
  
```python  
import numpy as np  
  
col = np.array([1, 2, 3, 4])  
lin = np.array([[4, 3, 2, 1]])  
  
res1 = np.dot(lin, col)  # 20  
res1 = np.dot(col, lin)  # error  
  
# ValueError: shapes (4,) and (1,4)   
# not aligned: 4 (dim 0) != 1 (dim 0)  
```  
  
Show shape error but only at runtime.  
  
## Observation (pytorch)  
  
```python  
import torch  
  
col = torch.tensor([1, 2, 3, 4])  
lin = torch.tensor([[4, 3, 2, 1]])  
  
res1 = torch.dot(lin, col)  # error  
res2 = torch.dot(col, lin)  # error  
  
# RuntimeError: 1D tensors expected,  
# but got 2D and 1D tensors  
```  
  
Only indication at runtime.  
  
## Observation (pytorch) 2  
  
```python  
import torch  
  
col = torch.tensor([1, 2, 3, 4])  
lin = torch.tensor([[4, 3, 2, 1]])  
  
res1 = lin + col  # tensor([[5, 5, 5, 5]])  
res2 = col + lin  # tensor([[5, 5, 5, 5]])  
  
print("res1:", res1)  
print("res2:", res2)  
```  
  
  
## Specificity of broadcasting  
  
![](images/broadcasting_semantic.png)  
  
Broadcasting add lacking dimension to tensors.  
  
## Correspondances  
  
### Broadcast vector  
So a **(n,)** vector can be broadcasted to a **(n, 1)** matrix.  
We can call it a **column vector** (n lines and 1 column).  
We also have a **line vector** (1 line and n columns).  
  
### Vectors  
column vector: [[T, 1], N]  
line vector: [[T, N], 1]  
  
  
## Dot product vectors line-column  
![](images/vectors_dot_product_scalar.png)  
  
**(1, n) dot (n, 1) -> (1, 1)**      
dot(m1: **[[T, N], 1]**, m2: **[[T, 1], N]**) -> **[[T, 1], 1]**  
  
  
## Dot product vectors column-line  
![](images/vectors_dot_product_matrix.png)  
  
**(n, 1) dot (1, n) -> (n, n)**    
dot(m1: **[[T, 1], N]**, m2: **[[T, N], 1]**) -> **[[T, N], N]**  
  
  
## Vectors  
  
### Properties  
  
- Are different from arrays  
- Are a specific case of matrix  
- Are of 2 kinds (line/column vector)  
- Are compatible with dot product  
- Are compatible with transposition  
  
### Definition  
  
- let ColVec = func<T, N>(a: [T, N]) -> [[T, 1], N]  
- let LinVec = func<T, N>(a: [T, N]) -> [[T, N], 1]  
  
## Scalar product  
  
### Question  
**Can we also represent a scalar as matrix ?**  
  
### Representation  
- **scalar**: 7 : T   
- **"matrix" scalar**: [\[7]] : [[T, 1], 1]  
- Now compatible with dot product  
  
## Scalar dot product (what works)  
  
### With a scalar  
(1, 1) dot (1, 1) -> (1, 1)  
  
### With a line vector (left product)  
(1, 1) dot (1, n) -> (1, n)  
dot<T, N>(m1: [[T, 1], 1], m2: [[T, N], 1]) -> [[T, N], 1]  
  
### With a column vector (right product)  
(n, 1) dot (1, 1) -> (n, 1)  
dot<T, N>(m1: [[T, 1], N], m2: [[T, 1], 1]) -> [[T, 1], N]  
  
## Scalar dot product (what works)  
  
### Modification  
**We need to extend the scalar to a square matrix**    
**In fact [[T, 1], 1] is himself a square matrix**  
  
### With a matrix (left product)  
(m, m) dot (m, n) -> (m, n)  
dot<T, N>(m1: [[T, M], M], m2: [[T, N], M]) -> [[T, N], M]  
  
### With a matrix (right product)  
(m, n) dot (n, n) -> (m, n)  
dot<T, N>(m1: [[T, N], M], m2: [[T, N], N]) -> [[T, N], M]  
  
## Scalars  
  
### Properties  
  
- Are different from primitiv types  
- Are a specific case of matrix  
- Are compatible with dot product  
- Are compatible with transposition (neutral function)  
- Can replace the multiplication if we define them as identity matrix  
  
  
## Other cases (from tensorflow)  
  
- add a scalar to a vector (**broadcasting**)  
- multiply two tensors (**broadcasting**)  
- matrices over for loops  (**broadcasting**)  
- add vector to a matrix (**broadcasting**)  
  
  
## Other cases (from tensorflow)  
  
- add a scalar to a vector (**use map**)  
- multiply two tensors (**use map**)  
- matrices over for loops (**use map**)  
- add vector to a matrix (use map)  
  
## Goal  
  
![](images/matrices_for_all.png)  
  
## Miscellanious  
  
### Linearisation  
let linearize = func <T, N1, N2>(m1: [[T, N2], N1]) -> [T, N1\*N2]    
  
### Higher order function  
let map = func<T, U, N>(f: (T) -> U, a: [T, N]) -> [U, N] {  
	if N == 0 {  
		[]  
	} else {  
		[f(head(a)), map(f, tail(a))]  
	}  
}  
  
  
## Neural network layer  
  
![](images/nn_layer.png)  
  
## Layer  
  
### Definition 1  
let NNLayer = func<T, N1, N2>(m: [[T, N2], N1], b: [[T, 1], N2]) -> f([[T, N1], 1]) -> f([[T, 1], N2])  
  
Take a line vector and return a column vector  
  
### Definition 1  
let NNLayer = func<T, N1, N2>(m: [[T, N2], N1], b: [[T, 1], N2]) -> f([T, N1]) -> f([T, N2])  
  
The array to vector (and vice versa) conversion is done in the function  
  
## Neural network layers  
  
![](images/nn_layers.png)  
  
## Layers  
  
let l1 = NNLayer(m1, b1) in  
let a = sigmoid in  
let l2 = NNLayer(m2, b2) in  
	a(l1(a(l2)))([1, 2, 3, 4])  
