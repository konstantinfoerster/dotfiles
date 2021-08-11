#!/bin/sh

if [[ $(grep Microsoft /proc/version) ]]; then
    export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2; exit;}'):0.0
    export LIBGL_ALWAYS_INDIRECT=1
fi

