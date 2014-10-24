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
alias e='emacsclient -c'
alias ec='emacsclient -t'
alias extract='unarchive'

# fasd
command -v fasd &> /dev/null && eval "$(fasd --init auto)"

# deer
source ~/.zplugins/deer/deer
zle -N deer-launch
bindkey '\ek' deer-launch

# Setup zsh-autosuggestions
#source ~/.zsh-autosuggestions/autosuggestions.zsh
#AUTOSUGGESTION_HIGHLIGHT_COLOR='fg=yellow'

# Enable autosuggestions automatically
#zle-line-init() {
#    zle autosuggest-start
#}
#zle -N zle-line-init
