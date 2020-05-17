#!/bin/bash
# ps2sdk.sh by Naomi Peori (naomi@peori.ca)
# changed to use Git by Mathias Lafeldt <misfire@debugon.org>

# make sure ps2sdk's makefile does not use it
unset PS2SDKSRC

## Download the source code.
if test ! -d "ps2sdk/.git"; then
	git clone https://github.com/ps2dev/ps2sdk && cd ps2sdk || exit 1
else
	cd ps2sdk &&
		git pull && git fetch origin &&
		git reset --hard origin/master || exit 1
fi

## Determine the maximum number of processes that Make can work with.
#OSVER=$(uname)
#if [ ${OSVER:0:10} == MINGW32_NT ]; then
#	PROC_NR=$NUMBER_OF_PROCESSORS
#elif [ ${OSVER:0:6} == Darwin ]; then
#	PROC_NR=$(sysctl -n hw.ncpu)
#else
#	PROC_NR=$(nproc)
#fi

## Build and install
# Workaround 2018/10/18: remove -j as the ps2toolchain's Makefiles do not have dependencies set up properly.
make --quiet clean && make --quiet && make --quiet install && make --quiet clean || { exit 1; }

## gcc needs to include both libps2sdkc and libkernel from ps2sdk to be able to build executables.
ln -sf "$PS2SDK/ee/lib/libps2sdkc.a" "$PS2DEV/ee/ee/lib/libps2sdkc.a" || { exit 1; }
ln -sf "$PS2SDK/ee/lib/libkernel.a"  "$PS2DEV/ee/ee/lib/libkernel.a"  || { exit 1; }
