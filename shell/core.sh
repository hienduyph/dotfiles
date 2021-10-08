PREPEND=(
  "$HOME/.local/bin"
  "/usr/local/sbin"
  "$HOME/.bin"
  "$GOPATH/bin"
)

for p in ${PREPEND[@]}; do
  prependToPATH $p
done

_CUS_PATH=(
  "$HOME/.local/google-cloud-sdk/bin"
  "$NPM_PACKAGES/bin"
  "$HOME/.deno/bin"
  "$HOME/.cargo/bin"
  "$HOME/.pub-cache/bin"
)
for p in ${_CUS_PATH[@]}; do
  addToPATH $p
done

export XDG_CONFIG_HOME="$HOME/.config"

if [[ -f "${LINUX_BREW}/bin/brew" ]]; then
  addToPATH "${LINUX_BREW}/bin"
  addToPATH "${LINUX_BREW}/sbin"
fi

export FZF_DEFAULT_COMMAND='rg --files --hidden --no-ignore --follow -g "!{.git,node_modules,vendor,.direnv,.mypy_cache,__pycache__,target,.pytest_cache,.next}" 2> /dev/null'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="cd ~/; bfs -type d -nohidden | sed s/^\./~/"


py_core_setup() {
  /usr/bin/env python -m pip install black pylint ipdb wheel pynvim --upgrade
}

# https://github.com/cheat/cheat
export CHEAT_USE_FZF=true
