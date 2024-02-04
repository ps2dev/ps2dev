#!/bin/bash

PS2TOOLCHAIN_REPO_URL="https://github.com/ps2dev/ps2toolchain.git"
PS2TOOLCHAIN_DEFAULT_REPO_REF="origin/master"
PS2SDK_REPO_URL="https://github.com/ps2dev/ps2sdk.git"
PS2SDK_DEFAULT_REPO_REF="origin/master"
PS2SDK_PORTS_REPO_URL="https://github.com/ps2dev/ps2sdk-ports.git"
PS2SDK_PORTS_DEFAULT_REPO_REF="origin/master"
PS2_PACKER_REPO_URL="https://github.com/ps2dev/ps2-packer.git"
PS2_PACKER_DEFAULT_REPO_REF="origin/master"
PS2CLIENT_REPO_URL="https://github.com/ps2dev/ps2client.git"
PS2CLIENT_DEFAULT_REPO_REF="origin/master"
PS2TOOLCHAIN_EE_GCC_REPO_URL="https://github.com/ps2dev/gcc.git"
PS2TOOLCHAIN_EE_GCC_DEFAULT_REPO_REF="ee-v11.3.0"
PS2TOOLCHAIN_EE_NEWLIB_REPO_URL="https://github.com/ps2dev/newlib.git"
PS2TOOLCHAIN_EE_NEWLIB_DEFAULT_REPO_REF="ee-v4.3.0"
PS2TOOLCHAIN_EE_PTHREAD_EMBEDDED_REPO_URL="https://github.com/ps2dev/pthread-embedded.git"
PS2TOOLCHAIN_EE_PTHREAD_EMBEDDED_DEFAULT_REPO_REF="platform_agnostic"

if test -f "$PS2DEV_CONFIG_OVERRIDE"; then
  source "$PS2DEV_CONFIG_OVERRIDE"
fi
