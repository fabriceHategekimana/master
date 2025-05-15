#pagebreak()

#import "@preview/simplebnf:0.1.0": *
#import "../src/module.typ" : *

=== Le système F

Si le lambda calcul simplement typé apporte la notion de type au lambda calcul. Le système F apporte la notion de générique sur ces types. Comme discuté dans le le lambda calcul simplement typé, la notion de type restreint fortement les opérations faisable sur les types. On le sait, on aura aussi parfois besoin d'avoir des fonctions plus générales pour la manipulation de types. 

Le système F, également connu sous le nom de polymorphisme de deuxième ordre, est une extension du lambda-calcul typé qui permet l'utilisation de types génériques. Il introduit la quantification universelle sur les types, ce qui permet de définir des fonctions et des structures de données polymorphes. Par exemple, une fonction dans le système F peut être définie pour opérer sur des tableaux de n'importe quel type sans avoir à redéfinir la fonction pour chaque type de tableau. 

#Definition[Syntaxe du système F
$ #bnf(
  Prod(
    $t$,
    annot: $sans("terms:")$,
    {
      Or[$x$][_variable_]
      Or[$λ x:T.t$][_abstraction_]
      Or[$t$ $t$][_application_]
      Or[$λ X. t$][_type abstraction_]
      Or[$t$ $[T]$][_type application_]
    },
  ),
  Prod(
    $v$,
    annot: $sans("values:")$,
    {
      Or[$λ x:T.t$][_abstraction value_]
      Or[$λ X. t$][_type abstraction value_]
    },
  ),
  Prod(
    $T$,
    annot: $sans("types:")$,
    {
      Or[$X$][_type variable_]
      Or[$T -> T$][_type of functions_]
      Or[$forall X.T$][_universal type_]
    },
  ),
  Prod(
    $Gamma$,
    annot: $sans("context:")$,
    {
      Or[$X$][_empty context_]
      Or[$Gamma, "x:T"$][_term variable binding_]
      Or[$Gamma, X$][_type variable binding_]
    },
  ),
) $
]


#Definition[Évaluation du système F
$ #proof-tree(eval("E-APP1", $t_1 t_2 --> t_1^' t_2$, $t_1 --> t_1^'$)) $ 
$ #proof-tree(eval("E-APP2", $v_1 t_2 --> v_1 t_2^'$, $t_2 --> t_2^'$)) $ 
$ #proof-tree(eval("E-APPABS", $(lambda x . t_12) v_2 --> [x\/v_2] t_12$)) $ 

$ #proof-tree(eval("E-TAPP", $t_1 [T_2] --> t_1^' [T_2]$, $t_1 --> t_1^'$)) $

$ #proof-tree(eval("E-TAPPTABS", $(lambda X . t_12) [T_2] --> [X \/ T_2] t_12$)) $
]

#Definition[Typage du système F
$ #proof-tree(typing_c("T-VAR", "x : T", $ Gamma("x") = T$)) $
$ #proof-tree((typing_c("T-ABS", $lambda x:T_1 . t_2 : T_1 -> T_2$))) $
$ #proof-tree(typing_c("T-APP", $t_1 t_2 : T_12 $, $Gamma tack.r T_11 -> T_12$, $Gamma tack.r t_2 : T_11$)) $
$ #proof-tree(typing_c("T-TABS", $lambda X . t_2 : forall X . T_2$, $Gamma, X tack.r t_2 : T_2$)) $
$ #proof-tree(typing_c("T-TAPP", $t_1 [T_2] : [X\/T_2] T_12$)) $
]

L'ajout de génériques dans le typage est un avantage considérable car il accroît la réutilisabilité et la flexibilité du code tout en maintenant une forte sécurité des types. Cela permet aux développeurs de créer des bibliothèques et des outils plus abstraits et polyvalents, réduisant ainsi le besoin de redondance et minimisant les erreurs. En conséquence, le système F et les types génériques favorisent une programmation plus expressive et plus sûre, où les invariants de type sont vérifiés à la compilation, garantissant une robustesse accrue des applications.

L'ajout de générique est aussi un élément crucial pour la définition de généricité pour des tableaux de taille différente. Nous verrons dans la suite comment ajouter cette notion. 
