# Based on https://github.com/lunaryorn/dotfiles/blob/master/Makefile

STOW = stow
STOWFLAGS =
STOWVERBOSE = 0
STOW-CMD = $(STOW) --target $(HOME) -v $(STOWVERBOSE) $(STOWFLAGS)
STOW-INSTALL = $(STOW-CMD) -R
STOW-UNINSTALL = $(STOW-CMD) -D

# 1. Only dirs.
# 2. Delete ending slash.
# 3. Filter out $(CURDIR)/ (note ending slash).
# 4. Extract last path component.
PKGS = $(notdir $(patsubst %/,%,$(filter-out $(CURDIR)/,$(dir $(wildcard $(CURDIR)/*/)))))

install:
	$(STOW-INSTALL) $(PKGS)

uninstall:
	$(STOW-UNINSTALL) $(PKGS)

.PHONY: install clean
