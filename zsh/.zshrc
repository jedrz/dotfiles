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

# Enable virtualenvwrapper
if hash virtualenvwrapper.sh &> /dev/null; then
    source virtualenvwrapper.sh
fi

# gopass autocompletion
source <(gopass completion zsh)

# Display date in the RPROMPT for pure theme.
# https://github.com/sindresorhus/pure/issues/170
prompt_pure_apply_rprompt() {
   str='%F{blue}%*%f'
   pos=$(( COLUMNS - 7 ))
   print -Pn "\e7\e[1A\e[${pos}G${str}\e8"
}

# Override old function.
# http://stackoverflow.com/a/16776065
eval "`declare -f prompt_pure_preprompt_render | sed '1s/.*/_&/'`"
prompt_pure_preprompt_render() {
    _prompt_pure_preprompt_render "$@"
    prompt_pure_apply_rprompt
}
