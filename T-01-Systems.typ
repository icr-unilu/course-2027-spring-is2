#import "@preview/touying:0.7.4": *
#import themes.metropolis: *
#import "utils.typ": *

// This deck introduces systems. Intelligence belongs in the separate T-02 deck.
#let pdfpc-config = pdfpc.config(duration-minutes: 60, last-minutes: 5)
#show: metropolis-theme.with(
  aspect-ratio: "16-9",
  footer: self => self.info.institution,
  config-common(
    preamble: pdfpc-config,
    show-bibliography-as-footnote: bibliography(title: none, "bibliography.bib"),
  ),
  config-info(
    title: [Intelligent Systems 2],
    subtitle: [Systems],
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

// Native, editable SVG diagrams. No external image files are needed.
#let diagram(body, height: 4.5cm) = align(center, image(bytes(
  "<svg xmlns='http://www.w3.org/2000/svg' width='1000' height='340' viewBox='0 0 1000 340'>"
  + "<defs><marker id='arrow' markerWidth='8' markerHeight='8' refX='7' refY='4' orient='auto-start-reverse'><path d='M0,0 L8,4 L0,8 Z' fill='#23373b'/></marker></defs>"
  + "<style>text{font-family: Fira Sans, sans-serif;fill:#23373b;font-size:32px} .label{font-size:28px} .small{font-size:24px} .node{fill:#edf3f4;stroke:#23373b;stroke-width:2} .edge{stroke:#23373b;stroke-width:3;fill:none;marker-end:url(#arrow)} .accent{fill:#eb811b} .boundary{fill:#f8fafb;stroke:#eb811b;stroke-width:3;stroke-dasharray:10 6}</style>"
  + body + "</svg>"
), format: "svg", height: height))

#let robot(x, y, caption) = "<g transform='translate(" + str(x) + "," + str(y) + ")'><rect x='0' y='0' width='105' height='88' rx='16' class='node'/><circle cx='33' cy='31' r='6'/><circle cx='72' cy='31' r='6'/><path d='M32 60 H73' stroke='#23373b' stroke-width='4'/><text x='52' y='120' text-anchor='middle' class='label'>" + caption + "</text></g>"

#title-slide()

= Fundamental Questions

== Intelligent Systems

#align(center)[*Two words to unpack*]
#v(2em)

#grid(
  columns: (1fr, 1fr),
  gutter: 2cm,
  [*Intelligent*

    What is
    - intelligence?
    - natural intelligence?
    - artificial intelligence?
    - an intelligent behavior?
    - consciousness?

  ],
  [*Systems*

    What is
    - science?
    - engineering?
    - a computer?
    - a system?
    - a computational system?
  ],
)

== Foundational Questions

*What are we studying when we study intelligent systems?*

- Science and engineering.
- Machines and computers.
- Computation and computational models.
- Systems and their context.

#v(1em)
We start from computer science, then broaden the perspective to systems in general.

= On Computer Science

== What is Science? (Part I)

*Knowledge and understanding grounded in evidence*

Science investigates the natural and social world through systematic observation, modelling and comparison with evidence#cite(label("chalmers2013science")).

- Observe and measure phenomena.
- Formulate questions and hypotheses.
- Develop models.
- Test explanations and predictions.

== What is Science? (Part II)

#grid(columns: (1fr, 1fr), gutter: 1.4cm,
  [*Phenomena*

    Events and properties as they appear to an observer.

    A measured trajectory, a sensor reading, an observed collision.
  ],
  [*Noumena*

    In Kant's terminology, things considered independently of how they appear.

    A philosophical distinction about the limits of our knowledge#cite(label("kant1998critique")).
  ],
)

#v(0.7em)
In science, we construct _models_ to explain observations.\
A model is not the thing itself.

== What is Science? (Part III)

#align(center)[
    #image("images/T-01/all-models-are-wrong-but-some-are-useful.jpeg", height: 100%)
]



== What Does Science Do? — Explanation

*From observations to models*

- Observe phenomena and record measurements.
- Look for relationships and mechanisms that account for them.
- Compare alternative explanations of the same observations.
- Make assumptions explicit and check their consequences.

