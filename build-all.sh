#!/bin/bash
# toolchain.sh by fjtrujy

## Enter the ps2dev directory.
cd "$(dirname "$0")" || { echo "ERROR: Could not enter the ps2dev directory."; exit 1; }

## Create the build directory.
mkdir -p build || { echo "ERROR: Could not create the build directory."; exit 1; }

## Enter the build directory.
cd build || { echo "ERROR: Could not enter the build directory."; exit 1; }

## Fetch the depend scripts.
DEPEND_SCRIPTS=($(ls ../depends/*.sh | sort))

## Run all the depend scripts.
for SCRIPT in ${DEPEND_SCRIPTS[@]}; do "$SCRIPT" || { echo "$SCRIPT: Failed."; exit 1; } done

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
  for STEP in "$@"; do "${BUILD_SCRIPTS[$STEP-1]}" "$TAG" || { echo "${BUILD_SCRIPTS[$STEP-1]}: Failed."; exit 1; } done

else

  ## Run the all build scripts.
  for SCRIPT in ${BUILD_SCRIPTS[@]}; do "$SCRIPT" "$TAG" || { echo "$SCRIPT: Failed."; exit 1; } done

fi

## Generate 'google repo' pinned manifest
cp ../ps2dev.xml "$PS2DEV"/ps2dev.xml
for REPO in $(find -type d -maxdepth 1 -not -name ".repo"); do
  if [ "$REPO" = "." ]; then
    NAME="ps2dev"
  else
    NAME=$(basename "$REPO")
  fi
  xml ed --inplace -a "/manifest/project[@name='$NAME.git']" -t attr -n "revision" -v $(git -C "$REPO" rev-parse --revs-only HEAD) "$PS2DEV"/ps2dev.xml
done
