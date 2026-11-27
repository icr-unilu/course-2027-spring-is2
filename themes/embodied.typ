#import "@preview/touying:0.7.4": *
#import themes.metropolis: *
#import "../utils.typ": author_list, first_author

#let embodied-theme(subtitle, body, duration: 90) = {
  show: metropolis-theme.with(
    aspect-ratio: "16-9",
    footer: self => self.info.institution,
    config-common(
      preamble: pdfpc.config(duration-minutes: duration, last-minutes: 5),
      show-bibliography-as-footnote: bibliography(title: none, "../bibliography.bib"),
    ),
    config-info(
      title: [Intelligent Systems 2],
      subtitle: subtitle,
      author: author_list((
        (first_author("Matteo Magnini"), "matteo.magnini@uni.lu"),
        ("Souvick Das", "souvick.das@uni.lu"),
      ), logo: "images/logo_unilu_fr.svg", width: 20%),
      date: [Summer Semester 2026/2027],
      institution: [University of Luxembourg],
      logo: context {
        if utils.slide-counter.get().first() > 1 {
          align(right, image("../images/logo_unilu_short.svg", height: 1cm))
        }
      },
    ),
  )
  set text(font: "Fira Sans", weight: "light", size: 20pt)
  set par(leading: 0.65em)
  show footnote.entry: set text(size: 0.65em)
  body
}

#let lesson-table(columns, ..cells) = {
  set text(size: 0.86em)
  table(
    columns: columns,
    align: (x, _) => if x == 0 { left } else { center },
    inset: (x: 9pt, y: 7pt),
    fill: (_, y) => if y == 0 { rgb("#edf3f4") } else { none },
    stroke: (x: none, y: 0.7pt + rgb("#d1dcde")),
    ..cells,
  )
}
