#import "@preview/curryst:0.3.0": rule, proof-tree
#import "@preview/ctheorems:1.1.2": *
#set par(first-line-indent: 2em)
#import "@preview/indenta:0.0.3": fix-indent
#show: fix-indent()


#show: thmrules

#let Definition = thmbox(
  "definition",
  "Definition",
  base_level: 1, 
  stroke: rgb("#e94845") + 1pt
)

#let Exemple = thmbox(
  "exemple",
  "Exemple",
  base_level: 1, 
  stroke: rgb("#e94845") + 1pt
)

#let Theorem = thmbox(
  "theorem",
  "Theorem",
  base_level: 1, 
  stroke: rgb("#e94845") + 1pt
)

#let type_context(body, ..entrees) = {
  let entries = entrees.pos().join(", ")
  $ Phi, Gamma entries tack.r body $
}

#let eval(name, conclusion, ..premices) = {
    rule(
        name: name,
        conclusion,
        ..premices
    )
}

#let typing(name, conclusion, ..premices) = {
      rule(
          name: name,
          conclusion,
          ..premices
        )
}

#let typing_c(name, conclusion, ..premices) = {
      rule(
          name: name,
          type_context(conclusion),
          ..premices
      )
}

#let t_context(generic: "", type: "") = $Phi #generic \; Gamma #type tack.r$

#let t_true =  rule(
    name: "T-TRUE",
    type_context("true : bool")
)

#let t_false =  rule(
    name: "T-FALSE",
    type_context("false : bool")
)

// évaluation

#let NUM = $ #proof-tree(eval("NUM", 
    $Delta tack.r "n" --> "n"$)) $

#let PLUS = $ #proof-tree(eval("PLUS", 
    $Delta tack.r "E1" + "E2" --> "E3"$, 
    $Delta tack.r "E1" --> "E1p"$, 
    $Delta tack.r "E2" --> "E2p"$, 
    $Delta tack.r "E1p" + "E2p" --> "E3"$)) $

#let TIME = $ #proof-tree(eval("TIME", 
    $Delta tack.r "E1" * "E2" --> "E3"$, 
    $Delta tack.r "E1" --> "E1p"$, 
    $Delta tack.r "E2" --> "E2p"$, 
    $Delta tack.r "E1p" * "E2p" --> "E3"$)) $

#let BOOL_T = $ #proof-tree(eval("BOOL-T", 
    $Delta tack.r "true" --> "true"$)) $

#let BOOL_F = $ #proof-tree(eval("BOOL-F", 
    $Delta tack.r "false" --> "false"$)) $

#let AND = $ #proof-tree(eval("AND", 
    $Delta tack.r "E1" "and" "E2" --> "E3"$,
    $Delta tack.r "E1" --> "E1p"$, 
    $Delta tack.r "E2" --> "E2p"$, 
    $Delta tack.r "E1" sect "E2" --> "E3"$)) $

#let OR = $ #proof-tree(eval("OR", 
    $Delta tack.r "E1" "or" "E2" --> "E3"$, 
    $Delta tack.r "E1" --> "E1p"$, 
    $Delta tack.r "E2" --> "E2p"$, 
    $Delta tack.r "E1" union "E2" --> "E3"$)) $

#let EQ = $ #proof-tree(eval("EQ", 
    $Delta tack.r "E1" == "E2" --> "E3"$, 
    $Delta tack.r "E1" --> "E1p"$, 
    $Delta tack.r "E2" --> "E2p"$, 
    $Delta tack.r "E1p" == "E2p" --> "E3"$)) $

#let LOW = $ #proof-tree(eval("LOW", 
    $Delta tack.r "E1" < "E2" --> "E3"$, 
    $Delta tack.r "E1" --> "E1p"$, 
    $Delta tack.r "E2" --> "E2p"$, 
    $Delta tack.r "E1p" < "E2p" --> "E3"$)) $

#let GRT = $ #proof-tree(eval("GRT", 
    $Delta tack.r "E1" > "E2" --> "E3"$, 
    $Delta tack.r "E1" --> "E1p"$, 
    $Delta tack.r "E2" --> "E2p"$, 
    $Delta tack.r "E1p" > "E2p" --> "E3"$)) $

