# Bootstrap Linux Machine

## Steps
```bash
sudo bash ./basic.sh
sudo bash ./ui.sh
sudo bash ./dotfiles.sh
sudo bash ./apps.sh

# install linux brew
bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
brew bundle
```

**Themes**
```bash
# https://github.com/pixel-saver/pixel-saver
$ cd ~/Applications/pixel-saver/pixel-saver@deadalnix.me/themes
$ cp OSX-Arc-Darker ./default
```

```css
// ~/.local/share/themes/Mojave-dark
#panel .panel-button {
  -natural-hpadding: 2px;
  -minimum-hpadding: 2px;
  }
```
