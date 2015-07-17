diagrams = first_generation_class_structure.pdf \
           support-tools-recepionist-example.pdf \
           component_diagram.pdf \
           system-state-machine-relations.pdf \
           system-state-machine-relations-detailed.pdf \
           component_diagram_with_tests.pdf \
           test-driven-development-flow.pdf \
           sor-model.pdf \
           resource_pool.pdf \
           3rd_iteration_meta_model.pdf \
           initial_model.pdf \
           framework_example.pdf \
           test_case_ui.pdf \
	   concept2_example_object.pdf \
           concept2_use_case_meta_model.pdf \
	   concept2_use_case_mapping.pdf \
           event-stack-to-state-machine.pdf \
           use_case_creation_activity_diagram.pdf \
           layered-mvc.pdf \
           tests-relation-to-implementation.pdf \
           ideal_flow.pdf \
           mapping-levels.pdf

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
	-rm $(addprefix img/, $(diagrams))

%.pdf:
	make -C img $@

todo_count:
	@grep -nir TODO chapters | wc -l
