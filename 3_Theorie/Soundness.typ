#import "../src/theorem.typ": *
#import "../src/rules.typ"
#import "../src/lang.typ"

= Preuve de sûrtée du langage

La "soundness" (ou sûreté) d'un système de types d'un langage de programmation est une propriété fondamentale qui garantit que le typage statique est fiable. En d'autres termes, un programme typé de manière statique ne produira pas d'erreurs de type lors de son exécution, soit en acceptant des valeurs dont le type n'est pas accepté à l'exécution du code soit en refusant des types normalement accepté à l'exécution du code. Cette propriété assure que les programmes qui passent la vérification de types (c'est-à-dire qui sont considérés comme bien typés par le compilateur) ne rencontreront pas d'erreurs de type au moment de l'exécution, évitant ainsi un certain nombre de bogues et de comportements imprévisibles.

Pour prouver la soundness d'un système de types, deux théorèmes principaux sont généralement démontrés :

En combinant ces deux théorèmes, on peut démontrer que les programmes bien typés dans le système de types donné ne produiront pas d'erreurs de typage au moment de l'exécution, assurant ainsi la soundness du système de types. La préservation garantit que les types sont maintenus tout au long de l'évaluation, tandis que la progression assure que l'évaluation des programmes bien typés avance correctement.

Le théorème de la préservation affirme que si un programme est bien typé et qu'une opération de réduction (ou d'évaluation) est appliquée à ce programme, le résultat de cette opération est également bien typé. Formellement, si une expression $t$ a un type $T$ (c'est-à-dire $t : T$) et que $t$ se réduit à $t$ (noté $t --> t'$), alors $t'$ doit aussi avoir le type $T$ (c'est-à-dire $t' : T$). Ce théorème garantit que les opérations de réduction ne violent pas les contraintes de typage.

La preuve de toutes les expressions du langage serait longue et redondante, surtout lorsque les expressions sur les tableaux multidimensionnels sont plus intéressante à prouver. C'est pourquoi nous nous intéresserons seulement au cas du type primitif booléen et de toutes les expressions qui y sont reliées (ce qui inclut les expressions sur les tableaux multidimensionnels).

Nous allons commencer par prouver la préservation du langage pour les éléments les plus simples. 

#Theorem()[Théorème de la préservation

*Si* $Phi, Gamma tack.r t : T$ *et* $t --> t'$, *alors* $Phi, Gamma tack.r t':T$
]

Pour les valeurs comme true, false, les nombres, les tableaux, les fonctions ou les variables, la preuve est triviale. Étant donné que ce sont des valeurs, ce sont déjà des état terminaux. Par définition, les terminaux ne peuvent être dérivées vers des nouveaux termes. Donc leur type est en quelque sorte "conservé".

=== Preuve: expression if 

On va commencer avec l'expression *if*:

$ "if" "E1" "then" "E2" "else" "E3" $

La règle de typage dit:

#rules.T_IF

Les règles d'évaluations correspondantes sont:

#rules.IF_T
#rules.IF_F
#rules.IF_START

En admettant que l'expression est de type T. On a 3 cas de figure:

==== Cas 1: E1 = true

On a alors l'expression:

$ "if" "true" "then" "E2" "else" "E3" $

IF-T est la seule règle applicable. On a alors:

$ "E2" $

Étant donné que `E2: T` on peut déduire que le type a été préservé. 

==== Cas 2: E1 = false

C'est le même principe que pour le premier cas. On a alors l'expression:

$ "if" "false" "then" "E2" "else" "E3" $

En appliquant la règle IF-T, on a alors:

$ "E3" $

Étant donné que `E3: T` on peut déduire que le type a été préservé. 

==== Cas 3: E1

On a donc l'expression:

$ "if" "E1" "then" "E2" "else" "E3" $

En appliquant la règle IF, on obtient:


$ "if" "V1" "then" "E2" "else" "E3" $

