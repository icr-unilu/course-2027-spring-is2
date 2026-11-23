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
    subtitle: [Autonomy],
    author: author_list(((
      first_author("Matteo Magnini"), "matteo.magnini@uni.lu"),
      ("Souvick Das", "souvick.das@uni.lu"),
    ),
      logo: "images/logo_unilu_fr.svg", width: 20%),
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
#show footnote.entry: set text(size: 0.65em)


// Reusable interaction diagrams are defined in diagrams.typ.
#import "slide-components.typ": lead, caption, pair, card, code
#let pic(name, height: 8cm, width: 100%) = align(center,
  image("images/T-03/" + name, height: height, width: width, fit: "contain"))

#title-slide()

= Biological Autonomy

== Autonomy and Living Systems

#lead[Living systems provide our first examples]

#grid(columns: (1fr, 1fr, 1fr), gutter: 0.7cm, align: top,
  card([A cell], [Maintains a boundary and renews its components.]),
  card([A plant], [Regulates exchanges while depending on light, water and nutrients.]),
  card([An animal], [Coordinates internal regulation with flexible behaviour.]),
)

#v(0.6em)
Biology reveals different ways to sustain activity#cite(label("rosslenbroich2014autonomy")).

== Autopoiesis (Part I)

#lead[An organisation that produces and maintains itself]

- A network of processes produces the components it needs.
- Those components sustain the network and its boundary.
- The system persists even as individual components are replaced.

#v(0.5em)
This is the central idea of *autopoiesis*#cite(label("varela1974autopoiesis")).

== Autopoiesis (Part II)

#lead[The cell: processes and boundary sustain each other]

#pic("cell-autopoiesis.svg", height: 8cm)

#caption[Conceptual diagram of cellular self-maintenance#cite(label("maturana1980autopoiesis")).]

== Autopoiesis (Part III)

#lead[Organisational closure does not mean physical isolation]

#pair(
  card([Organisationally closed], [The processes that maintain the system depend recursively on one another.]),
  card([Materially and energetically open], [Matter and energy cross the boundary; exchange keeps the organisation going.]),
)

#v(0.6em)
*Closure describes the organisation of processes, not a sealed container.*

== Autopoiesis (Part IV)

#lead[Externally specified task or internally sustained organisation?]

#pair(
  card([Heteronomy], [Organisation or activity is governed from outside: provide an input and demand an output.]),
  card([Biological autonomy], [Internal dynamics sustain the organism and regulate its interactions.]),
)

#v(0.6em)
A computer can run unattended without producing and maintaining itself#cite(label("maturana1980autopoiesis")).

== Autonomy and Environment

#lead[Different bodies organise dependence differently]

- Plants exchange resources through distributed interfaces such as roots and leaves.
- Animals often internalise exchange surfaces and use movement to change conditions.
- Both combine environmental dependence with internal regulation.

#v(0.4em)
These are contrasting strategies, not a universal ranking of organisms#cite(label("rosslenbroich2014autonomy")).

= Stability and Evolution

== Robustness (Part I)

#lead[Maintaining function despite perturbations]

- *External:* temperature, food availability or changing conditions.
- *Internal:* component failures, noise or biological variation.
- *Robustness:* preserving a relevant function across such changes.

#v(0.5em)
The system need not preserve every internal detail#cite(label("kitano2004robustness")).

== Robustness (Part II)

#lead[Three complementary strategies]

#grid(columns: (1fr, 1fr, 1fr), gutter: 0.7cm, align: top,
  card([Redundancy], [Alternative components or pathways can sustain a function.]),
  card([Feedback], [Measured effects regulate the activity that produced them.]),
  card([Organisation], [Modules contain disturbances; layers coordinate regulation.]),
)

#v(0.5em)
Robustness is relative to the perturbations considered.

== Homeostasis

#lead[Regulating internal conditions within a viable range]

#pic("homeostasis.svg", height: 6.5cm)

#v(0.4em)
Temperature and blood composition are examples of regulated variables.

