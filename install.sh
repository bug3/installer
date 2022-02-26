#!/bin/bash

if [[ $# -eq 2 || $# -eq 3 ]]; then
    user=$1
    repo=$2
    [[ $# -eq 3 ]] && branch=$3 || branch="master"

	curl -JLO https://github.com/$user/$repo/archive/$branch.zip
    
    unzip $repo-$branch.zip
    cd $repo-$branch

    /bin/bash setup.sh
else
	echo "args error"
fi
