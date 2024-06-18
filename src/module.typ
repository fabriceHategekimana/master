#import "@preview/curryst:0.3.0": rule, proof-tree

#let Exemple(content, caption: "") = figure(
      content, 
      caption: [#caption], 
      kind: "Exemple", 
      supplement: [*Exemple*]
    )

#let Definition(content, caption: "") = figure(
      content, 
      caption: [#caption], 
      kind: "Définition", 
      supplement: [*Définition*]
    )


#let type_context(body, ..entrees) = {
  let entries = entrees.pos().join(", ")
  $ Gamma entries tack.r body $
}

#let eval(name, conclusion, ..premices) = {
    rule(
        name: name,
        conclusion,
        ..premices
    )
}

#let t_num(exp) = rule(
    "T-NUM",
    $exp : "int"$,
    $exp in NN$
)

#let typing(name, conclusion, ..premices) = {
      rule(
          name: name,
          conclusion,
          ..premices
        )
}

#let typing_c(name, conclusion, ..premices) = {
      rule(
          name: name,
          type_context(conclusion),
          ..premices
      )
}

#let t_num(exp) = rule(
    "T-NUM",
    $exp : "int"$,
    $exp in NN$
)

#let t_true =  rule(
    name: "T-TRUE",
    type_context("true : bool")
)

#let t_false =  rule(
    name: "T-FALSE",
    type_context("false : bool")
)

