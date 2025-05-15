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

#let t_context(kind: "", type: "") = $Phi #kind \; Gamma #type tack.r$

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

#let PLUS_L = $ #proof-tree(eval("PLUS-L", 
    $Delta tack.r "E1" + "E2" --> "E1'" + "E2"$, 
    $Delta tack.r "E1" --> "E1'"$))$

#let PLUS_R = $ #proof-tree(eval("PLUS-R", 
    $Delta tack.r "V" + "E2" --> "V" + "E2'"$, 
    $Delta tack.r "E2" --> "E2'"$
  ))$
    
#let PLUS_FINAL = $ #proof-tree(eval("PLUS", 
    $Delta tack.r "V1" + "V2" --> "V1" + "V2"$)) $

#let TIME_L = $ #proof-tree(eval("TIME-L", 
    $Delta tack.r "E1" * "E2" --> "E1'" * "E2"$,
    $Delta tack.r "E1" --> "E1'"$)) $
  
#let TIME_R = $ #proof-tree(eval("TIME-R", 
    $Delta tack.r "V" * "E2" --> "V * E2"$, 
    $Delta tack.r "E2" --> "E2'"$)) $

#let TIME_FINAL = $ #proof-tree(eval("TIME", 
    $Delta tack.r "V1" * "V2" --> "V1 * V2"$)) $

#let BOOL_T = $ #proof-tree(eval("BOOL-T", 
    $Delta tack.r "true" --> "true"$)) $

#let BOOL_F = $ #proof-tree(eval("BOOL-F", 
    $Delta tack.r "false" --> "false"$)) $

#let AND_FINAL = $ #proof-tree(eval("AND", 
    $Delta tack.r "V1" "and" "V2" --> "V1" and "V2"$)) $

#let AND_L = $ #proof-tree(eval("AND-L", 
    $Delta tack.r "E1" "and" "E2" --> "E1'" and "E2"$,
    $Delta tack.r "E1" --> "E1'"$)) $

#let AND_R = $ #proof-tree(eval("AND-R", 
    $Delta tack.r "V" "and" "E2" --> "V" and "E2'"$,
    $Delta tack.r "E2" --> "E2'"$)) $


#let OR_L = $ #proof-tree(eval("OR-L", 
    $Delta tack.r "E1" "or" "E2" --> "E1'" or "E2"$,
    $Delta tack.r "E1" --> "E1'"$)) $

#let OR_R = $ #proof-tree(eval("OR-R", 
    $Delta tack.r "V1" "or" "E2" --> "V1" or "E2'"$,
    $Delta tack.r "E2" --> "E2'"$)) $

#let OR_FINAL = $ #proof-tree(eval("OR", 
    $Delta tack.r "V1" "or" "V2" --> "V1" or "V2"$)) $

#let EQ_L = $ #proof-tree(eval("EQ-L", 
    $Delta tack.r "E1" == "E2" --> "E1'" == "E2"$, 
    $Delta tack.r "E1" --> "E1'"$
    )) $

#let EQ_R = $ #proof-tree(eval("EQ-R", 
    $Delta tack.r "V1" == "E2" --> "V1" == "E2'"$, 
    $Delta tack.r "E2" --> "E2'"$
    )) $

#let EQ_FINAL = $ #proof-tree(eval("EQ-FINAL", 
    $Delta tack.r "V1" == "v2" --> "V1" == "E2'"$
    )) $

#let LOW_L = $ #proof-tree(eval("LOW-L", 
    $Delta tack.r "E1" < "E2" --> "E1'" < "E2"$, 
    $Delta tack.r "E1" --> "E1'"$)) $

#let LOW_R = $ #proof-tree(eval("LOW-R", 
    $Delta tack.r "V" < "E2" --> "E1" < "E2'"$, 
    $Delta tack.r "E2" --> "E2'"$)) $

#let LOW_FINAL = $ #proof-tree(eval("LOW", 
    $Delta tack.r "V1" < "V2" --> "V1" < "V2"$)) $

