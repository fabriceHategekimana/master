#import "../src/module.typ" : *

#pagebreak()

== Le système de type de R

Avant de nous lancer sur la construction de notre solution, il est important de voir le fonctionnement du langage R afin de voir les caractéristiques qui en font un bon candidat en tant que langage de référence. 

En R, tout est représenté sous forme de vecteurs, de liste ou de fonction. Même les scalaires sont des vecteurs. Un scalaire est simplement un vecteur de longueur 1, ce qui signifie que toute valeur en R est intrinsèquement un vecteur. Cette uniformité simplifie la manipulation des données, car les mêmes opérations peuvent être appliquées à des valeurs simples ou à des ensembles de valeurs sans distinction. 

#Exemple(
```R
# créer un vecteur
v1 <- c(1, 2, 3, 4) # donne [1, 2, 3, 4]

# La fonction 'c()' concatènes des vecteurs
v2 <- c(c(1, 2), c(3, 4)) # donne [1, 2, 3, 4]

# Définir une valeur crée automatiquement un vecteur
v3 <- 2  # donne [2]
```
)


De plus, les structures de données plus complexes, comme les listes, sont également basées sur des vecteurs. Les listes en R peuvent contenir des vecteurs de différentes longueurs et de différents types, offrant une grande flexibilité dans la gestion et l'organisation des données. C'est pourquoi il existe de nombreuses fonctions par défaut en R qui sont conçues pour opérer directement sur des vecteurs ou des listes, rendant le langage particulièrement puissant et efficace pour les analyses statistiques et les opérations de données.

#Exemple(
```R
# Création d'une liste: utilise le mot-clé "list"
nombres <- list(1, 2, 3, 4, 5)
noms <- list("Alice", "Bob", "Charlie")

# Accès aux éléments d'une liste
premier_nombre <- nombres[[1]]  # Résultat : 1
deuxieme_nom <- noms[[2]]  # Résultat : "Bob"

# Ajouter des éléments à une liste
nombres <- append(nombres, 6)  # La liste devient : list(1, 2, 3, 4, 5, 6)
noms <- append(noms, "David")  # La liste devient : list("Alice", "Bob", "Charlie", "David")

# Supprimer des éléments d'une liste
nombres <- nombres[-which(nombres == 3)]  # La liste devient : list(1, 2, 4, 5, 6)
dernier_nombre <- tail(nombres, n = 1)  # Dernier élément : 6
nombres <- nombres[-length(nombres)]  # Retirer le dernier élément, la liste devient : list(1, 2, 4, 5)
```
)

Dans le langage R, tout peut avoir des attributs. Les attributs sont des métadonnées associées à un objet R. Ils fournissent des informations supplémentaires sur l'objet, sa structure, ou son comportement. Les vecteurs et les listes peuvent ainsi contenir des informations supplémentaires qui peuvent aider à changer le comportement du code s'il a été prévu pour.

#Exemple(
```R
# Créer un vecteur
vecteur <- c(1, 2, 3)

# Afficher les attributs du vecteur
attributes(vecteur)

# Accéder à l'attribut "noms" (qui n'existe pas par défaut)
attr(vecteur, "noms")

# Ajouter un attribut "noms" au vecteur
noms <- c("un", "deux", "trois")
attr(vecteur, "noms") <- noms

# Afficher l'attribut "noms" après l'avoir ajouté
attr(vecteur, "noms")
```
)

Ces attributs sont des métadonnées qui peuvent être changées durant le temps d'exécution. Elles peuvent aussi être appliquées aux fonctions. Les classes ne sont en fait que des listes qui ont des attributs spécifiques. Ces attributs peuvent être utilisés lorsque les structures sont passées en tant que éléments de fonction, l'expédition de la bonne fonction à appeler se fait de façon dynamique (dynamic dispatch #footnote[Le dynamic dispatch, ou la répartition dynamique, est un concept clé en programmation orientée objet qui concerne la façon dont les méthodes sont sélectionnées et exécutées en fonction du type réel d'un objet lors de l'exécution du programme. En d'autres termes, cela permet à un langage de déterminer dynamiquement quelle méthode appeler en fonction du type de l'objet sur lequel la méthode est invoquée.]). C'est ce qu'utilise actuellement le système S3 ou S4 de R. 

Les arrays dans R sont la structure de données la plus proche de ce qu'est un tenseur. En effet, c'est une représentation de tenseur. En réalité, les arrays sont des vecteurs avec un attribut spécial décrivant la dimension du dit tenseur. Mais la structure sous-jacente reste le vecteurs. 

#Exemple(
```r
# Création d'un array 2x3
array_2x3 <- array(1:6, dim = c(2, 3))
print(array_2x3)

# Création d'un array 3x3x2
array_3x3x2 <- array(1:18, dim = c(3, 3, 2))
print(array_3x3x2)
```
)

