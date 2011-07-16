if has("gui_running")
    " gvim
    set guioptions-=r
    set guioptions-=L
    set guioptions-=T
    set guioptions-=m
    "set guifont=Monaco\ 9
    set guifont=Envy\ Code\ R
    set mousehide
    colorscheme molokai
else
    " vim
    set t_Co=256
    colorscheme delek
    " set background=dark
    " syntax enable
endif

set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

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
