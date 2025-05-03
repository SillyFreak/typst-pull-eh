#import "@preview/cetz:0.3.4"

#import "/src/lib.typ" as pull-eh

#set page(width: auto, height: auto, margin: 1cm)

#cetz.canvas({
  import cetz.draw: *
  import pull-eh: *

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
      circle(c, radius: r, fill: green, stroke: none)
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

#pagebreak()


#cetz.canvas({
  import cetz.draw: *
  import pull-eh: *

  let pulleys = (
    fix1: (1, 10),
    fix2: (4, 10),
    fix3: (7, 10),
    a: (c: (2, 5), r: 1),
    b: (c: (4, 8), r: 1),
    c: (c: (6, 5), r: 1),
  )

  for p in pulleys.values() {
    let (c, r) = pull-eh.normalize(p)
    if r > 0 {
      circle(c, radius: r, fill: green, stroke: none)
    }
  }

  line((0, 10), (8, 10))
  wind(
    mark: (start: ">"),
    pulleys.fix1,
    pulleys.a + pull-eh.ccw,
    pulleys.b + pull-eh.cw,
    pulleys.c + pull-eh.ccw,
    pulleys.fix3,
  )
  wind(
    pulleys.fix2,
    pulleys.b.c,
  )
})
