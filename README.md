# ps2dev
Main PS2 Repo for building the whole `PS2 Development` environment in your local machine.

![CI](https://github.com/ps2dev/ps2dev/workflows/CI/badge.svg)
![CI-Docker](https://github.com/ps2dev/ps2dev/workflows/CI-Docker/badge.svg)

This program will automatically build and install the whole a compiler and other tools used in the creation of homebrew software for the Sony PlayStation® 2 videogame system.

## What these scripts do

These scripts download (`git clone`) and install: 
- [ps2toolchain](https://github.com/ps2dev/ps2toolchain "ps2toolchain") 
- [ps2sdk](https://github.com/ps2dev/ps2sdk "ps2sdk") 
- [gsKit](https://github.com/ps2dev/gsKit "gsKit") 
- [ps2-packer](https://github.com/ps2dev/ps2-packer "ps2-packer") 
- [ps2client](https://github.com/ps2dev/ps2client "ps2client")

## Requirements

1. Install gcc/clang, make, patch, git, texinfo wget, zlib and ucl if you don't have those.

2. Add this to your login script (example: ~/.bash_profile)  
```bash
export PS2DEV=/usr/local/ps2dev
export PS2SDK=$PS2DEV/ps2sdk
export GSKIT=$PS2DEV/gsKit
export PATH=$PATH:$PS2DEV/bin:$PS2DEV/ee/bin:$PS2DEV/iop/bin:$PS2DEV/dvp/bin:$PS2SDK/bin
```

3. Run build-all.sh  
```
./build-all.sh
```

## Docker generation
This repo also uses CI/CD to create a docker image called `ps2dev/ps2dev:latest`per change. This is quite useful if you're a developer that want to create/port an application to the PS2. So, you just can go there and compile your project using this docker image.

## Extra steps
If you want, you *JUST* can install the extra dependencies as `ps2client and ps2-packer`, to achieve this just execute

```
./build-extra.sh
```

### macOS
If you download the pre-built macOS binaries and get a security error such as _`"ps2client" cannot be opened because the developer cannot be verified.`_, you can remove the quarantine attribute by running:

```bash
xattr -dr com.apple.quarantine path/to/ps2toolchain
```

## Thanks
