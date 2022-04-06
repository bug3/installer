#!/bin/bash

file="requirements.json"
url="https://raw.githubusercontent.com/bug3/installer/master/getpm.sh"
pm=$(bash <(curl -sL $url))

sudo $pm install -y $(jq -r ['.linux[]','keys[1:][]'][] $file)
