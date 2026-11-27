#import "@preview/touying:0.7.4": themes, speaker-note
#import themes.metropolis: title-slide
#import "themes/embodied.typ": embodied-theme, lesson-table
#import "slide-components.typ": lead, caption, pair, card
#import "diagrams.typ": agent-environment
#import "themes/robotics-diagrams.typ": belval-map, double-bridge, retrieval-controller

#show: embodied-theme.with([Swarm Robotics])

#title-slide()

#speaker-note[
  90 minutes. Allow 15 min for local and collective behaviour, 25 min for ant
  trails and the double bridge, 30 min for task allocation and the retrieval
  case, and 20 min for the experiment design exercise and debrief.
]

= From One Robot to a Group

== Twelve Delivery Robots at Belval

#belval-map(height: 6.6cm, door: "open")

#caption[Each robot can choose a route. The group also needs to manage shared corridors and avoid bottlenecks.]

#speaker-note[
  Ask who would decide which robot moves next if both approaches to the
  delivery point are occupied. Contrast a dispatcher that assigns each trip
  with robots acting on local information, using the same task in both cases.
]

== Coordination Through Local Interactions

#agent-environment(height: 6.65cm, agent-label: "One robot")

#caption[Other robots are part of each robot's environment. Their actions can change what it senses and what it can do next.]

== What Makes It Swarm Robotics?

- Each robot makes decisions using locally available information.
- Coordination emerges through repeated interactions with neighbours and the environment.
- The designer evaluates the behaviour of the group as well as that of each robot.

#v(0.5em)
Robot swarms can be evaluated for robustness, scalability and flexibility#cite(label("brambilla2013swarm"))#cite(label("roli2019swarm")).

== Why Add More Robots?

#grid(columns: (1fr, 1fr, 1fr), gutter: 0.55cm, align: top,
  card([Parallel work], [Multiple robots can retrieve different objects at the same time.]),
  card([Redundancy], [Another robot can take over a task when it has the required capabilities and access.]),
  card([Interference], [Robots may block each other or compete for space at the drop-off point.]),
)

#v(0.5em)
A group can deliver more objects per minute while delivering fewer objects per robot-minute.

= Stigmergy and Self-Organisation

== Coordination Through a Shared Environment

#pair(
  card([Direct interaction], [A robot broadcasts its local position and a nearby robot receives the message.]),
  card([Stigmergy], [A robot leaves a local mark. Later robots change their actions after sensing that mark.]),
)

#v(0.5em)
A shared mark can persist after the robot that wrote it has left.

== Ant Foraging: The Double Bridge

#grid(columns: (1fr, 1.45fr), gutter: 18pt, align: horizon,
  [
    #image("images/T-12/argentine-ant.jpg", width: 100%)
    #v(0.3em)
    #caption[
      Argentine ant. #link("https://commons.wikimedia.org/wiki/File:Argentine_Ant_(Linepithema_Humile).jpeg")[Exilpatriot],
      #link("https://creativecommons.org/licenses/by-sa/4.0/")[CC BY-SA 4.0]. Resized.
    ]
  ],
  [
    #lead[Which branch gets reinforced first?]
    #double-bridge(height: 4.7cm)
    #caption[Two branches connect nest and food. The lengths are schematic#cite(label("goss1989shortcuts")).]
  ],
)

#speaker-note[
  Before discussing the mechanism, ask whether a single ant has to compare
  path lengths. Sketch two ants leaving at the same time and ask where the
  first return trip can contribute to marking the bridge.
]

== How One Trail Becomes Stronger

1. Ants exploring the bridge can deposit pheromone as they move.
2. A better-marked branch is more likely to be selected by subsequent ants.
3. Faster round trips can reinforce the shorter branch sooner.
4. Pheromone decay reduces the influence of marks that are no longer reinforced.

#v(0.45em)
Early variation gets amplified. With equal branches, an initial fluctuation can favour either side#cite(label("goss1989shortcuts")).

#speaker-note[
  Distinguish the general phenomenon of reinforcement from a guarantee of the
  shortest route. Discuss what could happen if a strong trail already exists
  before a shortcut opens. Mention decay as one mechanism for forgetting.
]

== Translate the Mechanism to Robots

#lesson-table((1.3fr, 1.95fr, 1.9fr),
  table.header([Mechanism], [Ant colony], [Possible robot implementation]),
  [Write locally], [Deposit pheromone on the trail], [Boost a local marker after a successful trip],
  [Read locally], [Prefer a stronger trail probabilistically], [Bias branch choice using nearby marker values],
  [Forget], [Pheromone decays over time], [Reduce the recorded signal as it ages],
)

