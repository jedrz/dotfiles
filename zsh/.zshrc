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

# Extend history size
export HISTSIZE=1000000
export SAVEHIST=1000000

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

# fzf
if [[ -f /usr/share/fzf/key-bindings.zsh ]]; then
    source /usr/share/fzf/key-bindings.zsh
fi
if [[ -f /usr/share/fzf/completion.zsh ]]; then
    source /usr/share/fzf/completion.zsh
fi

# CTRL-O to open with `open` command,
# CTRL-E or Enter key to open with the $EDITOR
fo() {
    local out file key
    IFS=$'\n' out=($(fzf-tmux --query="$1" --exit-0 --expect=ctrl-o,ctrl-e))
    key=$(head -1 <<< "$out")
    file=$(head -2 <<< "$out" | tail -1)
    if [[ -n "$file" ]]; then
        [[ "$key" = ctrl-o ]] && xdg-open "$file" || eval ${=EDITOR:-vim} "$file"
    fi
}

eval "$(direnv hook zsh)"

# Load Node Version Manager
load-nvmrc() {
    local nvmrc_path="$(nvm_find_nvmrc)"

    if [ -n "$nvmrc_path" ]; then
        local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

        if [ "$nvmrc_node_version" = "N/A" ]; then
            nvm install
        elif [ "$nvmrc_node_version" != "$(nvm version)" ]; then
            nvm use
        fi
    elif [ -n "$(PWD=$OLDPWD nvm_find_nvmrc)" ] && [ "$(nvm version)" != "$(nvm version default)" ]; then
        echo "Reverting to nvm default version"
        nvm use default
    fi
}

if [[ -f /usr/share/nvm/init-nvm.sh ]]; then
    source /usr/share/nvm/init-nvm.sh
    add-zsh-hook chpwd load-nvmrc
    load-nvmrc
fi

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/home/lukasz/.sdkman"
[[ -s "/home/lukasz/.sdkman/bin/sdkman-init.sh" ]] && source "/home/lukasz/.sdkman/bin/sdkman-init.sh"
