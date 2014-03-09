FILE = diss
TEX_FILE = $(FILE).tex

BUILD_FOLDER = build
BUILD_PDF = $(BUILD_FOLDER)/$(FILE).pdf

LATEX = latexmk
LATEX_FLAGS = -xelatex --outdir=$(BUILD_FOLDER)
LATEX_WATCH = -pvc

.PHONY: watch clean pdf move

pdf: $(FILE).pdf

watch:
	$(LATEX) $(LATEX_FLAGS) $(LATEX_WATCH) $(FILE)

$(FILE).pdf: $(TEX_FILE)
	$(LATEX) $(LATEX_FLAGS) $(FILE)

move:
	if [ -f "$(BUILD_PDF)" ]; then cp $(BUILD_PDF) .; fi

clean: move
	$(LATEX) -c --outdir=$(BUILD_FOLDER)
	-rm $(BUILD_FOLDER)/$(FILE).run.xml
	-mv $(BUILD_FOLDER)/$(FILE).pdf .
	-rmdir $(BUILD_FOLDER)