#let LOW_EQ = $ #proof-tree(eval("LOW-EQ", 
    $Delta tack.r "E1" <= "E2" --> "E3"$, 
    $Delta tack.r "E1" --> "E1p"$, 
    $Delta tack.r "E2" --> "E2p"$, 
    $Delta tack.r "E1p" <= "E2p" --> "E3"$)) $

#let GRT_EQ = $ #proof-tree(eval("GRT-EQ", 
    $Delta tack.r "E1" >= "E2" --> "E3"$, 
    $Delta tack.r "E1" --> "E1p"$, 
    $Delta tack.r "E2" --> "E2p"$, 
    $Delta tack.r "E1p" >= "E2p" --> "E3"$)) $

#let IF_T = $ #proof-tree(eval("IF-T", 
    $Delta tack.r "if" "E1" "then" "E2" "else" "E3" --> "E2"$, 
    $Delta tack.r "E1" --> "true"$)) $

#let IF_F = $ #proof-tree(eval("IF-F", 
    $Delta tack.r "if" "E1" "then" "E2" "else" "E3" --> "E3"$, 
    $Delta tack.r "E1" --> "false"$)) $


#let LET = $ #proof-tree(eval("LET",
    $Delta tack.r "let" x: T = "E1" "in" "E2" --> "E2p"$, 
    $Delta tack.r "E1" --> "E1p"$,
    $Delta, "x" = "E1p" tack.r "E2" --> "E2p"$
  )) $

#let VAR = $ #proof-tree(eval("VAR",
    $Delta tack.r "x" --> "E"$, 
    $Delta("x") = E$,
  )) $

#let FUNC = $ #proof-tree(eval("FUNC",
    $Delta tack.r "func"< overline( "a")>( overline( "x":"P")) -> "T" { "E" } --> "func"<overline("a")>(overline("x":"P")) -> "T" { "Ep" }$, 
    $"E" --> "Ep"$
  )) $

#let FUNC_APP = $ #proof-tree(eval("FUNC-APP", 
    $Delta tack.r ("E1")< overline( "T")>( overline( "E")) --> "Ep"$, 
    $Delta tack.r "E1" --> "func" < overline("a")>( overline( "x":"P")) -> "T" { "E" }$, 
    $Delta, overline("x:E") tack.r "E" --> "Ep"$)) $

#let ARR = $ #proof-tree(eval("ARR", 
    $Delta tack.r [overline( "E")] --> [overline( "Ep")]$,
    $Delta tack.r overline("E") --> overline("Ep")$)) $

#let CONC = $ #proof-tree(eval("CONC", 
    $Delta tack.r [overline("E1")]::[overline("E2")] --> [overline("E1p"), overline("E2p")]$,
    $Delta tack.r [overline("E1")] --> [overline("E1p")]$,
    $Delta tack.r [overline("E2")] --> [overline("E2p")]$)) $

#let FIRST_ARR = $ #proof-tree(eval("FIRST-ARR", 
    $Delta tack.r "first"([ "E1", overline( "E2")])  --> "E1p"$,
    $Delta tack.r "E1" --> "E1p"$,
    $Delta tack.r overline("E2") --> overline("E2p")$
  )) $

#let REST_ARR = $ #proof-tree(eval("REST-ARR", 
    $Delta tack.r "rest"([ "E1", overline( "E2")])  --> overline("E2p")$,
    $Delta tack.r "E1" --> "E1p"$,
    $Delta tack.r overline("E2") --> overline("E2p")$
  )) $

// typing

#let INT = $ #proof-tree(typing("INT",
  $#t_context() "int" : "Type"$
)) $

#let BOOL = $ #proof-tree(typing("BOOL",
  $#t_context() "bool" : "Type"$
)) $

#let DIM = $ #proof-tree(typing("DIM",
  $#t_context() "m" : "Dim"$
)) $

#let T_NUM = $ #proof-tree(typing("T-NUM",
  $"n":"int"$,
  $"n" in NN$
)) $

#let T_PLUS = $ #proof-tree(typing("T-PLUS", 
  $#t_context() "E1" + "E2" : "int"$,
  $#t_context() "E1" : "int"$, $"E2" : "int"$)) $

#let T_TIME = $ #proof-tree(typing("T-TIME", 
  $#t_context() "E1" * "E2" : "int"$,
  $#t_context() "E1" : "int"$,
  $#t_context() "E2" : "int"$)) $

