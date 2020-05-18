#!/bin/sh
# check-make.sh by Naomi Peori (naomi@peori.ca)

## Check for make.
make -v 1> /dev/null || { echo "ERROR: Install make before continuing."; exit 1; }
