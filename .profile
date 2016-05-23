#
# ~/.profile
#
# Will be executed on login

if [ -d ~/.profile.d ]; then
	# add user drop-in path, useful for local builds of things
	[ ! -d ~/.profile.d/bin ] && mkdir ~/.profile.d/bin
	export PATH=~/.profile.d/bin:$PATH
fi

export VISUAL=vim
export EDITOR=vim

#export PANEL_FIFO="/tmp/panel-fifo"
#export PANEL_HEIGHT=15
#export PANEL_FONT="-misc-fixed-medium-r-semicondensed--13-120-75-75-c-60-iso8859-1"
#export PANEL_WM_NAME=bspwm_panel


[[ -f ~/.bashrc ]] && . ~/.bashrc

[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && startx

# vim: ft=sh:
