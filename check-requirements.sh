#!/bin/bash

file="requirements.json"
getpmUrl="https://raw.githubusercontent.com/bug3/installer/master/getpm.sh"
reqUrl="https://raw.githubusercontent.com/bug3/installer/master/requirements.json"
pm=$(bash <(curl -sL $getpmUrl))

checkInstall() {
    sudo $pm install -y $(echo $1 | jq -r ['.linux[]','keys[1:][]'][])

    for p in $(echo $1 | jq -r keys[1:][]); do
        values="echo $1 | jq -r '.\"$p\"[]'"

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

checkInstall "$(cat $file)"
