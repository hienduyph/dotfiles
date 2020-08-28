# Bootstrap Linux Machine

```bash
# for Nvim
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
```

## Install:
- tmux
- neovim

## ZSH Plugins
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

Themes:
```bash
# https://github.com/pixel-saver/pixel-saver
$ cd ~/Applications/pixel-saver/pixel-saver@deadalnix.me/themes
$ cp OSX-Arc-Darker ./default
```
