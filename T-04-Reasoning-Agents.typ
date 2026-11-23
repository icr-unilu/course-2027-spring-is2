#import "@preview/touying:0.7.4": *
#import themes.metropolis: *
#import "utils.typ": *
#import "diagrams.typ": agent-environment

#let pdfpc-config = pdfpc.config(duration-minutes: 90, last-minutes: 5)
#show: metropolis-theme.with(
  aspect-ratio: "16-9",
  footer: self => self.info.institution,
  config-common(
    preamble: pdfpc-config,
    show-bibliography-as-footnote: bibliography(title: none, "bibliography.bib"),
  ),
  config-info(
    title: [Intelligent Systems 2],
    subtitle: [Reasoning Agents],
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
  image("images/T-04/" + name, height: height, width: width, fit: "contain"))

#title-slide()

= Agents and Architectures

== Agents and their Environment (Part I)

#lead[Perception informs action; action changes the environment]

#agent-environment(height: 7cm)

#caption[The agent–environment loop#cite(label("russell2021aima")).]

== Agents and their Environment (Part II)

#lead[A compact abstract model]

- *Perception* maps an environment state to a percept: $E arrow.r P$.
- *Action selection* can depend on percept history: $P^* arrow.r A$.
- A percept describes what is observed, not necessarily the entire world.

== Agent Actions

#lead[An action is more than a command name]

#grid(columns: (1fr, 1fr, 1fr), gutter: 0.6cm, align: top,
  card([Preconditions], [What must hold for the action to be applicable?]),
  card([Expected effects], [What changes should the action produce?]),
  card([Observed outcome], [What actually happened after execution?]),
)

#v(0.5em)
A plan can fail when applicability or expected effects no longer match the world.

== Agent Environments

#lead[Three distinctions affect the architecture]

- *Observability:* can the agent access the relevant state?
- *Determinism:* is the effect of an action determined by the current state?
- *Dynamics:* can the world change while the agent reasons?

#v(0.4em)
Chess and road driving place different demands on the agent#cite(label("russell2021aima")).

== Reactive Systems (Part I)

#lead[An ongoing interaction, rather than one input and one output]

#pair(
  card([Functional view], [Compute a result from an input, then return it.]),
  card([Reactive-system view], [Continue interacting and respond while the response is still useful.]),
)

#v(0.5em)
“Reactive system” does not necessarily mean “memoryless agent”.

== Reactive Systems (Part II)

#lead[A purely reactive agent uses the current percept]

#align(center)[$ a_t = f(p_t) $]

- No explicit history is consulted by this action-selection model.
- A stimulus–response rule can produce useful behaviour.
- Hidden state can make the same percept require different actions.

#v(0.3em)
A thermostat is a simple example; a partially observed task may need more#cite(label("wooldridge2009introduction")).

== Stateful Agents

#lead[Memory changes the action-selection problem]

#align(center)[$ i_(t+1) = "next"(i_t, p_t) quad a_t = "act"(i_(t+1)) $]

- Observe a percept.
- Update an internal representation using state and percept.
- Select an action from the updated representation.

#v(0.3em)
The next question is *what that internal state should represent*.

== Intelligent Agent Behaviour

#lead[Three complementary capabilities]

#grid(columns: (1fr, 1fr, 1fr), gutter: 0.6cm, align: top,
  card([Reactivity], [Respond to relevant environmental changes.]),
  card([Proactiveness], [Take initiative towards objectives.]),
  card([Social ability], [Coordinate with other agents or humans.]),
)

#v(0.4em)
These capabilities operate within the environment in which the agent is situated#cite(label("wooldridge1995agents")).

= Intentional Systems

== The Intentional Stance (Part I)

#lead[Explain behaviour through beliefs and desires]

A driver chooses wet tyres because they *believe rain is approaching* and *want to maintain grip*.

- Beliefs describe the situation as the agent understands it.
- Desires describe outcomes the agent would like.
- Together, they help explain and predict a choice#cite(label("dennett1971intentional")).

== The Intentional Stance (Part II)

#lead[Agents can reason about other agents' attitudes]

#table(
  columns: (auto, 1fr), inset: 10pt, stroke: none,
  [*First order*], [A believes $p$.],
  [*Second order*], [A believes that B believes $p$.],
  [*Third order*], [A believes that B believes that A believes $p$.],
)

#v(0.4em)
These are modelling descriptions, not claims about consciousness.

== Mental States as an Abstraction

#lead[Describe what matters for deciding an action]

- *Epistemic state:* what the agent currently takes to be the case.
- *Motivational state:* what it would like to achieve.
- *Practical reasoning:* how those states guide action selection.

#v(0.4em)
A useful abstraction can support design and explanation without copying a human mind#cite(label("wooldridge2009introduction")).

== Epistemic and Practical Reasoning

#lead[Two different questions]

#pair(
  card([Epistemic reasoning], [What should I believe about the world?]),
  card([Practical reasoning], [What should I do, given my beliefs and objectives?]),
)

#v(0.5em)
Updating a map and selecting a route are related but distinct activities.

== Practical Reasoning

#lead[Deciding what to achieve and deciding how]

#pair(
  card([Deliberation], [Choose which available objectives to pursue.]),
  card([Means–ends reasoning], [Choose a course of action for the adopted objective.]),
)

#v(0.5em)
An *intention* connects that decision to subsequent action#cite(label("bratman1999intention")).