#caption[Homeostasis supports autonomy; it is not identical to autopoiesis#cite(label("rosslenbroich2014autonomy")).]

== Time Autonomy

#lead[Activity also has an internal rhythm]

- Metabolic and physiological processes have endogenous dynamics.
- Rest, activity and development are organised over time.
- Internal rhythms can synchronise with environmental cycles.

#v(0.5em)
*Synchronisation with daylight does not make the rhythm purely external*#cite(label("rosslenbroich2014autonomy")).

== Autonomy and Evolution (Part I)

#lead[An evolutionary perspective on the system–environment relation]

- New structures can buffer environmental fluctuations.
- New regulatory capacities can support flexible behaviour.
- Increasing autonomy is a proposed evolutionary pattern, not a predetermined destination.

#v(0.4em)
Evolution is not a ladder on which every lineage must climb#cite(label("rosslenbroich2014autonomy")).

== Autonomy and Evolution (Part II)

#lead[Resources for autonomy: boundaries, regulation, internalisation]

#grid(columns: (1fr, 1fr, 1fr), gutter: 0.7cm, align: top,
  card([Boundaries], [Membranes, skin and shells regulate exchanges with the surroundings.]),
  card([Regulation], [Feedback mechanisms maintain viable internal conditions.]),
  card([Internalisation], [Functions and structures become less directly exposed to external variation.]),
)

#v(0.6em)
Different resources can buffer different kinds of environmental change.

#caption[Adapted from Rosslenbroich's resources for autonomy, Fig. 3.3#cite(label("rosslenbroich2014autonomy")).]

== Autonomy and Evolution (Part III)

#lead[Resources for autonomy: size and flexibility]

#pair(
  card([Size], [A lower surface-to-volume ratio can buffer exchanges with the surroundings.]),
  card([Flexibility], [Physiological adjustment, movement and behaviour provide alternative responses to change.]),
)

#v(0.6em)
These are alternative resources, not requirements that every organism must satisfy.

#caption[Adapted from Rosslenbroich's Fig. 3.3#cite(label("rosslenbroich2014autonomy")).]

== Autonomy and Evolution (Part IV)

#lead[Two complementary dimensions]

#pair(
  card([Interactive autonomy], [Direct environmental influences become less tightly coupled to the system's responses.]),
  card([Constitutive autonomy], [Internal processes become better able to sustain the system's organisation.]),
)

#v(0.6em)
Both remain *relative to an environment and its perturbations*#cite(label("rosslenbroich2014autonomy")).

= Meanings of Autonomy

== What Does Autonomy Mean? (Part I)

#lead[Self-government is a starting point]

- Greek roots: *autos*, self; *nomos*, law.
- Something is autonomous *with respect to* a source of control or dependence.
- A useful claim specifies *which decisions*, *whose control*, and *under which conditions*.

== What Does Autonomy Mean? (Part II)

#lead[Philosophy distinguishes several questions]

#grid(columns: (1fr, 1fr, 1fr), gutter: 0.7cm, align: top,
  card([Personal], [Can I choose and reconsider my own aims?]),
  card([Moral], [Can I deliberate on the principles governing my actions?]),
  card([Political], [Are my decisions respected within a social order?]),
)

#v(0.5em)
In Kant's moral philosophy, autonomy concerns self-legislation through reason#cite(label("kant2012groundwork")).

= Autonomy and Human Control

== Automatic and Autonomous Behaviour

#lead[From a specified routine to goal-directed choice]

#pair(
  card([Automatic execution], [Follow a prescribed procedure and compensate for expected deviations.]),
  card([Operational autonomy], [Select actions towards a goal as observations and circumstances change.]),
)

#v(0.5em)
This distinction does not require machine learning: a hand-coded planner can select its own actions#cite(label("dod2011roadmap")).

== Human Control (Part I)

#lead[Who chooses the actions?]

#pair(
  card([Human operated], [The operator chooses actions; the system executes them.]),
  card([Human delegated], [The operator delegates a function; the system performs it within that assignment.]),
)

