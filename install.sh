#!/bin/bash

exists () {
    command -v $1 > /dev/null 2>&1
}

exitWithError () {
    echo $1
    exit 1
}

checkRepo () {
    if [[ $1 == 200 ]]; then
        return 0
    else
        exitWithError "$user/$repo repository not found"
    fi
}

if [[ $# -eq 2 || $# -eq 3 ]]; then
    user=$1
    repo=$2
    [[ $# -eq 3 ]] && branch=$3 || branch="master"
    archiveUrl="https://github.com/$user/$repo/archive/$branch.zip"
    reposUrl="https://api.github.com/repos/$user/$repo"
    dirname=$repo-$branch

    if exists curl; then
        curlResponse=$(wget $reposUrl -SO /dev/null 2>&1 | awk '/^  HTTP/{printf $2}')

        if checkRepo $curlResponse; then
            curl -JLO $archiveUrl
        fi
    elif exists wget; then
        wgetResponse=$(curl -so /dev/null -w '%{http_code}' $reposUrl)

        if checkRepo $wgetResponse; then
            wget $archiveUrl
            dirname=$branch
        fi
    else
        exitWithError "curl or wget command not found"
    fi

    unzip $dirname.zip
    rm $dirname.zip
    cd $repo-$branch

    /bin/bash setup.sh
else
	exitWithError "Wrong number of args"
fi
