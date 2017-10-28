# Based on https://github.com/lunaryorn/dotfiles/blob/master/Makefile

STOW = stow
STOWFLAGS =
STOWVERBOSE = 0
STOW-CMD = $(STOW) --target $(HOME) -v $(STOWVERBOSE) $(STOWFLAGS)
STOW-INSTALL = $(STOW-CMD) -R
STOW-UNINSTALL = $(STOW-CMD) -D

PKGS = \
	R awesome clojure fonts git i3 luakit ncmpcpp pacaur password-store \
	terminal vim xbm-icons zsh

install:
	$(STOW-INSTALL) $(PKGS)

uninstall:
	$(STOW-UNINSTALL) $(PKGS)

.PHONY: install clean
