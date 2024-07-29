#import "../src/module.typ": *

= Sûrtée du langage

La "soundness" (ou sûreté) d'un système de types d'un langage de programmation est une propriété fondamentale qui garantit que le typage statique est fiable. En d'autres termes, un programme typé de manière statique ne produira pas d'erreurs de type lors de son exécution. Cette propriété assure que les programmes qui passent la vérification de types (c'est-à-dire qui sont considérés comme bien typés par le compilateur) ne rencontreront pas d'erreurs de type au moment de l'exécution, évitant ainsi un certain nombre de bogues et de comportements imprévisibles.

Pour prouver la soundness d'un système de types, deux théorèmes principaux sont généralement démontrés :

En combinant ces deux théorèmes, on peut démontrer que les programmes bien typés dans le système de types donné ne produiront pas d'erreurs de typage au moment de l'exécution, assurant ainsi la soundness du système de types. La préservation garantit que les types sont maintenus tout au long de l'évaluation, tandis que la progression assure que l'évaluation des programmes bien typés avance correctement.

Le théorème de la progression stipule que si une expression est bien typée, alors cette expression est soit une valeur (c'est-à-dire qu'elle est entièrement évaluée et ne peut plus être réduite), soit il existe une autre expression à laquelle elle peut se réduire (c'est-à-dire qu'il existe une étape de réduction possible). Formellement, si un term $t$ est bien typée (c'est-à-dire $t : T$), alors $t$ est soit une valeur, soit il existe un term $t'$ telle que $t --> t'$. Ce théorème garantit qu'un programme bien typé ne se bloquera pas de manière inattendue (c'est-à-dire qu'il continuera de progresser jusqu'à être entièrement évalué).

#Theorem()[Théorème de la progression

*Si* $Phi, Gamma tack.r t : T$, *alors* $t in "Valeurs"$ *ou* $exists t', t --> t'$
]

Le théorème de la préservation affirme que si un programme est bien typé et qu'une opération de réduction (ou d'évaluation) est appliquée à ce programme, le résultat de cette opération est également bien typé. Formellement, si une expression $t$ a un type $T$ (c'est-à-dire $t : T$) et que $t$ se réduit à $t$ (noté $t --> t'$), alors $t'$ doit aussi avoir le type $T$ (c'est-à-dire $t' : T$). Ce théorème garantit que les opérations de réduction ne violent pas les contraintes de typage.

#Theorem()[Théorème de la préservation

*Si* $Phi, Gamma tack.r t : T$ *et* $t --> t'$, *alors* $Phi, Gamma tack.r t':T$
]
