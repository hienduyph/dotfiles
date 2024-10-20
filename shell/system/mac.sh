export HOMEBREW_CASK_OPTS="--appdir=~/Applications"

if [[ -f ${HOMEBREW_PREFIX}/bin/brew ]]; then
  export FPATH="${HOMEBREW_PREFIX}/share/zsh/site-functions:${FPATH}"
fi

u() {
  brew update && brew upgrade && brew upgrade --cask  --greedy && brew cleanup
  # nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
  nvim --headless "+Lazy! update" +qa
  nvim --headless -c 'TSUpdateSync' -c 'quitall'
}

xcode_dl() {
  # https://developer.apple.com/download/applications/
  local VERSION=$1
  VERSION=${VERSION:-14.1}
  local URL="https://download.developer.apple.com/Developer_Tools/Xcode_${VERSION}/Xcode_${VERSION}.xip"

  local TOKEN=$APPLE_AUTH_TOKEN

  aria2c --header "Host: adcdownload.apple.com" \
    --header "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8"\
    --header "Upgrade-Insecure-Requests: 1"\
    --header "Cookie: ADCDownloadAuth=$TOKEN"\
    --header "User-Agent: Mozilla/5.0 (iPhone; CPU iPhone OS 10_1 like Mac OS X) AppleWebKit/602.2.14 (KHTML, like Gecko) Version/10.0 Mobile/14B72 Safari/602.1" \
    --header "Accept-Language: en-us" -x 16 -s 16 \
    ${URL} \
    -d ~/Downloads

  xip -x ~/Downloads/Xcode_${VERSION}
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
