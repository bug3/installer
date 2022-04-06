#!/bin/bash

exists() {
    command -v $1 > /dev/null 2>&1
}

exitWithError() {
    echo $1
    exit 1
}

checkRepo() {
    if [[ $1 == 200 ]]; then
        return 0
    else
        exitWithError "$user/$repo repository not found"
    fi
}

removeParam=$([[ ${@: -1} == "-r" || ${@: -1} == "--remove" ]] && echo true || echo false)

if [[ ($# -eq 2 || $# -eq 3) || ($# -eq 4 && $isThereRemove == true) ]]; then
    user=$1
    repo=$2
    [[ $# -eq 3 && $removeParam == false ]] && branch=$3 || branch="master"
    archiveUrl="https://github.com/$user/$repo/archive/$branch.zip"
    reposUrl="https://api.github.com/repos/$user/$repo"
    crScriptUrl="https://raw.githubusercontent.com/bug3/installer/master/check-requirements.sh"
    dirname=$repo-$branch

    if exists curl; then
        curlResponse=$(curl -so /dev/null -w '%{http_code}' $reposUrl)

        if checkRepo $curlResponse; then
            curl -JLO $archiveUrl
        fi
    elif exists wget; then
        wgetResponse=$(wget $reposUrl -SO /dev/null 2>&1 | awk '/^  HTTP/{printf $2}')

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

    if [[ $removeParam == false ]]; then
        if /bin/bash setup.sh; then
            echo "$repo installed successfully"
        else
            cd ..
            rm -r $repo-$branch
            exitWithError "Installation encountered an error"
        fi
    else
        if /bin/bash setup.sh -r; then
            echo "$repo uninstalled successfully"
        else
            cd ..
            rm -r $repo-$branch
            exitWithError "Uninstallation encountered an error"
        fi
    fi

    cd ..
    rm -r $repo-$branch
else
    exitWithError "Wrong number of args"
fi
