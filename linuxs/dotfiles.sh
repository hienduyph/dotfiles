#!/bin/bash

mkdir ~/.backups

f_backups() {
  mv $1 ~/.backups/ || true
}

echo "Install Neovim Host"
python3 -m pip install virtualenv
python3 -m virtualenv ~/.venv/neovim
~/.venv/neovim/bin/pip install neovim pylint black flake8 mypy pydocstyle

echo "Install Neovim"
f_backups ~/.config/nvim/init.vim
f_backups ~/.config/nvim/coc-settings.json

mkdir -p ~/.config/nvim
ln -s ~/dotfiles/vim/init.vim ~/.config/nvim/init.vim
ln -s ~/dotfiles/vim/coc-settings.json ~/.config/nvim/

# for nvim
curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

nvim +PlugInstall +qall

echo "Install Tmux"
# install tmux dotfiles
f_backups ~/.tmux.conf
ln -s ~/dotfiles/tmux.conf ~/.tmux.conf

echo "Install zsh"

# install oh my zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# add to plugins
f_backups ~/.p10k.zsh
f_backups ~/.zshrc
f_backups ~/.profile

ln ~/dotfiles/.p10k.zsh ~/.p10k.zsh
ln -s ~/dotfiles/.zshrc ~/.zshrc
ln -s ~/dotfiles/.profile ~/.profile
