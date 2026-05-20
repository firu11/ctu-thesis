// ČVUT (CTU in Prague) Report Template for term projects etc.
// TODO

#import "src/core.typ": thesis
#import "src/faculties/fel.typ": fel-config

#let fel-thesis(config: (), meta: (), body) = {
  thesis(
    config: fel-config + config,
    meta: meta,
    body
  )
}
