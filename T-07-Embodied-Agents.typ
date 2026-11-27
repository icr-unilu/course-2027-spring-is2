#import "@preview/touying:0.7.4": speaker-note, themes
#import themes.metropolis: title-slide
#import "themes/embodied.typ": embodied-theme
#import "slide-components.typ": lead, caption, pair, card
#import "diagrams.typ": agent-environment
#import "themes/robotics-diagrams.typ": belval-map, braitenberg-vehicles

#let hangzhou-credit = [
  Photos: Matteo Magnini, #link("https://github.com/icr-unilu/course-2026-winter-stai/blob/98d81d687bee2248af50d4034c07b7ba51055913/01-artificial-intelligence-101.typ")[STAI · Artificial Intelligence 101]. Cropped for these slides.
]

#let robot-photo(filename, height) = block(
  width: 100%, height: height, clip: true, radius: 4pt,
  image("images/T-07/" + filename, width: 100%, height: 100%, fit: "cover"),
)

#let companion-photo(filename, name, description) = grid(
  columns: (1.1fr, 1fr), gutter: 12pt, align: left + horizon,
  robot-photo(filename, 4cm),
  [
    #text(weight: "semibold", size: 17pt, name)
    #v(3pt)
    #text(size: 14pt, fill: rgb("#53666a"), description)
  ],
)

#let hangzhou-gallery(filename, name, description, first, second) = [
  #grid(
    columns: (1.2fr, 1fr), gutter: 18pt, align: top,
    [
      #robot-photo(filename, 7.9cm)
      #v(6pt)
      #text(weight: "bold", size: 21pt, name)
      #h(9pt)
      #text(size: 15pt, fill: rgb("#53666a"), description)
    ],
    stack(dir: ttb, spacing: 10pt, first, second),
  )
  #v(0.25em)
  #caption(hangzhou-credit)
]

#show: embodied-theme.with([Embodied Agents])

#title-slide()

#speaker-note[
  90 minutes. Allow 25 min for embodiment and situatedness, 8 min for the historical
  digression, 15 min for Braitenberg vehicles and 42 min for the delivery case,
  exercise and discussion. The Belval map is fictional and schematic.
]

= Bodies in Environments

== Embodied AI in Hangzhou

#hangzhou-gallery(
  "delivery-robot.jpg", [Delivery robot], [Navigates a building],
  companion-photo("coffee-station.jpg", [Coffee station], [Positions a cup and pours.]),
  companion-photo("humanoid-bartender.jpg", [Humanoid bartender], [Manipulates objects at a counter.]),
)

#speaker-note[
  Compare the mobile platform with the fixed coffee station and the humanoid
  bartender. Ask where each body's constraints enter the task. The delivery
  platform motivates the fictional Belval case.
]

== Locomotion Beyond Corridors

#hangzhou-gallery(
  "unitree-quadruped.jpg", [Unitree quadruped], [Steps over uneven terrain],
  companion-photo("agricultural-robot.jpg", [Agricultural robot], [Works between plant rows.]),
  companion-photo("rover.jpg", [Rover prototype], [Traverses a rough surface.]),
)

#speaker-note[
  Ask which parts of the terrain each platform can cross and what it needs
  to sense. Use these practical differences to introduce the robot's body.
]

== A Delivery Robot at Belval

#lead[Carry a parcel from the lab to a drop-off point]

#belval-map()

#caption[A schematic route. A is the lab and C is the delivery point. Edge labels are simplified travel costs.]

#speaker-note[
  Opening prompt. If we give the robot a route as a list of corridors, what does it
  still need to know or do to get there? Collect examples before introducing the loop.
]

== The Agent–Environment Loop

#agent-environment(height: 7cm)

#caption[Wheel commands change the robot's pose. This changes what its sensors observe next.]

== Embodiment, Situatedness and Autonomy

#grid(columns: (1fr, 1fr, 1fr), gutter: 0.55cm, align: top,
  card([Embodiment], [The body determines how the agent can sense and act.]),
  card([Situatedness], [The agent acquires information and acts in its current environment.]),
  card([Autonomy], [The agent can make some decisions without immediate external control.]),
)

#v(0.45em)
A human may choose the destination while the robot selects how to move#cite(label("mataric2007robotics"))#cite(label("roli2019robotics")).

== From World State to Sensor Reading

- The world includes the robot's pose, obstacles and the door's actual condition.
- The robot receives measurements such as range readings or wheel rotation.
- It estimates relevant quantities from measurements, prior information and often a history of actions.

#v(0.45em)
#lead[Could two different situations give the robot the same reading?]

#speaker-note[
  A person and a trolley at the same distance can produce similar range readings.
  Two visually similar corridors can be confused. Ask which ambiguity matters for
  safe stopping and which matters for selecting the next corridor.
]

== The Body Changes the Task

