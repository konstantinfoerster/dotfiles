#!/bin/sh

if grep -iq microsoft /proc/version ; then
    display_target=$(grep nameserver /etc/resolv.conf | awk '{print $2; exit;}'):0
    export DISPLAY=$display_target
    export LIBGL_ALWAYS_INDIRECT=1
    export NO_AT_BRIDGE=1
    export VAGRANT_WSL_ENABLE_WINDOWS_ACCESS="1"
    unset display_target

    setxkbmap  de
fi

