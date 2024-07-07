#import "../src/module.typ" : *
#pagebreak()

== Sémantique d'Évaluation

#Definition()[Rèlges d'évaluation part.1
$ #proof-tree(eval("NUM", 
    $Delta tack.r "n" --> "n"$)) $
$ #proof-tree(eval("PLUS", 
    $Delta tack.r "E1" + "E2" --> "E3"$, 
    $Delta tack.r "E1" --> "E1p"$, 
    $Delta tack.r "E2" --> "E2p"$, 
    $Delta tack.r "E1p" + "E2p" --> "E3"$)) $
$ #proof-tree(eval("TIME", 
    $Delta tack.r "E1" * "E2" --> "E3"$, 
    $Delta tack.r "E1" --> "E1p"$, 
    $Delta tack.r "E2" --> "E2p"$, 
    $Delta tack.r "E1p" * "E2p" --> "E3"$)) $
$ #proof-tree(eval("BOOL-T", 
    $Delta tack.r "true" --> "true"$)) $
$ #proof-tree(eval("BOOL-F", 
    $Delta tack.r "false" --> "false"$)) $
$ #proof-tree(eval("AND", 
    $Delta tack.r "E1" "and" "E2" --> "E3"$,
    $Delta tack.r "E1" --> "E1p"$, 
    $Delta tack.r "E2" --> "E2p"$, 
    $Delta tack.r "E1" sect "E2" --> "E3"$)) $
$ #proof-tree(eval("OR", 
    $Delta tack.r "E1" "or" "E2" --> "E3"$, 
    $Delta tack.r "E1" --> "E1p"$, 
    $Delta tack.r "E2" --> "E2p"$, 
    $Delta tack.r "E1" union "E2" --> "E3"$)) $
$ #proof-tree(eval("EQ", 
    $Delta tack.r "E1" == "E2" --> "E3"$, 
    $Delta tack.r "E1" --> "E1p"$, 
    $Delta tack.r "E2" --> "E2p"$, 
    $Delta tack.r "E1p" == "E2p" --> "E3"$)) $
$ #proof-tree(eval("LOW", 
    $Delta tack.r "E1" < "E2" --> "E3"$, 
    $Delta tack.r "E1" --> "E1p"$, 
    $Delta tack.r "E2" --> "E2p"$, 
    $Delta tack.r "E1p" < "E2p" --> "E3"$)) $
$ #proof-tree(eval("GRT", 
    $Delta tack.r "E1" > "E2" --> "E3"$, 
    $Delta tack.r "E1" --> "E1p"$, 
    $Delta tack.r "E2" --> "E2p"$, 
    $Delta tack.r "E1p" > "E2p" --> "E3"$)) $
$ #proof-tree(eval("LOW-EQ", 
    $Delta tack.r "E1" <= "E2" --> "E3"$, 
    $Delta tack.r "E1" --> "E1p"$, 
    $Delta tack.r "E2" --> "E2p"$, 
    $Delta tack.r "E1p" <= "E2p" --> "E3"$)) $
$ #proof-tree(eval("GRT-EQ", 
    $Delta tack.r "E1" >= "E2" --> "E3"$, 
    $Delta tack.r "E1" --> "E1p"$, 
    $Delta tack.r "E2" --> "E2p"$, 
    $Delta tack.r "E1p" >= "E2p" --> "E3"$)) $
$ #proof-tree(eval("IF-T", 
    $Delta tack.r "if" "E1" "then" "E2" "else" "E3" --> "E2"$, 
    $Delta tack.r "E1" --> "true"$)) $
$ #proof-tree(eval("IF-F", 
    $Delta tack.r "if" "E1" "then" "E2" "else" "E3" --> "E3"$, 
    $Delta tack.r "E1" --> "false"$)) $
]

#Definition()[Règles d'évaluation part.2
$ #proof-tree(eval("LET",
    $Delta tack.r "let" x: T = "E1" "in" "E2" --> "E2p"$, 
    $Delta tack.r "E1" --> "E1p"$,
    $Delta, "x" = "E1p" tack.r "E2" --> "E2p"$
  )) $
$ #proof-tree(eval("VAR",
    $Delta tack.r "x" --> "E"$, 
    $Delta tack.r "x" = E$,
  )) $
$ #proof-tree(eval("FUNC",
    $Delta tack.r "func"< overline( "a")>( overline( "x":"P")) -> "T" { "E" } --> "func"<overline("a")>(overline("x":"P")) -> "T" { "Ep" }$, 
    $"E" --> "Ep"$
  )) $
$ #proof-tree(eval("FUNC-APP", 
    $Delta tack.r ("E1")< overline( "T")>( overline( "E")) --> "Ep"$, 
    $Delta tack.r "E1" --> "func" < overline("a")>( overline( "x":"P")) -> "T" { "E" }$, 
    $Delta, overline("x:E") tack.r "E" --> "Ep"$)) $
$ #proof-tree(eval("ARR", 
    $Delta tack.r [overline( "E")] --> [overline( "Ep")]$,
    $Delta tack.r overline("E") --> overline("Ep")$)) $
$ #proof-tree(eval("CONC", 
    $Delta tack.r [overline("E1")]::[overline("E2")] --> [overline("E1p"), overline("E2p")]$,
    $Delta tack.r [overline("E1")] --> [overline("E1p")]$,
    $Delta tack.r [overline("E2")] --> [overline("E2p")]$)) $
$ #proof-tree(eval("FIRST-ARR", 
    $Delta tack.r "first"([ "E1", overline( "E2")])  --> "E1p"$,
    $Delta tack.r "E1" --> "E1p"$,
    $Delta tack.r overline("E2") --> overline("E2p")$
  )) $
$ #proof-tree(eval("REST-ARR", 
    $Delta tack.r "rest"([ "E1", overline( "E2")])  --> overline("E2p")$,
    $Delta tack.r "E1" --> "E1p"$,
    $Delta tack.r overline("E2") --> overline("E2p")$
  )) $
]

