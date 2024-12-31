#!/bin/bash

PS2TOOLCHAIN_REPO_URL="https://github.com/ps2dev/ps2toolchain.git"
PS2TOOLCHAIN_DEFAULT_REPO_REF="master"
PS2SDK_REPO_URL="https://github.com/ps2dev/ps2sdk.git"
PS2SDK_DEFAULT_REPO_REF="master"
PS2SDK_PORTS_REPO_URL="https://github.com/ps2dev/ps2sdk-ports.git"
PS2SDK_PORTS_DEFAULT_REPO_REF="master"
PS2_PACKER_REPO_URL="https://github.com/ps2dev/ps2-packer.git"
PS2_PACKER_DEFAULT_REPO_REF="master"
PS2CLIENT_REPO_URL="https://github.com/ps2dev/ps2client.git"
PS2CLIENT_DEFAULT_REPO_REF="master"

if test -f "$PS2DEV_CONFIG_OVERRIDE"; then
  source "$PS2DEV_CONFIG_OVERRIDE"
fi
