#import "module.typ": *
#import "lang.typ"

#let t_true =  rule(
    name: "T-TRUE",
    type_context("true : bool")
)

#let t_false =  rule(
    name: "T-FALSE",
    type_context("false : bool")
)

// évaluation
#let NUM = $ #prooftree(evaluate("NUM", 
    $Delta tack.r "n" --> "n"$)) $

#let PLUS_L = $ #prooftree(evaluate("PLUS-L", 
    $Delta tack.r "E1" + "E2" --> "V1" + "E2"$, 
    $Delta tack.r "E1" --> "V1"$))$

#let PLUS_R = $ #prooftree(evaluate("PLUS-R", 
    $Delta tack.r "V" + "E2" --> "V" + "V2"$, 
    $Delta tack.r "E2" --> "V2"$
  ))$
    
#let PLUS_FINAL = $ #prooftree(evaluate("PLUS", 
    $Delta tack.r "V1" + "V2" --> "V1" + "V2"$)) $

#let TIME_L = $ #prooftree(evaluate("TIME-L", 
    $Delta tack.r "E1" * "E2" --> "V1" * "E2"$,
    $Delta tack.r "E1" --> "V1"$)) $
  
#let TIME_R = $ #prooftree(evaluate("TIME-R", 
    $Delta tack.r "V" * "E2" --> "V * E2"$, 
    $Delta tack.r "E2" --> "V2"$)) $

#let TIME_FINAL = $ #prooftree(evaluate("TIME", 
    $Delta tack.r "V1" * "V2" --> "V1 * V2"$)) $

#let BOOL_T = $ #prooftree(evaluate("BOOL-T", 
    $Delta tack.r "true" --> "true"$)) $

#let BOOL_F = $ #prooftree(evaluate("BOOL-F", 
    $Delta tack.r "false" --> "false"$)) $

#let AND_FINAL = $ #prooftree(evaluate("AND", 
    $Delta tack.r "V1" "and" "V2" --> "V1" and "V2"$)) $

#let AND_L = $ #prooftree(evaluate("AND-L", 
    $Delta tack.r "E1" "and" "E2" --> "V1" and "E2"$,
    $Delta tack.r "E1" --> "V1"$)) $

#let AND_R = $ #prooftree(evaluate("AND-R", 
    $Delta tack.r "V" "and" "E2" --> "V" and "V2"$,
    $Delta tack.r "E2" --> "V2"$)) $


#let OR_L = $ #prooftree(evaluate("OR-L", 
    $Delta tack.r "E1" "or" "E2" --> "V1" or "E2"$,
    $Delta tack.r "E1" --> "V1"$)) $

#let OR_R = $ #prooftree(evaluate("OR-R", 
    $Delta tack.r "V1" "or" "E2" --> "V1" or "V2"$,
    $Delta tack.r "E2" --> "V2"$)) $

#let OR_FINAL = $ #prooftree(evaluate("OR", 
    $Delta tack.r "V1" "or" "V2" --> "V1" or "V2"$)) $

#let EQ_L = $ #prooftree(evaluate("EQ-L", 
    $Delta tack.r "E1" == "E2" --> "V1" == "E2"$, 
    $Delta tack.r "E1" --> "V1"$
    )) $

#let EQ_R = $ #prooftree(evaluate("EQ-R", 
    $Delta tack.r "V1" == "E2" --> "V1" == "V2"$, 
    $Delta tack.r "E2" --> "V2"$
    )) $

#let EQ_FINAL = $ #prooftree(evaluate("EQ-FINAL", 
    $Delta tack.r "V1" == "v2" --> "V1" == "V2"$
    )) $

#let LOW_L = $ #prooftree(evaluate("LOW-L", 
    $Delta tack.r "E1" < "E2" --> "V1" < "E2"$, 
    $Delta tack.r "E1" --> "V1"$)) $

#let LOW_R = $ #prooftree(evaluate("LOW-R", 
    $Delta tack.r "V" < "E2" --> "E1" < "V2"$, 
    $Delta tack.r "E2" --> "V2"$)) $

#let LOW_FINAL = $ #prooftree(evaluate("LOW", 
    $Delta tack.r "V1" < "V2" --> "V1" < "V2"$)) $

#let GRT_L = $ #prooftree(evaluate("GRT-L", 
    $Delta tack.r "E1" > "E2" --> "V1" > "E2"$, 
    $Delta tack.r "E1" --> "V1"$)) $

#let GRT_R = $ #prooftree(evaluate("GRT-R", 
    $Delta tack.r "V" > "E2" --> "E1" > "V2"$, 
    $Delta tack.r "E2" --> "V2"$)) $

#let GRT_FINAL = $ #prooftree(evaluate("GRT", 
    $Delta tack.r "V1" > "V2" --> "V1" > "V2"$)) $

#let LOW_EQ_L = $ #prooftree(evaluate("LOW-EQ-L", 
    $Delta tack.r "E1" < "E2" --> "V1" < "E2"$, 
    $Delta tack.r "E1" --> "V1"$)) $