#let T_TRUE = $ #proof-tree(t_true) $
#let T_FALSE = $ #proof-tree(t_false) $

#let T_AND = $ #proof-tree(typing("T-AND", 
  $#t_context() "E1" "and" "E2" : "bool"$, 
  $#t_context() "E1" : "bool"$,
  $#t_context() "E2" : "bool"$
)) $

#let T_OR = $ #proof-tree(typing("T-OR", 
  $#t_context() "E1" "or" "E2" : "bool"$, 
  $#t_context() "E1" : "bool"; "E2" : "bool"$
)) $

#let T_EQ = $ #proof-tree(typing("T-EQ", 
  $#t_context() "E1" == "E2" : "bool"$, 
  $#t_context() "E1" : "T"; "E2" : "T"$
)) $

#let T_LOW = $ #proof-tree(typing("T-LOW", 
  $#t_context() "E1" < "E2" : "bool"$, 
  $#t_context() "E1" : "int"$,
  $#t_context() "E2" : "int"$
)) $

#let T_GRT = $ #proof-tree(typing("T-GRT", 
  $#t_context() "E1" > "E2" : "bool"$, 
  $#t_context() "E1" : "int"; "E2" : "int"$
)) $

#let T_LOW_EQ = $ #proof-tree(typing("T-LOW-EQ", 
  $#t_context() "E1" <= "E2" : "bool"$, 
  $#t_context() "E1" : "int"; "E2" : "int"$
)) $

#let T_GRT_EQ = $ #proof-tree(typing("T-GRT-EQ", 
  $#t_context() "E1" >= "E2" : "bool"$, 
  $#t_context() "E1" : "int"; "E2" : "int"$
)) $

#let T_IF = $ #proof-tree(typing("T-IF",
  $#t_context() "if" "E1" "then" "E2" "else" "E3" : "T"$,
  $#t_context() "E1" : "bool"$,
  $#t_context() "E2" : "T"$,
  $#t_context() "E3" : "T"$
)) $

#let T_LET = $ #proof-tree(typing("T-LET",
  $#t_context() "let" "x": "T1" = "E1" "in" "E2" : "T2"$,
  $#t_context() "E1" : "T1"$, 
  $#t_context(type: $,"x" : "T1"$) "E2" : "T2"$
)) $

#let T_VAR = $ #proof-tree(typing("T-VAR",
  $#t_context() "x": sigma$,
  $Gamma ("x") = sigma$
)) $

#let T_FUNC = $ #proof-tree(typing("T-FUNC",
  $#t_context() "func"<overline("a":"K")>(overline("x":"T")) -> "T" { "E" } : <overline("K")>(overline("T")) -> "T"$,
  $#t_context(generic: $, overline("a":"K")$, type: $, overline("x":"T")$) "E" : "T"$
)) $

#let T_FUNC_APP = $ #proof-tree(typing("T-FUNC-APP", 
  $#t_context() ("E1")< overline("a")>(overline("E2")) : "T"$,
  $#t_context() "E1" : <overline("K")>(overline("T")) -> "T"$,
  $#t_context() overline("a": "K")$,
  $#t_context() overline("E2": "T")$
)) $

#let T_ARR = $ #proof-tree(typing("T-ARR", 
  $#t_context() [ overline( "E") ] : ["n", "T"]$, 
  $"len"( overline( "E") ) => "n"$,
  $#t_context() overline("E") : "T"$
)) $

#let T_CONC = $ #proof-tree(typing("T-CONC", 
  $[overline("E1")] :: [overline("E2")] => ["m+n", "T"]$, 
  $#t_context() [overline("E1")] : [m, T]$,
  $#t_context() [overline("E2")] : [n, T]$,
)) $

#let T_FIRST_ARR = $ #proof-tree(typing("T-FIRST-ARR", 
  $#t_context() "first"(["E"]) : "T"$, 
  $#t_context() [overline("E")] : [m, T]$,
)) $

#let T_REST_ARR = $ #proof-tree(typing("T-REST-ARR", 
  $#t_context() "rest"([overline("E")]) : ["m", "T"]$, 
  $#t_context() [overline("E")] : ["m"+1, "T"]$,
)) $
