#import "@preview/ctheorems:1.1.3": *

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

#let Theorem = thmbox(
  "theorem",
  "Theorem",
  base_level: 1, 
  stroke: rgb("#e94845") + 1pt
)

#let Proof = thmproof("proof", "Proof")