Si la transition $"E1" arrow.r.long "V1"$ respect la propriété de progression alors l'expression la respecte aussi.

=== Preuve: expression let

On va vérifier l'expression *let*. 

$ "let" "x" : "T" = "E1" "in" "E2" $

La règle de typage dit:

#rules.T_LET

Les règles d'évaluations sont:

#rules.LET
#rules.LET_FINAL

Nous avons 3 cas:

==== Cas 1: E1 -> V1

En apliquant l'expression LET, on obtient cette expression:

$ "let" x: "T1" = "V1" "in" "E2" $

Par déduction `V1 : T1` donc l'expression respecte la règle de préservation.

==== Cas 2: E2 -> V2

En apliquant l'expression LET-FINAL, on obtient cette expression:

$ "let" x: "T1" = "V1" "in" "E2" $

Par déduction `V1 : T1` donc l'expression respecte la règle de préservation.


=== Preuve: expression array

Voyons les expression sur les tableaux (array):

$ lang.array("E1") $

Sa règle de typage correspondate est:

#rules.T_ARR

Sa règle d'évaluation est:

#rules.ARR

En l'appliquant à l'expression, nous obtenons:

$ lang.array("V1") $ 

Si chaque expression du tableau respectent la règle de progression, alors une expression tableau la respecte aussi.

=== Preuve: expression concat

Une expression de concatenation typique ressemble à ça:

$ lang.array("E1") :: lang.array("E2") $

Sa règle de typage correspondate est:

#rules.T_CONC

Ses règles d'évaluations sont:

#rules.CONC_L
#rules.CONC_R
#rules.CONC

En appliquant la règle T-CONC-L on obtient:

$ [overline("V1")] :: [overline("E2")] $

Selon la preuve précédente sur les array, l'expression marche toujours. Lorsque nous appliquons la règle T-CONC-R, on obtient:


$ [overline("V1")] :: [overline("V2")] $

Ici encore, on reste avec un typage valide du coup on peut appliquer la règle T-CONC pour obtenir une valeur:

$ [overline("V1"), overline("V2")] $

Ici encore, l'expression a conservé son type et est considérée comme une valeur à part entière.

=== Preuve: expression first

Une expression typique ressemble à ça: 

$ "first"("E1", overline("E2")) $

Sa règle de typage ressemble à ça:

#rules.T_FIRST_ARR

Ses règles d'évaluations sont:

#rules.FIRST_ARR_L
#rules.FIRST_ARR_R
#rules.FIRST_ARR

Comme l'expression n'est pas une valeur, on peut la faire progresser avec la règle FIRST-ARR-L, ce qui nous donne:

$ "first"(["V1", overline("E2")]) $

De façon similaire, on peut toujours faire progresser l'expression qui n'est pas encore une valeur à l'aide de la règle FIRST-ARR-R, on a cette expression:

$ "first"(["V1", overline("E2")]) $


Par définition, les opérations peuvent toujours progresser grâce à leur définitions analogue respective. C'est aussi pareil pour les opération *first_arr* et *rest_arr* qui ont les règles FIRST-ARR et REST-ARR.


---

Le théorème de la progression stipule que si une expression est bien typée, alors cette expression est soit une valeur (c'est-à-dire qu'elle est entièrement évaluée et ne peut plus être réduite), soit il existe une autre expression à laquelle elle peut se réduire (c'est-à-dire qu'il existe une étape de réduction possible). Formellement, si un term $t$ est bien typée (c'est-à-dire $t : T$), alors $t$ est soit une valeur, soit il existe un term $t'$ telle que $t --> t'$. Ce théorème garantit qu'un programme bien typé ne se bloquera pas de manière inattendue (c'est-à-dire qu'il continuera de progresser jusqu'à être entièrement évalué).


#Theorem()[Théorème de la progression

*Si* $Phi, Gamma tack.r t : T$, *alors* $t in "Valeurs"$ *ou* $exists t', t --> t'$
]
