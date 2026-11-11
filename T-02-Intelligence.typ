#import "@preview/touying:0.7.4": *
#import themes.metropolis: *
#import "utils.typ": *

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
    subtitle: [Intelligence],
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


// Vector illustrations are defined here; no additional image assets are required.
#let illustration(body, view-height: 260, width: 70%) = align(center, image(bytes(
  "<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 900 " + str(view-height) + "'>"
  + "<defs><marker id='arrow' markerWidth='8' markerHeight='8' refX='7' refY='4' orient='auto-start-reverse'><path d='M0,0 L8,4 L0,8 Z' fill='#23373b'/></marker><linearGradient id='food'><stop offset='0' stop-color='#f8fafb'/><stop offset='1' stop-color='#ffc17c'/></linearGradient></defs>"
  + "<style>text{font-family:Fira Sans,sans-serif;fill:#23373b;font-size:29px}.small{font-size:24px}.big{font-size:36px;font-weight:bold}.accent{fill:#eb811b}.box{fill:#edf3f4;stroke:#23373b;stroke-width:2}.edge{stroke:#23373b;stroke-width:3;fill:none;marker-end:url(#arrow)}</style>"
  + body + "</svg>"
), format: "svg", width: width))

#title-slide()

= Fundamental Questions

== What is Intelligence? (Part I)

*One word, very different behaviours*

#grid(columns: (1fr, 1fr), gutter: 1.3cm,
 [*A bacterium*

  Moves towards favourable conditions.

  *An ant colony*

  Organises exploration without a central controller.
 ],
 [*A human*

  Learns, reasons, invents and sometimes makes obvious mistakes.

  *An artificial system*

  Solves a problem, navigates a room or produces a fluent answer.
 ],
)

Which cases would you call intelligent? What evidence would change your answer?

== What is Intelligence? (Part II)

*“Intelligence is in the eye of the observer”*

The label reflects what an observer recognises as a meaningful achievement.

- Which *task* matters?
- What counts as *success*?
- Under which *conditions*?
- What *capabilities* do we expect from the system?

#v(0.5em)
We can make those choices explicit, then test the resulting claims.

== What is Intelligence? (Part III)

*Achieving goals across different environments*

Legg and Hutter connect intelligence with an agent's ability to succeed across a range of environments#cite(label("legg2007universal")).

For this course, ask:
- What can the system achieve?
- How does it cope with change, limited information and limited resources?
- How broadly does its competence transfer?

#v(0.5em)
Human similarity is one possible reference; it is not the only one.


= Life and Intelligence

== Life and Intelligence (Part I)

*Start from living systems, not only from human reasoning*

Living organisms face changing conditions and must sustain the processes that keep them alive.

- Obtain resources and manage disturbances.
- Respond to opportunities and threats.
- Coordinate activity within the organism and with its surroundings.

#v(0.6em)
Damasio's biological account connects these competences with the later emergence of minds, feelings and consciousness#cite(label("damasio2021feeling")).

== Life and Intelligence (Part II)

*Homeostasis: maintaining viable conditions*

- Keep essential variables within ranges compatible with life.
- Respond when nutrients, temperature or other conditions change.
- Regulate activity through feedback.

#illustration("<rect x='20' y='55' width='225' height='100' rx='12' class='box'/><text x='132' y='99' text-anchor='middle'>Sense</text><text x='132' y='132' text-anchor='middle'>conditions</text><rect x='335' y='55' width='230' height='100' rx='12' class='box'/><text x='450' y='99' text-anchor='middle'>Regulate</text><text x='450' y='132' text-anchor='middle'>activity</text><rect x='655' y='55' width='225' height='100' rx='12' class='box'/><text x='767' y='99' text-anchor='middle'>Change</text><text x='767' y='132' text-anchor='middle'>conditions</text><path d='M250 105 H330' class='edge'/><path d='M570 105 H650' class='edge'/><path d='M767 160 V220 H132 V160' class='edge'/>", view-height: 240)

Competence in maintaining life need not involve an explicit account of what the organism is doing.

== Life and Intelligence (Part III)

*An organism has both internal and external challenges*

