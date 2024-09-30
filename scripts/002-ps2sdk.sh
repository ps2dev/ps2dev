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
  git -C "$REPO_FOLDER" remote set-url origin "$REPO_URL"
  git -C "$REPO_FOLDER" fetch origin "$REPO_REF" --depth=1
  git -C "$REPO_FOLDER" checkout -f FETCH_HEAD
fi

cd "$REPO_FOLDER"

# make sure ps2sdk's makefile does not use it
unset PS2SDKSRC

## Determine the maximum number of processes that Make can work with.
PROC_NR=$(getconf _NPROCESSORS_ONLN)

## Build and install.
make -j "$PROC_NR" clean
make -j "$PROC_NR" || make -j "$PROC_NR" clean
## If the multi-job build failed, then build it with a single job.
## Otherwise, it won't build anything since it is already built.
make -j 1
make -j "$PROC_NR" install
make -j "$PROC_NR" clean

## gcc needs to include libcglue, libpthreadglue, libkernel and libcdvd from ps2sdk to be able to build executables,
## because they are part of the standard libraries
# Create symbolink links using relative paths
(cd $PS2DEV/ee/mips64r5900el-ps2-elf/lib && ln -sf ../../../ps2sdk/ee/lib/libcglue.a libcglue.a && cd -)
(cd $PS2DEV/ee/mips64r5900el-ps2-elf/lib && ln -sf ../../../ps2sdk/ee/lib/libpthreadglue.a libpthreadglue.a && cd -)
(cd $PS2DEV/ee/mips64r5900el-ps2-elf/lib && ln -sf ../../../ps2sdk/ee/lib/libprofglue.a libprofglue.a && cd -)
(cd $PS2DEV/ee/mips64r5900el-ps2-elf/lib && ln -sf ../../../ps2sdk/ee/lib/libkernel.a libkernel.a && cd -)
(cd $PS2DEV/ee/mips64r5900el-ps2-elf/lib && ln -sf ../../../ps2sdk/ee/lib/libcdvd.a libcdvd.a && cd -)
