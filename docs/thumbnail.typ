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

  let pulleys = (
    point: (0, 9),
    a: (c: (5, 15), r: 1),
    b: (c: (5, 12), r: 0.8),
    c: (c: (5, 9), r: 1),
    c-point: (5, 10),
  )

  for p in pulleys.values() {
    let (c, r) = pull-eh.normalize(p)
    if r > 0 {
      circle(c, radius: r)
    }
  }

  wind(
    mark: (start: ">"),
    pulleys.point,
    pulleys.a + pull-eh.cw,
    pulleys.c + pull-eh.cw,
    pulleys.b + pull-eh.cw,
    pulleys.c-point,
  )
})
