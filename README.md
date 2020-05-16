# ps2dev
Main PS2 Repo for build the whole environment in your local machine and/or docker image

![CI](https://github.com/ps2dev/ps2dev/workflows/CI/badge.svg)
![CI-Docker](https://github.com/ps2dev/ps2dev/workflows/CI-Docker/badge.svg)

This program will automatically build and install the whole a compiler and other tools used in the creation of homebrew software for the Sony PlayStation® 2 videogame system.

## What these scripts do

These scripts download (with wget) and install [binutils 2.14](http://www.gnu.org/software/binutils/ "binutils") (ee/iop), [gcc 3.2.3](https://gcc.gnu.org/ "gcc") (ee/iop), [newlib 1.10.0](https://sourceware.org/newlib/ "newlib") (ee), [ps2sdk](https://github.com/ps2dev/ps2sdk "ps2sdk"), and [ps2client](https://github.com/ps2dev/ps2client "ps2client").

## Requirements

1. Install gcc/clang, make, patch, git, texinfo and wget if you don't have those.

2. Add this to your login script (example: ~/.bash_profile)  
`export PS2DEV=/usr/local/ps2dev`  
`export PS2SDK=$PS2DEV/ps2sdk`  
`export PATH=$PATH:$PS2DEV/bin:$PS2DEV/ee/bin:$PS2DEV/iop/bin:$PS2DEV/dvp/bin:$PS2SDK/bin`  

3. Run build-all.sh  
`./build-all.sh`