#v(0.4em)
#lead[What happens when a well-marked corridor becomes blocked?]

#speaker-note[
  Ask what physically stores and exposes each marker. A writable floor beacon
  is a possible design assumption. Ask students to propose a role for exploration,
  decay or immediate obstacle detection, and say which signal each robot needs.
]

= Division of Labour

== How Could the Queue Recruit More Robots?

- In response-threshold models of insect colonies, a task has an associated stimulus.
- An individual with a lower threshold is more likely to respond at the same stimulus level.
- For delivery robots, a locally visible backlog can be the stimulus. Idle robots decide whether to join.

#v(0.5em)
#lead[The stimulus and the response are local. The number of active robots is a group outcome.]#cite(label("bonabeau1998thresholds"))

== A Probabilistic Response Threshold

#align(center)[$ P("start" | s, theta_i) = s^2 / (s^2 + theta_i^2) $]

- $s >= 0$ is the task stimulus and $theta_i > 0$ is robot $i$'s threshold.
- At $s=theta_i$, an idle robot starts with probability $1/2$ per decision.
- For $s=2$, thresholds $1$ and $4$ give start probabilities $0.8$ and $0.2$.

#caption[Fixed response-threshold model with exponent two#cite(label("bonabeau1998thresholds")).]

#speaker-note[
  Ask what happens when the queue clears or the observation interval changes.
  Explain that the formula governs entry into the active state. Specify stopping
  or reassessment separately. This is a separate model from the adaptive
  probability in the following case.
]

== Case Study: Distributed Object Retrieval

#lead[Robots have to find scattered objects and bring them back to the nest]

- An idle robot decides when to search.
- Each robot detects objects and landmarks using its own sensors.
- A local controller handles searching, retrieving and returning.

#v(0.45em)
Labella and colleagues tested the controller with physical robots and in simulation#cite(label("labella2006division")).

== An Individual Retrieval Controller

#retrieval-controller(height: 7.1cm)

#caption[Each robot executes this controller. Departure from rest is probabilistic. Search ends on a detection or a timeout#cite(label("labella2006division")).]

#speaker-note[
  This is a schematic of the logical states in the retrieval study. The two
  outcomes of search provide different feedback to the robot. Follow both
  paths back to Rest before introducing the departure probability update.
]

== Adaptation From Local Experience

#pair(
  card([Successful retrieval], [Increase the robot's probability of leaving the nest to search again.]),
  card([Search timeout], [Decrease the probability of leaving after the unsuccessful trip.]),
)

#v(0.5em)
Robots with different local histories can spend different amounts of time searching#cite(label("labella2006division")).

== What Did the Experiment Measure?

- Compare adaptive departure probabilities with a control group using a fixed probability.
- Use matched scenarios for where and when objects appear.
- Measure retrieval performance and efficiency. The efficiency index divides the number of retrieved objects by the sum of robots' time on duty.

#v(0.45em)
The study reported efficiency gains from adaptation in its test settings and identified interference as group size increased#cite(label("labella2006division")).

= Designing and Evaluating a Swarm

== Specialisation by Assignment or by Body

#pair(
  card([Task allocation], [Comparable robots can choose whether to search, retrieve or rest. Their activity can change as conditions change.]),
  card([Different bodies], [Swarmanoid combines foot-bots for ground motion, hand-bots for manipulation and eye-bots for aerial sensing.]),
)

#v(0.5em)
Changing the physical capabilities changes which robots can take over each task#cite(label("dorigo2013swarmanoid")).

== Exercise: Test the Delivery Swarm

#lead[The approach to the drop-off point can narrow to a single lane]

1. Give each robot a local rule for deciding when to enter or wait.
2. Name the observation the rule requires. Explain how the robot obtains it.
3. Design a comparison across two group sizes and choose one performance and one interference measure.

#speaker-note[
  Allow eight minutes in pairs. Example local rule: depart only when the
  robot detects a free approach and the local waiting area exceeds a threshold.
  A randomized retry can reduce repeated simultaneous starts. Compare equal
  delivery demand with, for example, 4 and 12 robots. Track parcels per minute
  and queue delay or blocked passages. Use the same layouts and demand traces
  and repeat trials. Ask who can act when robots cannot see each other.
]

== From Local Rules to Evidence

- Specify what each robot senses, what it can do and what information it can share.
- Identify the collective outcome and the feedback that could produce it.
- Test whether the outcome persists under congestion, component failures and changes in task demand.

#v(0.5em)
#lead[Which parts of the biological mechanism survived the translation to a robot controller?]
