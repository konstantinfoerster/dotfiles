# will be executed on login

if [ -d "$HOME/.bin" ]; then
    export PATH=$HOME/.bin:$PATH
fi

if [ -d "$HOME/.local/bin" ]; then
    export PATH=$HOME/.local/bin:$PATH
fi

if [ -d "$HOME/.scripts" ]; then
    export PATH=$HOME/.scripts:$PATH
fi

if [ -d "$HOME/go/bin" ]; then
    export PATH=$HOME/go/bin:$PATH
fi

export XDG_CONFIG_HOME=$HOME/.config

export JAVA_HOME=/usr/lib/jvm/default
export GOPATH=$HOME/go

if [ -S "$XDG_RUNTIME_DIR/podman/podman.sock" ]; then
    export DOCKER_HOST=unix://$XDG_RUNTIME_DIR/podman/podman.sock
fi

export VISUAL=nvim
export EDITOR=nvim

if [ -e /usr/bin/chromium ]; then
    export CHROME_BIN=/usr/bin/chromium
fi

if [ -e /usr/lib/seahorse/ssh-askpass ]; then
    export SSH_ASKPASS=/usr/lib/seahorse/ssh-askpass
fi

stty -ixon

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists 
    [[ -f $HOME/.bashrc ]] && . $HOME/.bashrc
fi

# vim: ft=sh:
