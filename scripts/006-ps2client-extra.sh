#!/bin/bash
# ps2client.sh by Naomi Peori (naomi@peori.ca)
# changed to use Git by Mathias Lafeldt <misfire@debugon.org>

## Download the source code.
REPO_URL="https://github.com/ps2dev/ps2client"
REPO_FOLDER="ps2client"

# Checking if a specific TAG has been selected, it is passed using parameter $1
[  -z "$1" ] && REPO_REFERENCE="origin/master" || REPO_REFERENCE=$1
echo "Using repo reference $REPO_REFERENCE"

if test ! -d "$REPO_FOLDER"; then
	git clone $REPO_URL|| exit 1
fi
cd $REPO_FOLDER && git fetch origin && git reset --hard ${REPO_REFERENCE} || exit 1

## Build and install.
make --quiet clean && make --quiet && make --quiet install && make --quiet clean || { exit 1; }
