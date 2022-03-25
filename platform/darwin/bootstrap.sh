#!/bin/bash

set -e

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

eval "$(/opt/homebrew/bin/brew shellenv)"

brew bundle

rustup-init -y

$(brew --prefix fzf)/install --all

kubectl krew install ctx
kubectl krew install ns
