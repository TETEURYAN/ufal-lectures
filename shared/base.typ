#set page(
  margin: 2cm
)

#set text(
  font: "Libertinus Serif",
  size: 11pt
)

#let lecture(n, date, title) = [
  = Aula #n: #title
  #align(right)[#date]
]
