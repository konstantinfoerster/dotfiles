#!/bin/sh

FONT_DIR="$HOME/.local/share/fonts"
if [ -d  "$FONT_DIR" ]; then 
    cd "$FONT_DIR";
    echo "Update fonts in $PWD";
    xset +fp "$PWD" ;
    mkfontscale;
    mkfontdir;
    xset fp rehash
fi; 
