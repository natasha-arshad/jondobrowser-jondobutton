#!/bin/bash


cat Dockerfile | while read line ; do
	case $line in
		ENV*TBB_BRANCH*)
			export TBB_BRANCH=${line##* }
			;;
		ENV*TBB_TAG*)
			export TBB_TAG=${line##* }
			;;
		RUN*apt-get*)
			eval ${line#* }
			;;
		RUN*mkdir*)
			eval ${line#* }
			;;
	esac
done

. ./tbb-build.sh
