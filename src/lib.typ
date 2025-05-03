#import "math.typ"

#let (cw, ccw) = ("cw", "ccw").map(dir => (dir: dir))

/// normalizes a winding to an array of point and radius. The radius is zero for points, positive
/// for `"cw"` circles, and negative for `"ccw"` ones.
///
/// -> array
#let normalize(
  /// a winding - either a point given as an array, or a dictionary containing `c`, `r` and
  /// `dir` (center, radius, `"cw"`/`"ccw"` direction)
  /// -> array | dictionary
  winding,
) = {
  import "schemas.typ" as schemas: z

  winding = z.parse(winding, schemas.winding)
  if type(winding) == array {
    // a point
    let c = winding
    (c, 0)
  } else {
    // a circle
    let (c, r, dir) = winding
    if dir == "ccw" { r = -r }
    (c, r)
  }
}

#let wind(
  ..args,
) = {
  import "schemas.typ" as schemas: z
  import "cetz.typ"
  import cetz.draw: *

  let windings = args.pos()
  let style = args.named()
  windings = z.parse(windings, schemas.windings).map(normalize)

  merge-path(..style, {
    let prev-angle = none

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
  })
}