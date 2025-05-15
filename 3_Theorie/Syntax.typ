#import "@preview/simplebnf:0.1.0": *
#import "../src/module.typ" : *

#pagebreak()

== Syntax du langage

Après avoir défini ses différents composants, nous allons maintenant faire une présentation complète du langage prototype système C3PO.


#Definition()[Syntaxe du langage Système C3PO

$Delta : X --> V$ *contexte d'évaluation*

$Gamma : X --> T$ *contexte de typage*

$Phi : a --> K$ *contexte de typage de variable de type*

#bnf(
  Prod(
    $E$,
    annot: $sans("Expression")$,
    {
      Or[$"let" x: T = "E1" "in" "E2"$][*let*]
      Or[$"if" "E1" "then" "E2" "else" "E3" $][*if*]
      Or[$"op"$][*bop*]
      Or[$("E1")< overline("a:K")>( overline( "E")) $][*func_app*]
      Or[$"first"("E") $][*first_arr*]
      Or[$"rest"("E") $][*rest_arr*]
      Or[$V $][*value*]
      Or[$x $][*variable*]
    },
  ),
  Prod(
    $V$,
    annot: "Value",
    {
      Or[$"n" in NN$][*number*]
      Or[$"true" $][*true*]
      Or[$"false" $][*false*]
      Or[$[ overline( "E")] $][*array*]
      Or[$"func"<overline("a:K")>(overline("x":"T")) -> "T" { "E" }$][*func*]
    },
  ),
  Prod(
    $T$,
    annot: "Type",
    {
      Or[$<overline("K")>( overline( "T")) -> "T"$][*function_type*]
      Or[$["I";"T"] $][*array_type*]
      Or[$"int" $][*int*]
      Or[$"bool" $][*bool*]
    }
  ),
  Prod(
    $I$,
    annot: "Index generic",
    {
      Or[$"n"$][*number*]
      Or[$"n1 + n2"$][*add_dim*]
    }
  ),
  Prod(
    $op$,
    annot: "bop",
    {
      Or[$"E1" "and" "E2" $][*and*]
      Or[$"E1" "or" "E2" $][*or*]
      Or[$"E1" + "E2" $][*plus*]
      Or[$"E1" :: "E2" $][*concat*]
      Or[$"E1" == "E2"$][*equal*]
      Or[$"E1" < "E2"$][*lower*]
      Or[$"E1" <= "E2"$][*lower or equal*]
      Or[$"E1" > "E2"$][*greater*]
      Or[$"E1" >= "E2"$][*greater or equal*]
    }
  ),
  Prod(
    $K$,
    annot: "Kind",
    {
      Or[$"Type"$][*Type*]
      Or[$"Dim"$][*Dimension*]
    }
  )
)
]
