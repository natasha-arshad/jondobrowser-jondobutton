#!/bin/bash
# This script is run inside the Docker container to prime the build for Tor Browser

test -z $TBB_BRANCH && export TBB_BRANCH=$1
test -z $TBB_TAG && export TBB_TAG=$2

cd /var/src
mkdir -p tor-browser-build
cd tor-browser-build
git clone -b tor-browser-builder-4 https://git.torproject.org/builders/gitian-builder.git
git clone -b $TBB_BRANCH https://git.torproject.org/builders/tor-browser-bundle.git
cd tor-browser-bundle
git checkout $TBB_TAG
cd gitian
exec /bin/bash -l
