#import "@preview/touying:0.7.4": themes, speaker-note
#import themes.metropolis: title-slide
#import "themes/embodied.typ": embodied-theme, lesson-table
#import "slide-components.typ": lead, caption, pair, card, code
#import "themes/robotics-diagrams.typ": belval-map, door-action

#show: embodied-theme.with([Planning])

#title-slide()

#speaker-note[
  90 minutes. Allow 15 min for the planning model, 20 min for search, 35 min for
  symbolic actions including the tracing exercise, and 20 min for execution.
  Keep the PDDL excerpt at reading level and use the same route throughout.
]

= What Is a Plan?

== The Delivery Goal

#belval-map()

#caption[The robot starts at A carrying a parcel. It must leave the parcel at C.]

#speaker-note[
  Ask for a valid route and a valid delivery plan. A robot can reach C while
  still carrying the parcel. Use the difference to motivate goal conditions.
]

== State, Actions and Goal

- *State:* facts that distinguish situations relevant to the task, such as robot location and door status.
- *Actions:* choices available in a state, with specified effects and optionally costs.
- *Initial state:* the starting facts of this instance.
- *Goal:* a condition on the final state, such as #raw("Delivered(parcel, C)").

#v(0.35em)
A plan is valid when every step is applicable and the final state satisfies the goal#cite(label("omicini2025planning")).

== When Is Classical Planning a Useful Model?

#grid(columns: (1fr, 1fr, 1fr), gutter: 0.55cm, align: top,
  card([Known initial state], [The model identifies the relevant facts at the start.]),
  card([Deterministic effects], [Each applicable action has a single successor state in the model.]),
  card([Static between actions], [The model has no external changes between steps.]),
)

#v(0.55em)
The controller will have to check how well these assumptions hold during execution#cite(label("russell2021aima")).

== Three Levels of Planning

#grid(columns: (1fr, 1fr, 1fr), gutter: 0.55cm, align: top,
  card([Task planning], [Choose operations such as open a door, move or drop a parcel.]),
  card([Route planning], [Choose a sequence of connected waypoints on a map.]),
  card([Motion planning], [Find a feasible path or trajectory for the robot's body.]),
)

#v(0.55em)
The choice of state and action depends on the level at which we are planning#cite(label("lavalle2006planning")).

= Planning as Search

== A Route Is a Path in a Graph

#lead[Assume the door is open and each corridor can be traversed both ways]

#belval-map(door: "open")

#caption[Nodes are waypoints. Edges are available moves with travel costs.]

== Uniform-Cost Search and A\*

#pair(
  card([Uniform-cost search], [Select a frontier node with the smallest known path cost $g(n)$ from the start.]),
  card([A\*], [Select a frontier node with the smallest $f(n)=g(n)+h(n)$, where $h(n)$ estimates remaining cost.]),
)

#v(0.5em)
A consistent heuristic satisfies $h(n) <= c(n,n') + h(n')$ and $h("goal")=0$. With nonnegative costs and proper duplicate handling, A\* graph search on this finite graph finds a least-cost route#cite(label("russell2021aima")).

== Trace A\* from A to C

#lead[After expanding A, which node should be expanded next?]

#lesson-table((1.7fr, 1fr, 1fr, 1fr),
  table.header([Frontier], [$g$], [$h$], [$f$]),
  [B via A], [2], [2], [4],
  [D via A], [3], [2], [5],
)

#v(0.4em)
Expand B and insert C with $g=4$ and $h=0$. Pop C next. The route is A → B → C with cost 4.

#speaker-note[
  Reveal the answer orally or cover the lower line. For the full example,
  h(A)=3, h(B)=2, h(D)=2, h(C)=0. Explain the frontier after expanding B and why
  the return to A cannot improve its best path cost. Setting h=0 recovers
  uniform-cost search.
]

= Symbolic Action Models

== When a Waypoint Is No Longer Enough

#lead[At B, the robot may face an open door or a closed door]

#pair(
  card([Route graph], [If the door's condition is fixed, include or remove the edge accordingly.]),
  card([Task state], [If the robot can open the door, include its status in the state and model the operation that changes it.]),
)

#v(0.45em)
A state can encode several relevant facts together.

== STRIPS: Preconditions and Effects

#lead[The Stanford Research Institute Problem Solver represents actions with logical facts]

- *Preconditions* list the facts required before an action can run.
- *Add effects* introduce facts and *delete effects* remove facts.
- Facts outside the effect lists persist in the model.

#align(center)[$ s' = (s backslash "Del"(a)) union "Add"(a) $]

#caption[For a state represented as a set of true ground facts, with positive preconditions#cite(label("fikes1971strips")).]

== One Action Changes the State

#door-action()

#caption[Opening the door removes `ClosedBC` and adds `PassableBC`. The robot stays at B and keeps carrying the parcel.]

#speaker-note[
  Point at the facts that persist and the fact that changes. Before moving
  on, ask which precondition for MoveBC this action supplies.
]

