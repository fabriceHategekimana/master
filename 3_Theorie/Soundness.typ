#import "../src/module.typ": *

= Sûrtée du langage

La "soundness" (ou sûreté) d'un système de types d'un langage de programmation est une propriété fondamentale qui garantit que le typage statique est fiable. En d'autres termes, un programme typé de manière statique ne produira pas d'erreurs de type lors de son exécution. Cette propriété assure que les programmes qui passent la vérification de types (c'est-à-dire qui sont considérés comme bien typés par le compilateur) ne rencontreront pas d'erreurs de type au moment de l'exécution, évitant ainsi un certain nombre de bogues et de comportements imprévisibles.

Pour prouver la soundness d'un système de types, deux théorèmes principaux sont généralement démontrés :

En combinant ces deux théorèmes, on peut démontrer que les programmes bien typés dans le système de types donné ne produiront pas d'erreurs de typage au moment de l'exécution, assurant ainsi la soundness du système de types. La préservation garantit que les types sont maintenus tout au long de l'évaluation, tandis que la progression assure que l'évaluation des programmes bien typés avance correctement.

Le théorème de la progression stipule que si une expression est bien typée, alors cette expression est soit une valeur (c'est-à-dire qu'elle est entièrement évaluée et ne peut plus être réduite), soit il existe une autre expression à laquelle elle peut se réduire (c'est-à-dire qu'il existe une étape de réduction possible). Formellement, si un term $t$ est bien typée (c'est-à-dire $t : T$), alors $t$ est soit une valeur, soit il existe un term $t'$ telle que $t --> t'$. Ce théorème garantit qu'un programme bien typé ne se bloquera pas de manière inattendue (c'est-à-dire qu'il continuera de progresser jusqu'à être entièrement évalué).

// page 353

#Theorem()[Théorème de la progression

*Si* $Phi, Gamma tack.r t : T$, *alors* $t in "Valeurs"$ *ou* $exists t', t --> t'$
]

Le théorème de la préservation affirme que si un programme est bien typé et qu'une opération de réduction (ou d'évaluation) est appliquée à ce programme, le résultat de cette opération est également bien typé. Formellement, si une expression $t$ a un type $T$ (c'est-à-dire $t : T$) et que $t$ se réduit à $t$ (noté $t --> t'$), alors $t'$ doit aussi avoir le type $T$ (c'est-à-dire $t' : T$). Ce théorème garantit que les opérations de réduction ne violent pas les contraintes de typage.

Nous allons commencer la progression pour les éléments les plus simples du langage. Pour les valeurs comme true, false, les nombres, les tableaux, les déclaration de fonction ou les variables, la preuve est triviale. Étant donné que ce sont des valeurs, ce sont déjà des état terminaux.

On va commencer avec l'expression *if*:

$ "if" "E1" "then" "E2" "else" "E3" $

La règle de typage dit:

#T_IF

À partir d'une expression if quelconque, nous avons 2 directions possibles: On peut appliquer les deux règles *IF-T* et *IF-F*. Étant donné que *E2* et *E3* sont du même type *T*, la progression est respectée.


On va vérifier l'expression *let*. 

$ "let" "x" : "T" = "E1" "in" "E2" $

La règle de typage dit:

#T_LET

On a deux possible règles de dérivation: *LET* et *LET-FINAL*. Dans le cas où la dérivation de *E1* à *E1'* respect le typage, la règle *LET* est respectée. Dans le cas de la règle *LET-FINAL*, la condition est respecté si la substitution ne casse pas *E2*.

Voyons les expression sur les tableaux (array):

#CONC
#FIRST_ARR
#REST_ARR

Leur règles de typage correspondantes sont:

#T_CONC
#T_FIRST_ARR
#T_REST_ARR

Par définition, les opérations peuvent toujours progresser grâce à leur définitions analogue respective. C'est aussi pareil pour les opération *first_arr* et *rest_arr* qui ont les règles *FIRST-ARR* et *REST-ARR*.

La progression d'une application de fonction est plus spéciale. L'unique règle *FUNC-APP* exige que l'expression E1 soit une fonction. À partir de là, le raisonnement est le même que pour l'expression *let* avec la substitution de plus d'une variable.


---

#Theorem()[Théorème de la préservation

*Si* $Phi, Gamma tack.r t : T$ *et* $t --> t'$, *alors* $Phi, Gamma tack.r t':T$
]

Par définition, les valeurs ne peuvent être dérivées vers des nouveaux termes. Donc leur type est en quelque sorte "conservé".

