#!/bin/bash

export PS2DEV=$PWD/ps2dev
export PS2SDK=$PS2DEV/ps2sdk
export GSKIT=$PS2DEV/gsKit
# This is just needed for MacOS
if command -v brew &> /dev/null; then export PATH="$(brew --prefix gnu-sed)/libexec/gnubin:$PATH"; fi
export PATH=$PATH:$PS2DEV/bin
export PATH=$PATH:$PS2DEV/iop/bin
export PATH=$PATH:$PS2DEV/ee/bin
export PATH=$PATH:$PS2DEV/dvp/bin
export PATH=$PATH:$PS2SDK/bin