#grid(columns: (1fr, 1fr), gutter: 1.4cm,
 [*Maintain life*

  Acquire energy, nutrients and materials.

  Regulate the conditions needed for continued activity.
 ],
 [*Avoid threats*

  Detect harmful conditions.

  Change activity or location to reduce danger.
 ],
)

#v(0.8em)
Here, “goal” describes the organisation of behaviour; it need not imply a consciously formulated intention.

== Life and Intelligence (Part IV)

*More differentiated bodies require coordination*

Multicellular organisms can contain specialised systems for movement, digestion, circulation and other functions.

- Nervous systems support coordination within many animal bodies.
- They connect information about internal conditions with information about the surroundings.
- In Damasio's account, this biological organisation also grounds feelings and conscious experience#cite(label("damasio2021feeling")).

#v(0.5em)
Life and successful regulation existed before nervous systems.

== Bacterial Competence (Part I)

*Useful behaviour without an explicit route or plan*

_Escherichia coli_ alternates swimming runs and tumbles. Chemical sensing biases movement towards favourable conditions#cite(label("berg1972chemotaxis")).

#illustration("<rect x='20' y='20' width='860' height='140' rx='12' fill='url(#food)'/><path d='M75 125 L155 80 L175 105 L290 130 L370 55 L430 85 L610 65 L800 60' class='edge'/><text x='35' y='210'>Lower attractant</text><text x='650' y='210'>Higher attractant</text><text x='450' y='250' text-anchor='middle' class='small'>Schematic biased random movement; not an experimental trajectory</text>", view-height: 270)

The organism responds effectively without explaining its actions or representing a symbolic route.

== Bacterial Competence (Part II)

*Chemical interaction can coordinate a population*

In quorum sensing, bacteria produce and detect chemical signals that can regulate collective activity#cite(label("diggle2007quorum")).

- Signal concentration depends on production and environmental conditions.
- Responses can alter gene expression and shared activities.
- Cooperation and conflict can both arise within the population.

#v(0.6em)
Sensing and coordinated responses do not require a nervous system or conscious deliberation.

= From Being to Knowing

== Explicit and Non-explicit Intelligence (Part I)

*Non-explicit competence maintains life without describing its own rules*

In Damasio's terminology, this competence can be embodied in chemical and physiological organisation#cite(label("damasio2021feeling")).

- Regulation proceeds without instructions formulated by the organism.
- Responses can support survival without an explicit model of the situation.
- A successful response need not be accompanied by conscious understanding.

#v(0.6em)
This is the broad biological sense in which we discuss intelligence before minds.

== Explicit and Non-explicit Intelligence (Part II)

*Explicit intelligence involves mental representations*

Objects, actions and relationships can be represented internally and brought into thought.

- Perception supplies information about current conditions.
- Memory brings past experience into the present.
- Reasoning can compare alternatives and their consequences.

#v(0.7em)
A person can imagine a situation, consider a response and explain the choice.

== Explicit and Non-explicit Intelligence (Part III)

*Human activity benefits from both forms of competence*

#table(columns: (1fr, 1fr), inset: 9pt, stroke: 0.4pt + rgb("d8dfe1"),
 [*Non-explicit*], [*Explicit*],
 [Much physiological regulation proceeds without deliberation.],
 [We can represent a problem and consciously consider alternatives.],
 [Example: adjustments involved in maintaining internal bodily conditions.],
 [Example: noticing thirst and deciding where to obtain water.],
)

#v(0.6em)
Conscious reasoning operates within a living body whose activity it does not continuously supervise.

== Feelings and Emotions (Part I)

*Feelings connect the state of the body with experience*

In Damasio's account, feelings are mental experiences related to the condition of the living organism#cite(label("damasio2021feeling")).

- Hunger, thirst and bodily comfort concern the state of life within us.
- Information from inside the body contributes through *interoception*.
- Body and nervous system interact continuously.

#v(0.6em)
A feeling is experienced by the organism, rather than being only a variable recorded by an external observer.

== Feelings and Emotions (Part II)

*An emotional response and the feeling of it are distinguishable*

