#!/bin/bash

exists () {
    command -v $1 > /dev/null 2>&1
}

checkRepo () {
    if [[ $1 == 200 ]]; then
        return 0
    else
        echo "$user/$repo repository not found"
        exit 1
    fi
}

if [[ $# -eq 2 || $# -eq 3 ]]; then
    user=$1
    repo=$2
    [[ $# -eq 3 ]] && branch=$3 || branch="master"
    archiveUrl="https://github.com/$user/$repo/archive/$branch.zip"
    reposUrl="https://api.github.com/repos/$user/$repo"

    if exists curl; then
        curlResponse=$(wget $reposUrl -SO /dev/null 2>&1 | awk '/^  HTTP/{printf $2}')

        if checkRepo $curlResponse; then
            curl -JLO $archiveUrl
            unzip $repo-$branch.zip
        fi
    elif exists wget; then
        wgetResponse=$(curl -so /dev/null -w '%{http_code}' $reposUrl)

        if checkRepo $wgetResponse; then
            wget $archiveUrl
            unzip $branch.zip
        fi
    else
        echo "curl or wget command not found"
        exit 127
    fi

    cd $repo-$branch
    /bin/bash setup.sh
else
	echo "args error"
fi
