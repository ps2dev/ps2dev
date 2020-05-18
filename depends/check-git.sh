#!/bin/sh
# check-git.sh by Mathias Lafeldt <misfire@debugon.org>

## Check for git.
git --version > /dev/null || { echo "ERROR: Install Git before continuing."; exit 1; }