#v(0.7em)
*Example:* why does a robot repeatedly collide near a particular doorway?

Possible explanations include sensor limitations, control delays and the geometry of the room.

== What Does Science Do? — Prediction

*A useful model also tells us what to expect*

A model should generate consequences that can be checked against observations not used to construct it.

- What happens if the doorway becomes narrower?
- What changes if the robot moves faster?
- Does the explanation still hold in a different room?

#v(0.7em)
Agreement with one recorded trajectory is not enough to establish predictive performance.

== What is Engineering?

*Designing artefacts to meet requirements under constraints*

Engineering is concerned with designing how things should work to achieve objectives#cite(label("simon1996sciences")).

- Specify the behaviour we need.
- Identify constraints on resources, time and operation.
- Design and implement a solution.
- Evaluate it against the requirements.

#v(0.7em)
Science can explain why the robot gets stuck. Engineering uses that understanding to design a robot that completes its task.

== What is Computer Science?

*The phenomena surrounding computers*

Newell, Perlis and Simon connect a science with its object of study: plants for botany, animals for zoology, computers for computer science#cite(label("newell1967computer")).

#v(0.7em)
But the meaning of *computer* changes as the field develops.

What does a calculator, a laptop, a robot controller or a network of machines have in common?

== What is the Object of Study of Computer Science?

*A computer computes*

A computer is a machine that carries out computation.

Computers and computational systems produce the phenomena we observe: executions, outputs, interactions and changing states.

#v(0.7em)
*Computation* is therefore central to understanding the field#cite(label("newell1967computer")).

What counts as computation determines how broadly we draw its boundaries.

== An Evolving Object of Study

*Definitions of computer science and computation evolve together*

#text(size: 18pt)[
#table(columns: (1fr, 4fr), inset: 6pt, stroke: 0.4pt + rgb("d8dfe1"),
  [*Period*], [*Focus*],
  [1940s], [Automatic computing],
  [1950s], [Information processing],
  [1960s], [Phenomena surrounding computers],
  [1970s], [What can be automated],
  [1980s], [Computation],
  [2000s], [Information processes, both natural and artificial],
)
]

A progression discussed by Denning#cite(label("denning2009field")).

= On Computation

== What is Computation?

*One foundational question, several perspectives*

A shared vocabulary helps us reason about systems.

But a definition fixed too narrowly can exclude important developments before we understand them#cite(label("freeman2011harmful")).

#v(0.7em)
We consider two perspectives:
- computation as *symbol manipulation*;
- computation as *process*.

== Computation as Symbol Manipulation

*Represent a problem, then transform its representation*

- Encode inputs and outputs using symbols.
- Specify well-defined transformation rules.
- Apply those rules to obtain a result#cite(label("conery2010symbols")).

#diagram("<rect x='25' y='105' width='210' height='105' rx='10' class='node'/><text x='130' y='166' text-anchor='middle'>Input data</text><path d='M235 157 H375' class='edge'/><rect x='375' y='85' width='250' height='145' rx='14' class='node'/><text x='500' y='166' text-anchor='middle'>Computation</text><path d='M625 157 H765' class='edge'/><rect x='765' y='105' width='210' height='105' rx='10' class='node'/><text x='870' y='166' text-anchor='middle'>Output data</text>", height: 3.8cm)

Sorting a list is one example: the representation and the permitted operations matter.

== Computation as Process

*Computation unfolds through changes over time*

A process is a succession of actions or changes. Frailey develops a process-oriented view of computation#cite(label("frailey2010process")).

- A program executes instructions.
- A controller repeatedly senses and acts.
- A service handles a continuing stream of requests.

#v(0.6em)
This perspective brings *behaviour over time* into the foreground.

== Broadening the View of Computation

*The computational model matters*

Denning highlights several issues when defining computation#cite(label("denning2011computation")):
- natural and artificial processes;
- terminating and non-terminating behaviour;
- discrete and continuous descriptions.

#v(0.7em)
Computing a sorted list ends with a result. Operating a robot requires continuing interaction.

== Computational Models

*Different abstractions make different aspects explicit*