#grid(columns: (1fr, 1fr), gutter: 1.3cm,
 [*Emotion*

  A coordinated biological state involving changes in bodily activity and behaviour.

  Example: a threatening event triggers defensive preparation.
 ],
 [*Feeling*

  The subjective experience associated with bodily conditions or an emotional response.

  Example: experiencing fear.
 ],
)

#v(0.5em)
Emotion includes mechanisms and responses, not only the conscious report of a feeling#cite(label("adolphs2018emotion")).

== Feelings and Emotions (Part III)

*Homeostatic feelings and emotional feelings*

#table(columns: (1fr, 1fr), inset: 9pt, stroke: 0.4pt + rgb("d8dfe1"),
 [*Homeostatic feelings*], [*Emotional feelings*],
 [Concern ongoing bodily conditions and their regulation.],
 [Accompany emotional responses to events, memories or imagined situations.],
 [Hunger, thirst, pain or bodily well-being.],
 [Experienced fear, anger, joy or sadness.],
)

#v(0.7em)
Remembering or imagining an event can also evoke an emotional response.

== Feelings and Emotions (Part IV)

*Affect participates in cognition*

What we perceive, remember, imagine and reason about can evoke affective responses.

- Bodily conditions contribute to what matters to the organism.
- Emotional responses can influence attention and action.
- Thought can change feelings, while feelings can change the course of thought.

#v(0.7em)
In this account, feelings form part of the context of human cognition rather than a separate output added after reasoning.

== Perception (Part I)

*Information comes from outside and inside the organism*

#text(size: 18pt)[
#table(columns: (1.2fr, 1.7fr, 1.8fr), inset: 8pt, stroke: 0.4pt + rgb("d8dfe1"),
 [*Mode*], [*Concerns*], [*Examples*],
 [Exteroception], [The surrounding world], [Seeing an obstacle; hearing a sound],
 [Proprioception], [Position and movement of the body], [Sensing the position of an arm],
 [Interoception], [Internal bodily conditions], [Signals contributing to thirst or awareness of a heartbeat],
)
]

#v(0.7em)
Perceptual representations are constructed from information; they are not the world itself#cite(label("damasio2021feeling")).

== Perception (Part II)

*The body is both what is sensed and part of the sensing system*

#grid(columns: (1fr, 1fr), gutter: 1.3cm,
 [*Perceiving the surroundings*

  External events affect sensory organs.

  The nervous system constructs representations of objects and events.
 ],
 [*Perceiving bodily conditions*

  The nervous system receives signals from the body and also regulates it.

  Changes in physiology affect subsequent signals and experience.
 ],
)

#v(0.6em)
Example: a sudden noise, a change in posture and a racing heart involve different, interacting sources of information.

== Mind and Consciousness (Part I)

*Mind as an ongoing production of mental contents*

Damasio describes mind through the production of images arising from perception, memory or their combination#cite(label("damasio2021feeling")).

- “Images” here are not restricted to visual pictures.
- They can concern sounds, bodily sensations, objects, actions and relationships.
- They carry information that can be recalled, combined and transformed.

#v(0.6em)
Recognising a voice and imagining a familiar place involve different kinds of mental content.

== Mind and Consciousness (Part II)

*Perspective gives experience a point of view*

A conscious experience occurs from the perspective of a particular organism.

- Its body has a location and a condition.
- Its sensory channels provide a situated view.
- Feelings connect mental activity with the state of that body.

#v(0.7em)
This first-person perspective differs from the external observer's judgement that a behaviour looks intelligent.

== Mind and Consciousness (Part III)

*Having mental processes and consciously experiencing them are different*

In Damasio's account, consciousness involves experiencing mental contents as occurring within one's own living organism.

- There is information about the world and about the body.
- Those contents are experienced from a personal perspective.
- The experience carries a sense that it is happening *to me*.

#v(0.6em)
Much information processing and bodily regulation occurs without becoming part of that experience.

== Mind and Consciousness (Part IV)

*Body, world and memory contribute to experience*

