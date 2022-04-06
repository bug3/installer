#!/bin/bash

file="requirements.json"
url="https://raw.githubusercontent.com/bug3/installer/master/getpm.sh"
pm=$(bash <(curl -sL $url))

sudo $pm install -y $(jq -r ['.linux[]','keys[1:][]'][] $file)

for p in $(jq -r keys[1:][] $file); do
    values="jq -r '.\"$p\"[]' requirements.json"

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
