#!/bin/bash
sudo apt-get update

# install docker
sudo apt-get install -y docker.io

# add root to docker group
sudo usermod -aG docker root

# add current user to docker group (except if we are root)
test $(whoami) = root || sudo usermod -aG docker $(whoami)

# install required packages
apt-get install -y make libyaml-libyaml-perl libtemplate-perl libio-handle-util-perl libio-all-perl libio-captureoutput-perl libfile-slurp-perl libstring-shellquote-perl libsort-versions-perl libdigest-sha-perl libdata-uuid-perl libdata-dump-perl libfile-copy-recursive-perl git

mkdir -p /var/src
cd /var/src

# chromium dependencies
git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git
export PATH=$PATH:/var/src/depot_tools
fetch chromium

# install additional dependencies
cd src/build
./install-build-deps.sh --no-prompt

cd ../../

echo "Run 'make <channel>' to start build, where <channel> is:"
echo "    release"
echo "    nightly"
echo "    alpha"
echo "    alpha-nightly"
echo
echo To switch off rbm debugging, run 'export RBM_NO_DEBUG=1'

exec /bin/bash -l
