#import "../src/module.typ" : *

#pagebreak()

== Sémantique de typage

Le typage est la partie la plus importante de ce travail, c'est à partir de là qu'on va créer la logique qui nous permettra de rendre sûr les action faites avec les tenseurs et tableaux multidimensionnels. 

Afin de pouvoir accueillir des génériques ainsi que des types dépendants. Nous avons la nécessité de définir un contexte convenable. 

Les règle *C-EMP* et *C-EXT* sont des règles définissant la création et l'extension du context. Un contexte peut s'étendre en recevant un couple variable-type ajouté par le symbole ",". 

$ #proof-tree(typing("C-EMP",  $nothing "ctxt"$)) $
$ #proof-tree(typing("C-EXT",  $"x": sigma "ctxt"$, $Gamma sigma "type"$)) $

Le context doit admettre un opérateur d'égalité pour vérifier que deux contextes sont égaux. Les règles *C-EQ-R*, *C-EQ-S* et *C-EQ-T* définissent respectivement les propriétés de réflexivité, de substitutivité et de transitivité de l'opérateur. *C-EXT-EQ* est la règle qui assure l'équivalence entre deux contextes. Celle-ci ne fonctionne que lorsque les contextes initiaux et les types sont équivalents, amenant donc un appel récursif. 

$ #proof-tree(typing("C-EQ-R", $Gamma = Gamma "ctxt"$, $Gamma "ctxt"$)) $
$ #proof-tree(typing("C-EQ-S", $Delta = Gamma "ctxt"$, $Gamma = Delta "ctxt"$)) $
$ #proof-tree(typing("C-EQ-T", $Gamma = Theta "ctxt"$, $Gamma = Delta "ctxt"$, $Delta = Theta "ctxt"$)) $
$ #proof-tree(typing("C-EXT-EQ", $Gamma, "x": sigma = Delta, "y": tau "ctxt"$, $Gamma = Delta "ctxt"$, $Gamma sigma = tau "type"$)) $


Les règles sur l'équivalence de contextes nous poussent aussi à définir l'opérateur d'égalité sur les types. les règle *TY-EQ-R*, *TY-EQ-S* et *TY-EQ-T* qui représentent aussi les propriétés de l'opérateur d'égalité entre les types (respectivement les propriétés de réflexivité, de substitutivité et de transitivité). 

$ #proof-tree(typing("TY-EQ-R", $Gamma sigma = sigma "type"$, $Gamma sigma "type"$)) $
$ #proof-tree(typing("TY-EQ-S", $Gamma tau = sigma "type"$, $Gamma sigma = tau "type"$)) $
$ #proof-tree(typing("TY-EQ-T", $Gamma sigma = rho "type"$, $Gamma sigma = tau "type"$, $Gamma tau = rho "type"$ )) $

Avec le contexte défini, nous avons la capacité de créer des variables adoptant un certain type. La règle *VAR* permet de vérifier l'assignation d'une variable si elle est présente dans le contexte. Le term *let* illustré par la règle *T-LET* permet la création desdites variables. Si les types de l'assignation correspondent, l'expression finale retourne un certain type. 
	
$ #proof-tree(typing("VAR", $Gamma , "x": sigma , Delta "x": sigma$, $Gamma,  "x": sigma$, $Delta "ctxt"$)) $

$ #proof-tree(typing("T-LET", $Gamma "let" "x": "T1" = "E1" "into" "E2" : "T2"$, $Gamma "E1" : "T1"$, $Gamma, "x" : "T1" "E2" : "T2"$)) $

Le typage des types primitifs est trivial et peut être fait facilement en même temps pour les nombre et les booléens.

$ #proof-tree(t_num("n")) $
$ #proof-tree(t_true) $
$ #proof-tree(t_false) $

Les tableaux sont le moyen de construire de nouveaux types. Ces tables ont des propriétés intéressantes. Premièrement, ils s'appuient sur des types dépendants. Leur type [n, T] permet de décrire un type de tableau de longueur *n* et de type T. Donc [2, int] qui représente les tableaux d'entier de longueur 2 est un type différent de [3, int] un tableau d'entier de longueur 3. Cela va être pratique pour préciser la dimension des tableaux et sera un outil très puissant combiné avec les génériques. La deuxième propriété réside dans sa nature récursive. Étant donné qu'un tableau [n, T] est un type, on peut construire un tableau $[n_2, [n, T]]$ qui est lui aussi un type. On le verra plus tard, mais cela peut être considéré comme l'équivalent d'une matrice. 

Pour vérifier le typage d'un tableau donné, il faut vérifier deux choses: la taille de ce tableau ainsi que si tous ses membres sont du même type. C'est une autre propriété des tableaux tel que nous le définissons ici. On appel ce type de type des *invariants*. 

$ #proof-tree(typing("T-ARR", $Gamma [ overline( "E") ] : ["n", "T"]$, $"count"( overline( "E") ) == "n"$, $forall "e" in overline( "E")$, $"e" : "T"$ )) $

Le typage des opérateurs de base est facile à faire. Les opérations d'addition, multiplication ainsi que l'opérateur "and" et "or" s'appliquent uniquement sur des élément du même type et ce type doit être respectivement *int* pour "+" et "\*" ainsi que *bool* pour les opération *and* et *or*. 

$ #proof-tree(typing("T-PLUS", $"E1" + "E2" : "N"$, $"E1" : "N"$, $"E2" : "N"$)) $
$ #proof-tree(typing("T-MUL", $"E1" * "E2" : "N"$, $"E1" : "N"$, $"E2" : "N"$)) $
$ #proof-tree(typing("T-AND", $"E1" "and" "E2" : "bool"$, $"E1" : "bool"; "E2" : "bool"$)) $
$ #proof-tree(typing("T-OR", $"E1" "or" "E2" : "bool"$, $"E1" : "bool"; "E2" : "bool"$)) $

Ces opérations sont définies par raison de convenance, le reste des fonctions peut être construit avec les définitions préalablement établies. 

Nous définition la sémantique de type du "if...then...else" à l'aide de la règle *T-IF*. Cette opération est assez trivial car on doit juste s'assurer que les deux expressions retournent le même type. 

$ #proof-tree(typing("T-IF", $"if" "E1" "then" "E2" "else" "E3" : "T"$, $"E1" : "bool"$, $"E2" : "T"$, $"E3" : "T"$ )) $

Comme mentionné précédemment, les fonctions sont l'un des outils les plus puissants et sophistiqués de ce langage, le but étant de pouvoir sécuriser les opérations sur des tableaux multidimensionnels. Ici, les fonctions peuvent admettre des génériques en plus des types sur chaque paramètre. 

$ #proof-tree(typing("T-FUNC", $"func"< overline( "a")>( overline( "x":"T")) -> "T" { "E" } : (( overline( "T")) -> "T")$, $overline( "x":"T"), "E" : "T"$)) $

Ces génériques peuvent être réservés pour contenir des types ou des valeurs et ainsi créer des fonctions spécifiques. On peut le voir quand à l'application de fonction. 

$ #proof-tree(typing("T-FUNC-APP", $("E1")< overline( "a")>( overline( "E")) : "T"$, $"E1" : ( overline( "T") -> "T")$, $overline( "a") = overline( "T")$, $overline( "E") : overline( "T")$)) $
