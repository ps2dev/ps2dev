#!/bin/bash
# toolchain.sh by fjtrujy

build_script_error ()
{
	printf '\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n'
	printf '%s\n' "$1"
	printf '===========================\n'
	printf 'Please see the community links at %s for assistance\n' 'https://ps2dev.github.io/#community'
	printf '===========================\n'
	exit 1
}

## Enter the ps2dev directory.
cd "$(dirname "$0")" || { build_script_error "ERROR: Could not enter the ps2dev directory."; exit 1; }

## Create the build directory.
mkdir -p build || { build_script_error "ERROR: Could not create the build directory."; exit 1; }

## Enter the build directory.
cd build || { build_script_error "ERROR: Could not enter the build directory."; exit 1; }

## Fetch the depend scripts.
DEPEND_SCRIPTS=($(ls ../depends/*.sh | sort))

## Run all the depend scripts.
for SCRIPT in ${DEPEND_SCRIPTS[@]}; do "$SCRIPT" || { build_script_error "$SCRIPT: Failed."; exit 1; } done

## Check if repo is in a tag, to install this specfic PS2 Dev environment
if git describe --exact-match --tags $(git log -n1 --pretty='%h') >/dev/null 2>&1; then
  TAG=$(git describe --exact-match --tags $(git log -n1 --pretty='%h'))
  if [ "$TAG" = "latest" ]; then
    ## Ignore latest tag, as this tag is for service purposes only
    echo "Installing latest environment status"
    TAG="";
  else
    echo "Instaling specific version $TAG";
  fi
else
  echo "Installing latest environment status"
  TAG=""
fi

## Fetch the build scripts.
BUILD_SCRIPTS=($(ls ../scripts/*.sh | sort))

## If specific steps were requested...
if [ "$1" ]; then

  ## Run the requested build scripts.
  for STEP in "$@"; do "${BUILD_SCRIPTS[$STEP-1]}" "$TAG" > >(tee -a ../build/stdout.log) 2> >(tee -a ../build/stderr.log >&2) || { build_script_error "${BUILD_SCRIPTS[$STEP-1]}: Failed."; exit 1; } done

else

  ## Run the all build scripts.
  for SCRIPT in ${BUILD_SCRIPTS[@]}; do "$SCRIPT" "$TAG" > >(tee -a ../build/stdout.log) 2> >(tee -a ../build/stderr.log >&2) || { build_script_error "$SCRIPT: Failed."; exit 1; } done

fi
