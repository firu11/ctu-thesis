#import "../core.typ": ctu-layout

#let defaults = (
  university: "Fakulta elektrotechnická, ČVUT v Praze",
  toc-title: "Obsah",
)

#let fel-cover(
  title: "REPORT TITLE",
  subtitle: "REPORT SUBTITLE",
  author: "AUTHOR NAME",
  details: (),
  username: "STUDENT USERNAME",
  date: "DATE OF SUBMISSION",
  university: defaults.university,
  branch: "YOUR STUDY BRANCH",
  logo: none,
) = {
  page(
    numbering: none,
  )[
    #set align(center)

    // logo + faculty/branch info
    #stack(dir: ltr, spacing: 1.3em)[
      #logo
    ][
      #v(1.5em)
      #set align(left)
      #stack(dir: ttb, spacing: 12pt)[
        #text(university, size: 20pt, weight: "bold")
      ][
        #text(branch, size: 16pt)
      ]
    ]

    // main title block vertically centered
    #v(16em)
    #text(title, size: 24pt, weight: "bold")
    #v(-1.5em)
    #text(subtitle, size: 18pt)
    #v(5em)
    #text(author, 18pt)

    // author and year information at the bottom
    #align(bottom, block[
      #if details.len() > 0 {
        align(center)[
          #set text(size: 16pt)
          #grid(
            columns: (auto, auto),
            gutter: 0.8em,
            column-gutter: 0.5em,
            align: (right, left),
            ..details
              .pairs()
              .map(((klic, hodnota)) => (
                [*#klic:*],
                [#hodnota],
              ))
              .flatten()
          )
        ]
      }
      #v(0.5em)
      #text(date, 14pt)
    ])
  ]
}

#let fel-toc(
  title: defaults.toc-title,
) = {
  // style headings based on level
  show outline.entry.where(level: 1): it => {
    v(12pt, weak: true) // space above
    text(it, weight: 900, size: 13pt)
  }
  show outline.entry.where(level: 2): it => {
    v(4pt) // space above
    text(it, weight: 500, size: 12pt)
  }
  show outline.entry.where(level: 3): it => {
    v(2pt) // space above
    text(it, weight: 300, size: 11pt)
  }
  show outline.entry.where(level: 4): it => {
    v(2pt) // space above
    text(it, weight: 300, size: 10pt)
  }

  page(
    numbering: none,
  )[
    #align(center, heading(level: 1, outlined: false, numbering: none)[#title])
    #v(14pt)
    #outline(title: none, indent: 1.6em)
  ]
}

// #let prohlaseni(
//   author: "AUTHOR NAME",
//   date: "DATE OF SUBMISSION",
// ) = {
//   page(
//     margin: 3cm,
//     numbering: none,
//   )[
//     Prohlaseni
//   ]
// }

#let fel-thesis(
  title: "REPORT TITLE",
  subtitle: "REPORT SUBTITLE",
  author: "AUTHOR NAME",
  details: (),
  date: "DATE OF SUBMISSION",
  abstract-cz: "ABSTRACT TEXT CZ",
  abstract-en: "ABSTRACT TEXT EN",
  university: defaults.university,
  branch: "YOUR STUDY BRANCH",
  toc-title: defaults.toc-title,
  logo: none,
  gutter: false,
  body,
) = {
  // global cvut layout
  show: ctu-layout.with(title: title, author: author, gutter: gutter)

  // cover page
  fel-cover(
    title: title,
    subtitle: subtitle,
    author: author,
    details: details,
    date: date,
    branch: branch,
    logo: logo,
  )
  pagebreak()

  // abstracts
  align(center)[
    #heading(level: 1, outlined: false, numbering: none)[Abstrakt]
    #abstract-cz

    #v(2em)

    #heading(level: 1, outlined: false, numbering: none)[Abstract]
    #abstract-en
  ]
  pagebreak()

  // table of contents
  fel-toc(title: toc-title)
  pagebreak()

  // reset page numbering
  set page(numbering: "1")
  counter(page).update(1)

  body // the actual thesis content
}
