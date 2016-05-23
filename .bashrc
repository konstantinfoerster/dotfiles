#!/bin/sh

[[ $- = *i* ]] || return

source ${HOME}/.scripts/common.sh

PROMPT_DIRTRIM=4 

#Arch default
#PS1='[\u@\h \W]\$ '

#\u user \h hostname \w pwd
PS1="[\u@\h \w]\\$ "


# Aliases
alias ls='ls --color=auto'
