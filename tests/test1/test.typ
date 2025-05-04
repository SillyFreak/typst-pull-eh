#import "/src/cetz.typ"

#import "/src/lib.typ" as pull-eh

#set page(width: auto, height: auto, margin: 1cm)

#cetz.canvas({
  import cetz.draw: *
  import pull-eh: *

  let circle-style = (fill: green, stroke: none)
  let point = (0, 9)
  circle((5, 15), radius: 1, name: "a", ..circle-style)
  circle((5, 12), radius: 0.8, name: "b", ..circle-style)
  circle((5, 9), radius: 1, name: "c", ..circle-style)

  wind(
    mark: (start: ">"),
    point,
    (coord: "a", radius: 1) + pull-eh.cw,
    (coord: "c", radius: 1) + pull-eh.cw,
    (coord: "b", radius: 0.8) + pull-eh.cw,
    "c.north",
  )
})

#pagebreak()

#cetz.canvas({
  import cetz.draw: *
  import pull-eh: *

  let circle-style = (fill: green, stroke: none)
  let fix1 = (1, 10)
  let fix2 = (4, 10)
  let fix3 = (7, 10)
  circle((2, 5), radius: 1, name: "a", ..circle-style)
  circle((4, 8), radius: 1, name: "b", ..circle-style)
  circle((6, 5), radius: 1, name: "c", ..circle-style)

  line((0, 10), (8, 10))
  wind(
    mark: (start: ">"),
    fix1,
    (coord: "a", radius: 1) + pull-eh.ccw,
    (coord: "b", radius: 1) + pull-eh.cw,
    (coord: "c", radius: 1) + pull-eh.ccw,
    fix3,
  )
  line(fix2, "b.center")
})
