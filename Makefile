

example/main.pdf: example/main.typ example/refs.bib naturelike.typ
	cd example && typst compile --root .. main.typ  

all: example/main.pdf