#pair(
  card([Sensing], [The robot's sensor position and field of view determine when a person approaching a corner becomes visible.]),
  card([Actuation], [The robot's width, turning ability and braking distance determine which manoeuvres are feasible.]),
)

#v(0.5em)
A corridor that looks passable on the map may be too narrow for a loaded robot.

== Feedback and Operating Conditions

#lead[Compare the intended motion with the motion actually observed]

- Wheel slip changes the relation between commanded and actual motion.
- Feedback lets the controller correct some deviations as it moves.
- The robot's operating conditions specify where its sensing and motion can be expected to work.

#v(0.4em)
A controller calibrated for a dry floor may need other settings on a slippery surface.

= A Brief History of Robotics

== From Preset Motion to Feedback and Planning

#grid(columns: (1.45fr, 1fr), gutter: 20pt, align: horizon,
  [
    #lead[Preset motion]
    #linebreak()
    Leonardo's cart encoded a sequence of movements mechanically.
    #v(0.5em)
    #lead[Sensor feedback]
    #linebreak()
    Light and contact signals changed how Grey Walter's tortoises moved#cite(label("winfield2012robotics")).
    #v(0.5em)
    #lead[Symbolic planning]
    #linebreak()
    Shakey used a model of its surroundings to plan a sequence of actions#cite(label("nilsson1984shakey")).
  ],
  [
    #align(center, image("images/T-07/shakey.jpg", height: 8.35cm))
    #v(0.2em)
    #caption[
      Shakey at the Computer History Museum.
      #link("https://commons.wikimedia.org/wiki/File:SRI_Shakey_robot,_1969,_Computer_History_Museum.jpg")[The wub],
      #link("https://creativecommons.org/licenses/by-sa/4.0/")[CC BY-SA 4.0]. Resized.
    ]
  ],
)

#speaker-note[
  Keep this digression to eight minutes. Ask where the next turn comes from in
  each example. Walter's robots are the bridge to Braitenberg. Shakey's
  planning work at the Stanford Research Institute sets up the next lecture.
]

= Braitenberg Vehicles

== Predict the First Turn

#braitenberg-vehicles()

#caption[The same light is ahead and to the left. An excitatory link speeds up a wheel. An inhibitory link slows it down.]

#speaker-note[
  Adapted from the four vehicle examples in STAI AI-101 and Andrea Roli's
  Braitenberg Vehicles slides. Assume the same positive baseline speed for
  both wheels and keep the vehicle's starting pose fixed. Have students
  predict the initial turn before showing the next slide.
]

== Four Circuits, Four Behaviours

#braitenberg-vehicles(reveal-turn: true)

#caption[The arrows show initial turns. The wiring also changes how speed varies with the light intensity#cite(label("braitenberg1984vehicles")).]

#speaker-note[
  The brighter left sensor makes the connected wheel faster in Vehicle 2
  and slower in Vehicle 3. A differential-drive vehicle turns towards the
  slower wheel. The classic names describe the visible behaviour. The
  drawing gives the first turn from this pose. Have students move the light
  in the next slide to see how changing readings redirect the vehicle.
]

== Try It: Braitenberg Playground

#lead[Change the wiring while keeping the light and starting pose fixed]

1. In #link("https://www.braitenberg.world/")[*Braitenberg World*], compare same-side and crossed excitatory links.
2. Check the first turn, then watch the trajectories diverge.
3. Move the light or add a second source and predict what will change.

#v(0.5em)
The #link("https://www.webandcircuits.com/lab/vehicles/")[*Vehicle Builder Sandbox*] also lets you compare all four presets shown here.

#speaker-note[
  Budget four to five minutes within the Braitenberg digression. The core
  comparison is 2a versus 2b. If time permits, change the sign of the links
  while retaining a positive base speed to connect to vehicles 3a and 3b.
]

= Designing for the Physical Task

== Frames of Reference

#belval-map(height: 5.25cm)

#pair(
  card([Robot frame], [A range measurement reports a person ahead and to the left.]),
  card([Map frame], [A waypoint identifies the junction regardless of the robot's heading.]),
)

#speaker-note[
  Rotate the robot in a sketch while keeping the person fixed. The person's map
  position is unchanged, but their bearing in the robot frame changes. Ask what
  the controller needs to align those frames.
]

== What Should the Robot Estimate?

- *For stopping:* distance to obstacles along the current direction of travel.
- *For following a route:* pose relative to the next waypoint.
- *For choosing a route:* whether the door or corridor is currently passable.

#v(0.45em)
These estimates use different evidence and may be updated at different rates.

== Exercise: The Blind Corner

#lead[A person may step out just beyond the corner]

1. Identify an observation the robot can use before and after the person becomes visible.
2. Name a relevant physical limit of the body.
3. Choose an action when visibility is poor and an action when the path becomes obstructed.

#speaker-note[
  Allow eight minutes in pairs, then compare answers. Example: infer limited
  visibility from map geometry or local sensing, detect the person once visible,
  and reduce speed before entering the corner. If the path is obstructed, stop
  within the measured stopping envelope. Ask who chooses the destination and who
  chooses the immediate motion.
]

== Debrief: Which Loop Closes?

#pair(
  card([Navigation], [At the junction, choose a corridor using the current route and what is known about access.]),
  card([Motion], [Approach slowly near the corner and adjust motion as new measurements arrive.]),
)

#v(0.5em)
The delivery objective constrains both decisions. The two decisions need different information and timing.

== Where the Next Lectures Start

- *Planning* asks which sequence of actions can reach the delivery goal.
- *Navigation and search* locate the robot and find a feasible route.
- *Robot controller architectures* determine which component makes each decision.
- *Robot learning* improves behaviour from demonstrations or interaction.
- *Swarm robotics* studies how robots coordinate through local interactions.

#v(0.45em)
#lead[At every level, ask what the robot senses, what it can do and how the environment can change.]
