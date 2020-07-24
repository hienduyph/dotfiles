# The Q dotfiles

![screenshot](./screenshot.png)

## TLDL

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/hienduyph/dotfiles/master/install.sh)"
```

## Detail

Fonts
- https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/IBMPlexMono

### Vim Stack
- [Vim Plug](https://github.com/junegunn/vim-plug)
- Language:
    - [x] https://github.com/neoclide/coc-rls
    - [x] https://github.com/josa42/coc-go
    - [x] JavaScript, TypeScript, HTML, SCSS, CSS
    - [x] Ruby
    - [x] https://github.com/neoclide/coc-python

### ViFM
```bash
mkdir -p ~/.vifm/colors
curl -Lo ~/.vifm/colors/gruvbox.vifm https://raw.githubusercontent.com/vifm/vifm-colors/master/gruvbox.vifm
# backup old files
mv ~/.vifm/vifmrc ~/.vifm/vifmrc.bak
ln -s $(pwd)/.vifmrc ~/.vifm/vifmrc
```


## Q Utils
*Install [Rust](https://www.rust-lang.org/tools/install)*

```
$ curl https://sh.rustup.rs -sSf | sh
$ cargo build --release
$ cp ./target/release/yaml2json ~/.local/bin
```

# License
[MIT License](LICENSE)

