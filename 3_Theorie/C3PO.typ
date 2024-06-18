#import "../src/module.typ" : *

= Système C3PO

Jusqu'à présent nous avons parlé de modèles de calcul déjà existant et abordé leur particularités fondamentales et leur apport a notre langage prototype. Nous allons maintenant commencer à explorer des route un peu plus avantureuse et rendre le designe de ce prototype plus personnalisé pour notre problème. En partant des fondements du système F, nous pouvons maintenant entreprendre d'incorporer des extensions afin d'accroître l'expressivité du langage, dans le dessein de faciliter la manipulation de structures de données complexes, notamment des tableaux multidimensionnels.

Le prototype final s'appel C3PO suite aux différente transformations que nous avons apporté au système F.

#pagebreak()

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

// Arithmétique de Presburger
// https://fr.wikipedia.org/wiki/Arithm%C3%A9tique_de_Presburger

Nous allons aborder les modifications présentées dans le tableau à partir du système R.

== Système R

Le système R est juste une première tentative pour amener des éléments plus communs en programmation et avec lesquels nous allons développer notre prototype. Le but n'est pas d'immiter entièrement le langage de programmation R mais de prendre le minimum pour faire nos calculs. C'est pourquoi nous choisissons les deux types `int` et `bool` qui ont chacun leur rôle. Il est possible d'émuler ces valeurs à l'aide des éléments du système F mais c'est beaucoup plus pratique de travailler avec des valeurs plus communes. 

Les nombre entiers positifs `int` vont nous permettre d'avoir une base minimal pour faire des calcules. C'es pourquoi nous ajoutons les opérateurs d'addition et de multiplication pour ne pas tomber sur des nombres à virgules ou des nombres négatifs. 

$ #proof-tree(eval("NUM", $"n" => "n"$)) $
$ #proof-tree(eval("PLUS", $"E1" + "E2" => "E3"$, $"E1" + "E2" => "E3"$)) $
$ #proof-tree(eval("PLUS", $"E1" * "E2" => "E3"$, $"E1" * "E2" => "E3"$)) $

Les booléens vont nous permettre d'ajouter de la logique à notre code et à simplifier le traitement conditionnel impliqué par le contrôle de flux `if...then..else` qui est un opérateurs ternaire. Ce choix nous permet d'avoir une structure régulière capable d'émuler des `else if` par imbrication de contrôle de flux `ìf...then...else`.
 
$ #proof-tree(eval("IF-T", $"if" "E1" "then" "E2" "else" "E3" => "E2"$, $"E1" => "true"$)) $
$ #proof-tree(eval("IF-F", $"if" "E1" "then" "E2" "else" "E3" => "E3"$, $"E1" => "true"$)) $

Les booléens se comportent aussi de la même façon que dans les langages de programmations classiques comme python. Ils s'appuient aussi sur l'arithmétique classique.

$ #proof-tree(eval("BOOL-T", $"true" => "true"$)) $
$ #proof-tree(eval("BOOL-F", $"false" => "false"$)) $
$ #proof-tree(eval("AND", $"E1" "and" "E2" => "E3"$, $"E1" sect "E2" => "E3"$)) $
$ #proof-tree(eval("OR", $"E1" "or" "E2" => "E3"$, $"E1" union "E2" => "E3"$)) $

On a maintenant un noyaux qui nous donne la capacité de faire des opérations sur des ensembles de valeurs définit. Ce qui va nous permettre de traiter avec des opérations plus complexes.

== Système R2

Bien que le système R nous donne plus de souplesse et de flexibilité dans nos calculs, nous pouvons toujours finir avec des représentations énormes car nous n'avons pas la possibilité de stocker temporairement des valeurs dans des variables. C'est pourquoi nous introduisons l'expression `let ... in ...`. Ce méchanisme var forcer le developpement d'un context d'évaluation.

$ #proof-tree(eval("C-EV-VAR", $"let" x: X = E_1 in E_2 --> E_2p$, $Delta tack.r E_1 --> E_1p$, $Delta, x = E_1p tack.r E_2 --> E_2p$ )) $

== Système R2D

Le système R2D va nous permettre d'introduire les types dépendants.

Les types dépendants sont des types qui dépendent de valeurs, ce qui permet d'exprimer des invariants et des contraintes plus précises directement dans le système de types. Par exemple, un vecteur de longueur n pourrait avoir un type qui dépend de n, garantissant que seules les opérations valides pour cette longueur sont permises. Cependant, les types dépendant peuvent involontairement devenir un obstacle pour les critères de notre langage. L'introduction de types dépendant rendent l'inférence de type indécidable. C'est pourquoi il est nécessaire de restreindre ses capacités. Ceci peut être fait avec l'arithmétique de Presburger.

L'arithmétique de Presburger est une théorie de l'arithmétique des entiers naturels avec l'addition, introduite par Mojżesz Presburger en 1929. Elle se distingue par son décidabilité : il existe un algorithme qui peut déterminer si une proposition donnée dans cette théorie est vraie ou fausse. Cette propriété en fait un outil précieux en informatique, en particulier dans le domaine des types dépendants.

Grâce à l'arithmétique de Presburger, on peut formaliser et vérifier des propriétés comme la somme des longueurs de deux tableaux, ou la relation entre les indices dans une matrice, directement dans le système de types. Cela augmente la capacité du compilateur à détecter les erreurs à la compilation, avant même que le programme ne soit exécuté. En outre, cela aide à garantir la correction des programmes en prouvant mathématiquement des propriétés essentielles du code.

