#import "@preview/curryst:0.3.0": rule, proof-tree
#import "@preview/ctheorems:1.1.2": *
#set par(first-line-indent: 2em)
#import "@preview/indenta:0.0.3": fix-indent
#show: fix-indent()


#show: thmrules

#let Definition = thmbox(
  "definition",
  "Definition",
  base_level: 1, 
  stroke: rgb("#e94845") + 1pt
)

#let Exemple = thmbox(
  "exemple",
  "Exemple",
  base_level: 1, 
  stroke: rgb("#e94845") + 1pt
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

