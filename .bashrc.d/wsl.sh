#!/bin/sh

if grep -iq microsoft /proc/version ; then
    export NO_AT_BRIDGE=1
    export VAGRANT_WSL_ENABLE_WINDOWS_ACCESS="1"
    ln -s /mnt/wslg/runtime-dir/wayland-0* /run/user/1000/ 2>/dev/null
    ln -s /mnt/wslg/.X11-unix/X0 /tmp/.X11-unix/X0 2>/dev/null
fi