Afin de pouvoir accueillir des génériques ainsi que des types dépendants. Nous avons la nécessité de définir un context convenable.

Les règle *C-EMP* et *C-EXT* sont des règles définissant la création et l'extension du context. Un context peut s'étendre en recevant un couple variable-type ajouté par le symbole ",".

$ #proof-tree(typing("C-EMP",  $nothing "ctxt"$)) $
$ #proof-tree(typing("C-EXT",  $"x": sigma "ctxt"$, $Gamma sigma "type"$)) $

Le context doit admètre un opérateur d'égalité pour vérifier que deux contextes sont égaux. Les règles *C-EQ-R*, *C-EQ-S* et *C-EQ-T* définissent respectivement les propritétés de réflexivité, de substitutivité et de transitivité de l'opérateur. *C-EXT-EQ* est la règle qui assure l'équivalence entre deux context. Celle-ci ne fonctionne que lorsque les context initiaux et les types sont équivalents, amenant donc un appel récursif.

$ #proof-tree(typing("C-EQ-R", $Gamma = Gamma "ctxt"$, $Gamma "ctxt"$)) $
$ #proof-tree(typing("C-EQ-S", $Delta = Gamma "ctxt"$, $Gamma = Delta "ctxt"$)) $
$ #proof-tree(typing("C-EQ-T", $Gamma = Theta "ctxt"$, $Gamma = Delta "ctxt"$, $Delta = Theta "ctxt"$)) $
$ #proof-tree(typing("C-EXT-EQ", $Gamma, "x": sigma = Delta, "y": tau "ctxt"$, $Gamma = Delta "ctxt"$, $Gamma sigma = tau "type"$)) $


Les règles sur l'équivalence de context nous pousse aussi à définir l'opérateur d'égalité sur les types. les règle *TY-EQ-R*, *TY-EQ-S* et *TY-EQ-T* qui représentent aussi les propriétés de l'opérateur d'égalité entre les types (respectivement les propriétés de reflexivité, de substitutivité et de transitivité).

$ #proof-tree(typing("TY-EQ-R", $Gamma sigma = sigma "type"$, $Gamma sigma "type"$)) $
$ #proof-tree(typing("TY-EQ-S", $Gamma tau = sigma "type"$, $Gamma sigma = tau "type"$)) $
$ #proof-tree(typing("TY-EQ-T", $Gamma sigma = rho "type"$, $Gamma sigma = tau "type"$, $Gamma tau = rho "type"$ )) $

Avec le context définit, nous avons la capacité de créer des variable adoptant un certain type. La règle *VAR* permet de vérifier l'assignation d'une variable si elle est présente dans le context. Le term *let* illustré par la règle *T-LET* permet la création des dites variables. Si les types de l'assignation correspondent, l'expression final renvera un certain type.
	
$ #proof-tree(typing("VAR", $Gamma , "x": sigma , Delta "x": sigma$, $Gamma,  "x": sigma$, $Delta "ctxt"$)) $

$ #proof-tree(typing("T-LET", $Gamma "let" "x": "T1" = "E1" "into" "E2" : "T2"$, $Gamma "E1" : "T1"$, $Gamma, "x" : "T1" "E2" : "T2"$)) $

== Système R2D2

Jusqu'à présent les fonctions étaient représentées par des lambda et se décomposait en deux types: Les abstraction lambda, et les abastractions de type. La plus part du temps, nous somme obligé de faire la composition des deux pour créer des fonctions génériques. C'est pourquoi l'usage d'une représentation qui combine ces deux notions sera plus facile à traité. Nous introduison le concept de fonctions génériques. Cette fonctions permet de combiner plusieurs génériques et plusieurs paramètre en un coup et donc énormément simplifier la création de fonction en bloque.

Bien sûr, on peut toujours définir des fonctions sans générique, il suffit juste de laisser le champs des génériques vide. De même, si on ne veut pas de paramètre, on peut laisser le champ des paramètres vides. On peut créer des fonctions de cette forme:

```
func<>(){7}
```

Mais ces fonctions n'auraient pas plus d'intérêt que des valeurs.

Comme mentionné précédement, les fonctions sont l'un des outils les plus puissants et sophistiqué de ce langage, le but étant de pouvoir sécuriser les opérations sur des tableaux multidimensionels. Ici, les fonctions peuvent admettre des génériques en plus des types sur chaque paramètre.

$ #proof-tree(typing("T-FUNC", $"func"< overline( "a")>( overline( "x":"T")) -> "T" { "E" } : (( overline( "T")) -> "T")$, $overline( "x":"T"), "E" : "T"$)) $

Ces génériques peuvent être réserver pour contenir des types ou des valeurs et ainsi créer des fonctions spécifiques. On peut le voir quand à l'application de fonction.

$ #proof-tree(typing("T-FUNC-APP", $("E1")< overline( "a")>( overline( "E")) : "T"$, $"E1" : ( overline( "T") -> "T")$, $overline( "a") = overline( "T")$, $overline( "E") : overline( "T")$)) $

== Système C3PO

Toutes ces fonctionnalités ont été introduite afin de favoriser la création et l'emploit de tableaux multidimensionnels. C'est pourquoi le dernier élément manquant n'est autre que la notion de tableau. Ici un tableau n'est autre qu'une liste d'éléments du même types avec une longueur déterminée. 

Comme nous le verrons plus loin, l'élaboration de tableau multidimentionnels se fera par la combinaison de plusieurs tableaux.
