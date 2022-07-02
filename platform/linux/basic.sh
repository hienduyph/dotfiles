#/bin/bash

set -ex

_py() {
  python3.9 -m ensurepip --user
  python3.9 -m pip install virtualenv
  python3.8 -m ensurepip --user
  python3.8 -m pip install virtualenv
}

_jetbrains() {
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

  curl -fsSL ${TOOLBOX_URL} | tar xz --directory=${HOME}/.local/bin --strip-components=1
}

_sccache() {
  if ! command -v sccache &> /dev/null
  then
    VERSION=0.3.0
    curl -fsSL https://github.com/mozilla/sccache/releases/download/v${VERSION}/sccache-v${VERSION}-x86_64-unknown-linux-musl.tar.gz | sudo tar zx -C /usr/local/bin --strip-components=1
    sudo chmod +x /usr/local/bin/sccache
  fi
}

_rust() {
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
}

main() {
  _py
  _jetbrains
  _rust
}

if [[ $_ == $0 ]]; then
  main
else
  echo "Sourced"
fi

