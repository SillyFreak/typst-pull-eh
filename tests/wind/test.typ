#import "@preview/cetz:0.3.4"

#import "/src/lib.typ" as pull-eh
#import pull-eh: *

#set page(width: auto, height: auto, margin: 1cm)

#let sketches(..args) = page(cetz.canvas({
  import cetz.draw: *

  rect((-1, -1), (9, 9), stroke: none)

  let tf(a, b, c, d, e, f) = ((x, y)) => {
    (a*x + b*y + c, d*x + e*y + f)
  }

  let sketch(tf) = {
    for arg in args.pos() {
      let (c, r) = {
        if type(arg) == dictionary { arg }
        else { (c: arg, r: 0.08) }
      }
      circle(tf(c), radius: r, fill: green, stroke: none)
    }

    wind(..args.pos().map(arg => {
      if type(arg) == dictionary {
        arg.c = tf(arg.c)
        arg
      }
      else {
        tf(arg)
      }
    }))
  }

  sketch(tf(1, 0, 0, 0, 1, 0))
  sketch(tf(0, -1, 8, 1, 0, 0))
  sketch(tf(-1, 0, 8, 0, -1, 8))
  sketch(tf(0, 1, 0, -1, 0, 8))
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

#sketches(p(0), p(2))
#sketches(p(0), c(2) + cw)
#sketches(p(0), c(2) + cw, p(4))
#sketches(p(0), c(2) + cw, c(5) + cw)
#sketches(p(0), c(2) + cw, c(5) + cw, p(7))
#sketches(p(0), c(2) + cw, c(5) + ccw)
#sketches(p(0), c(2) + cw, c(5) + ccw, p(7))
#sketches(p(0), c(2) + cw, c(4) + ccw)
#sketches(p(0), c(2) + cw, c(4) + ccw, p(6))
#sketches(p(0), c(2) + cw, c(4) + ccw, c(6) + cw)
#sketches(p(0), c(2) + cw, c(4) + ccw, c(6) + cw, p(8))
#sketches(p(0), c(2) + ccw)
#sketches(p(0), c(2) + ccw, p(4))
#sketches(p(0), c(2) + ccw, c(5) + ccw)
#sketches(p(0), c(2) + ccw, c(5) + ccw, p(7))
#sketches(p(0), c(2) + ccw, c(5) + cw)
#sketches(p(0), c(2) + ccw, c(5) + cw, p(7))
#sketches(p(0), c(2) + ccw, c(4) + cw)
#sketches(p(0), c(2) + ccw, c(4) + cw, p(6))
#sketches(p(0), c(2) + ccw, c(4) + cw, c(6) + ccw)
#sketches(p(0), c(2) + ccw, c(4) + cw, c(6) + ccw, p(8))
