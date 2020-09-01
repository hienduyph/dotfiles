#!/bin/bash

mkdir ~/.backups

echo "Install Neovim Host"
python3 -m pip install virtualenv
python3 -m virtualenv ~/.venv/neovim
~/.venv/neovim/bin/pip install neovim pylint black flake8 mypy pydocstyle

echo "Install Neovim"
mv ~/.config/nvim/init.vim ~/.backups/ || true
mkdir ~/.config/nvim
ln -s ~/dotfiles/vim/init.vim ~/.config/nvim/init.vim

# for nvim
curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

nvim +PlugInstall +qall

echo "Install Tmux"
# install tmux dotfiles
mv ~/.tmux.conf  ~/.backups/ || true
ln -s ~/dotfiles/tmux.conf ~/.tmux.conf

echo "Install zsh"

# install oh my zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# add to plugins
mv ~/.p10k.zsh ~/.backups/ || true
mv ~/.zshrc ~/.backups || true
mv ~/.profile ~/.backups || true
ln ~/dotfiles/.p10k.zsh ~/.p10k.zsh
ln -s ~/dotfiles/.zshrc ~/.zshrc
ln -s ~/dotfiles/.profile ~/.profile