#let GRT_L = $ #proof-tree(eval("GRT-L", 
    $Delta tack.r "E1" > "E2" --> "E1'" > "E2"$, 
    $Delta tack.r "E1" --> "E1'"$)) $

#let GRT_R = $ #proof-tree(eval("GRT-R", 
    $Delta tack.r "V" > "E2" --> "E1" > "E2'"$, 
    $Delta tack.r "E2" --> "E2'"$)) $

#let GRT_FINAL = $ #proof-tree(eval("GRT", 
    $Delta tack.r "V1" > "V2" --> "V1" > "V2"$)) $

#let LOW_EQ_L = $ #proof-tree(eval("LOW-EQ-L", 
    $Delta tack.r "E1" < "E2" --> "E1'" < "E2"$, 
    $Delta tack.r "E1" --> "E1'"$)) $

#let LOW_EQ_R = $ #proof-tree(eval("LOW-EQ-R", 
    $Delta tack.r "V" < "E2" --> "E1" < "E2'"$, 
    $Delta tack.r "E2" --> "E2'"$)) $

#let LOW_EQ_FINAL = $ #proof-tree(eval("LOW-EQ", 
    $Delta tack.r "V1" < "V2" --> "V1" < "V2"$)) $

#let GRT_EQ_L = $ #proof-tree(eval("GRT-EQ-L", 
    $Delta tack.r "E1" > "E2" --> "E1'" > "E2"$, 
    $Delta tack.r "E1" --> "E1'"$)) $

#let GRT_EQ_R = $ #proof-tree(eval("GRT-EQ-R", 
    $Delta tack.r "V" > "E2" --> "E1" > "E2'"$, 
    $Delta tack.r "E2" --> "E2'"$)) $

#let GRT_EQ_FINAL = $ #proof-tree(eval("GRT-EQ", 
    $Delta tack.r "V1" > "V2" --> "V1" > "V2"$)) $

#let IF_START = $ #proof-tree(eval("IF-START", 
    $Delta tack.r "if" "E1" "then" "E2" "else" "E3" --> "if" "E1'" "then" "E2" "else" "E3"$, 
    $Delta tack.r "E1" --> "E1'"$)) $

#let IF_T = $ #proof-tree(eval("IF-T", 
    $Delta tack.r "if" "true" "then" "E2" "else" "E3" --> "E2"$)) $

#let IF_F = $ #proof-tree(eval("IF-F", 
    $Delta tack.r "if" "false" "then" "E2" "else" "E3" --> "E3"$)) $


#let LET = $ #proof-tree(eval("LET",
    $Delta tack.r "let" x: T = "E1" "in" "E2" --> "let" x: T = "E1'" "in" "E2" $, 
    $Delta tack.r "E1" --> "E1'"$,
  )) $

#let LET_FINAL = $ #proof-tree(eval("LET-FINAL",
    $Delta tack.r "let" x: T = "V" "in" "E2" --> "E2"[x := V]$, 
  )) $

#let VAR = $ #proof-tree(eval("VAR",
    $Delta tack.r "x" --> "E"$, 
    $Delta("x") = E$,
  )) $

#let FUNC = $ #proof-tree(eval("FUNC",
    $Delta tack.r "func"< overline( "a")>( overline( "x":"P")) -> "T" { "E" } --> "func"<overline("a")>(overline("x":"P")) -> "T" { "E'" }$, 
    $"E" --> "E'"$
  )) $

#let FUNC_APP = $ #proof-tree(eval("FUNC-APP", 
    $Delta tack.r ("E1")< overline( "T")>( overline( "E")) --> "Ep"$, 
    $Delta tack.r "E1" --> "func" < overline("a")>( overline( "x":"P")) -> "T" { "E" }$, 
    $Delta, overline("x:E") tack.r "E" --> "E'"$)) $

#let ARR = $ #proof-tree(eval("ARR", 
    $Delta tack.r [overline( "E")] --> [overline( "E'")]$,
    $Delta tack.r overline("E") --> overline("E'")$)) $

