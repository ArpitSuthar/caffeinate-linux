# Install paths
PREFIX ?= /usr/local
BINDIR := $(PREFIX)/bin
MANDIR := $(PREFIX)/share/man/man1

# Source files
SCRIPT := caffeinate
MANPAGE := caffeinate.1

# Default target
.PHONY: all
all: validate

# Validate script syntax
.PHONY: validate
validate:
	@echo "🔍 Validating script syntax..."
	@bash -n $(SCRIPT)
	@echo "✅ Script is valid."

# Install script and man page
.PHONY: install
install: validate
	@echo "🚀 Installing $(SCRIPT) to $(BINDIR)..."
	install -Dm755 $(SCRIPT) $(DESTDIR)$(BINDIR)/$(SCRIPT)
	@if [ -f "$(MANPAGE)" ]; then \
		echo "📖 Installing man page to $(MANDIR)/$(MANPAGE)..."; \
		install -Dm644 $(MANPAGE) $(DESTDIR)$(MANDIR)/$(MANPAGE); \
		if command -v mandb >/dev/null 2>&1; then \
			echo "🔄 Updating man database..."; \
			mandb >/dev/null; \
		elif command -v /usr/bin/makewhatis >/dev/null 2>&1; then \
			/usr/bin/makewhatis; \
		fi \
	fi
	@echo "✅ Install complete."

# Uninstall script and man page
.PHONY: uninstall
uninstall:
	@echo "🗑️  Removing $(BINDIR)/$(SCRIPT)..."
	rm -f $(DESTDIR)$(BINDIR)/$(SCRIPT)
	@echo "📖 Removing man page $(MANDIR)/$(MANPAGE)..."
	rm -f $(DESTDIR)$(MANDIR)/$(MANPAGE)
	@echo "✅ Uninstall complete."

# Clean (no generated files, so just echo)
.PHONY: clean
clean:
	@echo "🧽 Nothing to clean."

# Help
.PHONY: help
help:
	@echo "Available targets:"
	@echo "  install    – Install script and man page"
	@echo "  uninstall  – Remove script and man page"
	@echo "  validate   – Check script syntax"
	@echo "  clean      – (No-op)"
	@echo "  help       – Show this help"
	@echo ""
	@echo "Override install prefix with: make PREFIX=/custom/path"