#illustration("<rect x='20' y='20' width='220' height='70' rx='10' class='box'/><text x='130' y='63' text-anchor='middle'>Body conditions</text><rect x='340' y='20' width='220' height='70' rx='10' class='box'/><text x='450' y='50' text-anchor='middle'>World</text><text x='450' y='80' text-anchor='middle'>perception</text><rect x='660' y='20' width='220' height='70' rx='10' class='box'/><text x='770' y='63' text-anchor='middle'>Memory</text><path d='M130 95 L360 175' class='edge'/><path d='M450 95 V170' class='edge'/><path d='M770 95 L540 175' class='edge'/><rect x='280' y='180' width='340' height='80' rx='12' class='box'/><text x='450' y='213' text-anchor='middle'>Experienced</text><text x='450' y='246' text-anchor='middle'>mental contents</text><text x='450' y='310' text-anchor='middle' class='small'>From the perspective of this living organism</text>", view-height: 325, width: 65%)

This is a conceptual summary of the biological account, not a diagram of brain regions.

Consciousness involves more than assembling an inventory of information#cite(label("damasio2021feeling")).

== Mind and Consciousness (Part V)

*A research problem, not a settled checklist*

Accounts of consciousness differ in their proposed mechanisms and in the evidence they seek to explain#cite(label("seth2022theories")).

- What makes information consciously experienced?
- How do bodily conditions and mental contents contribute?
- Which observations could distinguish competing explanations?

#v(0.7em)
For artificial systems, producing a convincing report of experience and establishing that experience exists remain different questions.

= Artificial Intelligence

== Artificial Intelligence (Part I)

*Human behaviour, human thought, or effective action?*

Russell and Norvig distinguish several approaches to artificial intelligence (AI)#cite(label("russell2021aima")).

#table(columns: (1fr, 1fr), inset: 10pt, stroke: 0.4pt + rgb("d8dfe1"),
 [*Human reference*], [*Rational reference*],
 [Thinking like humans], [Reasoning according to normative principles],
 [Acting like humans], [Acting effectively towards objectives],
)

#v(0.5em)
These choices imply different models and different evaluation criteria.

== Artificial Intelligence (Part II)

*An operational question about observable behaviour*

Turing's imitation game replaces an abstract question about thinking with a test based on conversational interaction#cite(label("turing1950computing")).

- Specify what the evaluator can observe.
- Compare responses under defined conditions.
- Judge behaviour through that interface.

#v(0.6em)
A successful test demonstrates performance under its conditions; it does not identify the internal mechanism.

== Artificial Intelligence (Part III)

*Three distinct dimensions of a system*

#table(columns: (1fr, 2.6fr), inset: 9pt, stroke: 0.4pt + rgb("d8dfe1"),
 [*Dimension*], [*Question*],
 [Intelligence], [What can the system achieve, and under which conditions?],
 [Autonomy], [Which decisions and actions does it control?],
 [Consciousness], [Does it have subjective experience? How could we establish that?],
)

#v(0.7em)
Fluent language, effective action and extensive autonomy do not by themselves settle the question of consciousness.


= Human Intelligence and Stupidity

== The Basic Laws of Human Stupidity (Part I)

*Carlo M. Cipolla's satirical lens on human behaviour*

Paraphrasing the first three laws#cite(label("cipolla2021stupidity")):

+ We systematically underestimate how widespread stupidity is.
+ Cipolla assumes independence between stupidity and a person's other characteristics.
+ Stupidity harms others while the actor gains nothing or also loses.

#v(0.7em)
A deliberately provocative essay about consequences, not a psychometric theory of intelligence.

== The Basic Laws of Human Stupidity (Part II)

*The danger lies in underestimating destructive behaviour*

Paraphrasing the remaining laws#cite(label("cipolla2021stupidity")):

#enum(start: 4,
 [Other people fail to anticipate the damage stupidity can cause.],
 [Cipolla ranks the stupid actor as the most dangerous type, even compared with the self-interested wrongdoer.],
)

#v(0.8em)
Being knowledgeable or technically skilled does not ensure that one's actions produce good outcomes.

== The Basic Laws of Human Stupidity (Part III)

*Evaluate consequences for the actor and for others*#cite(label("cipolla2021stupidity"))