Le fer de lance de R se trouve dans les dataframes qui sont une implémentation presque entièrement intégré dans le langage. Les dataframes sont des structures de données fondamentales en R, utilisées pour organiser des données tabulaires sous forme de lignes et de colonnes. Chaque colonne représente une variable distincte et chaque ligne correspond à une observation ou un enregistrement unique. Les dataframes sont essentiels en R pour plusieurs raisons principales. Tout d'abord, ils permettent de manipuler et d'analyser facilement des ensembles de données complexes et hétérogènes, provenant de diverses sources telles que des fichiers CSV, des bases de données ou des résultats d'expérimentations scientifiques. De plus, R offre un large éventail de fonctions intégrées et de packages spécialisés dédiés à la manipulation, à la transformation et à l'analyse de dataframes, facilitant ainsi des tâches telles que le filtrage, le tri, le calcul de statistiques descriptives et la création de graphiques. Enfin, les dataframes jouent un rôle crucial dans les analyses statistiques et la modélisation de données, permettant aux chercheurs, aux statisticiens et aux scientifiques des données d'effectuer des manipulations complexes tout en maintenant une organisation structurée et facilement interprétable des données. En réalité, un dataframe est une liste de vecteurs par définition.

#Exemple(
```R
# Créer des vecteurs pour chaque variable
nom <- c("Alice", "Bob", "Charlie", "David")
age <- c(18, 21, 22, 19)
filiere <- c("Informatique", "Mathématiques", "Statistique", "Informatique")
moyenne <- c(16.5, 17.2, 18.1, 15.8)

# Combiner les vecteurs dans un data frame
etudiants <- data.frame(nom, age, filiere, moyenne)

# Afficher le data frame
print(etudiants)
```
)

En R, les fonctions jouent un rôle central et peuvent être définies de manière anonyme, ce qui est un aspect clé de la programmation fonctionnelle. Une fonction anonyme est une fonction sans nom qui est définie à la volée, souvent utilisée comme argument à d'autres fonctions. En R toute fonction est une fonction anonyme.

#Exemple(
```R
# Création et utilisation de fonctions anonymes en R

#Définir une fonction anonyme
add_two <- function(x) { x + 2 }

# Utilisation de la fonction
result <- add_two(3)
print(result)  # Résultat : 5

#Utiliser des fonctions anonymes avec lapply
nombres <- list(1, 2, 3, 4, 5)
```
)

L'équivalent de la fonction map sont les fonctions apply et lapply. Apply s'applique à des array, mais lapply est plutôt utilisé pour travailler avec des listes.

#Exemple(
```R
# Utiliser une fonction anonyme pour ajouter 2 à chaque élément
result <- lapply(nombres, function(x) { x + 2 })
print(result)  # Résultat : list(3, 4, 5, 6, 7)

# Utiliser des fonctions anonymes avec apply
# Créer une matrice
matrice <- matrix(1:9, nrow = 3)
```
)

Nous avons aussi des fonctions comme reduce et filter comme pour un langage de programmation fonctionnel utilisant des fonctions d'ordre supérieur. 

#Exemple(
```R
# Utiliser des fonctions anonymes avec Reduce
# Utiliser une fonction anonyme pour calculer la somme cumulative des éléments
result <- Reduce(function(x, y) { x + y }, nombres)
print(result)  # Résultat : 15

# Utiliser des fonctions anonymes avec Filter et Find
# Utiliser une fonction anonyme pour filtrer les éléments pairs
result <- Filter(function(x) { x %% 2 == 0 }, nombres)
print(result)  # Résultat : list(2, 4)
```
)

Pour le reste les fonctions peuvent directement marcher sur des vecteur à cause de la fonctionnalité de "vectorization" du langage.

Floréal Morandat & co (source: Évaluating the design of the R language) ont donné une évaluation plus formelle du langage R et de sa sémantique.

