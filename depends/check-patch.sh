#!/bin/sh
# check-patch.sh by Naomi Peori (naomi@peori.ca)

## Check for patch.
patch -v 1> /dev/null || { echo "ERROR: Install patch before continuing."; exit 1; }
