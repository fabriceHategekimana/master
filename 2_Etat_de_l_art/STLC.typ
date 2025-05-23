#import "@preview/simplebnf:0.1.0": *
#import "../src/theorem.typ" : *
#import "@preview/curryst:0.5.1": rule, prooftree
#import "../src/rules.typ"

=== Le lambda calcul simplement typé

Malgré le fait qu'il soit Turing-complet. Le lambda calcul simple manque de pas mal de fonctionnalités qui vont nous aider à représenter les tableaux multidimensionnels. L'une d'entre elle et la notion de type. C'est pourquoi nous introduisons le lambda calcul simplement typé.

En effet, le lambda calcul simplement typé est le prochain pas vers la construction de notre premier langage. Il est une extension du lambda calcul non typé où chaque expression est associée à un type. Ce typage introduit une structure supplémentaire qui aide à prévenir certaines formes d'erreurs computationnelles et à garantir des propriétés de sûreté dans les programmes. 

#Definition[Syntaxe du lambda calcul simplement typé
$ #bnf(
  Prod(
    $t$,
    delim: "term",
    {
      Or[$x$][_variable_]
      Or[$lambda x: T.t$][_abstraction_]
      Or[$t space t$][_application_]
    },
  ),
  Prod(
    $v$,
    delim: "value",
    {
      Or[$lambda x: T.t$][_abstraction value_]
    },
  ),
  Prod(
    $T$,
    delim: "types",
    {
      Or[$T → T$][_type of functions_]
    },
  ),
  Prod(
    $Gamma$,
    delim: "context",
    {
    Or[$emptyset$][_empty context_]
    Or[$Gamma, "x:T"$][_term variable binding_]
  },
  ),
) $
]

#Definition[Évaluation du lambda calcul simplement typé
$ #prooftree(rules.evaluate("E-APP1", $t_1 t_2 --> t_1^' t_2$, $t_1 --> t_1^'$)) $ 
$ #prooftree(rules.evaluate("E-APP2", $v_1 t_2 --> v_1 t_2^'$, $t_2 --> t_2^'$)) $ 
$ #prooftree(rules.evaluate("E-APPABS", $(lambda x . t_12) v_2 --> [x\/v_2] t_12$)) $ 
]

#Definition[Typage du lambda calcul simplement typé
$ #prooftree(rules.typing_c("T-VAR", "x : T", $ Gamma(x) = T$)) $
$ #prooftree((rules.typing_c("T-ABS", $lambda x:T_1 . t_2 : T_1 -> T_2$))) $
$ #prooftree(rules.typing_c("T-APP", $t_1 t_2 : T_12 $, $Phi, Gamma tack.r T_11 -> T_12$, $Phi, Gamma tack.r t_2 : T_11$)) $
]

Le lambda calculs simplement typé ajoute des types de base au choix et la définition de type de fonction. Le lambda calcul simplement typé est moins expressif que le lambda calcul classique mais offre plus de sécurité dans ses manipulations. On sera en mesure de faire des calculs plus sûrs dans notre langage, mais ce n'est pas encore suffisant pour assurer assez de sécurité pour la manipulation de tableaux multidimensionnels. 


