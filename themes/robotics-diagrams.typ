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
