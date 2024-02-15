#!/bin/zsh
#
# .zshrc - Zsh file loaded on interactive shell sessions.
#

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Zsh options.
setopt extended_glob
setopt auto_cd
setopt printexitvalue

# prezto stub function
function pmodload {
}

# Autoload functions you might want to use with antidote.
ZFUNCDIR=${ZFUNCDIR:-$ZDOTDIR/functions}
fpath=($ZFUNCDIR $fpath)
autoload -Uz $fpath[1]/*(.:t)

# Source zstyles you might use with antidote.
[[ -e ${ZDOTDIR:-~}/.zstyles ]] && source ${ZDOTDIR:-~}/.zstyles

# Clone antidote if necessary.
[[ -d ${ZDOTDIR:-~}/.antidote ]] ||
  git clone https://github.com/mattmc3/antidote ${ZDOTDIR:-~}/.antidote

# Create an amazing Zsh config using antidote plugins.
source ${ZDOTDIR:-~}/.antidote/antidote.zsh
antidote load

# https://registerspill.thorstenball.com/p/which-command-did-you-run-1731-days
# Extend history size
export HISTSIZE=1000000
export SAVEHIST=1000000
# Record timestamp in history
setopt EXTENDED_HISTORY
# Share history between all sessions
setopt SHARE_HISTORY

# Edit command with editor (Ctrl-x ctrl-e)
autoload -U edit-command-line
zle -N edit-command-line
bindkey "^X^E" edit-command-line

# Enable zoxide - smart cd with z and zi commands
eval "$(zoxide init zsh)"
# Allow non-consecutive characters
# https://github.com/ajeetdsouza/zoxide/issues/388#issuecomment-1347808410
function __zoxide_z() {
    if [[ "$#" -eq 0 ]]; then
        __zoxide_cd ~
    elif [[ "$#" -eq 1 ]] && { [[ -d "$1" ]] || [[ "$1" = '-' ]] || [[ "$1" =~ ^[-+][0-9]$ ]]; }; then
        __zoxide_cd "$1"
    elif [[ "$@[-1]" == "${__zoxide_z_prefix}"* ]]; then
        \builtin local result="${@[-1]}"
        __zoxide_cd "${result:${#__zoxide_z_prefix}}"
    else
        \builtin local IFS=' '
        \builtin local result
        result="$(\command zoxide query --list --exclude "$(__zoxide_pwd)" | \command fzf --no-sort --filter "$*" | \command head -n 1)" &&
            __zoxide_cd "${result}"
    fi
}

# Use Ctrl-r to search history
bindkey '^r' _atuin_search_widget

# Alt-Shift-j - jq-repl
bindkey '^[J' jq-complete

# Enable virtualenvwrapper
source /usr/bin/virtualenvwrapper.sh

eval "$(direnv hook zsh)"

autoload -Uz promptinit && promptinit
prompt powerlevel10k

# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh
