#import "template.typ" as template: *
#import "/src/lib.typ" as pull-eh

#let package-meta = toml("/typst.toml").package
#let date = none
// #let date = datetime(year: ..., month: ..., day: ...)

#show: manual(
  title: "pull-eh",
  // subtitle: [
  //   A PACKAGE for something
  // ],
  authors: package-meta.authors.map(a => a.split("<").at(0).trim()),
  abstract: [
    Visualize pulleys with Typst and CeTZ
  ],
  url: package-meta.repository,
  version: package-meta.version,
  date: date,
)

// the scope for evaluating expressions and documentation
#let scope = (pull-eh: pull-eh)

= Introduction

This is a PACKAGE for something.

= Module reference

#module(
  read("/src/lib.typ"),
  name: "pull-eh",
  label-prefix: none,
  scope: scope,
)
