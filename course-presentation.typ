#import "@preview/touying:0.6.3": *
#import themes.metropolis: *
#import "@preview/fontawesome:0.6.0": *
#import "@preview/ctheorems:1.1.3": *
#import "@preview/numbly:0.1.0": numbly
#import "utils.typ": *

// Pdfpc configuration
// typst query --root . ./example.typ --field value --one "<pdfpc-file>" > ./example.pdfpc
#let pdfpc-config = pdfpc.config(
    duration-minutes: 30,
    start-time: datetime(hour: 14, minute: 10, second: 0),
    end-time: datetime(hour: 14, minute: 40, second: 0),
    last-minutes: 5,
    note-font-size: 12,
    disable-markdown: false,
    default-transition: (
      type: "push",
      duration-seconds: 2,
      angle: ltr,
      alignment: "vertical",
      direction: "inward",
    ),
  )

// Theorems configuration by ctheorems
#show: thmrules.with(qed-symbol: $square$)
#let theorem = thmbox("theorem", "Theorem", fill: rgb("#eeffee"))
#let corollary = thmplain(
  "corollary",
  "Corollary",
  base: "theorem",
  titlefmt: strong
)
#let definition = thmbox("definition", "Definition", inset: (x: 1.2em, top: 1em))
#let example = thmplain("example", "Example").with(numbering: none)
#let proof = thmproof("proof", "Proof")

#show: metropolis-theme.with(
  aspect-ratio: "16-9",
  footer: self => self.info.institution,
  config-common(
    // handout: true,
    preamble: pdfpc-config,
    show-bibliography-as-footnote: bibliography(title: none, "bibliography.bib"),
  ),
  config-info(
    title: [IS2],
    subtitle: [Intelligent Systems 2],
    author: author_list(
      (
        (first_author("Matteo Magnini"), "matteo.magnini@uni.lu"),
        ("Souvick Das", "souvick.das@uni.lu"),
      ),
      logo: "images/logo_unilu_fr.svg",
      width: 20%,
    ),
    date: "16 September 2026",
    institution: [University of Luxembourg],
    logo: context {
     if utils.slide-counter.get().first() > 1 [
        #align(right)[#image("images/logo_unilu_short.svg", height: 1cm)]
      ] else [
        #none
      ]
    },
  ),
)


#set text(font: "Fira Sans", weight: "light", size: 20pt)
#show math.equation: set text(font: "Fira Math")

#set raw(tab-size: 4)
#show raw: set text(size: 1em)
#show raw.where(block: true): block.with(
  fill: luma(240),
  inset: (x: 1em, y: 1em),
  radius: 0.7em,
  width: 100%,
)

#show bibliography: set text(size: 0.75em)
#show footnote.entry: set text(size: 0.75em)

// #set heading(numbering: numbly("{1}.", default: "1.1"))

#title-slide()

// == Outline <touying:hidden>

// #components.adaptive-columns(outline(title: none, indent: 1em))

= About the course

== Teachers

#grid(
  columns: 2,
  gutter: 1.5cm,

  [
    #box(
      inset: (x: 0.8em, y: 0.8em),
      radius: 0.6em,
      height: 6cm,
      [
        #align(center)[
          #image("images/matteo_magnini.jpeg", height: 100%)

          #v(0.6em)
          // Stile simile al first_author sulla title slide
          #first_author("Matteo Magnini")

          #v(0.3em)
          Postdoctoral Researcher

          #v(0.2em)
          #fa-icon("github")
          matteomagnini.github.io
        ]
      ],
    )
  ],

  [
    #box(
      inset: (x: 0.8em, y: 0.8em),
      radius: 0.6em,
      height: 6cm,
      [
        //Remove the vertical space below if the link is on one line.
        //#v(1.2em)
        #align(center)[
          #image("images/souvick_das.jpeg", height: 100%)

          #v(0.6em)
          Souvick Das

          #v(0.3em)
          Postdoctoral Researcher

          #v(0.2em)
          #fa-icon("user-graduate")
          www.uni.lu/fstm-en/people/souvick-das
        ]
      ],
    )
  ],
)

== Time schedule


== Course structure

#grid(
  columns: 2,
  gutter: 2cm,

  [
    *Part I – Main Lectures \
     (50% of the lectures)*

    - Natural and Artificial Intelligence
    - Computation in Time and Space
    - Agents
      - Autonomy
      - Reasoning
      - Embodiment
      - Navigation and Planning
    - Software Control Architectures
    - Multi‑Agent Systems
    - LLM as a Service
    - Information Theory & CSS
  ],

  [
    *Part II – Practical Lectures \
     (50% of the lectures)*

    - Simulation
    - Reproducibility
    - Exercises with ARGoS Simulator
      - Subsumption Architecture
      - Reinforcement Learning
      - for:
        - obstacle avoidance
        - phototaxis
        - path following
    - LLM empowered agents
      - LLM as a tool
      - LLM as a
  ],
)

== Where to find the material

- *Moodle (official channel)* \
  Use the university Moodle to access all course resources: \
  //#link("https://moodle.uni.lu/course/view.php?id=81")[
  //  moodle.uni.lu/course/view.php?id=81
  //]

- *GitHub page* \
  Overview of the course and additional material (this slide only): \
  #link("https://icr-unilu.github.io/course-2027-spring-is2")[
    icr-unilu.github.io/course-2027-spring-is2
  ]

- *GitHub releases (PDF slides)* \
  The PDF versions of the slides are available in the latest release: \
  #link("https://github.com/icr-unilu/course-2027-spring-is2/releases/latest")[
    github.com/icr-unilu/course-2027-spring-is2/releases/latest
  ]

== Assessment


== Table of contents

Lecture slides and materials are available in the “Latest release” of the course repository:
#link("https://github.com/icr-unilu/course-2027-spring-is2/releases/latest")[
  github.com/icr-unilu/ccourse-2027-spring-is2/releases/latest
]
