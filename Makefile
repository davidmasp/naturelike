

main.pdf: main.typ refs.bib naturelike.typ
	typst compile main.typ  

all: main.pdf