#v(0.5em)
Two categories from the DoD's historical four-level taxonomy#cite(label("dod2011roadmap")).

== Human Control (Part II)

#lead[Who decomposes and supervises the task?]

#pair(
  card([Human supervised], [The system conducts activities under high-level permissions and human oversight.]),
  card([Fully autonomous in the assigned task], [The system translates human goals into tasks and acts without routine intervention.]),
)

#v(0.5em)
Here, “fully” does not mean self-generated goals or freedom from all constraints.

== Driving Automation (Part I)

#lead[Three terms make the levels easier to understand]

- *Dynamic driving task:* the operational and tactical work of driving.
- *Operational design domain:* the conditions for which a feature is designed.
- *Fallback:* responding when continued operation is no longer possible.

#v(0.4em)
The SAE taxonomy distinguishes roles, not just technical sophistication#cite(label("sae2026taxonomy")).

== Driving Automation (Part II)

#lead[Levels 0–2: the human keeps supervising the driving]

#table(
  columns: (auto, 1fr, 1fr),
  inset: 10pt, stroke: none,
  table.header([*Level*], [*Sustained control*], [*Human role*]),
  [0], [No driving automation], [Perform the driving task],
  [1], [Steering *or* speed support], [Supervise and intervene],
  [2], [Steering *and* speed support], [Supervise and intervene],
)

#v(0.3em)
*Hands-free does not necessarily mean supervision-free.*

== Driving Automation (Part III)

#lead[Levels 3–5: who is needed when conditions change?]

#table(
  columns: (auto, 1fr, 1fr),
  inset: 10pt, stroke: none,
  table.header([*Level*], [*Where it operates*], [*Human driving needed?*]),
  [3], [Defined conditions], [Following an alert or evident malfunction],
  [4], [Defined conditions], [Not needed to mitigate risk],
  [5], [All conditions in which humans can drive], [Not needed],
)

#caption[Descriptors summarised from SAE J3016, September 2026#cite(label("sae2026taxonomy")).]

== Driving Automation (Part IV)

#lead[One trip can combine different automation features]

#pic("driving-trip.svg", height: 8cm)

#caption[Three trip patterns adapted from SAE J3016 (2021), Fig. 1#cite(label("sae2021taxonomy")).]

== Driving Automation (Part V)

#lead[The crucial questions are concrete]

- A Level 4 shuttle can operate in its domain without a human fallback driver.
- Outside that domain, the same feature is not promised to drive.
- Classify the *active feature and conditions*, rather than an entire brand or vehicle.

#v(0.4em)
A larger operating domain and a higher automation level are different claims.

= Goals and Social Autonomy

== Autonomous Goals (Part I)

#lead[Goals can be implicit or explicitly represented]

#pair(
  card([Goal-oriented behaviour], [A controller is designed to achieve a result without representing that result explicitly.]),
  card([Goal-governed behaviour], [An explicit goal helps determine which actions the agent selects.]),
)

#v(0.5em)
Both can produce purposeful behaviour#cite(label("castelfranchi1995autonomy")).

== Autonomous Goals (Part II)

#lead[Freedom over means and freedom over ends]

#pair(
  card([Executive autonomy], [Given a goal, determine how to achieve it.]),
  card([Motivational autonomy], [Generate, assess or adopt the goals that direct activity.]),
)

#v(0.5em)
A delivery robot may choose its route while a human chooses the delivery#cite(label("castelfranchi1995autonomy")).

== Autonomous Goals (Part III)

#lead[Influence does not have to mean direct control]

- Incoming information is assessed before it becomes an accepted belief.
- A proposed goal is adopted, revised or refused against existing aims and constraints.
- Accepting or refusing a request is an internal decision.

#v(0.4em)
Castelfranchi's cognitive architecture uses filters on beliefs and goals#cite(label("castelfranchi1995autonomy")).

= Computational Autonomy

== Programming Paradigms (Part I)

#lead[From reusable procedures to objects with local state]

- Methods encapsulate reusable behaviour.
- Fields preserve state across method calls.
- In the conventional passive-object model, another entity invokes the methods.

