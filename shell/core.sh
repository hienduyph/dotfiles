PREPEND=(
  "$HOME/.local/bin"
  "/usr/local/sbin"
  "$HOME/.bin"
  "$GOPATH/bin"
)
_CUS_PATH=(
  "$HOME/.local/google-cloud-sdk/bin"
  "$NPM_PACKAGES/bin"
  "$HOME/.deno/bin"
  "$HOME/.cargo/bin"
  "$HOME/.pub-cache/bin"
)

if [[ -f "${LINUX_BREW}/bin/brew" ]]; then
  _CUS_PATH+=("${LINUX_BREW}/bin" "${LINUX_BREW}/sbin")
fi

_before_path=$(IFS=:; echo "${PREPEND[*]}")
_after_path=$(IFS=:; echo "${_CUS_PATH[*]}")
export PATH="${_before_path}:${PATH}:${_after_path}"

export XDG_CONFIG_HOME="$HOME/.config"
export FZF_DEFAULT_COMMAND="fd --type f --hidden --follow --exclude '.git|node_modules|vendor|.direnv|.mypy_cache|__pycache__|target|.pytest_cache|.next'"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd -t d"

py_core_setup() {
  /usr/bin/env python -m pip install black pylint ipdb wheel pynvim --upgrade
}

# https://github.com/cheat/cheat
export CHEAT_USE_FZF=true
