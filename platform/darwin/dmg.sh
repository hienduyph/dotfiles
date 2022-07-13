#!/bin/bash

set -e

URL=$1
NAME=$2
if [ -z ${URL} ]; then
  exit 1
fi

DST=/tmp/${NAME}.dmg
if [ ! -f ${DST} ]; then
  echo "Downloading ${URL} to ${DST}"
  curl -fsLo ${DST} ${URL}
else
  echo "Downloaded exists! Skip down"
fi

echo "Attach to volumes"
sudo hdiutil attach ${DST}


echo "Copy Content"
for a in $(ls /Volumes/${NAME} | grep '.app'); do
  echo "Copy ${a}"
  sudo rm -rf /Applications/${a}
  sudo cp /volumes/${NAME}/${a} /Applications
done

echo "Cleanup system"
sudo hdiutil detach /Volumes/${NAME}
