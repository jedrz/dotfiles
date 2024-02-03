#!/bin/zsh
#
# .zprofile - Zsh file loaded on login.
#

#
# Browser
#

if [[ "$OSTYPE" == darwin* ]]; then
  export BROWSER="${BROWSER:-open}"
fi

#
# Editors
#

export EDITOR="${EDITOR:-vim}"
export VISUAL="${VISUAL:-vim}"
export PAGER="${PAGER:-less}"

#
# Paths
#

# Ensure path arrays do not contain duplicates.
typeset -gU path fpath

# Set the list of directories that zsh searches for commands.
path=(
  /usr/local/{bin,sbin}
  /usr/{bin,sbin}
  /{bin,sbin}
  ~/.bin
  ~/.local/bin
  # Go
  "$GOPATH/bin"
  # Haskell
  ~/.ghcup/bin
  ~/.cabal/bin/
  $path
)

# Private settings outside Git
if [[ -f "${ZDOTDIR:-$HOME}/.zprofile-private" ]]; then
    source "${ZDOTDIR:-$HOME}/.zprofile-private"
fi

