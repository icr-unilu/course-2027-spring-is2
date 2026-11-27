#import "@preview/touying:0.7.4": themes, speaker-note
#import themes.metropolis: title-slide
#import "themes/embodied.typ": embodied-theme, lesson-table
#import "slide-components.typ": lead, caption, pair, card
#import "diagrams.typ": agent-environment
#import "themes/robotics-diagrams.typ": belval-map, delivery-episode

#show: embodied-theme.with([Robot Learning])

#title-slide()

#speaker-note[
  90 minutes. Allow 18 min for learning targets and imitation, 25 min for the
  decision model, 27 min for Q-learning including a worked update, and 20 min
  for evaluation and transfer.
]

= What Can a Robot Learn?

== Learning Within the Control Loop

#agent-environment(height: 6.7cm)

#caption[Experience from the loop can be used to improve a component, from perception to action selection.]

== What Changes With Experience?

#grid(columns: (1fr, 1fr, 1fr), gutter: 0.55cm, align: top,
  card([Perception], [Recognise the dock from camera images.]),
  card([Dynamics], [Predict how the robot moves on different floors for a given command.]),
  card([Policy], [Select a docking or navigation action from the current input.]),
)

#v(0.5em)
The same robot can combine learned and hand-designed components#cite(label("kober2013robotics")).

== What Supervision Is Available?

#lesson-table((1.35fr, 1.85fr, 2.05fr),
  table.header([Learning approach], [Available signal], [Example]),
  [Supervised learning], [Target labels or values], [Detect the dock in labelled images],
  [Unsupervised learning], [Observations without target labels], [Group recurring sensing patterns],
  [Reinforcement learning], [Rewards for actions and outcomes], [Improve a policy for reaching and docking at C],
)

#v(0.4em)
Demonstrations can also provide labelled actions for learning a policy.

== Imitation From Demonstrations

#pair(
  card([Behaviour cloning], [Record observations and commands from a demonstrator. Train a policy to predict the demonstrated command.]),
  card([Distribution shift], [Small errors can take the robot to situations the demonstrator rarely visited. Further examples can cover recovery.]),
)

#v(0.55em)
#lead[Which docking demonstrations would you collect besides successful approaches?]#cite(label("ross2011imitation"))

= Reinforcement Learning

== Decisions at Belval

#belval-map(door: "open", height: 5.7cm)

#caption[For the learning example, the 2 and 3 are route-planning costs. We specify environment rewards separately.]

#speaker-note[
  Use a tabular toy environment. At each waypoint, legal actions are moves to
  neighbouring waypoints. At C, Dock ends an episode successfully. A collision
  can end an episode unsuccessfully in a stochastic extension used later.
]

== An Episodic Decision Model

- *State* $s$: current waypoint or the terminal state after docking.
- *Action* $a$: move to a legal neighbour, or dock at C.
- *Transition* $P(s' | s,a)$: probability of the next state.
- *Reward* $r$: scalar feedback observed after the action.

#v(0.4em)
In a *Markov decision process (MDP)*, the current state and action determine the distribution of the next state and reward#cite(label("sutton2018reinforcement")).

== State and Observation on the Real Robot

#pair(
  card([In the toy model], [The waypoint is fully observed. We assume it is enough to predict outcomes given each action.]),
  card([On the robot], [A sensor snapshot can be compatible with several poses, speeds or door conditions. Estimation can use observation history.]),
)

#v(0.5em)
The features given to a policy determine what distinctions it can make.

== Policy, Reward and Return

#lead[The policy specifies action selection. Return evaluates outcomes over time]

- A deterministic policy $pi(s)$ chooses an action. A stochastic policy assigns probabilities to actions.
- The toy robot receives $-0.1$ per move and $+1$ for successful docking. Successful docking ends the episode.
- The discount factor $gamma$ controls how strongly later rewards contribute to return.

#align(center)[$ G_t = r_(t+1) + gamma r_(t+2) + gamma^2 r_(t+3) + dots $]

#speaker-note[
  In an episode the sum stops at termination; equivalently, pad later rewards
  with zeros. Ask why arriving at C and docking give different outcomes.
  A physical collision would need explicit evaluation, regardless of the reward.
]

== A Delivery Episode

#delivery-episode()

#caption[Each arrow shows the action and the reward it produces. Reaching C still leaves the docking action to be taken.]

