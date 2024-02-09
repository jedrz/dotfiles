# Based on https://github.com/lunaryorn/dotfiles/blob/master/Makefile

STOW = stow
STOWFLAGS =
STOWVERBOSE = 0
STOW-CMD = $(STOW) --target $(HOME) -v $(STOWVERBOSE) $(STOWFLAGS)
STOW-INSTALL = $(STOW-CMD) -R
STOW-UNINSTALL = $(STOW-CMD) -D

PKGS = git password-store terminal tmux vim vim zsh-antidote atuin alacritty

install:
	$(STOW-INSTALL) $(PKGS)

uninstall:
	$(STOW-UNINSTALL) $(PKGS)

.PHONY: install clean
