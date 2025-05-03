#import "@preview/cetz:0.3.4"

#import "/src/lib.typ" as pull-eh
#import pull-eh: *

#set page(width: auto, height: auto, margin: 1cm)

#let sketch(..args) = page(cetz.canvas({
  import cetz.draw: *

  rect((-1, -1), (9, 9), stroke: none)

  for arg in args.pos() {
    let (c, r) = {
      if type(arg) == dictionary { arg }
      else { (c: arg, r: 0.08) }
    }
    circle(c, radius: r, fill: green, stroke: none)
    circle(c.rev(), radius: r, fill: green, stroke: none)
  }

  wind(..args)
  wind(..args.pos().map(arg => {
      if type(arg) == dictionary {
        arg.c = arg.c.rev()
        arg
      }
      else { arg.rev() }
  }))
}))

#let p(x, ..args) = {
  assert.eq(args.named().len(), 0)
  assert(args.pos().len() <= 1)
  let y = args.pos().at(0, default: 0)
  (x, y)
}
#let c(x, ..args) = {
  assert.eq(args.named().len(), 0)
  assert(args.pos().len() <= 2)
  let y = args.pos().at(0, default: 0)
  let r = args.pos().at(0, default: 1)
  (c: (x, y), r: r)
}

#sketch(p(0), p(2))
#sketch(p(0), c(2) + cw)
#sketch(p(0), c(2) + cw, p(4))
#sketch(p(0), c(2) + cw, c(5) + cw)
#sketch(p(0), c(2) + cw, c(5) + cw, p(7))
#sketch(p(0), c(2) + cw, c(5) + ccw)
#sketch(p(0), c(2) + cw, c(5) + ccw, p(7))
#sketch(p(0), c(2) + cw, c(4) + ccw)
#sketch(p(0), c(2) + cw, c(4) + ccw, p(6))
#sketch(p(0), c(2) + cw, c(4) + ccw, c(6) + cw)
#sketch(p(0), c(2) + cw, c(4) + ccw, c(6) + cw, p(8))
#sketch(p(0), c(2) + ccw)
#sketch(p(0), c(2) + ccw, p(4))
#sketch(p(0), c(2) + ccw, c(5) + ccw)
#sketch(p(0), c(2) + ccw, c(5) + ccw, p(7))
#sketch(p(0), c(2) + ccw, c(5) + cw)
#sketch(p(0), c(2) + ccw, c(5) + cw, p(7))
#sketch(p(0), c(2) + ccw, c(4) + cw)
#sketch(p(0), c(2) + ccw, c(4) + cw, p(6))
#sketch(p(0), c(2) + ccw, c(4) + cw, c(6) + ccw)
#sketch(p(0), c(2) + ccw, c(4) + cw, c(6) + ccw, p(8))
