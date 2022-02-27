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
    rawUrl="https://raw.githubusercontent.com/$user/$repo/$branch/setup.sh"
    reposUrl="https://api.github.com/repos/$user/$repo"

    if exists curl; then
        curlResponse=$(wget $reposUrl -SO /dev/null 2>&1 | awk '/^  HTTP/{printf $2}')

        if checkRepo $curlResponse; then
            /bin/bash <(wget -qO- $rawUrl) -r
        fi
    elif exists wget; then
        wgetResponse=$(curl -so /dev/null -w '%{http_code}' $reposUrl)

        if checkRepo $wgetResponse; then
            /bin/bash <(curl -fsSL $rawUrl) -r
        fi
    else
        exitWithError "curl or wget command not found"
    fi
else
	exitWithError "Wrong number of args"
fi