== Three Operators for Parcel Delivery

#lesson-table((1.1fr, 1.9fr, 1.5fr, 1.25fr),
  table.header([Action], [Preconditions], [Add], [Delete]),
  [#raw("OpenDoor")], [#raw("At(B), ClosedBC")], [#raw("PassableBC")], [#raw("ClosedBC")],
  [#raw("MoveBC")], [#raw("At(B), PassableBC")], [#raw("At(C)")], [#raw("At(B)")],
  [#raw("Drop")], [#raw("At(C), Carrying")], [#raw("Delivered")], [#raw("Carrying")],
)

#v(0.45em)
These are grounded actions for the Belval instance. #raw("Delivered") abbreviates #raw("Delivered(parcel, C)").

#speaker-note[
  The map supplies the connected corridors. For the short-route trace,
  MoveAB requires At(A), adds At(B), and deletes At(A). Other moves can be
  defined analogously and tested in the detour exercise.
]

== Exercise: Trace the State

#code[#raw("Initial: {At(A), Carrying, ClosedBC}\nGoal:    {Delivered}", block: true)]

1. Apply #raw("MoveAB"). Which facts now hold?
2. At B, can the robot apply #raw("MoveBC") immediately?
3. Find a valid plan via the door and write the facts after #raw("Drop").

#speaker-note[
  Allow seven minutes. After MoveAB: At(B), Carrying, ClosedBC. MoveBC is
  inapplicable until OpenDoor adds PassableBC. The short-route plan is
  MoveAB, OpenDoor, MoveBC, Drop. Final state: At(C), PassableBC, Delivered.
  Ask students to distinguish applicability, validity and optimality.
]

== Reading a PDDL Action

#lead[The Planning Domain Definition Language separates the domain from the problem instance]

#code[#raw("(:action move\n :parameters (?from ?to)\n :precondition (and (at ?from) (passable ?from ?to))\n :effect (and (not (at ?from)) (at ?to)))", block: true)]

The domain defines predicates and action schemas. The problem supplies objects, initial facts and a goal#cite(label("mcdermott1998pddl")).

#speaker-note[
  This is a schema excerpt. Mention that a full domain also declares predicates
  and that a concrete instance binds the parameters to objects such as b and c.
]

== Try It: A Route Query in tuProlog

#lead[Find a two-hop route from A to C using the current passability facts]

#code[#raw("passable(a,b).\npassable(b,c).\npassable(a,d).\npassable(d,c).\nvia(Mid) :- passable(a,Mid), passable(Mid,c).", block: true)]

In the #link("https://tuprolog.github.io/2p-kt/web-ide/")[*tuProlog Web IDE*], run #raw("via(Mid).") for all answers. Remove #raw("passable(b,c).") and run it again.

#caption[#link("https://github.com/tuProlog")[tuProlog projects] · #link("https://github.com/tuProlog/2p-kt")[2P-Kt engine]]

#speaker-note[
  Optional five-minute bridge to Logic and Computation. Load the clauses as
  the theory and enter via(Mid). as the query. The solutions are b and d.
  Removing passable(b,c). leaves d. The rule checks two-hop reachability
  from A in a fixed set of facts. It neither searches for an optimal route
  nor models the action of opening the door.
]

= Executing a Plan

== What Happens When the Door Is Blocked?

#lead[The robot is at B. The blockage cannot be cleared by opening the door]

#belval-map(door: "blocked")

#caption[The old plan has lost a relevant assumption. The robot now needs a route from B.]

== Monitor, Update, Replan

- *Monitor:* check that the next step is applicable and that executed steps have the expected outcome.
- *Update:* record the current location and that crossing B–C is unavailable.
- *Replan:* from B, travel back through A and D to C, then drop the parcel.

#v(0.45em)
#belval-map(door: "blocked", detour: true, height: 4.35cm)

#speaker-note[
  In the model, represent the blockage as an availability constraint on the
  crossing. Merely marking the door closed would allow the planner to propose
  OpenDoor again and repeat the failed plan. The detour travel cost from B is 8.
]

== Sequence, Replanning or Policy?

#lesson-table((1fr, 2.15fr, 2.1fr),
  table.header([Approach], [Decision made in advance], [At execution]),
  [Fixed sequence], [Choose the actions in order], [Follow the sequence under its assumptions],
  [Replanning], [Find a plan for the currently known state], [Compute a new plan when assumptions fail],
  [Conditional plan / policy], [Specify choices for alternative observations or states], [Choose the branch or action supported by the current information],
)

#v(0.4em)
A closed-loop motion controller still executes each movement.

== Planning Decisions at Belval

- Formulate the goal as delivered cargo, and represent the relevant state.
- Search the route graph when edge availability is known.
- Model door operations explicitly when actions can change access.
- Check outcomes during execution and update the plan when the world changes.

#v(0.45em)
#lead[How does the robot find and follow a feasible route for the next move in its plan?]
