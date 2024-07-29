#import "@preview/simplebnf:0.1.0": *
#import "../src/module.typ" : *

#pagebreak()

== Syntax du langage

Après avoir défini ses différents composants, nous allons maintenant faire une présentation complète du langage prototype système C3PO.


#Definition()[Syntax du langage Système C3PO

$Phi : a --> K$ *contexte de typage de variable de type*

$Gamma : X --> T$ *contexte de typage*

$Delta : X --> V$ *contexte d'évaluation*

#bnf(
  Prod(
    $E$,
    annot: $sans("Expression")$,
    {
      Or[$"let" x = "E1" "in" "E2"$][*let*]
      Or[$"func"<overline("a")>(overline("x":"T")) -> "T" { "E" }$][*func*]
      Or[$"if" "E1" "then" "E2" "else" "E3" $][*if*]
      Or[$"op"$][*bop*]
      Or[$("E1")< overline( "a")>( overline( "E")) $][*func_app*]
      Or[$"first"("E") $][*first_arr*]
      Or[$"rest"("E") $][*rest_arr*]
      Or[$V $][*V value*]
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
    },
  ),
  Prod(
    $T$,
    annot: "Type",
    {
      Or[$<overline("a")>( overline( "T")) -> "T"$][*function_type*]
      Or[$["I";"T"] $][*array_type*]
      Or[$"int" $][*int*]
      Or[$"bool" $][*bool*]
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
      Or[$T$][*Type*]
      Or[$D$][*Dimension*]
    }
  )
)
]
