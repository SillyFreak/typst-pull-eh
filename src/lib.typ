#import "math.typ"

#let (cw, ccw) = ("cw", "ccw").map(dir => (direction: dir))

#let wind(
  ..args,
) = {
  import "cetz.typ"
  import cetz.draw: *

  let windings = args.pos()
  let style = args.named()

  get-ctx(ctx => merge-path(..style, {
    let prev-angle = none
    let windings = windings.map(winding => {
      let coord = winding
      let radius = 0
      if type(coord) == dictionary and "radius" in coord and "direction" in coord {
        radius = coord.remove("radius")
        let direction = coord.remove("direction")
        assert(direction in ("cw", "ccw"), message: "direction must be cw or ccw")
        if direction == "ccw" { radius = -radius }
        if "coord" in coord {
          coord = coord.coord
        }
      }
      (coord, radius)
    })

    let (ctx, ..coords) = cetz.coordinate.resolve(ctx, update: true, ..windings.map(array.first))
    let windings = windings.zip(coords).map(((winding, coord)) => {
      assert.eq(coord.last(), 0, message: "only coordinates on the 0 z-plane are supported")
      _ = coord.remove(2)
      let radius = winding.last()
      (coord, radius)
    })

    for ((c1, r1), (c2, r2)) in windings.windows(2) {
      let (p1, p2) = math.tangent(c1, r1, c2, r2)

      let angle = if p1 != p2 {
        // the angle can be calculated from the tangent
        cetz.vector.angle2(p1, p2)
      } else {
        // the tangent is only a single point; the angle is perpendicular to the line through the
        // centers of the touching circles. The tangent direction depends on the winding direction.
        cetz.vector.angle2(c1, c2) + if r1 < 0 { 90deg } else { -90deg }
      }

      if prev-angle != none and r1 != 0 and prev-angle != angle {
        // create an arc segment between two straight line segments

        // the arc angles are measured from the center. An arc touching a tangent therefore uses
        // angles normal to the tangent's angle. The direction depends on the winding direction.
        let start = {
          if r1 > 0 { prev-angle + 90deg }
          else { prev-angle - 90deg }
        }
        let stop = {
          if r1 > 0 { angle + 90deg }
          else { angle - 90deg }
        }
        // make sure we are spanning the right side of the circle. Clockwise means angles decrease,
        // Counter-clockwise means they increase
        if r1 > 0 and stop > start {
          stop -= 360deg
        } else if r1 < 0 and stop < start {
          stop += 360deg
        }

        arc(c1, anchor: "origin", radius: calc.abs(r1), start: start, stop: stop)
      }
      prev-angle = angle

      if p1 != p2 {
        // create a line segment between two arc segments
        line(p1, p2)
      }
    }
  }))
}