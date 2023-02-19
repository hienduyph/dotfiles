libs=(
  mysql-client
  libpq
)
for L in ${libs[@]}; do
  C_LDFLAGS="-L$HOMEBREW_PREFIX/opt/${L}/lib ${C_LDFLAGS}"
  C_CPPFLAGS="-I$HOMEBREW_PREFIX/opt/${L}/include ${C_CPPFLAGS}"
  C_PKG_CONFIG_PATH="$HOMEBREW_PREFIX/opt/${L}/lib/pkgconfig:${C_PKG_CONFIG_PATH}"
  C_LD="$HOMEBREW_PREFIX/opt/${L}/lib:${C_LD}"
done
export LDFLAGS="${C_LDFLAGS} ${LDFLAGS} "
export CPPFLAGS="${C_CPPFLAGS}${CPPFLAGS}"
export PKG_CONFIG_PATH="${PKG_CONFIG_PATH}:${C_PKG_CONFIG_PATH}"

export LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:$HOMEBREW_PREFIX/lib:${C_LD}"
export LIBRARY_PATH=${LD_LIBRARY_PATH}:${LIBRARY_PATH}
[ -f $HOMEBREW_PREFIX/opt/fzf/shell/key-bindings.zsh ] && source $HOMEBREW_PREFIX/opt/fzf/shell/key-bindings.zsh
