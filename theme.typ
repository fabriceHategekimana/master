
#let accent(doc) = [
  #show "préservation": set text(weight: "bold")
  #show "progression": set text(weight: "bold")
  #show regex("E\d+"): set text(weight: "semibold")
  #show regex("V\d+"): set text(weight: "semibold")
  #show regex("T\d+"): set text(weight: "semibold")
  #show regex("[A-Z\-][A-Z\-]+"): set text(weight: "semibold")

#set par(first-line-indent: 2em)
#import "@preview/indenta:0.0.3": fix-indent
#show: fix-indent()

  #doc
]

