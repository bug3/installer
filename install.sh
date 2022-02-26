#!/bin/bash

exists () {
    command -v $1 > /dev/null 2>&1
}

if [[ $# -eq 2 || $# -eq 3 ]]; then
    user=$1
    repo=$2
    [[ $# -eq 3 ]] && branch=$3 || branch="master"
    archiveUrl="https://github.com/$user/$repo/archive/$branch.zip"
    
    if exists curl; then
        curl -JLO $archiveUrl
        unzip $repo-$branch.zip
    elif exists wget; then
        wget $archiveUrl
        unzip $branch.zip
    else
        echo "curl or wget command not found"
        exit 127
    fi

    cd $repo-$branch
    /bin/bash setup.sh
else
	echo "args error"
fi
