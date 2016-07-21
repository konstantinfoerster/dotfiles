#!/bin/sh

FONT_DIR="$HOME/.local/share/fonts"

if [ -d  "$FONT_DIR" ]; then 
    cd "$FONT_DIR"
    for dir in *; do
      if [ -d $dir ]; then
    	cd "$dir"
    	echo "Update fonts in $PWD"
    	xset +fp "$PWD"
    	mkfontscale
	    mkfontdir
	    cd ..
      fi
    done && xset fp rehash
fi 
unset FONT_DIR
