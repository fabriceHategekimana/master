#import "../src/theorem.typ" : *
#import "../src/rules.typ"

#pagebreak()

== Sémantique d'Évaluation

#Definition()[Rèlges d'évaluation part.1
#rules.NUM
#rules.PLUS_L
#rules.PLUS_R
#rules.PLUS_FINAL
#rules.TIME_L
#rules.TIME_R
#rules.TIME_FINAL
#rules.BOOL_T
#rules.BOOL_F
#rules.AND_L
#rules.AND_R
#rules.AND_FINAL
#rules.OR_L
#rules.OR_R
#rules.OR_FINAL
#rules.EQ_L
#rules.EQ_R
#rules.EQ_FINAL
]

#Definition()[Règles d'évaluation part.2
#rules.LOW_L
#rules.LOW_R
#rules.LOW_FINAL
#rules.GRT_L
#rules.GRT_R
#rules.GRT_FINAL
#rules.LOW_EQ_L
#rules.LOW_EQ_R
#rules.LOW_EQ_FINAL
#rules.GRT_EQ_L
#rules.GRT_EQ_R
#rules.GRT_EQ_FINAL
#rules.IF_T
#rules.IF_F
#rules.LET
#rules.LET_FINAL
]

#Definition()[Règles d'évaluation part.3
#rules.VAR
#rules.FUNC
#rules.FUNC_APP
#rules.ARR
#rules.CONC
#rules.FIRST_ARR
#rules.REST_ARR
]

