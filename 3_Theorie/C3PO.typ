#import "../src/module.typ" : *

#pagebreak()

= Système C3PO

Jusqu'à présent nous avons parlé de modèles de calcul déjà existant et abordé leur particularités fondamentales et leur apport à notre langage prototype. Nous allons maintenant commencer à explorer des routes un peu plus aventureuses et rendre le design de ce prototype plus personnalisé pour notre problème. En partant des fondements du système F, nous pouvons maintenant entreprendre d'incorporer des extensions afin d'accroître l'expressivité du langage, dans le dessein de faciliter la manipulation de structures de données complexes, notamment des tableaux multidimensionnels. 

Le prototype final s'appelle C3PO suite aux différentes transformations que nous avons apportées au système F. 

#pagebreak()

#Exemple[Tableau récapitulatif de l'évolution du lambda calcul jusqu'au système C3PO

#table(
  columns: (auto, auto),
  inset: 10pt,
  align: horizon,
  table.header(
    [*Langage*], [*Fonctionnalité ajouté*],
  ),
  "lambda caclul", "computation",
  "lambda calcul simplement typé", "typage",
  "système F", "génériques",
  "système R", "int, bool, opérateurs de base, if...then...else",
  "système R2", "context",
  "système R2D", "types dépendants sur les entiers positifs",
  "système R2D2", "fonctions générales",
  "système C3PO", "tableaux",
) 
]

// Arithmétique de Presburger
// https://fr.wikipedia.org/wiki/Arithm%C3%A9tique_de_Presburger

Nous allons aborder les modifications présentées dans le tableau à partir du système R.

== Système R

Le système R est juste une première tentative pour amener des éléments plus communs en programmation et avec lesquels nous allons développer notre prototype. Le but n'est pas d'imiter entièrement le langage de programmation R mais de prendre le minimum pour faire nos calculs. C'est pourquoi nous choisissons les deux types `int` et `bool` qui ont chacun leur rôle. Il est possible d'émuler ces valeurs à l'aide des éléments du système F mais c'est beaucoup plus pratique de travailler avec des valeurs plus communes. 

Les nombre entiers positifs `int` vont nous permettre d'avoir une base minimum pour faire des calculs. C'est pourquoi nous ajoutons les opérateurs d'addition et de multiplication pour ne pas tomber sur des nombres à virgules ou des nombres négatifs. 

#Definition()[Le type de base "int"
$ #proof-tree(eval("NUM", 
    $Delta tack.r "n" --> "n"$)) $
$ #proof-tree(eval("PLUS", 
    $Delta tack.r "E1" + "E2" --> "E3"$, 
    $Delta tack.r "E1" --> "E1p"$, 
    $Delta tack.r "E2" --> "E2p"$, 
    $Delta tack.r "E1p" + "E2p" --> "E3"$)) $
$ #proof-tree(eval("TIME", 
    $Delta tack.r "E1" * "E2" --> "E3"$, 
    $Delta tack.r "E1" --> "E1p"$, 
    $Delta tack.r "E2" --> "E2p"$, 
    $Delta tack.r "E1p" * "E2p" --> "E3"$)) $
]


Les booléens se comportent aussi de la même façon que dans les langages de programmations classiques comme python. Ils s'appuient aussi sur l'arithmétique classique.

#Definition([Le type de base "bool"
$ #proof-tree(eval("BOOL-T", 
    $Delta tack.r "true" --> "true"$)) $
$ #proof-tree(eval("BOOL-F", 
    $Delta tack.r "false" --> "false"$)) $
$ #proof-tree(eval("AND", 
    $Delta tack.r "E1" "and" "E2" --> "E3"$,
    $Delta tack.r "E1" --> "E1p"$, 
    $Delta tack.r "E2" --> "E2p"$, 
    $Delta tack.r "E1" sect "E2" --> "E3"$)) $
$ #proof-tree(eval("OR", 
    $Delta tack.r "E1" "or" "E2" --> "E3"$, 
    $Delta tack.r "E1" --> "E1p"$, 
    $Delta tack.r "E2" --> "E2p"$, 
    $Delta tack.r "E1" union "E2" --> "E3"$)) $
])

Les booléens vont nous permettre d'ajouter de la logique à notre code et à simplifier le traitement conditionnel impliqué par le contrôle de flux `if...then..else` qui est un opérateur ternaire. Ce choix nous permet d'avoir une structure régulière capable d'émuler des `else if` par imbrication de contrôle de flux `ìf...then...else`. 
 
