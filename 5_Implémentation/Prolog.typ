#import "@preview/simplebnf:0.1.0": *

#pagebreak()

= Implémentation

Dans le cadre de ce projet j'ai construit le prototype d'un interpréteur en Prolog pour appliquer et vérifier la faisabilité du langage construit jusqu'à présent. Le premier but est de traduire la syntaxe de base de notre langage prototype en son équivalent prolog et implémenter les règles d'évaluation et de typage.

Voici la version "Prolog" du langage:

#bnf(
  Prod(
    $E$,
    annot: $sans("Expression")$,
    {
      Or[$"let"(x,"E1","E2")$][*let*]
      Or[$"func"(overline("a"), overline(["x","T"]), "T", "E")$][*func*]
      Or[$"if"("E1", "E2", "E3")$][*if*]
      Or[$"E1" "op" "E2" $][*bop*]
      Or[$"app"("E1", overline( "a"), overline( "E"))$][*func_app*]
      Or[$"first"("E") $][*first_arr*]
      Or[$"rest"("E") $][*rest_arr*]
      Or[$V$][*V value*]
    },
  ),
  Prod(
    $V$,
    annot: "Value",
    {
      Or[$"n" in "N"$][*number*]
      Or[$"v_true"$][*true*]
      Or[$"v_false"$][*false*]
      Or[$"v_array"(overline("E"))$][*array*]
    },
  ),
  Prod(
    $T$,
    annot: "Type",
    {
      Or[$"t_func"(overline( "T"), "T")$][*function_type*]
      Or[$"t_array"("n", "T")$][*array_type*]
      Or[$"t_int"$][*int*]
      Or[$"t_bool"$][*bool*]
    }
  ),
  Prod(
    $op$,
    annot: "bop",
    {
      Or[$"E1" "and" "E2"$][*and*]
      Or[$"E1" "or" "E2"$][*or*]
      Or[$"E1" + "E2"$][*plus*]
      Or[$"append"("E1", "E2")$][*concat*]
      Or[$"E1" == "E2"$][*equal*]
      Or[$"E1" < "E2"$][*lower*]
      Or[$"E1" <= "E2"$][*lower or equal*]
      Or[$"E1" > "E2"$][*greater*]
      Or[$"E1" >= "E2"$][*greater or equal*]
    }
  ),
  Prod(
    $"ctx"$,
    annot: "context",
    {
      Or[$tack.r Gamma "ctxt" $][*valid_context*]
      Or[$"is_ctxt"("context") $][*valid_context*]
      Or[$"is_type"("type")$][*type_in_context*]
      Or[$"add"("context", "M" : sigma)$][*term_of_type_in_context*]
      Or[$"equal_ctx"(Gamma, Delta)$][*equal_contexts*]
      Or[$"equal_type_in_context"(sigma, tau)$][*equal_types_in_context*]
      Or[$"equal_terms(M, N, sigma)"$][*equal_terms_of_type_in_context*]
    }
  )
)
