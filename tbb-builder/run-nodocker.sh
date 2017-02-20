#!/bin/bash

export TBB_BRANCH
export TBB_TAG

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

TBB_BRANCH=$(grep TBB_BRANCH Dockerfile | cut -f 3 -d " ")
TBB_TAG=$(grep TBB_TAG Dockerfile | cut -f 3 -d " ")

. ./tbb-build.sh # $TBB_BRANCH $TBB_TAG

