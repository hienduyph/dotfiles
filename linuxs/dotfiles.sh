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

echo "Install zsh"

# install oh my zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/zsh-completions
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# add to plugins
dots=(
  .p10k.zsh
  .zshrc
  .profile
  .gitconfig
  .pylintrc
  .htoprc
  .ideavimrc
  .tmux.conf
)
for f in "${dots[@]}"; do
  f_backups $HOME/$f
  ln -s ~/dotfiles/$f $HOME/$f
done

dot_linux=(
  .alacritty.yml
)
for f in "${dots_linux[@]}"; do
  f_backups $HOME/$f
  ln -s ~/dotfiles/linuxs/$f $HOME/$f
done

# zsh config
mkdir -p ~/.oh-my-zsh/completions/
rustup completions zsh cargo > ~/.oh-my-zsh/completions/_cargo
