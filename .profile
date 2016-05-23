#
# ~/.profile
#
# Will be executed on login

if [ -d ~/.bin ]; then
	# add user drop-in path, useful for local builds of things
	export PATH=~/.bin:$PATH
fi

export VISUAL=vim
export EDITOR=vim

[[ -f ~/.bashrc ]] && . ~/.bashrc

[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && startx

# vim: ft=sh:
