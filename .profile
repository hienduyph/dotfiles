export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# source secrets files
export PROFILE_EXTRA_DIRS=$HOME/.profile_src

if [[ -d $PROFILE_EXTRA_DIRS ]]; then
  for filename in $PROFILE_EXTRA_DIRS/*.sh; do
    source $filename
  done
fi

export GPG_TTY=${TTY}

source "$HOME/dotfiles/shell/alias.sh"
