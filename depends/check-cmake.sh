#!/bin/sh

## Check for CMake.
cmake --version 1> /dev/null || { echo "ERROR: Install CMake before continuing."; exit 1; }
