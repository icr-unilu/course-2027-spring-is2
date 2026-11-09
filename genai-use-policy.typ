#import "@preview/touying:0.7.4": *
#import themes.metropolis: *
#import "@preview/board-n-pieces:0.9.0": *
#import "@preview/fontawesome:0.6.2": *
#import "@preview/ctheorems:1.1.3": *
#import "@preview/numbly:0.1.0": numbly
#import "utils.typ": *

// Separate deck explaining the course policy for generative artificial intelligence.
// Timetable, rooms and project deadlines will be announced on Moodle.
#let pdfpc-config = pdfpc.config(
  duration-minutes: 25,
  last-minutes: 5,
  note-font-size: 12,
  disable-markdown: false,
)

#show: metropolis-theme.with(
  aspect-ratio: "16-9",
  footer: self => self.info.institution,
  config-common(
    preamble: pdfpc-config,
    show-bibliography-as-footnote: bibliography(title: none, "bibliography.bib"),
  ),
  config-info(
    title: [Intelligent Systems 2],
    subtitle: [Using generative artificial intelligence responsibly],
    author: author_list(
      (
        (first_author("Matteo Magnini"), "matteo.magnini@uni.lu"),
        ("Souvick Das", "souvick.das@uni.lu"),
      ),
      logo: "images/logo_unilu_fr.svg",
      width: 20%,
    ),
    date: datetime(year: 2027, month: 2, day: 1).display("[day] [month repr:long] [year]"),
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

== Scope of this policy

*You remain responsible for your submission*

Generative artificial intelligence (GenAI) may assist your project work.

This policy covers its use in:
- code, experiments and analysis;
- reading, writing and references;
- figures, tables and presentation material.


== Cognitive locus

*Critical thinking*

The _cognitive locus_ is the person (or software) who directs the work and makes the intellectual decisions#cite(label("shaw2026thinking")).

You must retain control over:
- the question, objectives and specifications;
- design choices and experimental methodology;
- verification of code, claims and sources;
- interpretation of results and final conclusions.

#v(0.5em)
You must be able to explain and defend what you submit.\
If you do not know what you did you just _autopiloted_!


== No autopilot and cognitive surrender

*Autopilot:* accepting and submitting outputs without understanding and checking.

*Cognitive surrender:* handing intellectual judgement over to the tool.

Examples:
- accepting an architecture because the assistant recommends it;
- keeping generated code that you cannot explain or test;
- copying a conclusion because it sounds convincing;
- treating the model's confidence as evidence of correctness.


== A responsible working process

* Specify, inspect and verify before accepting an output *

#enum(
  [_Specify:_ write the goal, constraints and expected behaviour.],
  [_Request assistance:_ ask for a bounded contribution.],
  [_Inspect:_ understand the output and identify assumptions.],
  [_Verify:_ test the implementation or check the original evidence.],
  [_Decide and disclose:_ accept, revise or reject the output, and document the use.],
)

#v(0.4em)
Further model responses can help with checking, but verification also requires tests, data or original sources.


== A GenAI disclosure is mandatory

*Elicit the tools and what you used them for*

Include a clearly labelled _GenAI use disclosure_ in the project report.

For every tool used, state:
- _which tool:_ name and model or version, when available;
- _for what:_ the specific task it supported;
- _where:_ the affected code, report sections or other material;
- _how you checked it:_ the verification you actually performed.

#v(0.4em)
If you used no GenAI assistance, state this explicitly. \
A disclosure does not make an otherwise improper use acceptable.


== Example of a useful disclosure

*Illustrative example (adapt it to your actual use).*

#text(size: 18pt)[
    We used ChatGPT to draft a plotting script from specifications we wrote.\
    The affected file is `scripts/plot_results.py`.

    We inspected the data selection and aggregation,
    checked the summary values against the experiment output,
    and ran the script on the saved results.

    We also used the tool to turn our own bullet points into prose in Section 3.\
    We reviewed every sentence and checked that it introduced no new claims.
]

== Appropriate use (Part I)

*Code generation*

- Example request:
  write a Python function that reads these experiment files,
  groups results by controller and seed,
  and computes the specified summary statistics.
  Reject missing columns and include tests for the supplied examples.

- Your work continues after generation:
    - Inspect the algorithm, assumptions and dependencies.
    - Test normal cases, edge cases and invalid inputs.
    - Revise the implementation and explain the final choices.


== Appropriate use (Part II)

*Text summarisation and rewriting*

A model may help you obtain an initial summary of a text you provide:
- compare the summary with the original passage;
- check omissions, qualifications and technical terminology;
- read the relevant original material before relying on its claims;
- cite the original source for the claims it supports.

#v(0.6em)
A generated summary is a reading aid. Your use of the source must reflect what you verified in the original.

== Appropriate use (Part III)

*Prose from your own notes*

You may ask a tool to turn an outline or bullet list into readable prose:
- provide the points, evidence and intended structure;
- check that the prose preserves your meaning;
- remove invented details, results and references;
- make sure you can defend every statement.

#v(0.5em)
Disclose the writing assistance and identify the affected sections.


== Appropriate use (Part IV)

*Finding precise references*

#grid(
    columns: 2,
    gutter: 2cm,
    [
        A model may suggest a source for a specific question or claim:

        - locate the real publication and check its bibliographic details;

        - read the relevant section, figure, table, or result;

        - confirm that it supports the particular claim you make;

        - cite the verified source and remove unsupported suggestions.
    ],
    [
        It is always preferable to:
        - perform a literature search yourself;
        - tell the model to search using a specific online website;
        - a plausible title or a working link is not enough to establish support;
        - click on the link and be sure it leads to the right content;
        - check these additional sources:
            - #fa-icon("graduation-cap")
                  #link("https://scholar.google.com")[
                    Google Scholar
                  ]
            - #fa-icon("database")
              #link("https://dblp.org")[
                DBLP
              ]
    ],
)


== Improper use (Part I)

*Unverified output*

These practices are unacceptable:
- copying a generated bibliography without checking it;
- copying code that you cannot explain or test;
- accepting a conclusion without verifying the underlying evidence;
- using a model to generate files that are generable in a deterministic way from your own data and/or code:
    - data figures: data files and plotting code;
    - results tables: data files and aggregation code;
    - slides: editable source, such as Typst, LaTeX or HTML;
    - diagrams: a source description, such as _PlantUML_ or _Mermaid_.

== Improper use (Part II)

*Exemples*
- Ask a model to draw the results chart as an image and submit it as the representation of your data.
    - The image replaces the computation and plotting procedure.
- Ask for finished slide images or a presentation file as a substitute for the code that generates the slides.
    - Submit the output without reviewing its claims and sources.


== A language model inside your project

*Document assistance and experimental methods*

Distinguish _GenAI assistance used to produce the work_ from _a model used by the system you investigate_.

- Disclose development and writing assistance in the report.
- Describe the system's model, inputs and configuration in the methods.
- Record execution traces and outputs needed for evaluation.
- Check how model errors affect the whole system.

#v(0.5em)
Both uses require human oversight.\
A disclosure cannot replace an experimental method description.
