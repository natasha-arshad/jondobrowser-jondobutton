#!/bin/bash


cat Dockerfile | while read line ; do
	case $line in
		ENV*TBB_BRANCH*)
			echo export TBB_BRANCH=${line##* }
			;;
		ENV*TBB_TAG*)
			echo export TBB_TAG=${line##* }
			;;
		RUN*apt-get*)
			echo eval ${line#* }
			;;
		RUN*mkdir*)
			echo eval ${line#* }
			;;
	esac
done

. ./tbb-build.sh
