#!/bin/sh

if grep -iq microsoft /proc/version ; then
    export NO_AT_BRIDGE=1
    export VAGRANT_WSL_ENABLE_WINDOWS_ACCESS="1"
fi

