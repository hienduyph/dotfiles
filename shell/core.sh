PREPEND=(
  "${NPM_CONFIG_PREFIX}/bin"
  "$HOME/.cargo/bin"
  "$HOME/.local/bin"
  "/usr/local/sbin"
  "$HOME/.bin"
  "$GOPATH/bin"
)
_CUS_PATH=(
  "$HOME/.local/google-cloud-sdk/bin"
  "$HOME/.deno/bin"
  "$HOME/.pub-cache/bin"
  "$HOME/.krew/bin"
  "${PYCLI_HOME}/bin"
  "/opt/Telegram/"
)

if [[ -f "${BREW_PREFIX}/bin/brew" ]]; then
  _CUS_PATH+=("${BREW_PREFIX}/bin" "${BREW_PREFIX}/sbin")
fi

if [[ -f "${PORT_PREFIX}/bin/port" ]]; then
  _CUS_PATH+=("${PORT_PREFIX}/bin" "${PORT_PREFIX}/sbin")
fi

_before_path=$(IFS=:; echo "${PREPEND[*]}")
_after_path=$(IFS=:; echo "${_CUS_PATH[*]}")
export PATH="${_before_path}:${PATH}:${_after_path}"

export XDG_CONFIG_HOME="$HOME/.config"
export FZF_DEFAULT_COMMAND="fd --type f --hidden --follow -E .git -E node_modules -E vendor -E .direnv -E .mypy_cache -E __pycache__ -E target -E .pytest_cache -E .next"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd -t d"

py_core_setup() {
  /usr/bin/env python -m pip install black pylint ipdb wheel pynvim pip --upgrade
}

# https://github.com/cheat/cheat
export CHEAT_USE_FZF=true

export MANROFFOPT="-c"
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

if [[ -d $PROFILE_EXTRA_DIRS ]]; then
  for filename in $PROFILE_EXTRA_DIRS/*.sh; do
    source ${filename}
  done
fi

