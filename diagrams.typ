// Shared vector renderer and reusable course diagrams.
#let diagram(body, height: 4.5cm) = align(center, image(bytes(
  "<svg xmlns='http://www.w3.org/2000/svg' width='1000' height='340' viewBox='0 0 1000 340'>"
  + "<defs><marker id='arrow' markerWidth='8' markerHeight='8' refX='7' refY='4' orient='auto-start-reverse'><path d='M0,0 L8,4 L0,8 Z' fill='#23373b'/></marker></defs>"
  + "<style>text{font-family: Fira Sans, sans-serif;fill:#23373b;font-size:32px} .label{font-size:28px} .small{font-size:24px} .node{fill:#edf3f4;stroke:#23373b;stroke-width:2} .edge{stroke:#23373b;stroke-width:3;fill:none;marker-end:url(#arrow)} .accent{fill:#eb811b} .boundary{fill:#f8fafb;stroke:#eb811b;stroke-width:3;stroke-dasharray:10 6}</style>"
  + body + "</svg>"
), format: "svg", height: height))

#let robot(x, y, caption) = "<g transform='translate(" + str(x) + "," + str(y) + ")'><rect x='0' y='0' width='105' height='88' rx='16' class='node'/><circle cx='33' cy='31' r='6'/><circle cx='72' cy='31' r='6'/><path d='M32 60 H73' stroke='#23373b' stroke-width='4'/><text x='52' y='120' text-anchor='middle' class='label'>" + caption + "</text></g>"

// The same interaction loop is used in Systems, Autonomy and Reasoning Agents.
#let agent-environment(height: 5.5cm, system-boundary: false,
  agent-label: "Agent", agent-detail: false) = {
  let boundary = if system-boundary {
    "<rect x='15' y='10' width='970' height='315' rx='18' class='boundary'/><text x='40' y='48' class='accent'>System under study</text>"
  } else { "" }
  let label = if agent-detail {
    "<text x='210' y='122' text-anchor='middle'>Agent</text><text x='210' y='165' text-anchor='middle' class='small'>Model + controller</text><text x='210' y='203' text-anchor='middle' class='small'>Goal + state</text>"
  } else {
    "<text x='210' y='173' text-anchor='middle'>" + agent-label + "</text>"
  }
  diagram(boundary
    + "<rect x='60' y='80' width='300' height='170' rx='18' class='node'/>" + label
    + "<rect x='640' y='80' width='300' height='170' rx='18' class='node'/><text x='790' y='173' text-anchor='middle'>Environment</text>"
    + "<path d='M365 115 H635' class='edge'/><text x='500' y='90' text-anchor='middle' class='label'>actions</text>"
    + "<path d='M635 220 H365' class='edge'/><text x='500' y='263' text-anchor='middle' class='label'>observations</text>", height: height)
}

#let input-output(process: "Computation", input: "Input data", output: "Output data", height: 3.8cm) = diagram(
  "<rect x='25' y='105' width='210' height='105' rx='10' class='node'/><text x='130' y='166' text-anchor='middle'>" + input + "</text><path d='M235 157 H375' class='edge'/>"
  + "<rect x='375' y='85' width='250' height='145' rx='14' class='node'/><text x='500' y='166' text-anchor='middle'>" + process + "</text><path d='M625 157 H765' class='edge'/>"
  + "<rect x='765' y='105' width='210' height='105' rx='10' class='node'/><text x='870' y='166' text-anchor='middle'>" + output + "</text>", height: height)
