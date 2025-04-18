export PROFILE_EXTRA_DIRS=$HOME/.profile_src
if [[ -d $PROFILE_EXTRA_DIRS ]]; then
	for filename in $PROFILE_EXTRA_DIRS/*.sh; do
		source ${filename}
	done
fi
source $HOME/dotfiles/shell/vars.sh
source $HOME/dotfiles/shell/alias.sh
source $HOME/dotfiles/shell/core.sh
source $HOME/dotfiles/shell/func.sh
