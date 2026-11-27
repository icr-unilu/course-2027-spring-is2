#import "../diagrams.typ": diagram

#let svg-text(x, y, caption, style: "label", anchor: "middle") = (
  "<text x='" + str(x) + "' y='" + str(y) + "' text-anchor='" + anchor +
  "' class='" + style + "'>" + caption + "</text>"
)

#let svg-rect(x, y, width, height, style: "node") = (
  "<rect x='" + str(x) + "' y='" + str(y) + "' width='" + str(width) +
  "' height='" + str(height) + "' rx='12' class='" + style + "'/>"
)

#let belval-map(height: 6.6cm, door: "door", detour: false) = {
  let route-edge(d, highlighted: false, blocked: false) = {
    let color = if highlighted { "#eb811b" } else { "#53666a" }
    let width = if highlighted { "7" } else { "4" }
    ("<path fill='none' d='" + d + "' stroke='" + color +
    "' stroke-width='" + width + "'" +
    (if blocked { " stroke-dasharray='11 8'" } else { "" }) + "/>")
  }
  let waypoint(x, y, label) = (
    "<circle cx='" + str(x) + "' cy='" + str(y) + "' r='25' class='node'/>" +
    svg-text(x, y + 9, label)
  )
  diagram(
    route-edge("M154 165 L466 77", highlighted: detour) +
    route-edge("M514 77 L846 165", blocked: door == "blocked") +
    route-edge("M154 181 L466 270", highlighted: detour) +
    route-edge("M514 270 L846 181", highlighted: detour) +
    svg-text(305, 110, "2") + svg-text(697, 109, "2") +
    svg-text(304, 237, "3") + svg-text(703, 238, "3") +
    svg-rect(619, 108, 15, 21, style: "accent") +
    svg-text(666, 162, door, style: "small") +
    waypoint(130, 173, "A") + waypoint(490, 70, "B") +
    waypoint(870, 173, "C") + waypoint(490, 277, "D") +
    svg-text(130, 232, "Lab", style: "small") +
    svg-text(490, 32, "Junction", style: "small") +
    svg-text(870, 232, "Delivery", style: "small") +
    svg-text(490, 329, "Side corridor", style: "small"),
    height: height,
  )
}

#let svg-arrow(path) = "<path d='" + path + "' class='edge'/>"

#let braitenberg-vehicles(reveal-turn: false, height: 8.4cm) = {
  let vehicle(offset, crossed, excitatory, name) = {
    let sign = if excitatory { "+" } else { "−" }
    let caption = if excitatory { "Excitatory" } else { "Inhibitory" }
    let left-wheel = if crossed { "155" } else { "76" }
    let right-wheel = if crossed { "76" } else { "155" }
    let toward = crossed == excitatory
    let trajectory = if reveal-turn {
      if toward { svg-arrow("M115 148 C115 126 90 107 66 108") }
      else { svg-arrow("M115 148 C115 125 137 101 178 101") }
    } else { "" }
    (
      "<g transform='translate(" + str(offset) + ",0)'>" +
      "<rect x='0' y='10' width='232' height='316' rx='12' fill='#edf3f4'/>" +
      svg-text(116, 46, if reveal-turn { name } else { name.split(" · ").first() }, style: "label") +
      "<g stroke='#eb811b' stroke-width='3' stroke-linecap='round'>" +
      "<circle cx='45' cy='102' r='12' fill='#ffc681'/><path d='M45 81 V75 M45 123 V129 M24 102 H18 M66 102 H72 M30 87 L25 82 M60 87 L65 82 M30 117 L25 122 M60 117 L65 122'/></g>" +
      trajectory +
      svg-rect(66, 169, 99, 101) +
      "<path d='M76 185 L" + left-wheel + " 252 M155 185 L" + right-wheel + " 252' stroke='#23373b' stroke-width='3.5' fill='none'/>" +
      "<circle cx='76' cy='170' r='8' class='accent'/><circle cx='155' cy='170' r='8' class='accent'/>" +
      "<rect x='63' y='249' width='25' height='28' rx='4' fill='#23373b'/><rect x='143' y='249' width='25' height='28' rx='4' fill='#23373b'/>" +
      svg-text(47, 219, sign, style: "small") + svg-text(183, 219, sign, style: "small") +
      svg-text(116, 310, caption, style: "small") +
      "</g>"
    )
  }
  diagram(
    vehicle(9, false, true, "2a · Fear") +
    vehicle(258, true, true, "2b · Aggression") +
    vehicle(507, false, false, "3a · Love") +
    vehicle(756, true, false, "3b · Exploration"),
    height: height,
  )
}

