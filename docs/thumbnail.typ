#import "@preview/cetz:0.3.4"

#import "/src/lib.typ" as pull-eh: *

#set page(height: auto, margin: 5mm, fill: none)

// style thumbnail for light and dark theme
#let theme = sys.inputs.at("theme", default: "light")
#set text(white) if theme == "dark"

#set align(center)

#cetz.canvas(length: 2cm, {
  import cetz.draw: *
  import pull-eh: *

  rotate(-65deg)

  if theme == "dark" {
    set-style(stroke:  white)
  }

  let point = (0, 9)
  circle((5, 15), radius: 1, name: "a")
  circle((5, 12), radius: 0.8, name: "b")
  circle((5, 9), radius: 1, name: "c")

  wind(
    mark: (start: ">"),
    point,
    (coord: "a", radius: 1) + pull-eh.cw,
    (coord: "c", radius: 1) + pull-eh.cw,
    (coord: "b", radius: 0.8) + pull-eh.cw,
    "c.north",
  )
})