#Definition([Les conditions
$ #proof-tree(eval("IF-T", 
    $Delta tack.r "if" "E1" "then" "E2" "else" "E3" --> "E2"$, 
    $Delta tack.r "E1" --> "true"$)) $
$ #proof-tree(eval("IF-F", 
    $Delta tack.r "if" "E1" "then" "E2" "else" "E3" --> "E3"$, 
    $Delta tack.r "E1" --> "false"$)) $
])

Il nous faut aussi des opérateurs de base pour faire des testes logique. Ces opérateurs marcherons principalement pour les entiers car c'est le cas qui nous intresse le plus. L'opérateur d'égalité marchera pour tout les types (primitifs ou structure) du moment que les deux membre de l'opération sont du même type. Il est à noté qu'on pourra utiliser les opérateurs "and" ou "or" pour créer des combinaisons de propriété plus complexes.

#Definition([Les opérateurs de bases pour les conditions
$ #proof-tree(eval("EQ", 
    $Delta tack.r "E1" == "E2" --> "E3"$, 
    $Delta tack.r "E1" --> "E1p"$, 
    $Delta tack.r "E2" --> "E2p"$, 
    $Delta tack.r "E1p" == "E2p" --> "E3"$)) $
$ #proof-tree(eval("LOW", 
    $Delta tack.r "E1" < "E2" --> "E3"$, 
    $Delta tack.r "E1" --> "E1p"$, 
    $Delta tack.r "E2" --> "E2p"$, 
    $Delta tack.r "E1p" < "E2p" --> "E3"$)) $
$ #proof-tree(eval("GRT", 
    $Delta tack.r "E1" > "E2" --> "E3"$, 
    $Delta tack.r "E1" --> "E1p"$, 
    $Delta tack.r "E2" --> "E2p"$, 
    $Delta tack.r "E1p" > "E2p" --> "E3"$)) $
$ #proof-tree(eval("LOW-EQ", 
    $Delta tack.r "E1" <= "E2" --> "E3"$, 
    $Delta tack.r "E1" --> "E1p"$, 
    $Delta tack.r "E2" --> "E2p"$, 
    $Delta tack.r "E1p" <= "E2p" --> "E3"$)) $
$ #proof-tree(eval("GRT-EQ", 
    $Delta tack.r "E1" >= "E2" --> "E3"$, 
    $Delta tack.r "E1" --> "E1p"$, 
    $Delta tack.r "E2" --> "E2p"$, 
    $Delta tack.r "E1p" >= "E2p" --> "E3"$)) $
])

On a maintenant un noyau qui nous donne la capacité de faire des opérations sur des ensembles de valeurs définis. Ce qui va nous permettre de traiter avec des opérations plus complexes. 

== Système R2

Bien que le système R nous donne plus de souplesse et de flexibilité dans nos calculs, nous pouvons toujours finir avec des représentations énormes car nous n'avons pas la possibilité de stocker temporairement des valeurs dans des variables. C'est pourquoi nous introduisons l'expression `let ... in ...`. Ce mécanisme va forcer le développement d'un contexte d'évaluation. 

Il nous faut aussi une règle qui permet de vérifier que l'appel d'une variable est bel et bien valide, à savoir, que nous pouvons faire référence à une variable uniquement si elle a été préalablement définit à l'aide du mot clé "let". Nous pouvont faire ceci en créant la règle "VAR".

#Definition([Définition des variable et du contexte
$ #proof-tree(eval("LET",
    $Delta tack.r "let" x: T = "E1" "in" "E2" --> "E2p"$, 
    $Delta tack.r "E1" --> "E1p"$,
    $Delta, "x" = "E1p" tack.r "E2" --> "E2p"$
  )) $
$ #proof-tree(eval("VAR",
    $Delta tack.r "x" --> "E"$, 
    $Delta tack.r "x" = E$,
  )) $
])

#pagebreak()

== Système R2D

Le système R2D va nous permettre d'introduire les types dépendants.

Les types dépendants sont des types qui dépendent de valeurs, ce qui permet d'exprimer des invariants et des contraintes plus précises directement dans le système de types. Par exemple, un vecteur de longueur n pourrait avoir un type qui dépend de n, garantissant que seules les opérations valides pour cette longueur sont permises. Cependant, les types dépendants peuvent involontairement devenir un obstacle pour les critères de notre langage. L'introduction de types dépendants rendent l'inférence de type indécidable. C'est pourquoi il est nécessaire de restreindre ses capacités. Ceci peut être fait avec l'arithmétique de Presburger. 

