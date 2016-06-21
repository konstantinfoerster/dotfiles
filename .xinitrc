#!/bin/sh

source $HOME/.scripts/common.sh

sourceDir /etc/X11/xinit/xinitrc.d

usermodmap=$HOME/.Xmodmap
sysmodmap=/etc/X11/xinit/.Xmodmap

if [ -f $sysmodmap ]; then
	xmodmap "$sysmodmap"
fi
unset sysmodmap

if [ -f "$usermodmap" ]; then
        xmodmap "$usermodmap"
fi
unset usermodmap

userresources=$HOME/.Xresources
sysresources=/etc/X11/xinit/.Xresources

#read global system Xresources file
if [ -f "$sysresources" ]; then
	xrdb -merge "$sysresources"
fi
unset sysresources

#read user Xresources file
if [ -f "$userresources" ]; then
	xrdb -merge "$userresources"
fi
unset userresources

if [ -f /usr/bin/ssh-agent ]; then
    eval `/usr/bin/ssh-agent`
    if [ -f /usr/lib/ssh/x11-ssh-askpass ]; then
        export SSH_ASKPASS=/usr/lib/ssh/x11-ssh-askpass ssh-add < /dev/null
    fi
    
    if [ -f /usr/bin/keychain ]; then
        keychain id_dsa
        [ -f ~/.keychain/$HOSTNAME-sh  ] && . ~/.keychain/$HOSTNAME-sh 2>/dev/null
        [ -f ~/.keychain/$HOSTNAME-sh-gpg  ] && . ~/.keychain/$HOSTNAME-sh-gpg 2>/dev/null
    fi
fi

#Swap escape with caps key
setxkbmap -option caps:swapescape

wmname LG3D
export _JAVA_AWT_WM_NONREPARENTING=1
#export SWT_GTK3=0


xset +fp $HOME/.local/share/fonts
xset fp rehash

sxhkd &

xsetroot -cursor_name left_ptr &
#compton -f -b
devmon 	--sync --no-gui \
	--exec-on-drive "notify-send \"Devmon\" \"Mounted %f on %d\"" \
	--exec-on-unmount "notify-send \"Devmon\" \"Unmounted %f\"" \
	--exec-on-disc "notify-send \"Devmon\" \"Mounted data CD/DVD\"" \
	--exec-on-video "notify-send  \"Devmon\" \"Mounted video DVD\"" \
	--exec-on-audio "notify-send  \"Devmon\" \"Mounted audio CD\"" \
	--exec-on-remove "notify-send  \"Devmon\" \"Removed %f\"" > /dev/null 2>&1 &
exec bspwm 2> ${HOME}/.local/log/bspwm.log
#:exec ck-launch-session dbus-launch bspwm

# vim: set ft=sh:
