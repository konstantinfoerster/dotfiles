# will be executed on login
#echo "Loading .profile"

# set PATH so it includes user's private bin if it exist
if [ -d "$HOME/.bin" ]; then
    PATH=$HOME/.bin:$PATH
fi

if [ -d "$HOME/.gem/ruby/2.4.0/bin" ]; then
    PATH=$HOME/.gem/ruby/2.4.0/bin:$PATH
fi

export PATH=~/.npm-global/bin:$PATH
export JAVA_HOME=/usr/lib/jvm/default

export GOPATH=$HOME/go

export VISUAL=vim
export EDITOR=vim

if [ -e /usr/bin/chromium ]; then
    export CHROME_BIN=/usr/bin/chromium
fi

#export TERM='xterm-256color'

#if [ "$HOSTNAME" = "kg-pc" ]; then
#    export GDK_BACKEND=wayland
#fi
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
