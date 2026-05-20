#let ctu-layout(
  title: "",
  author: "",
  lang: "cs",
  body,
) = {
  set document(title: title, author: author)
  set text(lang: lang, region: "cz", size: 12pt, font: "libertinus serif")

  set heading(numbering: "1.")
  show heading: set block(below: 0.8em)
  set par(justify: true, first-line-indent: 2em)

  // slightly larger space behind an image/figure
  show figure: it => {
    it
    v(8pt)
  }

  // prettier code block
  show raw.where(block: true): it => align(
    block(
      stroke: rgb("#d5d5d5"),
      fill: rgb("#ffffff"),
      inset: 10pt,
      radius: 4pt,
      it,
    ),
    center,
  )

  body
}
