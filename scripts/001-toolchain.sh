#!/bin/bash
# ps2-packer.sh by fjtrujy

## Download the source code.
if test ! -d "ps2toolchain/.git"; then
	git clone https://github.com/fjtrujy/ps2toolchain && cd ps2toolchain || exit 1
else
	cd ps2toolchain &&
		git pull && git fetch origin &&
		git reset --hard origin/master || exit 1
fi

## Build and install.
./toolchain.sh || { exit 1; }
