#!/bin/bash
# This script is run inside the Docker container to prime the build for Tor Browser

cd $(dirname $0)

# The presence of a Dockerfile in the same directory as this script indicates that
# we are not running in a container
if [ -f Dockerfile ] ; then

  echo "Not running in a Docker container."

  cat Dockerfile | while read line ; do
  	case $line in
  		RUN*apt-get*)
  			eval ${line#* }
  			;;
  		RUN*mkdir*)
  			eval ${line#* }
  			;;
  	esac
  done

  if [ -f docker.env ] ; then
    . docker.env
  fi
else
  echo "Running inside Docker container."
  export USE_LXC=1
fi

cd /var/src
mkdir -p tor-browser-build
cd tor-browser-build
git clone -b tor-browser-builder-4 https://git.torproject.org/builders/gitian-builder.git
git clone -b $TBB_BRANCH https://git.torproject.org/builders/tor-browser-bundle.git
cd tor-browser-bundle
git checkout $TBB_TAG
cd gitian

echo 'To build torbrowser, run "make TORSOCKS="'

test -f Dockerfile || exec /bin/bash -l
