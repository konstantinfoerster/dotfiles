#!/bin/sh

source $HOME/.scripts/common.sh
sourceDir /etc/X11/xinit/xinitrc.d

[ -f ~/.xprofile ] && source ~/.xprofile

if [ -f /usr/bin/ssh-agent ]; then
    eval `/usr/bin/ssh-agent`
    if [ -f /usr/lib/ssh/x11-ssh-askpass ]; then
        SSH_ASKPASS=/usr/lib/ssh/x11-ssh-askpass ssh-add < /dev/null
	export SSH_ASKPASS
    fi
    
    if [ -f /usr/bin/keychain ]; then
        keychain id_dsa
        [ -f ~/.keychain/$HOSTNAME-sh  ] && . ~/.keychain/$HOSTNAME-sh 2>/dev/null
        [ -f ~/.keychain/$HOSTNAME-sh-gpg  ] && . ~/.keychain/$HOSTNAME-sh-gpg 2>/dev/null
    fi
fi

if [ -f /usr/local/bin/bspwm ]; then
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
    exec bspwm > $HOME/.local/log/bspwm.log 2>&1
    #:exec ck-launch-session dbus-launch bspwm
fi
# vim: set ft=sh:
