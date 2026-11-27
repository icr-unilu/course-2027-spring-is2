#import "@preview/touying:0.7.4": themes, speaker-note
#import themes.metropolis: title-slide
#import "themes/embodied.typ": embodied-theme, lesson-table
#import "slide-components.typ": lead, caption, pair, card
#import "themes/robotics-diagrams.typ": belval-map, rrt-step, exploration-map, pose-comparison

#show: embodied-theme.with([Navigation and Search], duration: 90)

#title-slide()

#speaker-note[
  90 minutes. Allow 20 min for navigation and localisation, 32 min for
  graph search, 20 min for motion planning, and 18 min for exploration,
  coverage and the closing exercise. This lecture follows T-08 Planning.

  Background: Andrea Roli's Navigation, Uninformed Search and Informed
  Search slides. The route exercise uses the IS2 Belval map.
]

= From a Destination to a Route

== Four Questions for the Delivery Robot

#lesson-table((1.45fr, 2.65fr),
  table.header([Problem], [Question at Belval]),
  [Localisation], [Where am I in the map, and which way am I facing?],
  [Target search], [Where is the drop-off point if its location is unknown?],
  [Route planning], [Which corridors lead from the current location to the destination?],
  [Motion planning and control], [Which movements fit through the corridor, and how do I execute them?],
)

#v(0.45em)
The available information determines which of these problems must be solved#cite(label("roli2019navigation")).

== Localisation and Drift

#pair(
  card([Predict from motion], [Wheel encoders estimate how far the robot moved and turned. Wheel slip can accumulate as pose error.]),
  card([Correct from observations], [Match a landmark or a range scan against the map to refine the estimate.]),
)

#v(0.5em)
Two similar junctions can match the same observation. A history of measurements may help distinguish them.

== Representing the Robot's Pose

#pose-comparison()

#caption[Both robots have the same position $(x,y)$ at the waypoint. Their headings $theta$ differ, so the feasible next motions may differ.]

#speaker-note[
  Draw the same robot at the same coordinates facing opposite ways. Ask what
  wheel motion would make each robot leave through a doorway to its left on the
  map. The example can serve as the bridge from task states to motion states.
]

== Exercise: An Ambiguous Junction

#lead[The robot could be at B or D. A door-shaped feature appears in its scan]

#lesson-table((2.15fr, 1fr, 1fr),
  table.header([Quantity], [B], [D]),
  [Probability before scan], [0.60], [0.40],
  [Probability of detecting the feature there], [0.80], [0.20],
)

#v(0.4em)
1. Multiply each prior by its likelihood and normalise the two weights.
2. The robot is about to turn. Which assumption would you check first?

#speaker-note[
  Allow five minutes. The two hypotheses are exhaustive in this exercise.
  B receives weight 0.48 and D receives 0.08. After normalising, B has
  probability 6/7 and D has 1/7. Ask what might make the likelihoods inaccurate:
  glare, a moved door, repeated features or a poorly calibrated sensor.
]

== When the Map Is Also Unknown

#lead[Simultaneous Localisation and Mapping (SLAM) estimates the robot's trajectory and a map together]

- Motion estimates are needed to place new observations in the map.
- Observations of known features can correct the estimated positions.
- Recognising a previously visited place can constrain the trajectory. This is *loop closure*.

#v(0.45em)
Matching observations to the correct location or feature is part of the problem#cite(label("durrant2006slam")).

= Comparing Graph Search Strategies

== Belval as a Graph Search Problem

#belval-map(height: 6.6cm, door: "open")

#caption[Start at A, finish at C and minimise total travel cost. Assume every displayed corridor is traversable in both directions.]

== One Waypoint, Several Candidate Paths

#pair(
  card([State], [C appears once in the route graph. Paths to C can arrive via B or via D.]),
  card([Search node], [A search node records a state, its predecessor and the cost of the path used to reach it.]),
)

#v(0.5em)
The route graph contains cycles. A search that repeatedly generates A → B → A can waste work. Tracking explored states lets the search reuse what it already knows.

== The Frontier Determines the Search Order

#lesson-table((1.6fr, 2.25fr, 1.55fr),
  table.header([Strategy], [Next node selected], [Information used]),
  [Breadth-first (BFS)], [Shallowest first, using a queue], [Depth],
  [Depth-first (DFS)], [Most recently added first, using a stack], [Expansion order],
  [Uniform-cost (UCS)], [Smallest $g(n)$], [Cost so far],
  [Greedy best-first], [Smallest $h(n)$], [Estimated cost to go],
  [A\*], [Smallest $g(n)+h(n)$], [Both costs],
)

#v(0.4em)
A graph contains repeated states. Keep track of visits and, for cost-based search, update the best known cost when a cheaper path is found#cite(label("russell2021aima")).

== When Does a Route Count as a Solution?

- *Completeness* guarantees that the algorithm will find a route if one exists.
- *Optimality* guarantees that the returned route minimises the stated cost.
- In uniform-cost search and A\*, apply the *goal test* when selecting a node from the frontier. A route discovered earlier may still be improved.

#v(0.45em)
Breadth-first search finds a route with the fewest moves. This also minimises cost when every move has the same positive cost#cite(label("russell2021aima")).

#speaker-note[
  A finite graph with repeated states handled is enough for the search algorithms
  in the next exercise to terminate. For UCS use nonnegative costs. Discuss how
  unbounded spaces change the question, especially for depth-first search.
]

== Exercise: Which Route Is Returned?

#lead[At A, visit D before B for BFS and DFS. At D, consider C before A]

#lesson-table((1fr, 1fr, 1fr, 1fr, 1fr),
  table.header([Waypoint], [A], [B], [C], [D]),
  [$h(n)$], [3], [2], [0], [1.5],
)

#v(0.45em)
1. In pairs, trace breadth-first, depth-first and uniform-cost search, or trace greedy best-first and A\*.
2. Write the frontier after each expansion. Stop when C is selected.
3. Compare the returned route, its number of moves and its total cost.

#speaker-note[
  Allow nine minutes including a brief comparison. Reuse the map on the board.
  Use graph search and a goal test on removal from the frontier. For BFS,
  preserve first discovery. For A\*,
  keep a state only at its best known cost. The heuristic at D is 1.5 in this
  exercise, chosen to make greedy search and A\* take different branches.
]

== The Same Graph, Different Outcomes

#lesson-table((1.6fr, 1.55fr, 1.35fr, 0.55fr),
  table.header([Strategy], [Nodes selected], [Returned route], [Cost]),
  [BFS], [A, D, B, C], [A → D → C], [6],
  [DFS], [A, D, C], [A → D → C], [6],
  [Greedy best-first], [A, D, C], [A → D → C], [6],
  [UCS], [A, B, D, C], [A → B → C], [4],
  [A\*], [A, B, C], [A → B → C], [4],
)

#v(0.45em)
Both routes have two moves. Breadth-first search minimises the number of moves. In this example the cheaper route goes through B.

#speaker-note[
  Account for DFS by putting D on top of the stack after expanding A.
  With UCS, D is selected before C because g(D)=3
  and g(C)=4. With A\*, f(B)=4 and f(D)=4.5. After B, f(C)=4.
]

== A\* in the Belval Example

#lesson-table((1.25fr, 1.95fr, 1.9fr),
  table.header([Expanded], [Frontier after expansion], [Priority values]),
  [A], [B, D], [$f(B)=2+2=4$, $f(D)=3+1.5=4.5$],
  [B], [C, D], [$f(C)=4+0=4$, $f(D)=4.5$],
)

#v(0.48em)
With the same heuristic, greedy best-first selects D first because $h(D)<h(B)$. It ignores the cost already incurred on the way to D.

== Choosing an A\* Heuristic

- An *admissible* heuristic never exceeds the true remaining cost.
- A *consistent* heuristic satisfies $h(n) <= c(n,n') + h(n')$ for each edge and is zero at the goal.
- If cost is path length, straight-line distance to the goal is consistent when each edge cost is at least the distance between its endpoints.

#v(0.45em)
If the cost is travel time, divide the distance by a known upper bound on travel speed. The heuristic then uses the same units as the cost#cite(label("russell2021aima")).

#speaker-note[
  View straight-line distance as the solution of a relaxed problem with no
  obstacles. Check consistency on B to C and D to C in the teaching graph.
  Setting h to zero gives uniform-cost search. For graph-search A\* with
  an admissible but inconsistent heuristic, a better path can require reopening
  a previously expanded state.
]

