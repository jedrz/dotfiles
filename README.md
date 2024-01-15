# My Dotfiles

Personal dotfiles managed with [GNU Stow](http://www.gnu.org/software/stow/).

## Usage

Clone this repository with `--recursive` flag to download all submodules too:

    $ git clone --recursive https://github.com/jedrz/dotfiles.git ~/.dotfiles

To install all modules:

    $ make

To uninstall them:

    $ make uninstall

To choose only some modules specify `PKGS` explicitly:

    $ make install PKGS=zsh

## zsh

zsh config is based on https://github.com/getantidote/zdotdir
