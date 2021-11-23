#!/usr/bin/env bash
# Reference: https://github.com/nagygergo/jetbrains-toolbox-install/blob/master/jetbrains-toolbox.sh

# Note that we grep for linux here, if you are using this on mac/windows please see json output
TOOLBOX_URL=$(curl --silent 'https://data.services.jetbrains.com//products/releases?code=TBA&latest=true&type=release' \
    -H 'Origin: https://www.jetbrains.com' \
    -H 'Accept-Encoding: gzip, deflate, br' \
    -H 'Accept-Language: en-US,en;q=0.8' \
    -H 'Accept: application/json, text/javascript, */*; q=0.01' \
    -H 'Referer: https://www.jetbrains.com/toolbox/download/' \
    -H 'Connection: keep-alive' \
    -H 'DNT: 1' \
    --compressed \
  | grep -Po '"linux":.*?[^\\]",' \
  | awk -F ':' '{print $3,":"$4}'| sed 's/[", ]//g')

install -d ${HOME}/bin
curl -sL ${TOOLBOX_URL} | tar xvz --directory=${HOME}/bin --strip-components=1

# intial setup
$(jetbrains-toolbox)
