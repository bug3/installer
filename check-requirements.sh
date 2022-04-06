#!/bin/bash

file="requirements.json"
url="https://raw.githubusercontent.com/bug3/installer/master/getpm.sh"
pm=$(bash <(curl -sL $url))
