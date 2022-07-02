# The Q dotfiles

![screenshot](./images/screenshot.png)
![shell](./images/shell.png)

## Steps
```bash
# install path must be at `$HOME/dotfiles`
git clone https://github.com/hienduyph/dotfiles ~/
cd ~/dotfiles
```

### 1. Install platform base first
**In each platform**
```bash
sudo bash basic.sh

```

### 2. Bootstrap dotfiles
```bash
bash ./install.sh
```

### Gnome Terminal
```bash
dconf dump /org/gnome/terminal/legacy/profiles:/ > gnome-terminal-profiles.dconf
dconf load /org/gnome/terminal/legacy/profiles:/ < gnome-terminal-profiles.dconf
```

# License
[MIT License](LICENSE)
