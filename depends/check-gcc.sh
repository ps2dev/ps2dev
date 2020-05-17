#!/bin/sh
# check-gcc.sh by Naomi Peori (naomi@peori.ca)

## Check for gcc.
gcc --version 1> /dev/null || { echo "ERROR: Install gcc before continuing."; exit 1; }
