#!/bin/bash

export PS2DEV=$PWD/ps2dev
export PS2SDK=$PS2DEV/ps2sdk
export GSKIT=$PS2DEV/gsKit
# This is just needed for MacOS: ensure `sed` resolves to GNU sed.
if command -v brew &> /dev/null; then export PATH="$(brew --prefix gnu-sed)/libexec/gnubin:$PATH"; fi
# MacPorts installs GNU sed as `gsed`; expose it as `sed` via a shim directory.
if command -v port &> /dev/null && command -v gsed &> /dev/null; then
    GNU_SED_SHIM_DIR="${TMPDIR:-/tmp}/ps2dev-gnused-shim"
    mkdir -p "$GNU_SED_SHIM_DIR"
    ln -sf "$(command -v gsed)" "$GNU_SED_SHIM_DIR/sed"
    export PATH="$GNU_SED_SHIM_DIR:$PATH"
fi
export PATH=$PATH:$PS2DEV/bin
export PATH=$PATH:$PS2DEV/iop/bin
export PATH=$PATH:$PS2DEV/ee/bin
export PATH=$PATH:$PS2DEV/dvp/bin
export PATH=$PATH:$PS2SDK/bin