#let LOW_EQ_R = $ #prooftree(evaluate("LOW-EQ-R", 
    $Delta tack.r "V" < "E2" --> "E1" < "V2"$, 
    $Delta tack.r "E2" --> "V2"$)) $

#let LOW_EQ_FINAL = $ #prooftree(evaluate("LOW-EQ", 
    $Delta tack.r "V1" < "V2" --> "V1" < "V2"$)) $

#let GRT_EQ_L = $ #prooftree(evaluate("GRT-EQ-L", 
    $Delta tack.r "E1" > "E2" --> "V1" > "E2"$, 
    $Delta tack.r "E1" --> "V1"$)) $

#let GRT_EQ_R = $ #prooftree(evaluate("GRT-EQ-R", 
    $Delta tack.r "V" > "E2" --> "E1" > "V2"$, 
    $Delta tack.r "E2" --> "V2"$)) $

#let GRT_EQ_FINAL = $ #prooftree(evaluate("GRT-EQ", 
    $Delta tack.r "V1" > "V2" --> "V1" > "V2"$)) $

#let IF_START = $ #prooftree(evaluate("IF-START", 
    $Delta tack.r "if" "E1" "then" "E2" "else" "E3" --> "if" "V1" "then" "E2" "else" "E3"$, 
    $Delta tack.r "E1" --> "V1"$)) $

#let IF_T = $ #prooftree(evaluate("IF-T", 
    $Delta tack.r "if" "true" "then" "E2" "else" "E3" --> "E2"$)) $

#let IF_F = $ #prooftree(evaluate("IF-F", 
    $Delta tack.r "if" "false" "then" "E2" "else" "E3" --> "E3"$)) $

#let LET = $ #prooftree(evaluate("LET",
    $Delta tack.r "let" x: "T1" = "E1" "in" "E2" --> "let" x: "T1" = "V1" "in" "E2" $, 
    $Delta tack.r "E1" --> "V1"$,
  )) $

#let LET_FINAL = $ #prooftree(evaluate("LET-FINAL",
    $Delta tack.r "let" x: T = "V1" "in" "E2" --> "V2"$, 
    $ Delta, x := "V1" tack.r "E2" --> "V2" $
  )) $

#let VAR = $ #prooftree(evaluate("VAR",
    $Delta tack.r "x" --> "E"$, 
    $Delta("x") = E$,
  )) $

#let FUNC = $ #prooftree(evaluate("FUNC",
    $Delta tack.r "func"< overline( "a")>( overline( "x":"P")) -> "T" { "E" } --> "func"<overline("a")>(overline("x":"P")) -> "T" { "E'" }$, 
    $"E" --> "E'"$
  )) $

#let FUNC_APP = $ #prooftree(evaluate("FUNC-APP", 
    $Delta tack.r ("E1")< overline( "T")>( overline( "E")) --> "Ep"$, 
    $Delta tack.r "E1" --> "func" < overline("a")>( overline( "x":"P")) -> "T" { "E" }$, 
    $Delta, overline("x:E") tack.r "E" --> "E'"$)) $

#let ARR = $ #prooftree(evaluate("ARR", 
    $Delta tack.r [overline( "E1")] --> [overline( "V1")]$,
    $Delta tack.r overline("E1") --> overline("V1")$)) $

#let CONC = $ #prooftree(evaluate("CONC", 
    $Delta tack.r [overline("V1")]::[overline("V2")] --> [overline("V1"), overline("V2")]$)) $

#let CONC_L = $ #prooftree(evaluate("CONC-L", 
    $Delta tack.r [overline("E1")]::[overline("E2")] --> [overline("V1"), overline("E2")]$,
    $Delta tack.r [overline("E1")] --> [overline("V1")]$)) $

#let CONC_R = $ #prooftree(evaluate("CONC-R", 
    $Delta tack.r [overline("V")]::[overline("E2")] --> [overline("V"), overline("V2")]$,
    $Delta tack.r [overline("E2")] --> [overline("V2")]$)) $

#let FIRST_ARR = $ #prooftree(evaluate("FIRST-ARR", 
    $Delta tack.r "first"([ "V1", overline( "V2")])  --> "V1"$ )) $

#let FIRST_ARR_L = $ #prooftree(evaluate("FIRST-ARR-L", 
    $Delta tack.r "first"([ "E1", overline( "E2")])  --> "first"([ "V1", overline( "E2"))]$,
    $Delta tack.r "E1" --> "V1"$,
  )) $

#let FIRST_ARR_R = $ #prooftree(evaluate("FIRST-ARR-R", 
    $Delta tack.r "first"([ "V1", overline( "E2")])  --> "first"([ "V1", overline( "V2'"))]$,
    $Delta tack.r overline("E2") --> overline("V2")$
  )) $

#let REST_ARR = $ #prooftree(evaluate("REST-ARR", 
    $Delta tack.r "rest"([ "V1", overline( "V2")])  --> overline("V2'")$
  )) $

// typing
#let INT = $ #prooftree(typing("INT",
  $#t_context() "int" : "Type"$
)) $

#let BOOL = $ #prooftree(typing("BOOL",
  $#t_context() "bool" : "Type"$
)) $

#let DIM = $ #prooftree(typing("DIM1",
  $#t_context() "m" : "Dim"$,
  $m in NN$
)) $
#let DIM = $ #prooftree(typing("DIM2",
  $#t_context() "m" : "Dim"$,
  $m in NN$
)) $

#let T_NUM = $ #prooftree(typing("T-NUM",
  $"n":"int"$,
  $"n" in NN$
)) $

#let T_PLUS = $ #prooftree(typing("T-PLUS", 
  $#t_context() "E1" + "E2" : "int"$,
  $#t_context() "E1" : "int"$, $"E2" : "int"$)) $

#let T_TIME = $ #prooftree(typing("T-TIME", 
  $#t_context() "E1" * "E2" : "int"$,
  $#t_context() "E1" : "int"$,
  $#t_context() "E2" : "int"$)) $

#let T_TRUE = $ #prooftree(t_true) $
#let T_FALSE = $ #prooftree(t_false) $

#let T_AND = $ #prooftree(typing("T-AND", 
  $#t_context() "E1" "and" "E2" : "bool"$, 
  $#t_context() "E1" : "bool"$,
  $#t_context() "E2" : "bool"$
)) $

#let T_OR = $ #prooftree(typing("T-OR", 
  $#t_context() "E1" "or" "E2" : "bool"$, 
  $#t_context() "E1" : "bool"; "E2" : "bool"$
)) $

#let T_EQ = $ #prooftree(typing("T-EQ", 
  $#t_context() "E1" == "E2" : "bool"$, 
  $#t_context() "E1" : "T"; "E2" : "T"$
)) $

#let T_LOW = $ #prooftree(typing("T-LOW", 
  $#t_context() "E1" < "E2" : "bool"$, 
  $#t_context() "E1" : "int"$,
  $#t_context() "E2" : "int"$
)) $

#let T_GRT = $ #prooftree(typing("T-GRT", 
  $#t_context() "E1" > "E2" : "bool"$, 
  $#t_context() "E1" : "int"; "E2" : "int"$
)) $

#let T_LOW_EQ = $ #prooftree(typing("T-LOW-EQ", 
  $#t_context() "E1" <= "E2" : "bool"$, 
  $#t_context() "E1" : "int"; "E2" : "int"$
)) $

#let T_GRT_EQ = $ #prooftree(typing("T-GRT-EQ", 
  $#t_context() "E1" >= "E2" : "bool"$, 
  $#t_context() "E1" : "int"; "E2" : "int"$
)) $

#let T_IF = $ #prooftree(typing("T-IF",
  $#t_context() "if" "E1" "then" "E2" "else" "E3" : "T"$,
  $#t_context() "E1" : "bool"$,
  $#t_context() "E2" : "T"$,
  $#t_context() "E3" : "T"$
)) $

#let T_LET = $ #prooftree(typing("T-LET",
  $#t_context() "let" "x": "T1" = "E1" "in" "E2" : "T2"$,
  $#t_context() "E1" : "T1"$, 
  $#t_context(type: $,"x" : "T1"$) "E2" : "T2"$
)) $

#let T_VAR = $ #prooftree(typing("T-VAR",
  $#t_context() "x": sigma$,
  $Gamma ("x") = sigma$
)) $

#let T_FUNC = $ #prooftree(typing("T-FUNC",
  $#t_context() "func"<overline("a":"K")>(overline("x":"T")) -> "T" { "E" } : <overline("K")>(overline("T")) -> "T"$,
  $#t_context(kind: $, overline("a":"K")$, type: $, overline("x":"T")$) "E" : "T"$
)) $

#let T_FUNC_APP = $ #prooftree(typing("T-FUNC-APP", 
  $#t_context() ("E1")< overline("a:K")>(overline("E2")) : "T"$,
  $#t_context() "E1" : <overline("a:K")>(overline("T")) -> "T"$,
  $#t_context(kind: $"a:K"$) forall "t" in overline("T"), "e" in overline("E2"), ("t:T'" and "e:T'")$
)) $

#let T_ARR = $ #prooftree(typing("T-ARR", 
  $#t_context() lang.array("E1") : ["n", "T"]$, 
  $"len"( overline("E1") ) => "n"$,
  $#t_context() "n" : "Dim"$,
  $#t_context() forall "e" in  overline("E1"), "e" : "T"$,
  $#t_context() "T" : "Type"$
)) $

#let T_CONC = $ #prooftree(typing("T-CONC", 
  $[overline("E1")] :: [overline("E2")] : ["m+n", "T"]$, 
  $#t_context() [overline("E1")] : [m, T]$,
  $#t_context() [overline("E2")] : [n, T]$,
)) $

#let T_FIRST_ARR = $ #prooftree(typing("T-FIRST-ARR", 
  $#t_context() "first"("E1") : "T1"$, 
  $#t_context() "E1" : [m, "T1"]$,
)) $

#let T_REST_ARR = $ #prooftree(typing("T-REST-ARR", 
  $#t_context() "rest"("E") : ["m", "T"]$, 
  $#t_context() "E" : ["m"+1, "T"]$,
)) $

