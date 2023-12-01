#!/bin/bash

# need testing for repo
echo "https://dl-cdn.alpinelinux.org/alpine/edge/testing/" >> /etc/apk/repositories && apk update
apk add repo gpg-agent openssh-client

REPO_MANIFEST="$PS2DEV"/manifests
mkdir -p "$REPO_MANIFEST"

## Generate 'google repo' pinned manifest
cd "$PS2_WORKSPACE"
repo init -q -u https://github.com/bignaux/ps2pkgs.git
repo init -m "$PS2_WORKSPACE"/ps2dev/ps2dev.xml
repo manifest -r -o "$REPO_MANIFEST"/ps2dev.xml
