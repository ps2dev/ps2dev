#!/bin/sh
# check-wget.sh by Naomi Peori (naomi@peori.ca)

## Check for wget.
wget -V 1> /dev/null || { echo "ERROR: Install wget before continuing."; exit 1; }
