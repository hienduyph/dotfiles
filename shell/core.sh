PREPEND=(
	"$HOME/.local/bin"
	"$HOME/.cargo/bin"
	"$GOPATH/bin"
	"${HOMEBREW_PREFIX}/bin"
	"${HOMEBREW_PREFIX}/sbin"
	"${NPM_CONFIG_PREFIX}/bin"
	"/usr/local/sbin"
	"$HOME/.bin"
	"$HOME/dotfiles/shell/bins"
)
_CUS_PATH=(
	"$HOME/.local/google-cloud-sdk/bin"
	"$HOME/.deno/bin"
	"$HOME/.pub-cache/bin"
	"$HOME/.krew/bin"
	"${PYCLI_HOME}/bin"
	$ANDROID_HOME/cmdline-tools/latest/bin
	$HOME/.dotnet/tools
)

_before_path=$(
	IFS=:
	echo "${PREPEND[*]}"
)
_after_path=$(
	IFS=:
	echo "${_CUS_PATH[*]}"
)
export PATH="${_before_path}:${PATH}:${_after_path}"

export XDG_CONFIG_HOME="$HOME/.config"
export FZF_DEFAULT_COMMAND="fd --type f --hidden --follow -E .git -E node_modules -E vendor -E .direnv -E .mypy_cache -E __pycache__ -E target -E .pytest_cache -E .next -E vendor"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd -t d"

py_core_setup() {
	/usr/bin/env python -m pip install wheel pip --upgrade
	/usr/bin/env python -m pip install black pylint ipdb pynvim --upgrade
}
export MANROFFOPT="-c"
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

if [[ -d $PROFILE_EXTRA_DIRS ]]; then
	for filename in $PROFILE_EXTRA_DIRS/*.sh; do
		source ${filename}
	done
fi
