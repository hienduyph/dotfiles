#export HOMEBREW_CASK_OPTS="--appdir=~/Applications"

if [[ -f ${HOMEBREW_PREFIX}/bin/brew ]]; then
  export FPATH="${HOMEBREW_PREFIX}/share/zsh/site-functions:${FPATH}"
fi

u() {
  brew update && brew upgrade && brew upgrade --cask  --greedy && brew cleanup
  # nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
  nvim --headless "+Lazy! update" +qa
  nvim --headless -c 'TSUpdateSync' -c 'quitall'
}

addToPATH $HOMEBREW_PREFIX/opt/libpq/bin
addToPATH $HOMEBREW_PREFIX/opt/mysql-client/bin
addToPATH "$HOME/Library/Application Support/Coursier/bin"

libs=(
  mysql-client
  libpq
  zlib
  openssl
)
for L in ${libs[@]}; do
  C_LDFLAGS="-L$HOMEBREW_PREFIX/opt/${L}/lib ${C_LDFLAGS}"
  C_CPPFLAGS="-I$HOMEBREW_PREFIX/opt/${L}/include ${C_CPPFLAGS}"
  C_PKG_CONFIG_PATH="$HOMEBREW_PREFIX/opt/${L}/lib/pkgconfig:${C_PKG_CONFIG_PATH}"
  C_LD="$HOMEBREW_PREFIX/opt/${L}/lib:${C_LD}"
done
export LDFLAGS="${C_LDFLAGS} ${LDFLAGS} "
export CPPFLAGS="-I$HOMEBREW_PREFIX/include -L$HOMEBREW_PREFIX/lib ${C_CPPFLAGS}${CPPFLAGS}"
export PKG_CONFIG_PATH="${PKG_CONFIG_PATH}:${C_PKG_CONFIG_PATH}"

export LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:$HOMEBREW_PREFIX/lib:${C_LD}"
export DYLD_LIBRARY_PATH="${DYLD_LIBRARY_PATH}:$HOMEBREW_PREFIX/opt/zlib/lib"
export LIBRARY_PATH=${LD_LIBRARY_PATH}:${LIBRARY_PATH}

zvm_after_init_commands+=(
  '[ -f $HOMEBREW_PREFIX/opt/fzf/shell/key-bindings.zsh ] && source $HOMEBREW_PREFIX/opt/fzf/shell/key-bindings.zsh'
  'bindkey '^n' autosuggest-accept'
)

qsh() {
  tmux new-session -A -s $(hostname -s)
}
