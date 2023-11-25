#import "naturelike.typ": *
#show: naturelike.with(
  title: lorem(10),
  article_type: "Preprint",
  abstract: [
    #lorem(150)
  ],
  authors: (
    (
      name: "Carles Puigdemont",
      affiliation: ("Junts","Consell per la Republica")
    ),
    (
      name: "Oriol Junqueras",
      affiliation: ("Esquerra Republicana de Catalunya (ERC)")
    ),
    (
      name: "Jordi Turull",
      affiliation: ("Junts")
    ),
    (
      name: "Marta Rovira",
      affiliation: ("Esquerra Republicana de Catalunya (ERC)")
    ),
  ),
  bibliography-file: "refs.bib",
)

= Introduction

#lorem(300) @wagner2019

= Methods
#lorem(100)

$ a + b = gamma $

#lorem(120)

= Results

== #lorem(5)

#lorem(300)

== #lorem(7)

#lorem(300)
