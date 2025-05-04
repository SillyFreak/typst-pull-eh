#import "/src/cetz.typ"
#import "/src/lib.typ" as pull-eh

#let block(coord, (w, h), ..args) = {
  // use the given coord as the center of the rect
  let tl = (rel: (-w/2, -h/2), to: coord)
  let br = (rel: (w, h))
  cetz.draw.rect(tl, br, fill: white, ..args)
}
#let fixing(coord, len, ..args) = {
  cetz.draw.line(stroke: 3pt, coord, (rel: len, to: coord))
  cetz.draw.circle(coord, fill: black, radius: 0.2)
}
#let pulley(..args) = {
  cetz.draw.circle(fill: green, stroke: none, ..args)
}

#let gun-tackle = cetz.canvas({
  import cetz.draw: *
  import pull-eh: *

  // the pulleys; on the default layer
  on-layer(0, {
    pulley(name: "pulley1", (1, 4))
    pulley(name: "pulley2", (1, 0))
  })
  // the "fixed" parts of the diagram: ceiling and blocks. The blocks wrap around the pulleys
  // and thus hide them and the rope
  on-layer(2, {
    block(name: "block1", "pulley1", (0.4, 2.4))
    block(name: "block2", "pulley2", (0.4, 2.4))
    line(stroke: 2pt, (rel: (-1.4, 0), to: "block1.north"), (rel: (1.4, 0), to: "block1.north"))
  })
  // the rope; drawn over the pulleys, but hidden by the blocks
  on-layer(1, wind(
    stroke: 1.5pt,
    (rel: (1.5, -2.5), to: "pulley1"),
    (coord: "pulley1", radius: 1) + ccw,
    (coord: "pulley2", radius: 1) + ccw,
    "block1.south",
  ))
})

#let separated = cetz.canvas({
  import cetz.draw: *
  import pull-eh: *

  let block1 = (4, 5.2)

  // the pulleys; on the default layer
  on-layer(0, {
    pulley(name: "pulley1", (1, 4))
    pulley(name: "pulley2", (3, 0))
  })
  // the "fixed" parts of the diagram: ceiling and blocks. The blocks wrap around the pulleys
  // and thus hide them and the rope
  on-layer(2, {
    fixing("pulley1.center", (0, 1.2))
    fixing("pulley2.center", (0, -1.2))
    line(stroke: 2pt, (rel: (-4.4, 0), to: block1), (rel: (0.4, 0), to: block1))
  })
  // the rope; drawn over the pulleys, but hidden by the blocks
  on-layer(1, wind(
    stroke: 1.5pt,
    (rel: (-1.5, -2.5), to: "pulley1"),
    (coord: "pulley1", radius: 1) + cw,
    (coord: "pulley2", radius: 1) + ccw,
    block1,
  ))
})

#grid(
  columns: 2,
  column-gutter: 2cm,
  gun-tackle,
  separated,
)
