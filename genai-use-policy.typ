#import "@preview/touying:0.6.3": *
#import themes.metropolis: *
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
  config-common(preamble: pdfpc-config),
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

== Scope of this policy

*You remain responsible for your submission*

Generative artificial intelligence (GenAI) may assist your project work.

This policy covers its use in:
- code, experiments and analysis;
- reading, writing and references;
- figures, tables and presentation material.


== Cognitive locus

*Critical thinking*

The _cognitive locus_ is the person (or software) who directs the work and makes the intellectual decisions.

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


== Improper use: unverified references

#lead[A plausible citation is not verified evidence]

These practices are unacceptable:
- Copying a generated bibliography without checking it.
- Keeping a reference because its title sounds relevant.
- Citing a real paper that does not support the claim.
- Asking the model whether its own citation is correct and stopping there.

#v(0.6em)
*You are responsible for the existence, accuracy and relevance of every reference.*

#speaker-note[1 minute. Verification after receiving a suggestion is required. The model is a discovery aid, while the source provides the evidence.]

== Reproducible artefacts require executable sources

#lead[Keep the source that generates the artefact]

For deterministic outputs, provide the input material and generating source alongside the rendered result.

Examples:
- Data figures: data files and plotting code.
- Results tables: data files and aggregation code.
- Slides: editable source, such as Typst, LaTeX or HTML.
- Diagrams: a source description, such as PlantUML or Mermaid.

#v(0.5em)
GenAI may help write the source. Inspect it and execute it to produce the artefact.

#speaker-note[2 minutes. This is the coordinator's explicit reproducibility rule. The prohibited shortcut is asking for a finished artefact in place of a reproducible generating source. The rule concerns artefacts derivable from code, especially representations of data and technical content.]

== Data figure: proper and improper use

#lead[Generate figures from data and reviewed code]

#grid(columns: (1fr, 1fr), gutter: 1.4cm,
  [*Improper*

    Ask a model to draw the results chart as an image and submit it as the representation of your data.

    The image replaces the computation and plotting procedure.
  ],
  [*Proper*

    Specify the input data, aggregation and visual encoding. Ask for a plotting script if useful.

    Inspect the script, check its calculations and execute it on the saved data.
  ],
)

#v(0.5em)
The figure must trace back to the actual experiment results and generating code.

#speaker-note[2 minutes. Even a visually plausible graph is unacceptable if its plotted values were invented or cannot be traced to the data. The same applies to error bars, sample counts and statistical annotations.]

== Slides: proper and improper use

#lead[Generate slides from reviewed, editable sources]

#grid(columns: (1fr, 1fr), gutter: 1.4cm,
  [*Improper*

    Ask for finished slide images or a presentation file as a substitute for the code that generates the slides.

    Submit the output without reviewing its claims and sources.
  ],
  [*Proper*

    Prepare the outline and evidence. Ask for help drafting or editing the Typst, LaTeX or HTML source.

    Review the content and sources, compile it, and inspect the rendered slides.
  ],
)

#v(0.5em)
Keep the generating source together with the material it depends on.

#speaker-note[1 minute. A final PDF is a useful deliverable, but it does not replace the editable generating source. A complete rendering pipeline and reviewed content remain the student's responsibility.]

== Statistical judgement stays with you

#lead[Justify the analysis and interpret the evidence]

GenAI may help implement a specified analysis or explain a statistical concept.

You must justify:
- The experimental unit, baseline and comparison.
- The test or estimation procedure and its assumptions.
- The treatment of variability and repeated observations.
- The interpretation of effect sizes and statistical significance.

#v(0.5em)
Do not accept a test or conclusion merely because the tool suggests it. \
Do not keep changing the analysis until it gives a desired result.

#speaker-note[2 minutes. Connect this to the course outcomes. A generated p-value or verbal conclusion cannot replace a justified analysis of the actual experiment. Students should be able to explain the comparison in their report.]

== A language model inside your project

#lead[Document assistance and experimental methods]

Distinguish *GenAI assistance used to produce the work* from *a model used by the system you investigate*.

- Disclose development and writing assistance in the report.
- Describe the system's model, inputs and configuration in the methods.
- Record execution traces and outputs needed for evaluation.
- Check how model errors affect the whole system.

#v(0.5em)
Both uses require human oversight. A disclosure cannot replace an experimental method description.

#speaker-note[1 minute. For a language-model-based agent, model integration is part of the research artefact. Documentation should support repeating the procedure, while recognising that service responses may change. No claim of identical stochastic outputs is required.]

== Responsibility in a group project

#lead[Make each contribution and its verification explicit]

A group can submit one consolidated GenAI disclosure.

It must identify:
- Which tools each member used and for which tasks.
- Which parts of the submission were affected.
- Who checked the outputs and how.

#v(0.7em)
Each member must understand their own contribution and how it fits the overall design. \
The joint submission must contain checked, defensible work.

#speaker-note[1 minute. This elaborates the approved requirement to identify individual contributions. It does not introduce a new oral assessment or a new grading component.]

== Before submitting

#lead[Check understanding, evidence and disclosure]

#enum(
  [Can I explain the design, implementation and conclusions?],
  [Have I tested generated code and checked factual claims?],
  [Does every figure or table trace back to data and generating code?],
  [Have I verified every reference against the original source?],
  [Does the disclosure accurately identify the tools, purposes and checks?],
)

#v(0.6em)
*Use assistance deliberately. Retain intellectual control and responsibility.*

#speaker-note[1 minute. Ask students to apply these questions to one example from their project. This is a submission checklist, not an additional assessment task.]

== Policy and recommended reading

*Course coordinator's guidance for students* \
#link("https://matteomagnini.github.io/students/")[matteomagnini.github.io/students/]

#v(0.8em)
The page requires a GenAI disclosure and recommends \
*Thinking--Fast, Slow, and Artificial* before using language models.

#v(0.8em)
These slides specify the expected practice for Intelligent Systems 2. \
Ask the teaching team about unclear cases before using the output in your submission.

#speaker-note[1 minute. The students page was consulted on 6 November 2026. The detailed examples and requirements in this deck implement the course coordinator's instructions. This is not a claim that the website already contains every detailed course rule.]
