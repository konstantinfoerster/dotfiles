#!/bin/sh
dryRun="--dry-run"

if [ "$1" == "-y" ]; then
    dryRun=""
else
    echo "running in dry mode. Add '-y' to disable dry-run"
fi

git remote prune origin $dryRun