Nous allons regarder la preuve pour le terme "T-IF":

#T_IF

Expression T-IF:
- t = if t_1 then t_2 else t_3

Contraintes T-IF:
- t_1 : bool
- t_2 : T
- t_3 : T

Les expression t_2 et t_3 sont supposé être du même type. Ce qui nous intéresse est le term t_1. Par induction, t_1 est soit une valeur ou il existe un terme t_1' où t_1 -> t_1':

Expression t_1:
  - t_1 is true => t_2 : T
  - t_1 is false => t_3 : T 
  - t_1 -> t_1' => if t_1' then t_2 else t_3 : T

On voit donc que l'évaluation finit sur une valeur ou peut toujours progresser si t_2 et t_3 sont des expressions valides. On va maintenant se concentrer sur les opérations classiques. On les regroupe par leur type pour faire les choses plus simplement. Donc l'opérateur "and" va être le représentant de "or" et l'opérateur "+" va être le représentant des opérations "<", ">", "<=", ">=". Il ne reste plus que les opérateurs "==" et "::". Commençons par la règle de l'opérateur "and".

#T_AND

Expression T-AND:
- t = t_1 and t_2

Contraintes:
- t_1 : bool  
- t_2 : bool

Case t_1:
  - t_1 is v $in$ [true; false] => v and t_2 : bool
  - t_1 -> t_1' => t_1' and t_2 : bool

Case t_2:
  - t_2 is v $in$ [true; false] => t_1 and v : bool
  - t_2 -> t_2' => t_1 and t_2' : bool

On voit donc que t_1 et t_2 peuvent toujours être des valeurs ou progresser vers d'autres valeurs.

#T_PLUS

Expression T-PLUS:
- t = t_1 + t_2

Contraintes:
- t_1 : int  
- t_2 : bool

Case t_1:
  - t_1 is v $in$ [true; false] => v and t_2 : bool
  - t_1 -> t_1' => t_1' and t_2 : bool

Case t_2:
  - t_2 is v $in$ [true; false] => t_1 and v : bool
  - t_2 -> t_2' => t_1 and t_2' : bool

#T_EQ

Expression T-EQ:
- t = t_1 == t_2

Contraintes:
- t_1 : T
- t_2 : T

Case t_1:
  - t_1 is v $in$ Values => v == t_2 : bool
  - t_1 -> t_1' => t_1' == t_2 : bool

Case t_2:
  - t_2 is v $in$ Values => t_1 == v : bool
  - t_2 -> t_2' => t_1 == t_2' : bool


#T_CONC

// todo

Expression T_CONC:
- t = t_1 :: t_2

Contraintes:
- t_1 : [N, T]
- t_2 : T

Case t_1:
  - t_1 is v $in$ [N, T] => v :: t_2 : [N+1, T]
  - t_1 -> t_1' => t_1' :: t_2 : bool

Case t_2:
  - t_2 is v $in$ Values => t_1 :: v : [N, T]
  - t_2 -> t_2' => t_1 :: t_2' : [N, T]


#T_FIRST_ARR

Expression T_FIRST:
- t = first(t_1)

Contraintes:
- t_1 : [N, T]

Case t_1:
  - t_1 is v $in$ [N, T] => first(v) : T
  - t_1 -> t_1' => first(t_1') : T


#T_REST_ARR

Expression T_REST:
- t = rest(t_1)

Contraintes:
- t_1 : [N+1, T]

Case t_1:
  - t_1 is v $in$ [N+1, T] => rest(v) : [N, T]
  - t_1 -> t_1' => rest(t_1') : [N, T] 


#T_LET

Expression T_LET:
- t = let x: T = t_1 in t_2
 
Contraintes:
- t_1 : T
- t_2 : U

Case t_1:
  - t_1 is v $in$ T => let x: T = v in t_2 : U
  - t_1 -> t_1' $in$ T => let x: T = t_1 in t_2 : U

Case t_2:
  - t_2 is v $in$ T => let x: T = t_1 in v : U
  - t_1 -> t_1' $in$ T => let x: T = t_1 in t_2 : U


#T_FUNC_APP

Expression T_FUNC_APP
- t = (t_0)<k>(t_1,..., t_n)

Contraintes:
- t_0: func <k>(T1,...,Tn) -> U
- t_1: T1
- ...
- t_n: Tn

Case t_0:
  - t_0 is v $in$ func <k>(T1,...,Tn) -> U => v<k>(t_1,...,t_n) 
  - t_0 -> t_0' => t_0<k>(t_1,...,t_n) 


