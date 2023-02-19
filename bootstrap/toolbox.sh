#!/usr/bin/env bash

sudo dnf copr enable atim/starship -y
sudo dnf install starship fzf zsh direnv nodejs neovim ripgrep bat fd-find jq git-lfs gnupg git-delta curl zoxide golang gcc g++ -y
sudo curl -fSL https://github.com/mikefarah/yq/releases/latest/download/yq_linux_amd64 -o /usr/bin/yq && sudo chmod +x /usr/bin/yq

python3.11 -m ensurepip
python3.11 -m pip install --upgrade pip
python3.11 -m pip install virtualenv

npm config set prefix $HOME/.local
npm i -g pyright
