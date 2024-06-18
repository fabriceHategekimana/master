== Broadcasting

Le broadcasting fait référence à la capacité d'une bibliothèque de manipuler des tableaux de différentes dimensions ensemble, en étendant implicitement la forme des tableaux plus petits pour qu'ils correspondent à la forme des tableaux plus grands. Cela permet de réaliser des opérations élémentaires sans explicitement dupliquer des données, ce qui est crucial pour l'efficacité computationnelle.

Le but est de voir comment le broadcasting peut-être implémenté dans notre système de type. L'idéal serait de pouvoir le faire pour les tenseurs avec les opération binaires (+, -, /, etc.). En général, l'extension se fait par la dernière dimension.

=== Cas simple
Dans cet exemple, fait avec python et la librairie numpy, l'opération marche sans problème. Nous avons deux tenseurs de même taille. Ce genre de cas est facile a implémenter et ne dépend pas du broadcasting. Cet exemple est juste pour montrer que c'est une propriété du broadcasting.
 
```python
a = np.array([1.0, 2.0, 3.0])
b = np.array([2.0, 2.0, 2.0])
a * b = array([2.,  4.,  6.])
```

=== Propriété 1: extension axiale
Une des propriétés intéressantes du broad casting est l'extension axiale. On est capable de prendre deux tableaux de taille différente. Nous avons ici, deux tenseurs de dimension 1 mais de longueur différente. Le broadcasting permet d'étendre la longueur de l'axe le plus court.
 
```python
a = np.array([1.0, 2.0, 3.0])
b = np.array([2.0])
# a * b = array([2.,  4.,  6.])
```

Si nous avons deux tenseurs de dimension N, T1: (n1, n2, ..., nN) et T2: (m1, m2, .., mN). Le broadcasting va nous permettre d'ajuster la taille de la dimension la plus petite à la dimension la plus grande. On aurait une signature du type:

op((n1, n2, ..., nN), (m1, m2, ..., mN)) -> (max(n1, m1), max(n2, m2), ..., max(nN, mN))

Dans le cas de l'exemple précédent, nous avons cette transformation: \*((3), (1)) -> (3).

=== Propriété 2: extension dimensionelle (extension sur la gauche)
Une autre propriété du broadcasting est sa capacité à ajuster la forme d'un tenseur en ajustant le nombre de dimension.
 
```python
a = np.array([[1.0, 2.0, 3.0], [4.0, 5.0, 6.0]])
b = np.array([2.,  4.,  6.])
# a * b =  np.array([[ 2.  8. 18.], [ 8. 20. 36.]])
```

Si nous avons deux tenseurs de dimensions différentes T1: (n1, ...), T2: (m1, ..) et dim(T1) = N, dim(T2) = M le broadcasting va nous permettre d'ajuster la dimension la plus petite en ajoutant des axes supplémentairs de longueur 1. Après quoi, on applique l'extension axial mensionné précédement. Il serait difficile de représenter une signature pour des tenseurs de dimensions différentes sans ajouter des notations bizarre.

Notre exemple de tout à l'heure nous donnerait:  \*((2, 3), (3)) -> (2, 3). Comme mentionné précédement, il n'y a pas de méthode possible avec notre système de type pour représenter ce genre d'opération. Pour accomplir cela, on pourait inclure la dimension dans la description de type comme dans le travail de (TODO : mentionner la source).

=== Autre propriété
Dans les langage dynamique comme python, le broadcasting est couplé à une transformation dynamique de type. Notament, on peut faire des calcules élémentaires entre des nombres et des matrices, ce qui est proche de la vision mathématique de l'algèbre linéaire.
 
```python
a = np.array([1.0, 2.0, 3.0])
b = 2.0
a * b = array([2.,  4.,  6.])
```

On se réalise que le broadcasting est la combinaison de trois applications: l'extension dimensionnelle, l'extension axiale et l'application de l'opération élément par élément. On peut donc séparer ça en trois fonctions différentes. Comme on l'a vu, les fonctions d'extension dimensionnelle et d'extension axiale.

L'équipe qui voulait developper un système de type pour les ndarray de numpy a proposé une représentation du broadcasting intéressante mais qui n'offre pas la sécurité qui nous intéresse (TODO : citer la source).
 
```python
def broadcast(x: Ndarray[*A], Ndarray[Broadcast[A]])
-> Ndarray ?:
```

La représentation des tenseurs que nous avons adopté dans le chapitre précédent reste quand même très puissante et assez fidèle à la représentation mathématique des vecteurs et matrices tout en gardant l'habilité de travailler avec des tenseurs de dimensions supérieur à 2. Malheureusement le broadcasting ne peut pas être fidèlement typé et sécurisé dans ce langage et sera donc mis de côté.


