#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...

# Print exit value
setopt printexitvalue

# Custom aliases
# to prevent from showing in every folder git info
alias dotgit='git --git-dir=$HOME/.dotfiles --work-tree=$HOME '
# other aliases
alias gcc='gcc -Wall'
alias g++='g++ -Wall'
alias e='emacsclient -c'
alias ec='emacsclient -t'
alias extract='unarchive'
