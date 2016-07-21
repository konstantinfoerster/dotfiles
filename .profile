# will be executed on login

# set PATH so it includes user's private bin if it exist
if [ -d "$HOME/.bin" ]; then
	export PATH=~/.bin:$PATH
fi

export VISUAL=vim
export EDITOR=vim

export FT2_SUBPIXEL_HINTING=0  # Classic mode
#export FT2_SUBPIXEL_HINTING=1  # Infinality mode 
#export FT2_SUBPIXEL_HINTING=2  # Default mode

#export TERM='xterm-256color'

stty -ixon

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists 
    [[ -f $HOME/.bashrc ]] && . $HOME/.bashrc
fi
if [ -f /usr/local/bin/bspwm ]; then
    [[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && startx
fi

# vim: ft=sh:

