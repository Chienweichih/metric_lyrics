SRC_DIR := .
OUT_DIR := .

PANDOC          := pandoc
FROM_FMT        := markdown+hard_line_breaks
TARGET_FMT      := epub
EPUB_TITLE_PAGE := false

MD     := $(filter-out $(SRC_DIR)/README.md, $(wildcard $(SRC_DIR)/*.md))
EPUB   := $(patsubst $(SRC_DIR)/%.md,$(OUT_DIR)/%.epub,$(MD))

PANDOC_OPTS := \
    -f $(FROM_FMT) \
    --epub-title-page=$(EPUB_TITLE_PAGE) \

.PHONY: all clean list

all: $(EPUB)

list:
	@echo "Source MD files:"
	@$(foreach f,$(MD),echo "  $(f)";)
	@echo ""
	@echo "Will build EPUB files:"
	@$(foreach f,$(EPUB),echo "  $(f)";)

$(OUT_DIR)/%.epub: $(SRC_DIR)/%.md
	@mkdir -p "$(OUT_DIR)"
	@echo "Building: $< -> $@"
	@$(PANDOC) -t $(TARGET_FMT) $(PANDOC_OPTS) -o "$@" "$<"

clean:
	@echo "Cleaning EPUBs in $(OUT_DIR)"
	@rm -f $(EPUB)