- A *Turing machine* formalises computation through states, symbols and transition rules.
- A *stored-program architecture* describes the organisation of a programmable computer.
- An *interactive model* makes ongoing exchanges with an environment explicit#cite(label("goldin2006interactive")).

#v(0.6em)
For a robot team, we also need to describe *interaction, location, resources and timing*.

== What is a Machine?

*Inputs, outputs and transformations*

A machine receives influences from outside and produces effects through its operation.

- *Input:* what affects it from the outside.
- *Output:* how it affects the outside.
- *State:* the information needed to describe its subsequent evolution, given its inputs and context.

#v(0.7em)
For a robot: sensor readings, motor commands and the current operating mode.

== What is a Computing Machine?

*Information processing implemented by a machine*

A computing machine transforms information represented in some physical form.

- Its inputs and outputs carry information.
- Its internal state affects its behaviour.
- Its operation requires physical resources.

#v(0.7em)
To describe different implementations, we can abstract from the machinery and focus on the *computational process*.

= Basic Ontology for Computational Systems

== Computational Process

*A computation takes place somewhere and evolves over time*

We model an elementary computational process as a *sequence of computational steps*.

Several such processes can interact or execute concurrently.

#diagram("<rect x='25' y='105' width='210' height='105' rx='10' class='node'/><text x='130' y='166' text-anchor='middle'>Input</text><path d='M235 157 H375' class='edge'/><rect x='375' y='85' width='250' height='145' rx='14' class='node'/><text x='500' y='166' text-anchor='middle'>Process</text><path d='M625 157 H765' class='edge'/><rect x='765' y='105' width='210' height='105' rx='10' class='node'/><text x='870' y='166' text-anchor='middle'>Output</text>", height: 3.8cm)

We distinguish the *process*, the *machine* on which it runs, and its *context*.

== Context for Computation

*Which surrounding conditions matter to the process?*

#grid(columns: (1fr, 1fr), gutter: 1.4cm,
  [*Machine and resources*

    Processor, memory, energy, sensors and communication channels.
  ],
  [*Time and space*

    Delays, deadlines, location, geometry and distance.
  ],
)

#v(0.8em)
A context feature belongs in the model when it affects the behaviour we want to understand.

== Timed, Spatial and Situated Computation

*The context can be essential to the computation*

- *Timed computation:* when an event occurs, or how long it takes, matters.
- *Spatial computation:* location, distance or spatial relationships matter.
- *Situated computation:* behaviour depends on the environment in which computation takes place#cite(label("suchman1987plans")).

#v(0.7em)
A correct motor command can still be useless if it arrives too late or is applied in the wrong place.

== What is a System?

*Interrelated components considered as a whole*

A system comprises components connected through relationships and interactions#cite(label("bertalanffy1950outline")).

- *Components:* what the system contains.
- *Relations:* how the components are connected and affect one another.
- *Boundary:* what is included in the system under study.
- *Environment:* what is outside that boundary and interacts with it.

== Systems Beyond Computers

*The same perspective applies to different kinds of components*

#table(columns: (1fr, 1.3fr, 1.6fr), inset: 8pt, stroke: 0.4pt + rgb("d8dfe1"),
  [*System*], [*Components*], [*Interactions*],
  [Organism], [Cells and organs], [Chemical and electrical signalling],
  [Transport network], [Vehicles and infrastructure], [Traffic and shared capacity],
  [Software service], [Processes and data stores], [Messages, reads and writes],
  [Robot team], [Robots and shared resources], [Movement, signals and contention],
)

#v(0.5em)
A system need not be artificial or designed for a purpose.

== Interacting Computational Systems

*Processes both compute and interact*

In the interacting-system perspective, two or more computational processes carry out local computations and influence one another#cite(label("goldin2006interactive")).

#diagram("<rect x='40' y='25' width='920' height='280' rx='18' class='boundary'/><text x='65' y='60' class='accent'>Computational system</text><rect x='110' y='115' width='200' height='90' rx='12' class='node'/><text x='210' y='170' text-anchor='middle'>Process A</text><rect x='400' y='115' width='200' height='90' rx='12' class='node'/><text x='500' y='170' text-anchor='middle'>Process B</text><rect x='690' y='115' width='200' height='90' rx='12' class='node'/><text x='790' y='170' text-anchor='middle'>Process C</text><path d='M310 160 H395' class='edge'/><path d='M600 160 H685' class='edge'/><text x='500' y='265' text-anchor='middle' class='label'>Messages, shared data or shared resources</text>", height: 4cm)

