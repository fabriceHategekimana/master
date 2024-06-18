#import "@preview/simplebnf:0.1.0": *

#pagebreak()

== Syntax du langage

Après avoir défini ses différents composants, nous allons maintenant faire une présentation complète du langage prototype système C3PO.


#bnf(
  Prod(
    $E$,
    annot: $sans("Expression")$,
    {
      Or[$"let" x = "E1" "into" "E2"$][*let*]
      Or[$"func"<overline("a")>(overline("x":"T")) -> "T" { "E" }$][*func*]
      Or[$"if" "E1" "then" "E2" "else" "E3" $][*if*]
      Or[$"E1" "op" "E2" $][*bop*]
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
      Or[$"n" in "N" $][*number*]
      Or[$"true" $][*true*]
      Or[$"false" $][*false*]
      Or[$[ overline( "E")] $][*array*]
    },
  ),
  Prod(
    $T$,
    annot: "Type",
    {
      Or[$(( overline( "T")) -> "T") $][*function_type*]
      Or[$["n";"T"] $][*array_type*]
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
      Or[$"E1" == "E2" $][*equal*]
    }
  ),
  Prod(
    $"ctx"$,
    annot: "context",
    {
      Or[$tack.r Gamma "ctxt" $][*valid_context*]
      Or[$Gamma tack.r sigma "type" $][*type_in_context*]
      Or[$Gamma tack.r "M" : sigma $][*term_of_type_in_context*]
      Or[$tack.r Gamma = Delta "ctxt" $][*equal_contexts*]
      Or[$Gamma tack.r sigma = tau "type" $][*equal_types_in_context*]
      Or[$Gamma tack.r "M" = "N" : sigma $][*equal_terms_of_type_in_context*]
    }
  )
)
