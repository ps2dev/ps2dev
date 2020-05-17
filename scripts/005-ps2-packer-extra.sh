#!/bin/bash
# ps2-packer.sh by fjtrujy

## Download the source code.
if test ! -d "ps2-packer/.git"; then
	git clone https://github.com/ps2dev/ps2-packer && cd ps2-packer || exit 1
else
	cd ps2-packer &&
		git pull && git fetch origin &&
		git reset --hard origin/master || exit 1
fi

## Build and install.
make --quiet clean && make --quiet && make --quiet install && make --quiet clean || { exit 1; }
