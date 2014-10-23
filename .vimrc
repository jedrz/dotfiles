if has("gui_running")
    set guioptions-=r
    set guioptions-=L
    set guioptions-=T
    set guioptions-=m
    set guifont=Inconsolata\ 11
    set mousehide
else
    set t_Co=256
endif
set background=dark

set nocompatible

set backspace=indent,eol,start

set history=50
set ruler
set showcmd
set incsearch

set mouse=a
syntax on
set nobackup
set spelllang=pl
set tabstop=4
set shiftwidth=4
set smarttab
set expandtab
set number
set hlsearch
set autoindent

filetype on
filetype plugin indent on
