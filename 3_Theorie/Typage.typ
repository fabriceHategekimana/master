#import "../src/module.typ" : *

#pagebreak()

== Sémantique de typage

#Definition()[Règle de typage part.1
$ #proof-tree(typing("T-NUM",
  $"n":"int"$,
  $"n" in NN$
)) $

$ #proof-tree(typing("T-PLUS", 
  $Gamma tack.r "E1" + "E2" : "int"$,
  $Gamma tack.r "E1" : "int"$, $"E2" : "int"$)) $

$ #proof-tree(typing("T-TIME", 
  $Gamma tack.r "E1" * "E2" : "int"$,
  $Gamma tack.r "E1" : "int"$,
  $Gamma tack.r "E2" : "int"$)) $

$ #proof-tree(t_true) $
$ #proof-tree(t_false) $

$ #proof-tree(typing("T-AND", 
  $tack.r "E1" "and" "E2" : "bool"$, 
  $tack.r "E1" : "bool"$,
  $tack.r "E2" : "bool"$
)) $

$ #proof-tree(typing("T-OR", 
  $Gamma tack.r "E1" "or" "E2" : "bool"$, 
  $Gamma tack.r "E1" : "bool"; "E2" : "bool"$
)) $

$ #proof-tree(typing("T-EQ", 
  $Gamma tack.r "E1" == "E2" : "bool"$, 
  $Gamma tack.r "E1" : "T"; "E2" : "T"$
)) $

$ #proof-tree(typing("T-LOW", 
  $Gamma tack.r "E1" < "E2" : "bool"$, 
  $Gamma tack.r "E1" : "int"$,
  $Gamma tack.r "E2" : "int"$
)) $

$ #proof-tree(typing("T-GRT", 
  $Gamma tack.r "E1" > "E2" : "bool"$, 
  $Gamma tack.r "E1" : "int"; "E2" : "int"$
)) $

$ #proof-tree(typing("T-LOW-EQ", 
  $Gamma tack.r "E1" <= "E2" : "bool"$, 
  $Gamma tack.r "E1" : "int"; "E2" : "int"$
)) $

$ #proof-tree(typing("T-GRT-EQ", 
  $Gamma tack.r "E1" >= "E2" : "bool"$, 
  $Gamma tack.r "E1" : "int"; "E2" : "int"$
)) $

$ #proof-tree(typing("T-IF",
  $Gamma tack.r "if" "E1" "then" "E2" "else" "E3" : "T"$,
  $Gamma tack.r "E1" : "bool"$,
  $Gamma tack.r "E2" : "T"$,
  $Gamma tack.r "E3" : "T"$
)) $
]

#Definition()[Règle de typage part.2
$ #proof-tree(typing("T-LET",
  $Gamma tack.r "let" "x": "T1" = "E1" "in" "E2" : "T2"$,
  $Gamma tack.r "E1" : "T1"$, 
  $Gamma tack.r "x" : "T1" "E2" : "T2"$
)) $

$ #proof-tree(typing("VAR",
  $Gamma tack.r "x": sigma$,
  $Gamma tack.r "x": sigma$,
)) $

$ #proof-tree(typing("T-FUNC",
  $Gamma tack.r "func"< overline( "a")>( overline( "x":"T")) -> "T" { "E" } : (( overline( "T")) -> "T")$,
  $Gamma , overline( "x":"T") tack.r "E" : "T"$
)) $

$ #proof-tree(typing("T-FUNC-APP", 
  $("E1")< overline("g")>( overline( "E")) : "T"$,
  $Gamma tack.r "E1" : <overline(a)>(overline( "T")) -> "T"$,
  $[overline("a") \/ overline("g")]overline("T") => overline("Tp")$,
  $Gamma tack.r overline("E") : overline("Tp")$)) $

$ #proof-tree(typing("T-ARR", 
  $Gamma tack.r [ overline( "E") ] : ["n", "T"]$, 
  $"len"( overline( "E") ) => "n"$,
  $tack.r "n" "index"$,
  $Gamma tack.r overline("E") : "T"$
)) $

$ #proof-tree(typing("T-CONC", 
  $[overline("E1")] :: [overline("E2")] => ["m+n", "T"]$, 
  $Gamma tack.r[overline("E1")] : [m, T]$,
  $tack.r "m" "index"$,
  $Gamma tack.r[overline("E2")] : [n, T]$,
  $tack.r "n" "index"$,
)) $

$ #proof-tree(typing("T-FIRST-ARR", 
  $Gamma tack.r "first"(["E"]) => "T"$, 
  $Gamma tack.r [overline("E")] : [m, T]$,
  $tack.r "m" "index"$
)) $

$ #proof-tree(typing("T-REST-ARR", 
  $Gamma tack.r "rest"([overline("E")]) => ["m", "T"]$, 
  $Gamma tack.r [overline("E")] : ["m"+1, "T"]$,
  $tack.r "m" "index"$
)) $
]
