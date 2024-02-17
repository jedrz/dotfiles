# My Dotfiles

Personal dotfiles managed with [GNU Stow](http://www.gnu.org/software/stow/).

## Usage

Clone this repository with `--recursive` flag to download all submodules too:

    $ git clone --recursive https://github.com/jedrz/dotfiles.git ~/.dotfiles

To install all modules:

    $ stow */

To uninstall them:

    $ stow -D */

To install only some modules:

    $ stow tmux zsh

## zsh

zsh config is based on https://github.com/getantidote/zdotdir

Dependencies:
- [atuin](https://atuin.sh/) - better history
- [zoxide](https://github.com/ajeetdsouza/zoxide) - for `z` and `zi`
