### dotfiles
Dotfiles repository

Theme: base16-atelier-dune

cd ~

git clone https://github.com/kgeorgiew/dotfiles.git

cd dotfiles

git submodule init

git submodule update


or

cd ~

git clone --recursive https://github.com/kgeorgiew/dotfiles.git


Link all needed files to $HOME

source .bashrc

base16_atelier-dune # will generate the shell theme and .vimrc_background
