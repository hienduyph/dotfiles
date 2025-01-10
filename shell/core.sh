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


if [[ -d $PROFILE_EXTRA_DIRS ]]; then
	for filename in $PROFILE_EXTRA_DIRS/*.sh; do
		source ${filename}
	done
fi
