#import "@preview/touying:0.7.4": *
#import themes.metropolis: *
#import "utils.typ": *

#let pdfpc-config = pdfpc.config(duration-minutes: 55, last-minutes: 5)
#show: metropolis-theme.with(
  aspect-ratio: "16-9",
  footer: self => self.info.institution,
  config-common(
    preamble: pdfpc-config,
    show-bibliography-as-footnote: bibliography(title: none, "bibliography.bib"),
  ),
  config-info(
    title: [Intelligent Systems 2],
    subtitle: [Automated Reasoning],
    author: author_list(((
      first_author("Matteo Magnini"), "matteo.magnini@uni.lu"),
      ("Souvick Das", "souvick.das@uni.lu"),
    ),
      logo: "images/logo_unilu_fr.svg", width: 20%),
    date: [Summer Semester 2026/2027],
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
#show footnote.entry: set text(size: 0.65em)


#import "slide-components.typ": lead, caption, pair, card, code
#let pic(name, height: 7.5cm, width: 100%) = align(center,
  image("images/T-06/" + name, height: height, width: width, fit: "contain"))

#title-slide()

= Classical Reasoning

== The Automated Reasoning Problem

#lead[Does a conjecture follow from the assumptions?]

#align(center)[#text(size: 1.4em)[$ S models phi $]]

- $S$ represents the assumptions or knowledge base.
- $phi$ represents a property or conjecture.
- The representation determines which question the solver actually answers.

#v(0.4em)
A correct answer about a model still depends on modelling the relevant facts#cite(label("russell2021aima")).

== Proofs and Countermodels

#lead[Two complementary ways to investigate a claim]

#pair(
  card([Refutation], [Show that $S union {not phi}$ is inconsistent: no model satisfies both the assumptions and the negated conjecture.]),
  card([Countermodel], [Find a model satisfying $S union {not phi}$: the assumptions hold while the conjecture is false.]),
)

#v(0.4em)
A timeout supplies neither a proof nor a countermodel#cite(label("robinson1965resolution")).

== Automated and Interactive Proving

#lead[Who guides the construction of a proof?]

#pair(
  card([Automated prover], [Searches for a proof without requiring a human to choose each step.]),
  card([Interactive prover], [Combines human-selected structure or lemmas with machine-checked steps and automation.]),
)

#v(0.5em)
The distinction concerns the process; both need a precise statement and assumptions.

== Decidability and Limits

#lead[A missing answer is not always a negative answer]

- A *decision procedure* terminates with yes or no for every input in its scope.
- First-order validity is *semi-decidable*: a complete fair proof search can find every valid formula, but need not halt on an invalid one.
- A resource limit can leave a particular problem *unknown*.

#v(0.3em)
Restricting the logic or the problem can make decision procedures possible#cite(label("russell2021aima")).

== Reasoning as Search

#lead[Separate valid steps from the strategy that selects them]

- *Inference system:* which derivation steps are allowed?
- *Search strategy:* which rule and data should be considered next?
- *Guarantees:* soundness, completeness and termination are separate properties.

#v(0.4em)
Generating useful consequences and removing redundancy both matter.

== Satisfiability (Part I)

#lead[Encode a choice as propositional constraints]

The Fellowship must choose one route: Caradhras ($C$) or Moria ($M$). Snow blocks Caradhras.

#align(center)[#text(size: 1.15em)[$ (C or M) and (not C or not M) and not C $]]

- $C or M$: choose at least one route.
- $not C or not M$: do not choose both.
- $not C$: exclude the blocked pass.

#v(0.3em)
A satisfying assignment is $C = "false"$, $M = "true"$.

== Satisfiability (Part II)

#lead[Search for an assignment rather than a free-form explanation]

- *Propagate:* infer forced assignments such as $not C$ and then $M$.
- *Branch:* try an assignment when choices remain.
- *Backtrack:* revise a choice when it leads to a conflict.

#v(0.4em)
These are core ideas of DPLL-style search#cite(label("davis1962machine")). SAT is decidable, but large instances can still be difficult.

= Defaults and Explanations

== Non-Monotonic Reasoning

#lead[Some conclusions should change when information changes]

#pair(
  card([Classical consequence], [Adding premises does not remove an earlier logical consequence.]),
  card([Default reasoning], [A conclusion drawn under a default assumption may be withdrawn when an exception becomes known.]),
)

#v(0.5em)
A default that Caradhras is usable must be withdrawn when a snow blockage is reported#cite(label("lifschitz2019asp")).

== Negation as Failure

#lead[Failure to establish a goal is not classical negation]

- Negation as failure succeeds when a goal *finitely fails* under the chosen operational semantics.
- A loop or timeout is not finite failure.
- New facts can invalidate conclusions previously drawn using failure.

#v(0.4em)
Failure to prove #raw("blocked(moria)") does not establish that Moria is safe.

== Answer Set Programming

#lead[Before the snow report, two routes remain possible]

#code[#raw("via_moria     :- not via_caradhras.\nvia_caradhras :- not via_moria.", block: true)]

#pair(
  card([Answer set 1], [#raw("{via_moria}")]),
  card([Answer set 2], [#raw("{via_caradhras}")]),
)

#v(0.4em)
ASP computes stable models of a program rather than following a Prolog-style goal trace#cite(label("lifschitz2019asp")).

== Abductive Reasoning

#lead[Find hypotheses that could explain an observation]

- *Observation:* a beacon of Gondor is lit.
- *Candidate explanations:* an alarm was raised, or a beacon test is in progress.
- *Constraints:* check messages and test schedules against each hypothesis.

#v(0.5em)
An abductive explanation is a supported possibility, not a conclusion guaranteed by the observation alone#cite(label("kakas1992abductive")).

= Verification and Applications

== Model Checking (Part I)

#lead[Check a specified property against a system model]

- *Model:* states and possible transitions.
- *Property:* a formal statement about allowed behaviour.
- *Check:* establish the property or return a counterexample.

#v(0.5em)
Finite-state model checking makes this exploration automatic; state-space growth remains a challenge#cite(label("clarke1999model")).

== Model Checking (Part II)

#lead[Can the Ring-bearer remain undetected?]

#pic("model-checking.svg", height: 8cm)

#caption[Safety requirement: the bearer is never detected. This simplified model admits a violating execution.]

== Reasoning about Actions

#lead[Describe change without forgetting what stays the same]

- *Preconditions:* when can an action be performed?
- *Effects:* which properties change after it?
- *Frame problem:* how do we represent what remains unchanged?

#v(0.5em)
Moving Frodo from the Shire to Rivendell changes his location; possession of the Ring can remain unchanged#cite(label("russell2021aima")).

== Logic in Intelligent Systems

#lead[Three engineering roles]

#grid(columns: (1fr, 1fr, 1fr), gutter: 0.6cm, align: top,
  card([Specify], [Describe beliefs, action conditions or domain knowledge.]),
  card([Program], [Use rules and constraints to compute decisions.]),
  card([Verify], [Check safety properties or interaction protocols.]),
)

#v(0.4em)
A logical representation can complement other components of an intelligent system.

== Automated Reasoning: Take-Home Messages

#lead[Match the question, the method and the guarantee]

- Choose a formalism that expresses the relevant assumptions and properties.
- Choose a procedure suited to that reasoning task and its resource budget.
- Interpret proofs, models, finite failure and unknown outcomes correctly.

#v(0.4em)
*An intelligent system needs more than an answer: it needs the right meaning for that answer.*
