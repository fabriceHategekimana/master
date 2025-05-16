#import "../src/theorem.typ": *
#import "../src/rules.typ"
#import "../src/lang.typ"

= Preuve de sûrtée du langage

La "soundness" (ou sûreté) d'un système de types d'un langage de programmation est une propriété fondamentale qui garantit que le typage statique est fiable. En d'autres termes, un programme typé de manière statique ne produira pas d'erreurs de type lors de son exécution, soit en acceptant des valeurs dont le type n'est pas accepté à l'exécution du code soit en refusant des types normalement accepté à l'exécution du code. Cette propriété assure que les programmes qui passent la vérification de types (c'est-à-dire qui sont considérés comme bien typés par le compilateur) ne rencontreront pas d'erreurs de type au moment de l'exécution, évitant ainsi un certain nombre de bogues et de comportements imprévisibles.

Pour prouver la soundness d'un système de types, deux théorèmes principaux sont généralement démontrés :

En combinant ces deux théorèmes, on peut démontrer que les programmes bien typés dans le système de types donné ne produiront pas d'erreurs de typage au moment de l'exécution, assurant ainsi la soundness du système de types. La préservation garantit que les types sont maintenus tout au long de l'évaluation, tandis que la progression assure que l'évaluation des programmes bien typés avance correctement.

Le théorème de la préservation affirme que si un programme est bien typé et qu'une opération de réduction (ou d'évaluation) est appliquée à ce programme, le résultat de cette opération est également bien typé. Formellement, si une expression $t$ a un type $T$ (c'est-à-dire $t : T$) et que $t$ se réduit à $t$ (noté $t --> t'$), alors $t'$ doit aussi avoir le type $T$ (c'est-à-dire $t' : T$). Ce théorème garantit que les opérations de réduction ne violent pas les contraintes de typage.

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

À partir d'une expression if quelconque, nous avons 2 directions possibles: On peut appliquer les deux règles IF-T et IF-F. Étant donné que E2 et E3 sont du même type *T*, la progression est respectée.


=== Preuve: expression let

On va vérifier l'expression *let*. 

$ "let" "x" : "T" = "E1" "in" "E2" $

La règle de typage dit:

#rules.T_LET

On a deux règles possibles de dérivation: LET et LET-FINAL. Dans le cas où la dérivation de E1 à E1' respecte le typage, la règle LET est respectée. Dans le cas de la règle LET-FINAL, la condition est respecté si la substitution ne casse pas E2.

=== Preuve: expression array

Voyons les expression sur les tableaux (array):

$ lang.array("E1") $

Sa règle de typage correspondate est:

#rules.T_ARR


Nous pouvons appliquer la règle ARR:

#rules.ARR

Ce qui nous donne:

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

// page 353

#Theorem()[Théorème de la progression

*Si* $Phi, Gamma tack.r t : T$, *alors* $t in "Valeurs"$ *ou* $exists t', t --> t'$
]
