#import "@preview/cetz:0.3.4"

#import "/src/lib.typ" as pull-eh
#import pull-eh.math: *

#set page(width: auto, height: auto, margin: 1cm)

#let sketch(c1, r1, c2, r2) = page(cetz.canvas({
  import cetz.draw: *

  rect((-2, -2), (5, 2), stroke: none)

  circle(c1, radius: r1)
  circle(c2, radius: r2)

  let t(i, ..args, stroke: auto) = {
    let l = tangent(..args)
    if l != none {
      line(..l, stroke: stroke)
      circle((4.2 + 0.25*i, -1.8), radius: 0.05, fill: stroke, stroke: stroke)
    }
  }

  t(0, c1, r1, c2, r2, stroke: green)
  t(1, c1, -r1, c2, -r2, stroke: blue)
  t(2, c1, r1, c2, -r2, stroke: red)
  t(3, c1, -r1, c2, r2, stroke: teal)
}))

#sketch((0, 0), 1, (3, 0), 1)
#sketch((0, 0), 2, (4, 0), 1)
#sketch((0, 0), 2, (3, 0), 1)
#sketch((0, 0), 2, (3, 0), 2)
#sketch((1.5, 0), 2, (2.5, 0), 1)
#sketch((1.5, 0), 2, (1.5, 0), 1)
#sketch((1.5, 0), 2, (1.5, 0), 2)
