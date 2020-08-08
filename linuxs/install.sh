#!/bin/bash

echo "Install Neovim Host"
python3 -m pip install virtualenv
python3 -m virtualenv ~/.venv/neovim
~/.venv/neovim/bin/pip install neovim pylint black flake8 mypy pydocstyle

echo 'Backup Vim & Neovim'
mv .vimrc .vimrc.bak || true
mv ~/.config/nvim/init.vim ~/.config/nvim/init.vim.bak || true

echo "Install Neovim"
mv ~/.vimrc ~/.vimrc.bak || true
mv ~/.config/nvim/init.vim ~/.config/nvim/init.vim.bak || true
ln -s ~/dotfiles/vim/init.vim ~/.vimrc
ln -s ~/dotfiles/vim/init.vim ~/.config/nvim/init.vim

# install vim plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

nvim +PlugInstall +qall

echo "Install Tmux"
# install tmux dotfiles
mv ~/.tmux.conf  ~/.tmux.conf.bak || true
ln -s ~/dotfiles/tmux.conf ~/.tmux.conf

echo "Install zsh"
# install oh my zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k

# add to plugins
sed -i 's/plugins=(/&zsh-autosuggestions /' ~/.zshrc
mv ~/.p10k.zsh ~/.p10k.zsh.bak || true
ln ~/dotfiles/.p10k.zsh ~/.p10k.zsh

echo "Set alacritty"
mv ~/.alacritty.yml ~/.alacritty.yml.bak || true
ln -s $HOME/dotfiles/alacritty.yml ~/.alacritty.yml
