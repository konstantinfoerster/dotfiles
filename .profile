#
# ~/.profile
#
# Will be executed on login

if [ -d $HOME/.bin ]; then
	# add user drop-in path, useful for local builds of things
	export PATH=~/.bin:$PATH
fi

export VISUAL=vim
export EDITOR=vim

if [ -e /usr/share/terminfo/x/xterm-256color  ]; then
    export TERM='xterm-256color'
else
    export TERM='xterm-color'
fi

stty -ixon

if [ -n "$BASH_VERSION" ]; then
    [[ -f $HOME/.bashrc ]] && . ~/.bashrc
fi

if [ -f /usr/bin/bspwm ]; then
    [[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && startx
fi

# vim: ft=sh:

