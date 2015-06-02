diagrams = uc2_test_config.pdf \
           first_generation_class_structure.pdf \
           support-tools-recepionist-example.pdf \
           component_diagram.pdf

XELATEX=xelatex -file-line-error -interaction=nonstopmode

.PHONY: all
all: Thesis.tex
	latexmk -pdf -pdflatex="$(XELATEX)" -use-make Thesis.tex

.PHONY: auto
auto: Thesis.tex
	latexmk -pdf -pdflatex="$(XELATEX)" -use-make -pvc Thesis.tex

.PHONY: clean
clean: clean_diagrams
	rm -f Thesis.pdf *.aux *.bbl *bcf *.blg *.log *.out *.tdo *.toc *.xdv *.synctex.gz *.fdb_latexmk *.fls *.run.xml; \
	rm -f **/*.aux

generate_diagrams: $(diagrams)

clean_diagrams:
	rm $(addprefix img/, $(diagrams))

%.pdf:
	make -C img $@

