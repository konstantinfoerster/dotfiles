#!/bin/sh

if [ "$1" == "-y" ]; then
    git fetch -p && for branch in $(git branch -vv | grep ': gone]' | awk '{print $1}'); do git branch -d $branch; done
else 
    echo "Following branches would be deleted. Run with -y to delete these branches."
    git fetch -p && git branch -vv | grep ': gone]'
fi


