#import "@preview/cetz:0.4.0"

#import "/src/lib.typ" as pull-eh

#set page(height: auto, margin: 5mm, fill: none)

// style thumbnail for light and dark theme
#let theme = sys.inputs.at("theme", default: "light")
#set text(white) if theme == "dark"

#set align(center)

#cetz.canvas(length: 2cm, {
  import cetz.draw: *
  import pull-eh: *

  if theme == "dark" {
    set-style(stroke: white)
  }

  rotate(-65deg)

  let point = (0, 9)
  circle(name: "a", (5, 15), radius: 1)
  circle(name: "b", (5, 12), radius: 0.8)
  circle(name: "c", (5, 9), radius: 1)

  wind(
    stroke: 2pt + if theme == "dark" { white },
    point,
    (coord: "a", radius: 1) + cw,
    (coord: "c", radius: 1) + cw,
    (coord: "b", radius: 0.8) + cw,
    "c.north",
  )
})
