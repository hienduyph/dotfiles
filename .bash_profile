source $HOME/dotfiles/shell/vars.sh
source $HOME/dotfiles/shell/alias.sh
source $HOME/dotfiles/shell/core.sh
source $HOME/dotfiles/shell/func.sh
source $HOME/.profile

source $HOME/dotfiles/shell/alias/git.sh
source $HOME/dotfiles/shell/bash/alias.sh

# load default shell
eval "$(starship init bash)"
eval "$(zoxide init bash --cmd z)"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
[ -f /usr/share/fzf/shell/key-bindings.bash ] && source /usr/share/fzf/shell/key-bindings.bash

set -o vi


# fzf tab
source ${BASHMAN_DIR}/lincheney/fzf-tab-completion/bash/fzf-bash-completion.sh
bind -x '"\t": fzf_bash_completion'
_fzf_bash_completion_loading_msg() { echo "\$ ${READLINE_LINE}" | tail -n1; }


if [[ -d ~/.bash_completion.d/ ]] && \
   ! find ~/.bash_completion.d/. ! -name . -prune -exec false {} +
then
  for f in ~/.bash_completion.d/*; do
    source "$f"
  done
fi

export HISTFILE=$HOME/.bash_history

export GPG_TTY=$(tty)