= Beyond the Route Graph

== A Route Still Needs Feasible Motion

#pair(
  card([Route], [“Go through B” selects a waypoint. Each edge is an abstract connection.]),
  card([Motion], [The path must keep the robot clear of obstacles and account for its body, heading and steering limits.]),
)

#v(0.5em)
A path that fits a small robot through a corner may be infeasible for the same robot when loaded#cite(label("lavalle2006planning")).

== Exercise: Will the Robot Fit?

#lead[A robot of radius 0.24 m approaches a 0.60 m opening]

- Keep a clearance of $0.08$ m to each wall.
- How wide must the opening be? Would $0.05$ m clearance to each wall change the answer?

#v(0.5em)
For a disk on a flat floor, plan for its centre by enlarging obstacles by the robot's radius plus the clearance. This defines forbidden positions for the centre#cite(label("lavalle2006planning")).

#speaker-note[
  Allow four minutes. The required width is twice the radius plus twice the
  chosen clearance. At 0.08 m it is 0.64 m and the passage is too narrow.
  At 0.05 m it is 0.58 m, so the simplified model allows passage. Sketch both
  walls moving inward by the inflation distance. The model assumes a circular
  footprint and a straight opening. In practice, clearance requirements also
  depend on uncertainty and the task.
]

== From a Floor Map to a Motion Search Space

#pair(
  card([Grid], [Represent free positions as cells. Choose neighbour moves and check that the transition between cells has clearance.]),
  card([Continuous space], [Represent poses with continuous coordinates. A sampling-based planner can propose poses and connect them with feasible motions.]),
)

#v(0.5em)
Smaller cells capture narrower passages and increase the number of states. Robots with steering constraints may also need heading in the state.

== Planning in Continuous Space With an RRT

#rrt-step(height: 6.6cm)

#caption[A Rapidly-exploring Random Tree (RRT) samples a configuration, then extends from the nearest tree vertex toward it. Add the solid orange segment if it passes the motion checks#cite(label("lavalle2006planning")).]

#speaker-note[
  The example uses a point robot in 2D. For a
  real robot, sample configurations, apply a suitable steering or propagation
  rule, and check the entire proposed motion for feasibility. The dashed
  segment is the remainder toward the sample. It is not yet part of the tree.
]

= Navigating With an Incomplete Map

== A Known Goal, an Unknown Target or Coverage?

#grid(columns: (1fr, 1fr, 1fr), gutter: 0.55cm, align: top,
  card([Known destination], [Plan to the mapped drop-off point and monitor route execution.]),
  card([Unknown target], [Explore areas that may contain the target. Stop when the target is confirmed.]),
  card([Coverage], [Visit the reachable area specified by the task. Track which parts have already been covered.]),
)

#v(0.45em)
#lead[What information is missing, and what observation would let the robot stop?]

== Exploring a Partly Known Floor

#exploration-map()

#caption[R marks the robot. A and B are examples of frontiers where known free space meets unexplored space#cite(label("yamauchi1997frontier")).]

#speaker-note[
  Define map frontiers before comparing them with the frontier of a graph
  search. A and B mark example cells rather than the complete boundary.
  The graph-search frontier is a data structure of candidate search nodes.
  The map frontier separates what the robot has observed from unknown space.
]

== Exercise: Which Frontier Should the Robot Visit?

#lead[On the previous map, compare A and B using four-neighbour moves through known free cells]

1. Count the shortest route in moves from R to each candidate frontier.
2. Suppose the robot expects to see more of the unknown area from A. What could justify going there first?
3. When the robot reaches its chosen frontier, which parts of the map and route might it update?

#speaker-note[
  Allow six minutes. A takes six moves and B takes five. B is cheaper under
  the unit-cost assumption. A may be worth the extra move if the expected
  observations can resolve useful uncertainty. After sensing, some unknown
  cells become free or occupied. Extract new frontier candidates and plan again.
  If the task is coverage, require a stopping criterion for the specified
  region, plus a definition of what counts as covered.
]

== From a Route to a Controller

- Localise the robot and choose a representation that captures the relevant constraints.
- Search for a route under that representation and check motion feasibility.
- Use new observations to update the route or resume exploration.

#v(0.45em)
#lead[Which decisions belong in the route planner, and which need immediate feedback from the robot?]
