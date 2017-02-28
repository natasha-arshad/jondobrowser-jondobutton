#!/bin/bash
cd ~/tbb-builder
sudo docker build --tag jondos-test/tbb-builder .
sudo docker start -ai tbb-builder || sudo docker run --env-file docker.env --privileged -ti "$@" --name tbb-builder -v /mnt:/var/src jondos-test/tbb-builder