The interaction rules are part of the description of the system.

== Context for a Computational System

*Separate contexts, a shared context, or both?*

- Each process can have its own machine, resources and local state.
- Several processes can share resources and environmental conditions.
- Local and shared contexts may need to be represented together.

#v(0.7em)
Two robots have different positions and batteries, but may share a doorway, a communication channel and a task.

== Local and Shared Contexts

*What is local, and what couples the components?*

#diagram("<rect x='20' y='20' width='960' height='300' rx='16' class='boundary'/><text x='45' y='60' class='accent'>Shared context</text><rect x='75' y='90' width='350' height='185' rx='12' class='node'/><text x='250' y='135' text-anchor='middle'>Local context A</text><rect x='575' y='90' width='350' height='185' rx='12' class='node'/><text x='750' y='135' text-anchor='middle'>Local context B</text><circle cx='250' cy='210' r='45' fill='#c4dde7' stroke='#23373b' stroke-width='2'/><text x='250' y='220' text-anchor='middle'>A</text><circle cx='750' cy='210' r='45' fill='#c4dde7' stroke='#23373b' stroke-width='2'/><text x='750' y='220' text-anchor='middle'>B</text><path d='M300 210 H700' class='edge'/>", height: 4.5cm)

Shared context does not imply identical observations or perfectly synchronised clocks.

== The System Boundary

*The same component can be a system at another level*

#diagram("<rect x='40' y='35' width='920' height='275' rx='15' class='boundary'/><text x='65' y='70' class='accent'>Building system</text><rect x='220' y='90' width='540' height='185' rx='15' class='boundary'/><text x='245' y='125' class='accent'>Room and robot</text><rect x='350' y='160' width='280' height='80' rx='12' class='node'/><text x='490' y='209' text-anchor='middle'>Robot subsystem</text>", height: 4.2cm)

The floor is external to a robot considered alone. It is internal to a room-and-robot system.

Choose the boundary according to the question you want to answer.

= Parallel, Concurrent and Distributed Systems

== Parallel and Concurrent Computation

*Simultaneous execution and overlapping progress*

- *Parallel:* computations execute at the same time, for example on different processor cores.
- *Concurrent:* several activities can be in progress, including through interleaving on one processor.

#v(0.7em)
Parallel execution is one way to realise concurrency#cite(label("steen2023distributed")).

Timing assumptions and the ordering of events determine which interactions are possible.

== Distributed Computation

*Computation across networked devices*

Components execute on different devices and interact through communication.

- Each device has local state and resources.
- Communication takes time and can fail.
- Different components can observe events in different orders.

#v(0.7em)
Two robots exchanging messages form a distributed system. They can also operate concurrently and in parallel.

== Spatial and Temporal Contexts

*Where things happen and how events are related in time*

#table(columns: (1fr, 2fr), inset: 8pt, stroke: 0.4pt + rgb("d8dfe1"),
  [*Context*], [*Questions for a robot team*],
  [Spatial], [Where are the robots? Which resources and communication links connect them?],
  [Temporal], [Which events precede others? Are clocks synchronised? What delays are possible?],
)

#v(0.7em)
A system model must make its spatial and temporal assumptions explicit#cite(label("steen2023distributed")).

= Agents and Environment

== What is an Agent?

*An autonomous system that perceives and acts in an environment*

An agent selects actions to pursue objectives using the information available to it#cite(label("wooldridge1995agents")).

For a cleaning robot:
- *Perception:* distance, light and battery readings.
- *Action:* move, turn, stop or recharge.
- *Objective:* clean an area while respecting operational constraints.

== Computational Autonomy

*The agent encapsulates control over its action selection*

An external request can influence the agent without prescribing every internal step#cite(label("wooldridge1995agents")).

- The robot decides when to turn or return to its charger.
- Other agents can send information and requests.
- Its capabilities, observations and design constrain its choices.