#let door-action(height: 6.95cm) = {
  let door-panel(x, label, detail, open: false) = (
    "<g transform='translate(" + str(x) + ",0)'>" +
    "<rect x='0' y='22' width='320' height='292' rx='13' fill='#edf3f4'/>" +
    svg-text(160, 65, label) +
    "<path d='M45 159 H125 M195 159 H275' stroke='#53666a' stroke-width='12' stroke-linecap='round'/>" +
    "<circle cx='125' cy='159' r='6' fill='#23373b'/>" +
    (if open {
      "<path d='M125 159 V98' stroke='#008273' stroke-width='9' stroke-linecap='round'/>"
    } else {
      "<path d='M125 159 H195' stroke='#c26411' stroke-width='9' stroke-linecap='round'/>"
    }) +
    svg-text(160, 246, detail) +
    svg-text(160, 285, "At(B), Carrying", style: "small") +
    "</g>"
  )
  diagram(
    door-panel(38, "Before", "ClosedBC") +
    svg-arrow("M388 159 H613") + svg-text(500, 132, "OpenDoor", style: "small") +
    door-panel(642, "After", "PassableBC", open: true),
    height: height,
  )
}
#let rrt-step(height: 6.25cm) = {
  let point(x, y, color) = (
    "<circle cx='" + str(x) + "' cy='" + str(y) + "' r='7' fill='" + color + "'/>"
  )
  diagram(
    svg-rect(156, 27, 686, 281) +
    "<rect x='420' y='78' width='145' height='163' rx='5' fill='#53666a'/>" +
    "<text x='492' y='168' text-anchor='middle' style='fill:white;font-size:25px'>Obstacle</text>" +
    "<path d='M241 231 L325 229 L378 274 L487 277 M325 229 L365 132' fill='none' stroke='#23373b' stroke-width='4'/>" +
    "<path d='M487 277 L584 272' fill='none' stroke='#eb811b' stroke-width='6'/>" +
    "<path d='M584 272 L722 263' fill='none' stroke='#eb811b' stroke-width='3' stroke-dasharray='8 6'/>" +
    point(241, 231, "#23373b") + point(325, 229, "#23373b") +
    point(378, 274, "#23373b") + point(365, 132, "#23373b") +
    point(487, 277, "#23373b") + point(584, 272, "#eb811b") +
    point(722, 263, "#eb811b") + point(745, 111, "#23373b") +
    svg-text(245, 208, "Start", style: "small") +
    svg-text(490, 301, "Nearest", style: "small") +
    svg-text(615, 299, "New vertex", style: "small") +
    svg-text(723, 246, "Sample", style: "small") +
    svg-text(745, 91, "Goal", style: "small"),
    height: height,
  )
}
#let exploration-map(height: 6.9cm) = {
  let rows = (
    "######???",
    "#....A???",
    "#..#.#???",
    "#R.#..???",
    "#....B???",
    "######???",
  )
  let fills = (
    "#": "#53666a",
    ".": "#f8fafb",
    "?": "#d1dcde",
    "R": "#edf3f4",
    "A": "#ffc681",
    "B": "#ffc681",
  )
  let tile(x, y, cell) = (
    "<rect x='" + str(x) + "' y='" + str(y) +
    "' width='44' height='44' fill='" + fills.at(cell) +
    "' stroke='#53666a' stroke-width='1'/>"
  )
  let grid-drawing = rows.enumerate().map(((row, line)) => {
    line.clusters().enumerate().map(((col, cell)) => {
      let x = 160 + 44 * col
      let y = 36 + 44 * row
      tile(x, y, cell) + if ("R", "A", "B").contains(cell) {
        svg-text(x + 22, y + 31, cell, style: "small")
      } else { "" }
    }).join()
  }).join()
  let legend = (("#", "Occupied"), (".", "Known free"), ("?", "Unexplored"), ("A", "Candidate frontier"))
  diagram(
    grid-drawing +
    legend.enumerate().map(((index, entry)) => {
      let y = 54 + 60 * index
      tile(625, y, entry.at(0)) + svg-text(687, y + 31, entry.at(1), style: "small", anchor: "start")
    }).join(),
    height: height,
  )
}

