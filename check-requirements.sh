#!/bin/bash

file="requirements.json"
getpmUrl="https://raw.githubusercontent.com/bug3/installer/master/getpm.sh"
reqUrl="https://raw.githubusercontent.com/bug3/installer/master/requirements.json"
pm=$(bash <(curl -sL $getpmUrl))

checkInstall() {
    req=$1

    sudo $pm install -y $(echo $req | jq -r ['.core[]','keys[1:][]'][])

    for p in $(echo $req | jq -r keys[1:][]); do
        values="echo \$req | jq -r '.\"$p\"[]'"

        case $p in
            npm)
                sudo npm install -g $(eval $values)
                ;;
            snapd)
                sudo snap install $(eval $values)
                ;;
            python3-pip)
                pip install $(eval $values)
                ;;
            *)
                $p install $(eval $values)
                ;;
        esac

        echo ""
    done
}

checkInstall "$(cat <(curl -sL $reqUrl))"
checkInstall "$(cat $file)"
