#import "@preview/curryst:0.5.1": rule, prooftree

#let type_context(body, ..entrees) = {
  let entries = entrees.pos().join(", ")
  $ Phi, Gamma entries tack.r body $
}

#let evaluate(name, conclusion, ..premices) = {
    rule(
        name: name,
        conclusion,
        ..premices
    )
}

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

#let t_context(kind: "", type: "") = $Phi #kind \; Gamma #type tack.r$


