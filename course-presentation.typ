#import "@preview/touying:0.6.3": *
#import themes.metropolis: *
#import "utils.typ": *
#import "@preview/fontawesome:0.6.0": *

// Course introduction, approximately 30 minutes within the first 90-minute lecture.
// Timetable, rooms and project deadlines will be announced on Moodle.
#let pdfpc-config = pdfpc.config(
  duration-minutes: 30,
  last-minutes: 5,
  note-font-size: 12,
  disable-markdown: false,
)

#show: metropolis-theme.with(
  aspect-ratio: "16-9",
  footer: self => self.info.institution,
  config-common(preamble: pdfpc-config),
  config-info(
    title: [Intelligent Systems 2],
    subtitle: [Course presentation],
    author: author_list(
      (
        (first_author("Matteo Magnini"), "matteo.magnini@uni.lu"),
        ("Souvick Das", "souvick.das@uni.lu"),
      ),
      logo: "images/logo_unilu_fr.svg",
      width: 20%,
    ),
    date: [Summer semester 2026/2027],
    institution: [University of Luxembourg],
    logo: context {
      if utils.slide-counter.get().first() > 1 {
        align(right, image("images/logo_unilu_short.svg", height: 1cm))
      }
    },
  ),
)

#set text(font: "Fira Sans", weight: "light", size: 20pt)
#set par(leading: 0.65em)
#show footnote.entry: set text(size: 0.7em)

#let lead(body) = block(
  above: 0pt,
  below: 0.5em,
  text(fill: rgb("eb811b"), weight: "bold", body),
)

#title-slide()

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

*Theory and practice throughout the semester*

- *Theory lectures:* 14 sessions of 90 minutes with Matteo Magnini.
- *Practical lectures:* 14 sessions of 90 minutes with Souvick Das.
- *Weekly organisation:* normally one lecture and one practical session. The opening sessions may place greater emphasis on foundations.
- *Timetable and rooms:* to be announced on Moodle.

#v(0.5em)
21 contact hours per teacher, 42 overall. The course carries 4 credits under the European Credit Transfer and Accumulation System (ECTS).

== Course structure

#grid(columns: (1fr, 1fr), gutter: 1.4cm,
  [
    *Theory: 14 lectures*

    - *Foundations:* intelligence, agency, autonomy, representation, reasoning and planning.

    - *Embodied agents:* embodiment, control architectures, classical tasks and MAS.

    - *Advanced:* generative AI as a tool, complex systems science, neuro-symbolic systems and explainability.
  ],
  [
    *Practice: 14 tutorials*

    - *Foundations:* reproducibility, experimental design and statistical comparisons.

    - *Simulation:* individual and collective robot behaviours, controller comparisons and robustness.

    - *Advanced:* language models as tools, symbolic checks and experimental evaluation.
  ],
)

== Where to find the material

- *Moodle: official channel* \
  Timetable, rooms, announcements, exercise instructions and assessment submissions. The course link will be announced.

- *GitHub page* \
  Course overview and presentation: \
  #link("https://icr-unilu.github.io/course-2027-spring-is2")[icr-unilu.github.io/course-2027-spring-is2]

- *GitHub releases: PDF slides* \
  Published slide decks are available in the latest release: \
  #link("https://github.com/icr-unilu/course-2027-spring-is2/releases/latest")[github.com/icr-unilu/course-2027-spring-is2/releases/latest]

== Assessment

#grid(columns: (1fr, 1fr), gutter: 1.4cm,
  [
    *50%: written examination*

    Individual, *closed book*. \
    Only a _calculator_ is permitted.

    Questions cover both theory and practice aspects.
    The exam is designed to be completed in _90 minutes_.

    We assess correctness, completeness and clear reasoning.
  ],
  [
    *50%: project and written report*

    Individual or groups of *at most three*.

    Submit source code, reproduction instructions, results and a report identifying _each member's contribution_.

    We assess design, implementation, methodology, reproducibility and critical analysis.
  ],
)

== Repeating students

#grid(columns: (1fr, 1fr), gutter: 1.4cm,
  [
    *2026/2027: the reformed course*

    Students from the previous version of the course must *re-enrol and repeat the full course*:

    - New project and report: *50%*.

    - New written examination: *50%*.

    - Previous marks do not carry over.
  ],
  [
    *For 20027/2028 and future years*

    A project from the previous academic year can carry forward:
    - Sufficient project: at least 10/20, repeat only the written examination.
    - Insufficient project: repeat both assessments.

    *50% retained project + 50% new exam.*
  ],
)

== Use of generative artificial intelligence

*Transparent assistance with human intellectual responsibility*

- Include a *mandatory disclosure*: tools, purposes, and affected material.
- Retain control over specifications, design choices, verification and conclusions.
  - _No autopilot nor cognitive surrender!_
- Generate code-derived artefacts from _reproducible sources_.
- _Verify references_ against the original publications.

#v(0.5em)
The separate *GenAI use policy* deck provides detailed rules, examples and a disclosure template.
Here you can find more about the it #link("https://icr-unilu.github.io/course-2027-spring-is2/releases/latest/download/genai-use-policy.pdf")[genai-use-policy.pdf].

== Table of contents

#grid(columns: (1fr, 1fr), gutter: 1.4cm,
  [
    *Lecture material*

    -TBA
  ],
  [
    *Other material*

    - TBA
  ],
)

#v(0.5em)
Slide PDFs will appear in the repository releases as the course progresses.