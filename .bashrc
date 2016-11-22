#!/bin/sh

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

source ~/.scripts/common.sh

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend
# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS. 
shopt -s checkwinsize

PROMPT_DIRTRIM=4 

#\u user \h hostname \w pwd
PS1="\u@\h \w\\$ "

if [ -f ~/.bashrc.d/git-prompt.sh ]; then
    source ~/.bashrc.d/git-prompt.sh
    GIT_PS1_SHOWDIRTYSTATE=1
    GIT_PS1_SHOWCOLORHINTS=1
    #export GIT_PS1_SHOWUNTRACKEDFILES=1 # can be slow
    PROMPT_COMMAND='__git_ps1 "\u@\h:\w" "\\\$ "'
 fi

if [ -f ~/.bashrc.d/bash-aliases.sh ]; then
    source ~/.bashrc.d/bash-aliases.sh
fi

if [ -f ~/.bashrc.d/bash-env.sh ]; then
    source ~/.bashrc.d/bash-env.sh
fi


#### GPG

# Start the gpg-agent if not already running
if ! pgrep -x -u "${USER}" gpg-agent >/dev/null 2>&1; then
    gpg-connect-agent /bye >/dev/null 2>&1
fi
# Set SSH to use gpg-agent
unset SSH_AGENT_PID
if [ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$  ]; then
    export SSH_AUTH_SOCK="/run/user/$UID/gnupg/S.gpg-agent.ssh"
fi
 # Set GPG TTY
export GPG_TTY=$(tty)

 # Refresh gpg-agent tty in case user switches into an X session
gpg-connect-agent updatestartuptty /bye >/dev/null
