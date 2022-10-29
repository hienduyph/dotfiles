#!/usr/bin/env bash

set -ex

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

eval "$(/opt/homebrew/bin/brew shellenv)"

brew bundle

$(brew --prefix)/opt/fzf/install --no-update-rc --key-bindings --completion

curl -s "https://get.sdkman.io" | bash
sdk install java 11.0.16.1-tem