#let pose-comparison(height: 7.8cm) = {
  let scene(x, heading, label) = (
    "<g transform='translate(" + str(x) + ",0)'>" +
    "<rect x='0' y='18' width='433' height='277' rx='14' fill='#edf3f4'/>" +
    "<path d='M35 112 H156 M273 112 H398 M35 245 H398' fill='none' stroke='#53666a' stroke-width='8' stroke-linecap='round'/>" +
    svg-text(215, 94, "Open doorway", style: "small") +
    "<g transform='translate(215,177) rotate(" + str(heading) + ")'>" +
    "<circle cx='0' cy='0' r='39' fill='#f8fafb' stroke='#23373b' stroke-width='3'/>" +
    "<path d='M0 21 V-24 M-10 -13 L0 -24 L10 -13' stroke='#eb811b' fill='none' stroke-width='6' stroke-linecap='round'/>" +
    "</g>" +
    svg-text(215, 281, label, style: "small") +
    "</g>"
  )
  diagram(scene(48, 0, "Facing the door") + scene(518, 180, "Facing away"), height: height)
}
#let hybrid-control(height: 6.5cm) = {
  let layer(x, y, w, label) = svg-rect(x, y, w, 68) + svg-text(x + w / 2, y + 43, label)
  diagram(
    layer(295, 17, 410, "Task planner") +
    layer(295, 133, 410, "Executive") +
    layer(295, 251, 410, "Reactive motion control") +
    svg-arrow("M360 85 V131") + svg-text(346, 114, "plan", style: "small", anchor: "end") +
    svg-arrow("M640 132 V87") + svg-text(654, 114, "replan request", style: "small", anchor: "start") +
    svg-arrow("M360 201 V249") + svg-text(346, 230, "skill + target", style: "small", anchor: "end") +
    svg-arrow("M640 251 V203") + svg-text(654, 230, "status", style: "small", anchor: "start") +
    svg-text(134, 270, "Sensor readings", style: "small") + svg-arrow("M64 285 H293") +
    svg-arrow("M706 285 H925") + svg-text(860, 270, "Motor commands", style: "small"),
    height: height,
  )
}

#let subsumption-example(height: 7.2cm) = {
  let behaviour(y, label) = svg-rect(262, y, 326, 64) + svg-text(425, y + 42, label)
  diagram(
    behaviour(59, "Follow a corridor") +
    behaviour(205, "Avoid contact") +
    svg-rect(766, 205, 188, 64) + svg-text(860, 247, "Drive motors", style: "small") +
    svg-arrow("M51 91 H259") + svg-text(155, 76, "Direction", style: "small") +
    svg-arrow("M51 237 H259") + svg-text(155, 222, "Clearance", style: "small") +
    svg-arrow("M590 237 H763") +
    "<path d='M588 91 H677 V231' fill='none' stroke='#c26411' stroke-width='4' stroke-dasharray='9 5'/>" +
    "<circle cx='677' cy='237' r='14' fill='#f8fafb' stroke='#c26411' stroke-width='4'/><text x='677' y='246' text-anchor='middle' style='font-weight:bold;font-size:23px;'>S</text>" +
    svg-text(697, 157, "Override", style: "small", anchor: "start") +
    svg-text(425, 164, "Both layers keep running", style: "small"),
    height: height,
  )
}

#let delivery-episode(height: 6.75cm) = {
  let frame(x, key, description, terminal: false) = (
    (if terminal {
      "<rect x='" + str(x) + "' y='139' width='133' height='113' rx='12' fill='#e0f0ed' stroke='#008273' stroke-width='2'/>"
    } else { svg-rect(x, 139, 133, 113) }) +
    svg-text(x + 67, 184, key) +
    svg-text(x + 67, 225, description, style: "small")
  )
  let transition(x, label, reward) = (
    svg-arrow("M" + str(x) + " 200 h114") +
    svg-text(x + 56, 176, label, style: "small") +
    svg-text(x + 56, 243, reward, style: "small")
  )
  diagram(
    frame(49, "A", "Start") + transition(184, "Move", "−0.10") +
    frame(302, "B", "Junction") + transition(437, "Move", "−0.10") +
    frame(555, "C", "Arrival") + transition(690, "Dock", "+1.00") +
    frame(808, "Done", "Terminal", terminal: true),
    height: height,
  )
}