= Intentions and Plans

== Intentions (Part I)

#lead[A commitment organises future activity]

- It directs effort towards finding and executing a plan.
- It filters options that conflict with the adopted objective.
- It provides stability across successive decisions.

#v(0.4em)
Stability avoids reconsidering every choice from scratch#cite(label("bratman1999intention")).

== Intentions (Part II)

#lead[Desiring an outcome does not yet settle what to do]

#pair(
  card([Desires], [Several attractive outcomes may compete for time and resources.]),
  card([Intentions], [Selected commitments structure the activity the agent actually undertakes.]),
)

#v(0.5em)
A robot may want to finish a delivery and recharge; it must decide what to pursue now.

== Intentions (Part III)

#lead[Intended outcomes and expected side effects differ]

I intend to visit the dentist and expect the visit to involve pain.

- I intend the visit.
- I expect the pain.
- It does not follow that I intend the pain.

#v(0.4em)
Intentions are not simply closed under every believed consequence#cite(label("bratman1999intention")).

== Means–Ends Reasoning

#lead[Relate an objective to actions and the current situation]

#pic("means-ends.svg", height: 8cm)

#caption[The three inputs of the means–ends architecture#cite(label("wooldridge2009introduction")).]

== Reasoning in a Changing World

#lead[The world need not wait for deliberation]

#pic("reasoning-time.svg", height: 7.5cm)

#caption[An intention or plan may become inappropriate before the first action is executed.]

== Bounded Practical Reasoning

#lead[Balance commitment with responsiveness]

- Reasoning consumes time and computational resources.
- Execute and observe incrementally instead of assuming the whole plan will succeed.
- Reconsider when relevant changes undermine the current commitment.

#v(0.4em)
Neither “always replan” nor “never replan” is a universal solution.

= Belief, Desire and Intention

== The BDI Model (Part I)

#lead[Three kinds of internal representation]

#grid(columns: (1fr, 1fr, 1fr), gutter: 0.6cm, align: top,
  card([Beliefs], [What the agent currently takes to be true.]),
  card([Desires], [Candidate outcomes it would like to achieve.]),
  card([Intentions], [The commitments it has selected to pursue.]),
)

#v(0.4em)
BDI makes practical reasoning explicit in the agent architecture#cite(label("rao1995bdi")).

== The BDI Model (Part II)

#lead[Beliefs are a situated representation, not infallible knowledge]

- Percepts and messages can update the belief base.
- Information can be incomplete or out of date.
- Belief revision changes the basis for subsequent decisions.

#v(0.4em)
A stored belief that a corridor is free does not guarantee that it remains free.

== The BDI Model (Part III)

#lead[Plans and events make the model operational]

#pair(
  card([Plan library], [Recipes describing how to respond or achieve objectives.]),
  card([Events], [Changes, messages or subgoals that make activity relevant.]),
)

#v(0.5em)
Many BDI implementations select and refine stored plans rather than planning from scratch#cite(label("bordini2007jason")).

== BDI Plans (Part I)

#lead[Three parts of a plan]

#grid(columns: (1fr, 1fr, 1fr), gutter: 0.6cm, align: top,
  card([Trigger], [Which event makes this plan relevant?]),
  card([Context], [Under which beliefs is the plan applicable?]),
  card([Body], [Which actions or subgoals should be attempted?]),
)

#v(0.4em)
Relevance and applicability are not the same test.

== BDI Plans (Part II)

#lead[Example: adopting a delivery plan]

- *Trigger:* a goal to deliver a parcel is adopted.
- *Context:* a route is known and the robot has enough battery.
- *Body:* navigate to the destination, then drop the parcel.

#v(0.5em)
The body can introduce subgoals whose execution expands the current intention.

== The BDI Control Cycle (Part I)

#lead[From information to options to commitments]

#pic("bdi-cycle.svg", height: 8cm)

#caption[Compact view of belief revision, option generation and filtering#cite(label("rao1995bdi")).]

== The BDI Control Cycle (Part II)

#lead[One cycle, three phases]

#code[
#raw("# Observe and update\np = perceive(); B = revise(B, p)\n\n# Deliberate and prepare\nD = options(B, I); I = filter(B, D, I)\nplan = select_plan(B, I)\n\n# Act and continue\nexecute_next_step(plan); collect_events()", block: true)
]

#caption[Conceptual pseudocode: current intentions participate in the next decision.]

== Reconsidering Intentions

#lead[Keep commitments useful rather than permanent]

- Drop an intention that has succeeded.
- Drop or revise one that is no longer achievable.
- Consider relevant new opportunities without endlessly restarting deliberation.

#v(0.4em)
Reactivity and stable commitment must coexist#cite(label("rao1995bdi")).

== BDI: Model and Implementation

#lead[An architecture is not one particular programming language]

- The intentional stance provides an explanatory viewpoint.
- A BDI architecture organises state, plans and control.
- Platforms such as Jason provide programming mechanisms for that organisation#cite(label("bordini2007jason")).

#v(0.4em)
What a framework calls an “intention” should be checked against its implementation.

== From Reasoning Agents to Computational Logic

#lead[Three questions remain]

- How should beliefs, goals and action conditions be represented?
- Which conclusions can be justified from those representations?
- Which reasoning procedures can run within the available resources?

#v(0.4em)
These questions connect agent architectures to *logic and automated reasoning*.