#v(0.5em)
An object protects its state without necessarily deciding *when to act*.

== Programming Paradigms (Part II)

#lead[Agents add control over activity]

- Behaviour defines what the component can do.
- Internal state records its current situation.
- Internal control determines when and why it acts.

#v(0.5em)
Messages can request action; the agent's policy governs its response#cite(label("odell2002objects")).

== Programming Paradigms (Part III)

#lead[Three dimensions: behaviour, state, invocation]

#pic("programming-paradigms.svg", height: 8cm, width: 88%)

#caption[Odell's original comparison, recovered from the published article#cite(label("odell2002objects")).]

== Software Agents (Part I)

#lead[Computational autonomy is control plus a criterion]

#pic("agent-boundary.svg", height: 8cm)

#caption[This architectural view concerns control inside the component; the host still controls its execution.]

== Software Agents (Part II)

#lead[Internal control makes initiative possible]

- An agent can react to an observation or message.
- It can also initiate activity using its internal state and objectives.
- A goal, task or state machine can supply the criterion for action.

#v(0.5em)
A dedicated operating-system thread alone does not establish agency#cite(label("wooldridge1995agents")).

== Software Agents (Part III)

#lead[Agents interact through messages and environmental actions]

#pic("agent-actions.svg", height: 8cm)

#caption[Multi-agent systems expose the social dimension; a single agent can also act in an environment.]

= Autonomy in Agentic AI

== LLM-Based Agents (Part I)

#lead[A language model is a component, not the whole agent]

- *Model:* proposes outputs or actions from context.
- *Controller:* decides how to continue, retry or stop.
- *Environment and tools:* supply observations and make actions possible.

#v(0.4em)
Autonomy belongs to the configured system, not to the label “LLM”#cite(label("gulli2025patterns")).

== LLM-Based Agents (Part II)

#lead[An interaction loop gives the model a role in action]

#agent-environment(height: 7cm, agent-detail: true)

#caption[The same perception–action loop: the model proposes actions; the controller applies constraints and stopping criteria.]

== LLM-Based Agents (Part III)

#lead[Retrieval, tools and autonomy are different capabilities]

#grid(columns: (1fr, 1fr, 1fr), gutter: 0.7cm, align: top,
  card([Retrieval], [Provides information. It need not change who controls the process.]),
  card([Tool workflow], [Calls tools along a predefined sequence.]),
  card([Agent loop], [Chooses the next action using its goal, state and observations.]),
)

#v(0.4em)
Adding tools does not automatically create autonomous control.

== LLM-Based Agents (Part IV)

#lead[Feedback can change behaviour without retraining a model]

- New observations can revise the plan or the next action.
- Updating context or memory is different from updating model weights.
- Useful autonomy also requires stopping conditions and permission boundaries.

#v(0.5em)
“Learning on the job” is a claim to examine, not an automatic property#cite(label("gulli2025patterns")).

== Agentic Multi-Agent Systems

#lead[Example: preparing an evidence-based answer]

#pic("agent-team.svg", height: 8cm)

#caption[Each role governs its own work; messages coordinate the shared objective.]

= Conclusion

== Comparing Autonomy

#lead[Describe a profile, rather than assign one universal score]

#table(
  columns: (1fr, 1.4fr),
  inset: 10pt, stroke: none,
  table.header([*Dimension*], [*Question*]),
  [Constitutive], [Does it sustain its own organisation?],
  [Executive / operational], [What can it do without routine intervention?],
  [Motivational], [Who determines or adopts its goals?],
)

#v(0.3em)
A system can be strong on one dimension and limited on another.

== Take-Home Messages

#lead[Keep three distinctions clear]

- *Biological autonomy:* sustaining an organisation while exchanging with the environment.
- *Operational autonomy:* deciding and acting within a task and operating conditions.
- *Computational autonomy:* keeping control and the criterion for action inside the component.

#v(0.4em)
*Autonomous with respect to what, from whom, and under which conditions?*
