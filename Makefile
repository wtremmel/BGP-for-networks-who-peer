TEXFILE ?= BGP_for_networks_who_peer

all: screen print
.PHONY: screen print clean

all-rfcs.bib:
	cat *.tex tex/*.tex | ./get-referenced-rfcs > all-rfcs.bib
screen: all-rfcs.bib
	latexmk -auxdir=.build -bibtex -pdf -jobname=$(TEXFILE)-screen $(TEXFILE)
print: all-rfcs.bib
	latexmk -auxdir=.build -bibtex -pdf -usepretex="\def\paperversion{1}" \
		-jobname=$(TEXFILE)-print $(TEXFILE)
clean:
	rm -rf .build
	rm -rf *.pdf
	rm -rf all-rfcs.bib
