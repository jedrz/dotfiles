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
alias e='emacsclient -c'
alias ec='emacsclient -t'
alias extract='unarchive'
alias prettyjson='python -m json.tool'

# Git
alias gpnt='git push --no-thin'

# fasd
eval "$(fasd --init auto)"

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
