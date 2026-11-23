#import "@preview/touying:0.7.4": *
#import themes.metropolis: *
#import "utils.typ": *

#let pdfpc-config = pdfpc.config(duration-minutes: 35, last-minutes: 5)
#show: metropolis-theme.with(
  aspect-ratio: "16-9",
  footer: self => self.info.institution,
  config-common(
    preamble: pdfpc-config,
    show-bibliography-as-footnote: bibliography(title: none, "bibliography.bib"),
  ),
  config-info(
    title: [Intelligent Systems 2],
    subtitle: [Logic and Computation],
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
  image("images/T-05/" + name, height: height, width: width, fit: "contain"))

#title-slide()

= Consequence and Proof

== Computational Logic

#lead[Logic can play three roles in computer science]

- *Represent computation:* describe a system, state or requirement.
- *Reason about computation:* justify that a property follows.
- *Perform computation:* execute a logic program by answering queries.

#v(0.5em)
Here, logic is a tool for engineering reasoning agents#cite(label("russell2021aima")).

== Syntax and Semantics

#lead[Writing expressions and interpreting them are different activities]

#pair(
  card([Syntax], [Which expressions are well formed, and which inference steps are allowed?]),
  card([Semantics], [What do those expressions mean in an interpretation, and when are they true?]),
)

#v(0.5em)
A conclusion is *entailed* when it is true in every model of the premises.

== Inference Rules

#lead[The form of an argument can justify its conclusion]

#align(center)[#text(size: 1.4em)[$ frac(p quad p arrow.r q, q) $]]

- $p$: the One Ring is destroyed.
- $p arrow.r q$: if the Ring is destroyed, Sauron is defeated.
- By *modus ponens*, infer $q$: Sauron is defeated.

#v(0.4em)
Derivability $S tack.r phi$ and entailment $S models phi$ are distinct notions.

== Soundness and Completeness

#lead[Relating derivations to logical consequence]

#pair(
  card([Soundness], [What the calculus proves is entailed.]),
  card([Completeness], [What is entailed can be proved in the calculus.]),
)

#align(center)[$ S tack.r phi quad med "versus" quad med S models phi $]

#caption[These properties concern a specified logic and proof calculus; they do not guarantee efficient search.]

= Deduction as Computation

== Computation and Deduction

#lead[Automating deduction means choosing how to search]

#pair(
  card([Computation], [Apply a specified procedure to obtain a result.]),
  card([Deduction], [Construct evidence that a conclusion follows from assumptions.]),
)

#v(0.5em)
A proof-search strategy turns inference rules into an executable procedure#cite(label("kowalski1979algorithm")).

== Proof Search (Part I)

#lead[Forward chaining: from known facts towards a conclusion]

#pic("forward-chaining.svg", height: 8cm)

#caption[Apply a rule to established premises; add the derived conclusion.]

== Proof Search (Part II)

#lead[Backward chaining: from a goal towards required premises]

#pic("backward-chaining.svg", height: 8cm)

#caption[Select a rule for the goal; try to establish each of its premises.]

== Proof Search (Part III)

#lead[Rules do not determine the whole computation]

- Several rules or subgoals may be available.
- The strategy decides which alternatives to explore and in what order.
- A branch may fail or continue forever, even when another branch succeeds.

#v(0.4em)
Domain knowledge can guide search; it does not remove computability limits.

= Logic Programming

== Facts, Rules and Queries

#lead[One notation supports representation and execution]

#grid(columns: (1fr, 1fr, 1fr), gutter: 0.6cm, align: top,
  card([Fact], [A statement supplied as part of the program.]),
  card([Rule], [A head can be established by establishing its body.]),
  card([Query], [A goal for which the interpreter seeks a derivation.]),
)

#v(0.4em)
For a definite rule, $A arrow.l B_1, dots, B_n$, read “to prove $A$, prove the body”#cite(label("robinson1965resolution")).

== Terms and Unification

#lead[Matching is a computation over symbolic structure]

- Terms include variables, constants and structured expressions.
- A substitution replaces variables with terms.
- Unification finds a substitution making two expressions identical.

#code[#raw("guards(X, frodo)  and  guards(aragorn, frodo)\n\nUnifier: X = aragorn", block: true)]

#caption[Unification is symbolic matching, not a statistical similarity measure.]

== A Logic Program

#lead[Who protects the One Ring?]

#code[#raw("guards(aragorn, frodo).\nguards(legolas, frodo).\ncarries(frodo, ring).\n\nprotects(X, Item) :- guards(X, Bearer), carries(Bearer, Item).", block: true)]

#v(0.4em)
The query #raw("protects(X, ring)") returns #raw("X = aragorn") and #raw("X = legolas").

#caption[A simplified model of the Fellowship: guarding the bearer counts as protecting the item.]

== Executing a Query

#lead[Backward reasoning turns one goal into subgoals]

#code[#raw("protects(aragorn, ring)\n    => guards(aragorn, Bearer), carries(Bearer, ring)\n    => carries(frodo, ring)     [Bearer = frodo]\n    => empty goal: success", block: true)]

- Unify the selected goal with the head of a rule.
- Replace it with the instantiated body.
- Continue until no subgoal remains.

#caption[An informal SLD-resolution trace for the program on the preceding slide.]

== Success, Failure and Search

#lead[Three possible outcomes must be distinguished]

- *Success:* a derivation completes, possibly yielding variable bindings.
- *Finite failure:* the search finitely exhausts all alternatives without success.
- *Non-termination:* the search continues without returning an answer.

#v(0.5em)
Failure on one branch is not necessarily failure of the whole query.

== Logic and Computation: Take-Home Messages

#lead[Representation, inference and control work together]

- Logic specifies relationships and justified inference steps.
- A search strategy controls how those steps are explored.
- Logic programming uses that exploration to compute answers.

#v(0.4em)
*Which reasoning tasks can be automated, and what can a solver's answer establish?*
