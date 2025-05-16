#import "../src/theorem.typ": *
#import "../src/rules.typ"
#import "@preview/simplebnf:0.1.1": bnf, Prod, Or
#import "@preview/curryst:0.5.1": prooftree

== Sémantique des langages

Établir une sémantique claire et précise pour un langage de programmation prototype revêt une importance capitale lorsqu'il s'agit de tester des hypothèses fondamentales sur sa conception. La sémantique d'un langage définit le sens exact et le comportement des constructions syntaxiques utilisées, ce qui est essentiel pour assurer la prédictibilité et la fiabilité du langage. En définissant rigoureusement la sémantique, les concepteurs peuvent garantir que chaque expression et chaque instruction est interprétée de manière cohérente par le système, minimisant ainsi les ambiguïtés et facilitant la compréhension par les programmeurs.

Une sémantique bien établie facilite également la vérification formelle du langage, permettant de valider sa correction avant même sa mise en œuvre complète. Cela inclut la capacité à utiliser des techniques telles que la vérification de type, la preuve de programme et les tests automatisés pour identifier et corriger les erreurs potentielles dans la conception du langage. De plus, une sémantique claire aide les développeurs à expérimenter rapidement avec de nouvelles idées et variations de conception. Ils peuvent ainsi évaluer différentes approches pour la syntaxe, les règles de portée, la gestion de la mémoire et d'autres aspects essentiels du langage, tout en évaluant leur impact sur la facilité d'utilisation et les performances du langage.

=== Le lambda calcul

Le lambda calcul est un formalisme mathématique développé par Alonzo Church dans les années 1930 pour étudier les fonctions, les variables, et les applications de fonctions de manière abstraite. Il est souvent considéré comme l'un des fondements théoriques de l'informatique et des langages de programmation. 

Le lambda calcul est particulièrement important car il fournit un modèle minimaliste et élégant pour la computation, où toutes les opérations peuvent être réduites à l'application de fonctions à des arguments. Il se compose de trois éléments de base : les variables, les abstractions (qui définissent des fonctions), et les applications (qui appliquent des fonctions à des arguments). Malgré sa simplicité, le lambda calcul est Turing-complet, ce qui signifie qu'il peut exprimer toute computation réalisable par une machine de Turing.

#Definition[Synaxe du lambda calcul
$ #bnf(
  Prod(
    $e$,
    annot: $sans("Expr")$,
    {
      Or[$x$][_variable_]
      Or[$λ x. e$][_abstraction_]
      Or[$e$ $e$][_application_]
    },
  ),
  Prod(
    $v$,
    annot: "values",
    {
      Or[$λ x. e$][_abstraction value_]
    }
  ),    
) $,
]

#Definition[Évaluation du lambda calcul
$ #prooftree(rules.evaluate("E-APP1", $t_1 t_2 --> t_1^' t_2$, $t_1 --> t_1^'$)) $ 
$ #prooftree(rules.evaluate("E-APP2", $v_1 t_2 --> v_1 t_2^'$, $t_2 --> t_2^'$)) $ 
$ #prooftree(rules.evaluate("E-APPABS", $(lambda x . t_12) v_2 --> [x\/v_2] t_12$)) $ 
]

Le lambda calcul est un modèle de computation universel. Le lambda calcul fournit un cadre théorique qui peut simuler n'importe quel autre modèle de computation. Cela en fait un outil puissant pour comprendre les propriétés fondamentales des langages de programmation et pour prouver des théorèmes sur la computation.

Le lambda calcul est aussi une base pour les langages fonctionnels. C'est un avantage comme R, notre langage cible, est une langage de programmation orienté vers le fonctionnel. De nombreux langages de programmation modernes, tels que Haskell, Lisp, et même certaines parties de Python, sont fortement influencés par les concepts du lambda calcul. Il sert de base à la programmation fonctionnelle, un paradigme qui traite les fonctions comme des citoyens de première classe et favorise des concepts comme l'immuabilité et les expressions pures.

Le lambda calcul servira de première pierre à notre langage prototype.

#pagebreak()
