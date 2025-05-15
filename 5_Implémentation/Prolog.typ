#import "@preview/simplebnf:0.1.0": *
#import "../src/module.typ": *

#pagebreak()

= Implémentation

Dans le cadre de ce projet j'ai construit le prototype d'un interpréteur en Prolog pour appliquer et vérifier la faisabilité du langage construit jusqu'à présent. Le premier but est de traduire la syntaxe de base de notre langage prototype en son équivalent prolog et implémenter les règles d'évaluation et de typage.

Voici la version "Prolog" du langage:

#Definition()[Traduction des expressions en syntaxe prolog
#bnf(
  Prod(
    $E$,
    annot: $sans("Expression")$,
    {
      Or[$"let"("var"(x),"E1","E2")$][*let*]
      Or[$"func"(overline("gen"("a")), overline(["x","T"]), "T", "E")$][*func*]
      Or[$"if"("E1", "E2", "E3")$][*if*]
      Or[$"op"$][*bop*]
      Or[$"app"("E1", overline( "a"), overline( "E"))$][*func_app*]
      Or[$"first"("E") $][*first_arr*]
      Or[$"rest"("E") $][*rest_arr*]
      Or[$V$][*V value*]
    },
  ),
  Prod(
    $V$,
    annot: "Value",
    {
      Or[$"n" in "N"$][*number*]
      Or[$"v_true"$][*true*]
      Or[$"v_false"$][*false*]
      Or[$"v_array"(overline("E"))$][*array*]
    },
  ),
  Prod(
    $T$,
    annot: "Type",
    {
      Or[$"t_func"(overline( "T"), "T")$][*function_type*]
      Or[$"t_array"("n", "T")$][*array_type*]
      Or[$"t_int"$][*int*]
      Or[$"t_bool"$][*bool*]
    }
  ),
  Prod(
    $op$,
    annot: "bop",
    {
      Or[$"and(E1, E2)"$][*and*]
      Or[$"or(E1,E2)"$][*or*]
      Or[$"plus(E1,E2")$][*plus*]
      Or[$"time(E1,E2")$][*time*]
      Or[$"append"("E1", "E2")$][*concat*]
      Or[$"equal(E1,E2)"$][*equal*]
      Or[$"lower(E1,E2)"$][*lower*]
      Or[$"low_eq(E1,E2)"$][*lower or equal*]
      Or[$"greater(E1,E2)"$][*greater*]
      Or[$"gre_eq(E1, E2)"$][*greater or equal*]
    }
  ),
  Prod(
    $"ctx"$,
    annot: "context",
    {
      Or[$tack.r Gamma "ctxt" $][*valid_context*]
      Or[$"is_ctxt"("context") $][*valid_context*]
      Or[$"is_type"("type")$][*type_in_context*]
      Or[$"add"("context", "M" : sigma)$][*term_of_type_in_context*]
      Or[$"equal_ctx"(Gamma, Delta)$][*equal_contexts*]
      Or[$"equal_type_in_context"(sigma, tau)$][*equal_types_in_context*]
      Or[$"equal_terms(M, N, sigma)"$][*equal_terms_of_type_in_context*]
    }
  )
)
]

La transition est plutôt simple comme il suffit de transformer les expressions en fonction prenant un paramètre spécial par élément de la syntaxe. Pour donner une distinction, les types prennent un "t\_" au début du nom pour préciser que ce sont des types. Il faut aussi encapsuler les variable et les générique (respectivement var(x) et gen(a)) pour donner une distinction dans l'evaluation des règles. Il n'y a pas besoin de créer les règles pour les symboles true et false. 

Après cela, il a fallut créer deux règles pour la sémantique dévaluation (evaluation(Context, Term, Result)) et la sémantique de typage (typage(Context, Term, Result)).

On peut prendre par exemple la fonction d'itentité représenté avec le langage système C3PO, ainsi que sa sémantique d'évaluation et sa sémantique de typage.

#Exemple()[Application de la fonction identité dans la syntaxe de Système C3PO
```typescript
func<T>(a: T) -> T {
  a
}(7)

# va retourner 7
```
]

#Exemple()[Application de la fonction identité : sémantique d'évaluation
```prolog
evaluation([], 
     app(
            func([gen(t)], [[var(a), get(t)]], gen(t), var(a)),
            [],
            [7]
     ),
     7
).
```
]

#Exemple()[Application de la fonciton identité : sémantique de typage
```prolog
typing([],
      app(
          func([gen(t)], [[var(a), gen(t)]], gen(t), var(a)),
          [int],
          par([7])
      ),
      int
      ).
```
]

Le code prolog se trouve dans mon repository github. Les deux fichiers principaux sont `evaluation.pl` et `typage.pl`. Il existe une liste de teste dans ces deux fichiers.
