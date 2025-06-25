#import "template.typ" as template: *
#import "/src/lib.typ" as pull-eh

#show: manual(
  package-meta: toml("/typst.toml").package,
  subtitle: [Visualize pulleys with Typst and CeTZ],
  date: datetime(year: 2025, month: 5, day: 4),

  // logo: rect(width: 5cm, height: 5cm),
  // abstract: [
  //   A PACKAGE for something
  // ],

  scope: (pull-eh: pull-eh),
)

= Introduction

Pull-eh lets you visualize pulleys and similar things with Typst and CeTZ. More specifically, it computes the way a cable or rope would wind around a series of wheels. This can be used to visualize physical systems. As an example, here is a gun tackle#footnote(link("https://en.wikipedia.org/wiki/Block_and_tackle#Overview")) in place and with pulleys separated:

#figure(
  include "gun-tackle.typ",
  caption: [a gun tackle, and its separation],
)

And the corresponding code:

#context {
  import "@preview/crudo:0.1.1"

  let code = read("gun-tackle.typ").trim()
  code = raw(block: true, lang: "typ", code)
  code = crudo.join(
    crudo.map(```typ
    #import "@preview/cetz:0.4.0"
    #import "PACKAGE"

    ```, l => l.replace("PACKAGE", package-import-spec())),
    crudo.lines(code, "4-"),
  )

  codly.codly(
    smart-skip: (last: false, rest: true),
    ranges: ((1, 2), (18, 20), (34, 42)),
  )
  code
}

Note that pull-eh is _only_ responsible for drawing the rope using #ref-fn("wind()"). The rest of the diagram is regular CeTZ; the pulleys themselves are circles with a `name` set. Pull-eh supports any kind of CeTZ coordinate, so the loose end of the rope can be specified relative to the center of pulley 1 (line 37), for example.

The `wind()` function works with either points (CeTZ coordinates) or pulleys (coordinates, plus a radius and winding direction); see the #ref-fn("wind()") function for more details. The direction is specified as a dictionary key `direction: "cw"` or `direction: "ccw"`; for convenience the #ref-fn("cw") and #ref-fn("ccw") variables can be "added" to another dictionary, as shown in lines 38 and 39.

= Module reference

#module(
  read("/src/lib.typ"),
  name: "pull-eh",
  label-prefix: none,
)