#let CONC = $ #proof-tree(eval("CONC", 
    $Delta tack.r [overline("V1")]::[overline("V2")] --> [overline("V1"), overline("V2")]$)) $

#let CONC_L = $ #proof-tree(eval("CONC-L", 
    $Delta tack.r [overline("E1")]::[overline("E2")] --> [overline("E1'"), overline("E2")]$,
    $Delta tack.r [overline("E1")] --> [overline("E1'")]$)) $

#let CONC_R = $ #proof-tree(eval("CONC-R", 
    $Delta tack.r [overline("V")]::[overline("E2")] --> [overline("V"), overline("E2'")]$,
    $Delta tack.r [overline("E2")] --> [overline("E2'")]$)) $

#let FIRST_ARR = $ #proof-tree(eval("FIRST-ARR", 
    $Delta tack.r "first"([ "V1", overline( "V2")])  --> "V1'"$ )) $

#let FIRST_ARR_L = $ #proof-tree(eval("FIRST-ARR", 
    $Delta tack.r "first"([ "E1", overline( "E2")])  --> "first"([ "E1'", overline( "E2"))]$,
    $Delta tack.r "E1" --> "E1'"$,
  )) $

#let FIRST_ARR_R = $ #proof-tree(eval("FIRST-ARR", 
    $Delta tack.r "first"([ "V", overline( "E2")])  --> "first"([ "V", overline( "E2'"))]$,
    $Delta tack.r overline("E2") --> overline("E2'")$
  )) $

#let REST_ARR = $ #proof-tree(eval("REST-ARR", 
    $Delta tack.r "rest"([ "E1", overline( "E2")])  --> overline("E2'")$,
    $Delta tack.r "E1" --> "E1'"$,
    $Delta tack.r overline("E2") --> overline("E2'")$
  )) $

// typing
#let INT = $ #proof-tree(typing("INT",
  $#t_context() "int" : "Type"$
)) $

#let BOOL = $ #proof-tree(typing("BOOL",
  $#t_context() "bool" : "Type"$
)) $

#let DIM = $ #proof-tree(typing("DIM1",
  $#t_context() "m" : "Dim"$,
  $m in NN$
)) $
#let DIM = $ #proof-tree(typing("DIM2",
  $#t_context() "m" : "Dim"$,
  $m in NN$
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
  $#t_context(kind: $, overline("a":"K")$, type: $, overline("x":"T")$) "E" : "T"$
)) $

#let T_FUNC_APP = $ #proof-tree(typing("T-FUNC-APP", 
  $#t_context() ("E1")< overline("a:K")>(overline("E2")) : "T"$,
  $#t_context() "E1" : <overline("a:K")>(overline("T")) -> "T"$,
  $#t_context(kind: $"a:K"$) forall "t" in overline("T"), "e" in overline("E2"), ("t:T'" and "e:T'")$
)) $

#let T_ARR = $ #proof-tree(typing("T-ARR", 
  $#t_context() "E" : ["n", "T"]$, 
  $"len"( "E" ) => "n"$,
  $"n" : "Dim"$,
  $#t_context() forall "e" in  "E", "e" : "T"$,
  $"T" : "Type"$
)) $

#let T_CONC = $ #proof-tree(typing("T-CONC", 
  $[overline("E1")] :: [overline("E2")] => ["m+n", "T"]$, 
  $#t_context() [overline("E1")] : [m, T]$,
  $#t_context() [overline("E2")] : [n, T]$,
)) $

#let T_FIRST_ARR = $ #proof-tree(typing("T-FIRST-ARR", 
  $#t_context() "first"("E") : "T"$, 
  $#t_context() "E" : [m, T]$,
)) $

#let T_REST_ARR = $ #proof-tree(typing("T-REST-ARR", 
  $#t_context() "rest"("E") : ["m", "T"]$, 
  $#t_context() "E" : ["m"+1, "T"]$,
)) $
