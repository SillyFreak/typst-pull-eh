#import "@preview/valkyrie:0.2.2" as z

#let point = z.tuple(z.number(), z.number())

#let circle = z.dictionary((
  c: point,
  r: z.number(),
))

#let circle-winding = z.dictionary((
  c: point,
  r: z.number(),
  dir: z.choice(("cw", "ccw"))
))

#let winding = z.either(point, circle-winding)
#let windings = z.array(winding)