#illustration("<rect x='100' y='40' width='350' height='190' fill='#e6eff2'/><rect x='450' y='40' width='350' height='190' fill='#e1f1e8'/><rect x='100' y='230' width='350' height='190' fill='#f6e6e3'/><rect x='450' y='230' width='350' height='190' fill='#fff0d8'/><path d='M75 230 H835' class='edge'/><path d='M450 445 V15' class='edge'/><text x='275' y='120' text-anchor='middle' class='big'>Helpless</text><text x='275' y='160' text-anchor='middle'>Self − / Others +</text><text x='625' y='120' text-anchor='middle' class='big'>Intelligent</text><text x='625' y='160' text-anchor='middle'>Self + / Others +</text><text x='275' y='310' text-anchor='middle' class='big'>Stupid</text><text x='275' y='350' text-anchor='middle'>Self − / Others −</text><text x='625' y='310' text-anchor='middle' class='big'>Bandit</text><text x='625' y='350' text-anchor='middle'>Self + / Others −</text><text x='830' y='265' text-anchor='end' class='small'>Effect on the actor →</text><text x='460' y='30' class='small'>Effect on others ↑</text><text x='450' y='485' text-anchor='middle' class='small'>Gains and losses; zero-payoff boundary cases lie on the axes.</text>", view-height: 500, width: 55%)

== The Basic Laws of Human Stupidity (Part IV)

*Whose success are we measuring?*

Imagine a navigation system that saves its users time by diverting traffic through residential streets.

- Who gains, and who bears the costs?
- What changes when everyone uses the same strategy?
- Which time horizon and system boundary matter?

#v(0.7em)
A system can optimise its local objective while producing undesirable collective consequences.


= Digression: Fast, Slow and Artificial Thinking

== Thinking, Fast, Slow and Artificial (Part I)

*Kahneman's two modes of thinking*

#table(columns: (1fr, 1fr), inset: 10pt, stroke: 0.4pt + rgb("d8dfe1"),
 [*System 1*], [*System 2*],
 [Fast, automatic and associative.], [Effortful, deliberative and demanding of attention.],
 [Recognising a familiar face or understanding a simple phrase.], [Checking a calculation or comparing alternatives.],
)

#v(0.6em)
Fast processing can be highly competent; deliberate reasoning can also be mistaken. These are functional descriptions, not two anatomical boxes#cite(label("kahneman2011thinking")).

== Thinking, Fast, Slow and Artificial (Part II)

*AI assistance introduces an external contribution*

Shaw and Nave propose a *System 3*: artificial cognition consulted outside the human brain#cite(label("shaw2026thinking")).

- It can supplement intuition and deliberation.
- It can also supply an answer that the person adopts without checking.
- Their experiments show that correct advice can help while faulty advice can reduce performance.

#v(0.7em)
A proposed framework from a research paper: the question is how AI changes the overall process of human judgement.

== Thinking, Fast, Slow and Artificial (Part III)

*External help does not remove the need for judgement*

#grid(columns: (1fr, 1fr), gutter: 1.2cm,
 [*Cognitive offloading*

  An external aid reduces demands on internal processing#cite(label("risko2016offloading")).

  We can still define the task and evaluate the result.
 ],
 [*Cognitive surrender*

  AI output is adopted with little scrutiny, replacing personal evaluation#cite(label("shaw2026thinking")).

  A plausible answer is accepted without adequate checking.
 ],
)

#v(0.6em)
For this course: keep the cognitive locus on the person who uses the tool.

= Conclusion

== Intelligence Beyond Explicit Reasoning (Part I)

*From maintaining life to experiencing and knowing*

- Living systems exhibit competence before explicit reasoning.
- Nervous systems support coordination and representations.
- Perception concerns both the surroundings and the body.
- Emotions and feelings participate in the regulation and experience of life.
- Mind, perspective and consciousness introduce further questions about experience.

== Intelligence Beyond Explicit Reasoning (Part II)

*Which capabilities do our artificial systems actually need?*

We can take inspiration from regulation, perception, memory, coordination and reasoning.

- Which principles can we model and reproduce?
- Which kinds of competence suit the task and environment?
- What would we need to demonstrate, rather than merely attribute, intelligence?
- What would consciousness add, and how could we establish it?

#v(0.6em)
Design decisions start from the capabilities required, not from assuming a complete human-like mind.
