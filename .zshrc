export EDITOR="vim"
export BROWSER="luakit"
# skype camera
#export LD_PRELOAD=/usr/lib/libv4l/v4l1compat.so
# dosbox
export SDL_AUDIODRIVER=alsa
#export AUDIO_DEV="/dev/dsp"
# java fix for awesome wm
export _JAVA_AWT_WM_NONREPARENTING=1
# gtk styles in qt
export GTK2_RC_FILES=$HOME/.gtkrc-2.0


# Opcje
zstyle ':completion:*' completer _expand _complete
zstyle ':completion:*' expand prefix suffix
zstyle ':completion:*' file-sort name
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' list-suffixes true
zstyle ':completion:*' matcher-list 'r:|[._-]=** r:|=**'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' preserve-prefix '//[^/]##/'
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' squeeze-slashes true
zstyle :compinstall filename '/home/lukasz/.zshrc'


# dopelnianie
autoload -Uz compinit
compinit

# ustawienia
HISTFILE=~/.histfile
HISTSIZE=5000
SAVEHIST=5000

#setopt appendhistory autocd extendedglob notify
unsetopt beep

setopt AUTO_CD
setopt CORRECT
setopt CHECK_JOBS
setopt AUTO_PUSHD
setopt MULTIOS
setopt HIST_IGNORE_ALL_DUPS
setopt PRINT_EXIT_VALUE


# PS1
# kolory
local BLUE=$'%{\e[1;34m%}'
local CYAN=$'%{\e[1;36m%}'
local GREEN=$'%{\e[1;32m%}'
local YELLOW=$'%{\e[1;33m%}'
local PINK=$'%{\e[1;35m%}'
local RED=$'%{\e[1;31m%}'
local WHITE=$'%{\e[1;37m%}'
local NORMAL=$'%{\e[0m%}'
# prompt
#PROMPT="${BLUE}┌─[${PINK}%n@%m${BLUE}]─[${RED}%~${BLUE}]
#└─> ${NORMAL}"
PROMPT="[${RED}%~${NORMAL}] ${BLUE}\$${NORMAL} "

# funkcja jest wywoływana po wpisaniu komendy i wciśnięciu entera
# ustawia standardowy kolor
#preexec() {
#    echo -n "\e[0m"
#}


# zsh-mime-setup
autoload -U zsh-mime-setup
zsh-mime-setup


# Aliasy
alias ..='cd ..'
alias ls='ls --color=auto'
alias grep='grep --color=auto'
#alias pyaur='python2 ~/Programowanie/python/skrypty/pyaur/pyaur.py'
alias wrar='wine ~/.wine/drive_c/Program\ Files/WinRAR/WinRAR.exe'
alias gcc='gcc -Wall'
alias g++='g++ -Wall'

# Funkcje
extract () {
   if [ -f $1 ] ; then
       case $1 in
           *.tar.bz2)   tar xvjf $1    ;;
           *.tar.gz)    tar xvzf $1    ;;
           *.bz2)       bunzip2 $1     ;;
           *.rar)       unrar x $1     ;;
           *.gz)        gunzip $1      ;;
           *.tar)       tar xvf $1     ;;
           *.tbz2)      tar xvjf $1    ;;
           *.tgz)       tar xvzf $1    ;;
           *.zip)       unzip $1       ;;
           *.Z)         uncompress $1  ;;
           *.7z)        7z x $1        ;;
           *)           echo "don't know how to extract '$1'..." ;;
       esac
   else
       echo "'$1' is not a valid file!"
   fi
}

# key bindings
bindkey "\e[1~" beginning-of-line # Home
bindkey "\e[4~" end-of-line # End
bindkey "\e[5~" beginning-of-history # PageUp
bindkey "\e[6~" end-of-history # PageDown
bindkey "\e[2~" quoted-insert # Ins
bindkey "\e[3~" delete-char # Del
bindkey "\e[5C" forward-word
bindkey "\eOc" emacs-forward-word
bindkey "\e[5D" backward-word
bindkey "\eOd" emacs-backward-word
bindkey "\e\e[C" forward-word
bindkey "\e\e[D" backward-word
bindkey "\e[Z" reverse-menu-complete # Shift+Tab
# for rxvt
bindkey "\e[7~" beginning-of-line # Home
bindkey "\e[8~" end-of-line # End
