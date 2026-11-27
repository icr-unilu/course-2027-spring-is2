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
