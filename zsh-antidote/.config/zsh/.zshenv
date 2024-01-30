#!/bin/zsh
#
# .zshenv - Zsh environment file, loaded always.
#

# NOTE: .zshenv needs to live at ~/.zshenv, not in $ZDOTDIR!

# Set ZDOTDIR if you want to re-home Zsh.
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-$HOME/.config}
export ZDOTDIR=${ZDOTDIR:-$XDG_CONFIG_HOME/zsh}

# You can use .zprofile to set environment vars for non-login, non-interactive shells.
if [[ ( "$SHLVL" -eq 1 && ! -o LOGIN ) && -s "${ZDOTDIR:-$HOME}/.zprofile" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprofile"
fi

# Editors
export EDITOR="emacsclient -c"
export VISUAL="emacsclient -c"
export PAGER="less"
# automatically start an emacs daemon if no one is started yet
export ALTERNATE_EDITOR=""

# Maven home
export M2_HOME="/opt/maven"
# Go home
export GOPATH="$HOME/.go"

# Disable default atuin key bindings
export ATUIN_NOBIND="true"

# Private vars outside Git
if [[ -f "${ZDOTDIR:-$HOME}/.zshenv-private" ]]; then
    source "${ZDOTDIR:-$HOME}/.zshenv-private"
fi
