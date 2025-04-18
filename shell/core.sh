_PREPEND=(
	"$HOME/.local/bin"
	"$HOME/.cargo/bin"
	"$GOPATH/bin"
	"${HOMEBREW_PREFIX}/bin"
	"${HOMEBREW_PREFIX}/sbin"
	"${NPM_CONFIG_PREFIX}/bin"
	"/usr/local/sbin"
)
_CUS_PATH=(
	"$HOME/.local/google-cloud-sdk/bin"
)

_before_path=$(
	IFS=:
	echo "${_PREPEND[*]}"
)
_after_path=$(
	IFS=:
	echo "${_CUS_PATH[*]}"
)
export PATH="${_before_path}:${PATH}:${_after_path}"

py_core_setup() {
	/usr/bin/env python -m pip install wheel pip --upgrade
	/usr/bin/env python -m pip install black pylint ipdb pynvim --upgrade
}
export MANROFFOPT="-c"


# https://github.com/alacritty/alacritty/issues/5999#issuecomment-2053664635
theme() {
  ln -sf $HOME/.config/alacritty/themes/$1.toml $HOME/.config/alacritty/theme.toml
}
alias dark="theme github_dark"
alias light="theme github_light"
