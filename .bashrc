#!/bin/sh

[[ $- = *i* ]] || return

source ${HOME}/.scripts/common.sh

PROMPT_DIRTRIM=4 

#Arch default
#PS1='[\u@\h \W]\$ '

#\u user \h hostname \w pwd
#PS1="[\u@\h \w]\\$ "

source ~/.bashrc.d/git-prompt.sh
PROMPT_COMMAND='__git_ps1 "\u@\h:\w" "\\\$ "'
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWCOLORHINTS=1

# Aliases
alias ls='ls --color=auto'
