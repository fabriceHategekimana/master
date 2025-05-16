#import "../src/theorem.typ" : *
#import "../src/rules.typ"

#pagebreak()

== Sémantique de typage

#Definition()[Règle de typage part.1
#rules.T_NUM
#rules.T_PLUS
#rules.T_TIME
#rules.T_TRUE
#rules.T_FALSE
#rules.T_AND
#rules.T_OR
#rules.T_EQ
#rules.T_LOW
#rules.T_GRT
#rules.T_LOW_EQ
#rules.T_GRT_EQ
#rules.T_IF
]

#Definition()[Règle de typage part.2
#rules.INT
#rules.BOOL
#rules.DIM
#rules.T_LET
#rules.T_VAR
#rules.T_FUNC
#rules.T_FUNC_APP
#rules.T_ARR
#rules.T_CONC
#rules.T_FIRST_ARR
#rules.T_REST_ARR
]

Ce langage est très simple car il se limite au strict minimum pour le projet.

