# Dotfiles
Dotfiles repository

Vim / Terminal Theme: base16-atelier-dune

## Setup
```
cd ~
git clone https://github.com/konstantinfoerster/dotfiles.git
cd dotfiles
git submodule init
git submodule update
```

or

```
cd ~
git clone --recursive https://github.com/konstantinfoerster/dotfiles.git
```

mkdir -p $HOME/.vim/backup

Link all needed files to $HOME

### Gnome terminal theme
source ~/.config/base16-gnome-terminal/color-scripts/base16-atelier-dune.sh