#speaker-note[
  With gamma equal to 0.9, the return before taking the first move is
  −0.10 + 0.9 × (−0.10) + 0.9² × 1 = 0.62. Before moving from B,
  the return along the same episode is 0.80. Ask students which transition
  reaches a terminal state before presenting the Q-learning update.
]

== What Does Q Represent?

#align(center)[$ Q^pi(s,a) = EE[G_t | S_t=s, A_t=a] $]

- Start in state $s$ and take action $a$.
- Follow policy $pi$ for the subsequent decisions.
- The expected return depends on both the action and what happens afterwards.

#v(0.45em)
$Q^*(s,a)$ uses optimal subsequent decisions. A greedy policy selects a legal action with the largest optimal action value#cite(label("sutton2018reinforcement")).

= Learning From Experience

== The Q-Learning Update

#lead[Update the value of the action just taken from a sampled transition]

#align(center)[$ y = r + gamma max_(a') Q(s',a') $]

#align(center)[$ Q(s,a) <- Q(s,a) + alpha (y - Q(s,a)) $]

- $alpha$ is the learning rate.
- The maximum ranges over actions available at $s'$.
- For a terminal transition, use $y=r$.

#caption[Tabular Q-learning uses the observed reward and next state without requiring an explicit transition model#cite(label("sutton2018reinforcement")).]

== Exercise: Update the Move from B to C

#lead[The robot moves to C and has yet to dock]

#lesson-table((2.4fr, 1fr),
  table.header([Quantity], [Value]),
  [$Q("B", "move to C")$ before the update], [0.20],
  [Reward for the move], [$-0.10$],
  [Best current estimate at C], [0.80],
  [Learning rate $alpha$ and discount $gamma$], [0.50 and 0.90],
)

#v(0.4em)
Compute the target and the updated action value. How would the target change on a successful docking transition?

#speaker-note[
  Allow four minutes. The target for the move is -0.10 + 0.90 × 0.80 = 0.62.
  The updated value is 0.20 + 0.50 × (0.62 - 0.20) = 0.41.
  Reaching C is nonterminal here. The subsequent docking transition is
  terminal, so its target is the docking reward, +1.
]

== Worked Update and Exploration

#align(center)[$ y = -0.10 + 0.90 times 0.80 = 0.62 $]

#align(center)[$ Q_"new" = 0.20 + 0.50 times (0.62 - 0.20) = 0.41 $]

For successful docking, the target is $y=+1$.

- *Exploit:* choose an action with the highest current value.
- *Explore:* sometimes try a different available action to gather evidence.
- In simulation, an $epsilon$-greedy strategy chooses a random legal action with probability $epsilon$, and a greedy action otherwise.

#speaker-note[
  Keep exploratory behaviour in the toy simulation for this exercise. The
  safety requirements of an actual robot are a separate engineering concern.
]

= Evaluation and Transfer

== Why Train in Simulation?

#pair(
  card([What it buys], [Repeat trials under controlled conditions and vary scenarios without wearing the hardware.]),
  card([What may differ], [Wheel friction, sensor noise, latency and physical contact can differ from the real robot.]),
)

#v(0.55em)
*Domain randomisation* varies selected simulator parameters during training. Real-world evaluation tests how well the resulting policy transfers#cite(label("tobin2017randomization")).

== What Counts as an Improvement?

- Compare against a baseline, such as a hand-designed docking controller.
- Use held-out starting positions and conditions. Repeat across episodes and, when the method is stochastic, across training seeds.
- Report delivery success, collision or intervention rate, and time to successful delivery separately.

#v(0.5em)
#lead[Would you use a faster policy if it also increased collision frequency?]

#speaker-note[
  Have students choose one baseline, a test environment variation (for example
  a different friction setting), and a metric with a clear denominator. Discuss
  why time measured only for successful runs must be read alongside success rate.
]

== Planning, Control and Learning at Belval

#grid(columns: (1fr, 1fr, 1fr), gutter: 0.55cm, align: top,
  card([Plan], [Select a route and the operations needed to deliver the parcel.]),
  card([Control], [Execute the route and respond to what happens in the corridor.]),
  card([Learn], [Improve components such as dock perception or the docking policy from experience.]),
)

#v(0.5em)
#lead[For each learned component, specify its inputs, where it acts in the controller and how improvement is measured.]
