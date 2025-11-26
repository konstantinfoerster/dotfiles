# will be executed on login

if [ -d "$HOME/.bin" ]; then
    export PATH=$HOME/.bin:$PATH
fi

if [ -d "$HOME/.scripts" ]; then
    export PATH=$HOME/.scripts:$PATH
fi

if [ -d "$HOME/go/bin" ]; then
    export PATH=$HOME/go/bin:$PATH
fi

# if [ -d "/usr/share/dotnet" ]; then
#     export PATH=$HOME/.dotnet/tools:$PATH
#     export DOTNET_CLI_TELEMETRY_OPTOUT=1
#     export DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=1
#     export PATH=$HOME/.bin/dotnet/omnisharp/:$PATH
# fi

export XDG_CONFIG_HOME=$HOME/.config

export JAVA_HOME=/usr/lib/jvm/default
export GOPATH=$HOME/go

export VISUAL=nvim
export EDITOR=nvim

if [ -e /usr/bin/chromium ]; then
    export CHROME_BIN=/usr/bin/chromium
fi

if [ -e /usr/lib/seahorse/ssh-askpass ]; then
    export SSH_ASKPASS=/usr/lib/seahorse/ssh-askpass
fi

#export TERM='xterm-256color'

stty -ixon

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists 
    [[ -f $HOME/.bashrc ]] && . $HOME/.bashrc
fi

# vim: ft=sh:
