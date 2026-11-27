#import "@preview/touying:0.7.4": themes, speaker-note
#import themes.metropolis: title-slide
#import "themes/embodied.typ": embodied-theme, lesson-table
#import "slide-components.typ": lead, caption, pair, card
#import "diagrams.typ": agent-environment
#import "themes/robotics-diagrams.typ": hybrid-control, subsumption-example

#show: embodied-theme.with([Robot Controller Architectures])

#title-slide()

#speaker-note[
  90 minutes. Allow 20 min for deliberative control, 30 min for reactive and
  behaviour-based control, and 40 min for hybrid control including the exercise.
  Keep the person-in-the-corridor case fixed across architectures.
]

= Deliberative Control

== What Lives Inside the Agent?

#agent-environment(height: 6.75cm)

#caption[The architecture decides how observations produce commands and how goals, models and memory influence the decision.]

== Two Decisions on Different Timescales

#pair(
  card([Choose a route], [A blocked door triggers a search for another way to deliver the parcel.]),
  card([Respond to an obstacle], [A person steps into the current corridor. The robot needs to adapt its motion immediately.]),
)

#v(0.5em)
A single task can require both decisions within the same execution.

== Sense–Plan–Act

#grid(columns: (1fr, 1fr, 1fr), gutter: 0.55cm, align: top,
  card([Sense], [Update the estimated world state from observations.]),
  card([Plan], [Use that estimate and a model of actions to choose a sequence.]),
  card([Act], [Execute a step or an appropriate part of the plan, then sense again.]),
)

#v(0.5em)
A central model supports reasoning across multiple actions. Planning latency and stale state become concerns when the world changes quickly#cite(label("arkin1998behavior")).

== Where Deliberation Helps

- The robot can look ahead to avoid a route that ends at a blocked door.
- Explicit action models expose why opening the door must precede crossing it.
- The plan gives the executive a sequence whose progress it can check.

#v(0.45em)
#lead[What should happen if an obstacle appears while the planner is still searching?]

= Reactive and Behaviour-Based Control

== Reactive Control

#lead[Update the command directly when relevant input changes]

- A simple rule can reduce speed or stop when clearance drops.
- The controller may maintain local state, including filtered readings or a current mode.
- Local feedback may leave the robot waiting at an obstruction that requires a different route.

#speaker-note[
  Recall Braitenberg. Its simplest form is memoryless, while a reactive design
  more generally may include state. Keep the distinction between e.g. reactive
  obstacle handling and a deliberative search over a world model.
]

== Behaviour-Based Decomposition

#grid(columns: (1fr, 1fr, 1fr), gutter: 0.55cm, align: top,
  card([Follow waypoint], [Turn towards the current route target.]),
  card([Avoid obstacle], [Steer away from nearby obstacles or stop.]),
  card([Dock], [Slow down and align with the drop-off station.]),
)

#v(0.5em)
Behaviours can have different activation conditions and propose conflicting commands. Coordination determines what reaches the actuators#cite(label("arkin1998behavior")).

== Arbitration and Fusion

#pair(
  card([Arbitration], [Select one candidate command. A stop response can take priority over waypoint following.]),
  card([Fusion], [Combine compatible proposals. Goal attraction and obstacle repulsion can contribute to a steering vector.]),
)

#v(0.5em)
#lead[Averaging two outputs can weaken or cancel a required response.]

== Exercise: Opposing Directions

#lead[The goal suggests $(1,0)$ and obstacle avoidance suggests $(-1,0)$]

1. Compute the command under equal-weight fusion.
2. Pick a command under stop-priority arbitration when clearance is critically low.
3. Explain how the robot might get moving again.

#speaker-note[
  Give students four minutes. Fusion yields (0,0). With an active stop
  response, the stop command wins. If the obstruction persists, the executive
  should ask for another route after the robot has stopped. If clearance is
  restored, the controller can resume the current skill. This is a simplified
  teaching example about coordination.
]

== Subsumption

- Build layers that implement progressively richer competences.
- Behaviours can run concurrently in asynchronous modules.
- Higher layers can inhibit inputs or suppress outputs of lower layers. Lower layers can resume their ordinary role when the override is released.

#v(0.45em)
Brooks's design provides a concrete way to organise and coordinate behaviours#cite(label("brooks1986layered")).

#speaker-note[
  Draw two concurrent modules and a signal that temporarily substitutes a
  different output. Subsumption's higher layers are levels of competence.
  A safety-priority arbitration rule from the previous slide is a separate
  design decision, so avoid presenting it as a rule about layer numbering.
]

== How Subsumption Can Override an Output

#subsumption-example()

#caption[S marks output suppression. The upper layer can substitute its command when its override is active. The lower layer continues to run#cite(label("brooks1986layered")).]

#speaker-note[
  Simplified signal path inspired by the subsumption diagram in STAI AI-101.
  The example illustrates communication between layers. A separate safety
  rule may still command a stop whenever the minimum clearance is breached.
]

= Hybrid Control

== Planning, Execution and Reaction

#hybrid-control(height: 7.1cm)

#caption[One hybrid architecture. The planner selects tasks, the executive invokes and monitors skills, and motion control closes the fast loop.]

== The Executive Connects Decisions

- Start the next skill when its preconditions are met.
- Interpret skill status such as running, succeeded or blocked.
- Respond to failure by waiting, retrying under suitable conditions or requesting a new plan.

#v(0.45em)
The executive needs a definition of success for each skill. Reaching C and dropping the parcel are distinct outcomes.

== One Obstruction, Three Responses

#lesson-table((1.05fr, 2fr, 2fr),
  table.header([Layer], [Information used], [Response]),
  [Motion control], [Current range readings], [Stop or steer within clearance limits],
  [Executive], [Blocked skill status and timing], [Wait briefly or request replanning],
  [Planner], [Updated corridor availability], [Find a route via the side corridor],
)

#v(0.45em)
These responses can run at different rates while cooperating on the same delivery.

== Exercise: A Stuck Door at B

#lead[The planner expects the door to open. The door skill reports failure]

1. Define the signal that the door skill sends to the executive.
2. Choose when the executive should ask for a different route.
3. Explain which component can keep the robot stationary while it waits.

#speaker-note[
  Give pairs eight minutes. Example: report skill failure with reason and
  timestamp after the door fails to reach the expected open state. Once the
  executive has evidence that crossing is unavailable, update the route state
  and request a new plan from B. Motion control holds position during this work.
  Ask what would change if a pedestrian temporarily blocked an open corridor.
]

== Comparing Controller Architectures

#lesson-table((1.02fr, 2fr, 2fr),
  table.header([Architecture], [Strength], [Design challenge]),
  [Deliberative], [Look ahead using explicit models], [Keep models current and planning timely],
  [Reactive / behaviour-based], [Respond quickly using current sensing], [Coordinate local behaviours towards longer-term goals],
  [Hybrid], [Combine look-ahead with timely local feedback], [Specify interfaces, responsibilities and failure handling],
)

#v(0.45em)
#lead[Which decisions need search, which need immediate feedback, and how should the two communicate?]