#v(0.6em)
Autonomy concerns control; it does not imply independence from the environment.

== Actions and Perception

*The agent and the environment form an interaction loop*

#diagram("<rect x='60' y='80' width='300' height='170' rx='18' class='node'/><text x='210' y='173' text-anchor='middle'>Agent</text><rect x='640' y='80' width='300' height='170' rx='18' class='node'/><text x='790' y='173' text-anchor='middle'>Environment</text><path d='M365 115 H635' class='edge'/><text x='500' y='90' text-anchor='middle' class='label'>actions</text><path d='M635 220 H365' class='edge'/><text x='500' y='263' text-anchor='middle' class='label'>observations</text>", height: 4.3cm)

Actions affect the environment. Perception provides information about it#cite(label("wooldridge1995agents")).

The environment can also change through other agents and physical processes.

== Environment and Observation

*The world can contain more than the agent currently senses*

#grid(columns: (1fr, 1fr), gutter: 1.4cm,
  [*Environment state*

    Robot positions, obstacles, doors and physical conditions represented in the model.
  ],
  [*Agent observation*

    A few distance readings and a battery measurement from the robot's current location.
  ],
)

#v(0.7em)
Different world states can produce the same observation.

An agent may need memory, further sensing or interaction to distinguish them.

== Agents, Environment and System

*The environment is part of the larger system under study*

#diagram("<rect x='25' y='20' width='950' height='290' rx='18' class='boundary'/><text x='55' y='58' class='accent'>System under study</text><rect x='90' y='105' width='270' height='130' rx='16' class='node'/><text x='225' y='180' text-anchor='middle'>Agent or agents</text><rect x='640' y='105' width='270' height='130' rx='16' class='node'/><text x='775' y='180' text-anchor='middle'>Environment</text><path d='M365 140 H635' class='edge'/><path d='M635 205 H365' class='edge'/><text x='500' y='98' text-anchor='middle' class='label'>interaction</text>", height: 4.1cm)

*Agents + environment + interactions*, within a chosen boundary.

What is outside the agent can be inside the system we analyse.

== Multiple Agents in a Shared Environment

*Interaction can be direct or mediated by the environment*

#diagram("<rect x='40' y='30' width='920' height='270' rx='16' class='boundary'/><text x='65' y='65' class='accent'>Shared room</text>" + robot(140,125,"Robot A") + robot(700,125,"Robot B") + "<rect x='380' y='125' width='235' height='100' rx='12' class='node'/><text x='497' y='166' text-anchor='middle' class='label'>Doorway, charger,</text><text x='497' y='195' text-anchor='middle' class='label'>floor or task</text><path d='M250 165 H375' class='edge'/><path d='M695 190 H620' class='edge'/><path d='M250 95 Q490 -10 700 95' class='edge'/><text x='485' y='92' text-anchor='middle' class='small'>messages</text>", height: 4.2cm)

Robots can exchange messages, compete for a charger or change what others encounter.

We need to understand their joint behaviour, as well as each individual controller.

= Conclusion

== Summing Up

*From computer science to systems of interacting agents*

- Science seeks explanations and testable predictions.
- Computation can be studied through different models.
- Processes operate in a context of machines, resources, time and space.
- Systems comprise components and their relationships.
- Agents act within an environment and interact with other agents.


== The Whole and Its Parts

*The whole is greater than the sum of its parts.*

#diagram("<text x='500' y='33' text-anchor='middle' class='accent'>Every robot: &quot;My controller passed its tests.&quot;</text><rect x='320' y='65' width='360' height='215' rx='8' fill='#edf3f4' stroke='#23373b' stroke-width='2'/><path d='M425 70 V275 M575 70 V275' stroke='#b4c3c6' stroke-width='7'/>" + robot(447,75,"") + robot(447,185,"") + "<text x='70' y='160' class='small'>No collisions.</text><text x='705' y='205' class='small'>No progress either.</text><text x='500' y='325' text-anchor='middle' class='accent'>The system: &quot;We are still in the corridor.&quot;</text>", height: 4.4cm)

Both robots avoid collisions by waiting for the other to move. Neither has a rule for yielding: *the pair makes no progress*.
