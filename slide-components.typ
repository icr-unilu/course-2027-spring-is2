// Shared visual components for theory decks.
#let lead(body) = text(fill: rgb("#eb811b"), weight: "bold", body)
#let caption(body) = align(center, text(size: 0.6em, fill: rgb("#53666a"), body))
#let pair(left, right) = grid(columns: (1fr, 1fr), gutter: 1cm, align: top, left, right)
#let card(title, body) = block(width: 100%, inset: 12pt, radius: 6pt, fill: rgb("#edf3f4"))[
  #lead(title)
  #v(0.3em)
  #body
]
#let code(body) = block(width: 100%, inset: 12pt, radius: 5pt, fill: rgb("#edf3f4"))[
  #set text(size: 0.9em)
  #body
]