L'arithmétique de Presburger est une théorie de l'arithmétique des entiers naturels avec l'addition, introduite par Mojżesz Presburger en 1929. Elle se distingue par sa décidabilité : il existe un algorithme qui peut déterminer si une proposition donnée dans cette théorie est vraie ou fausse. Cette propriété en fait un outil précieux en informatique, en particulier dans le domaine des types dépendants. 

Grâce à l'arithmétique de Presburger, on peut formaliser et vérifier des propriétés comme la somme des longueurs de deux tableaux, ou la relation entre les indices dans une matrice, directement dans le système de types. Cela augmente la capacité du compilateur à détecter les erreurs à la compilation, avant même que le programme ne soit exécuté. En outre, cela aide à garantir la correction des programmes en prouvant mathématiquement des propriétés essentielles du code.

Afin de pouvoir accueillir des génériques ainsi que des types dépendants. Nous avons la nécessité de définir un système limité et simplifié.

Avec le contexte défini, nous avons la capacité de créer des variables adoptant un certain type. La règle *VAR* permet de vérifier l'assignation d'une variable si elle est présente dans le contexte. Le term *let* illustré par la règle *T-LET* permet la création desdites variables. Si les types de l'assignation correspondent, l'expression finale retourne un certain type. 

#Definition([Context pour les types et les génériques
$ #proof-tree(typing("T-LET",
  $Gamma tack.r "let" "x": "T1" = "E1" "in" "E2" : "T2"$,
  $Gamma tack.r "E1" : "T1"$, 
  $Gamma tack.r "x" : "T1" "E2" : "T2"$
)) $

$ #proof-tree(typing("VAR",
  $Gamma tack.r "x": sigma$,
  $Gamma tack.r "x": sigma$
)) $
])

== Système R2D2

Jusqu'à présent les fonctions étaient représentées par des lambda et se décomposaient en deux types: Les abstractions lambda, et les abstractions de type. La plupart du temps, nous sommes obligés de faire la composition des deux pour créer des fonctions génériques. C'est pourquoi l'usage d'une représentation qui combine ces deux notions sera plus facile à traiter. Nous introduisons le concept de fonctions génériques. Cette fonction permet de combiner plusieurs génériques et plusieurs paramètres en un coup et donc énormément simplifier la création de fonction en bloc. 

Bien sûr, on peut toujours définir des fonctions sans générique, il suffit juste de laisser le champ des génériques vide. De même, si on ne veut pas de paramètre, on peut laisser le champ des paramètres vides. On peut créer des fonctions de cette forme: 

#Exemple()[Création d'une simple fonction
```R
func<>(){7}
```
]

Comme mentionné précédemment, les fonctions sont l'un des outils les plus puissants et sophistiqués de ce langage, le but étant de pouvoir sécuriser les opérations sur des tableaux multidimensionnels. Ici, les fonctions peuvent admettre des génériques en plus des types sur chaque paramètre. 

#Definition()[Typage de fonction
$ #proof-tree(typing("T-FUNC",
  $Gamma tack.r "func"< overline( "a")>( overline( "x":"T")) -> "T" { "E" } : (( overline( "T")) -> "T")$,
  $Gamma , overline( "x":"T") tack.r "E" : "T"$
)) $
]

Ces génériques peuvent être réservés pour contenir des types ou des valeurs et ainsi créer des fonctions spécifiques. On peut le voir quand à l'application de fonction. 

#Definition()[Typage d'une application de fonction
$ #proof-tree(typing("T-FUNC-APP", 
  $("E1")< overline("g")>( overline( "E")) : "T"$,
  $Gamma tack.r "E1" : <overline(a)>(overline( "T")) -> "T"$,
  $[overline("a") \/ overline("g")]overline("T") => overline("Tp")$,
  $Gamma tack.r overline("E") : overline("Tp")$)) $
]

== Système C3PO

Toutes ces fonctionnalités ont été introduites afin de favoriser la création et l'emploi de tableaux multidimensionnels. C'est pourquoi le dernier élément manquant n'est autre que la notion de tableau. Ici un tableau n'est autre qu'une liste d'éléments du même type avec une longueur déterminée. 

Comme nous le verrons plus loin, l'élaboration de tableaux multidimensionnels se fera par la combinaison de plusieurs tableaux. 
