
// this function allow for the creation 
// of a nature-like preprint.
// title: the title of the paper
// authors: an array of authors. Each author can have a name and a affiliation*
// abstract: the abstract of the paper
// paper-size: the size of the paper. Default is us-letter
// bibliography-file: the bib file to use for the references

// * wip for corresponding an co-first authors

#let naturelike(
  // The paper's title.
  title: "Paper Title",
  article_type: "Article",
  authors: (),
  abstract: none,
  paper-size: "us-letter",
  bibliography-file: none,
  body
) = {
  set document(title: title,
               author: authors.map(author => author.name))
  // font for the main text
  set text(font: "Roboto Slab", size: 10pt)
  // Configure the page.
  set page(
    paper: paper-size,
    margin: if paper-size == "a4" {
      (x: 41.5pt, top: 80.51pt, bottom: 89.51pt)
    } else {
      (
        x: (50pt / 216mm) * 100%,
        top: (60pt / 279mm) * 100%,
        bottom: (64pt / 279mm) * 100%,
      )
    },
    header: align(left)[
    #text(article_type, font: "Roboto Serif",weight: "extrabold", size: 16pt)
    #place(top , dy: 50pt, line( length: 100%))   
  ], 
    foreground: place(
      top + left, dx: 40pt,
      line(start: (0pt, 30pt), end: (0pt, ((279mm - 64pt) / 279mm) * 100%)),
    ),
    numbering: "1",
    footer: [
    #set text(8pt, weight: "extrabold", font: "Roboto")
    #counter(page).display(
      "1"
    )
    #set text(8pt, weight: "regular", font: "Roboto")
    | #h(2pt) Test #h(2pt) | #h(2pt) pub.masponte.com
  ]
  )
  
  // this comes from the ieee template, probably should change
  // Configure equation numbering and spacing.
  set math.equation(numbering: "(1)")
  show math.equation: set block(spacing: 0.65em)

  // Configure appearance of equation references
  show ref: it => {
    if it.element != none and it.element.func() == math.equation {
      // Override equation references.
      link(it.element.location(), numbering(
        it.element.numbering,
        ..counter(math.equation).at(it.element.location())
      ))
    } else {
      // Other references as usual.
      it
    }
  }

  // Configure lists.
  set enum(indent: 10pt, body-indent: 9pt)
  set list(indent: 10pt, body-indent: 9pt)

  show heading: it => locate(loc => {
    let levels = counter(heading).at(loc)
    let deepest = if levels != () {
      levels.last()
    } else {
      1
    }

    set text(11pt, weight: 400)
    if it.level == 1 [
      #set par(first-line-indent: 0pt)
      #let is-ack = it.body in ([Acknowledgment], [Acknowledgement], [References])
      #set text(if is-ack { 11pt } else { 15pt }, weight: "bold")
      #v(25pt, weak: true)
      #it.body
      #v(10pt, weak: true)
    ] else if it.level == 2 [
      #set par(first-line-indent: 0pt)
      #v(10pt, weak: true)
      #set text(12pt, weight: "bold")
      #it.body
      #v(10pt, weak: true)
    ] else [
      _#(it.body):_
    ]
  })
  // TITLE  
  v(1pt, weak: true)
  align(left, text(20pt, font: "Roboto Serif", weight: "extrabold", title))
  v(10mm, weak: true)
  line(length: 100%)
  // here is the header with the authors and the metadata on the left.
  // TODO: doi+date will need to be added in the function arguments!
  grid(
    columns: (1fr, 3fr),
    gutter: 2pt,
    { 
      set text(size: 8pt)
      grid(rows: 12pt,
        [#link("doi.org/10.99")],
        [*Received*: 17 July 2023],
        [*Updated*: 18 July 2023]
      )
    },
    {
        let affl_dict = (:);
  let curr_affl = 0;
  for i in range(authors.len()){
    text(authors.at(i).name)
    let dpt_name_arr = authors.at(i).affiliation
    //text(str(type(dpt_name_arr)))
    if type(dpt_name_arr) == "string" {
      if dpt_name_arr in affl_dict.keys() {
          super(text(str(affl_dict.at(dpt_name_arr))))
        } else {
          curr_affl = curr_affl + 1
          affl_dict.insert(dpt_name_arr, curr_affl)
          super(text(str(affl_dict.at(dpt_name_arr))))
        } 
    } else{
      for j in range(dpt_name_arr.len()) {
        let dpt_name = dpt_name_arr.at(j)
        if dpt_name in affl_dict.keys() {
          super(text(str(affl_dict.at(dpt_name))))
        } else {
          curr_affl = curr_affl + 1
          affl_dict.insert(dpt_name, curr_affl)
          super(text(str(affl_dict.at(dpt_name))))
        }
        if j != dpt_name_arr.len() -1 {
          super(text(","))
        }
      }
    }

    // this is 0-idx
    if (i == (authors.len() - 2)) {
      text(" & ")
    } else if (i != (authors.len() -1)) {
      text(", ")
    } else {
      text(".")
    }
  }

  v(5pt)
  for j in affl_dict.keys(){
    super(text(str(affl_dict.at(j))))
    h(1pt)
    text(str(j), size: 8pt)
    text(".", size: 8pt)
    h(3pt)
  }

  v(12pt, weak: true)

      if abstract != none [
          #set text(9pt, weight: 500)
          #abstract
          #v(15pt)
        ]
    }
  )

  set text(8pt, weight: 400)
  
  // Start two column mode and configure paragraph properties.
  show: columns.with(2, gutter: 15pt)
  set par(justify: true, first-line-indent: 0em)
  show par: set block(spacing: 0.65em)

  // Display the paper's contents.
  body

  // Display bibliography.
  // because display is nature, this template requires 
  // version 0.9.0
  if bibliography-file != none {
    show bibliography: set text(8pt)
    bibliography(bibliography-file, title: text(10pt)[References],
          style: "nature")
  }
}
