#!/bin/bash
# 002-ps2sdk.sh by ps2dev developers

## Exit with code 1 when any command executed returns a non-zero exit code.
onerr()
{
  exit 1;
}
trap onerr ERR

## Read information from the configuration file.
source "$(dirname "$0")/../config/ps2dev-config.sh"

## Download the source code.
REPO_URL="$PS2SDK_REPO_URL"
REPO_REF="$PS2SDK_DEFAULT_REPO_REF"
REPO_FOLDER="$(s="$REPO_URL"; s=${s##*/}; printf "%s" "${s%.*}")"

# Checking if a specific Git reference has been passed in parameter $1
if test -n "$1"; then
  REPO_REF="$1"
  printf 'Using specified repo reference %s\n' "$REPO_REF"
fi

if test ! -d "$REPO_FOLDER"; then
  git clone --depth 1 -b "$REPO_REF" "$REPO_URL" "$REPO_FOLDER"
else
  git -C "$REPO_FOLDER" fetch origin
  git -C "$REPO_FOLDER" reset --hard "origin/$REPO_REF"
  git -C "$REPO_FOLDER" checkout "$REPO_REF"
fi

cd "$REPO_FOLDER"

# make sure ps2sdk's makefile does not use it
unset PS2SDKSRC

## Determine the maximum number of processes that Make can work with.
# Workaround 2018/10/18: remove -j as the ps2toolchain's Makefiles do not have dependencies set up properly.
# PROC_NR=$(getconf _NPROCESSORS_ONLN)
PROC_NR=1

## Build and install.
make --quiet -j "$PROC_NR" clean
make --quiet -j "$PROC_NR"
make --quiet -j "$PROC_NR" install
make --quiet -j "$PROC_NR" clean

## gcc needs to include libcglue, libpthreadglue, libkernel and libcdvd from ps2sdk to be able to build executables,
## because they are part of the standard libraries
ln -sf "$PS2SDK/ee/lib/libcglue.a" "$PS2DEV/ee/mips64r5900el-ps2-elf/lib/libcglue.a"
ln -sf "$PS2SDK/ee/lib/libpthreadglue.a" "$PS2DEV/ee/mips64r5900el-ps2-elf/lib/libpthreadglue.a"
ln -sf "$PS2SDK/ee/lib/libkernel.a"  "$PS2DEV/ee/mips64r5900el-ps2-elf/lib/libkernel.a"
ln -sf "$PS2SDK/ee/lib/libcdvd.a"  "$PS2DEV/ee/mips64r5900el-ps2-elf/lib/libcdvd.a"
