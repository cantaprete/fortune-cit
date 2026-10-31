OS := $(shell uname -s)

ARCHIVIO := citazioni
SORGENTE := $(ARCHIVIO).txt
INDICE := $(ARCHIVIO).dat

ifeq ($(OS),Darwin)
	FORTUNE_PREFIX := $(shell brew --prefix fortune 2>/dev/null)
	FORTUNE_DIR := $(FORTUNE_PREFIX)/share/games/fortunes
	STRFILE := $(FORTUNE_PREFIX)/bin/strfile
else ifeq ($(OS),Linux)
	FORTUNE_DIR := /usr/share/games/fortune
	STRFILE := strfile
else
	$(error Sistema operativo non supportato: $(OS))
endif

.PHONY: all install uninstall clean

all: $(INDICE)

$(INDICE): $(SORGENTE)
	$(STRFILE) -c % $< $@

install: $(INDICE)
	install -Dm644 $(SORGENTE) $(FORTUNE_DIR)/$(SORGENTE)
	install -Dm644 $(INDICE) $(FORTUNE_DIR)/$(INDICE)

uninstall:
	rm -f $(FORTUNE_DIR)/$(SORGENTE)
	rm -f $(FORTUNE_DIR)/$(INDICE)

clean:
	rm -f $(INDICE)

show-path:
	@echo "Sistema: $(OS)"
	@echo "Directory fortune: $(FORTUNE_DIR)"
	@echo "strfile: $(STRFILE)"
