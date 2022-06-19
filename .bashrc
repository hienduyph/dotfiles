export HISTFILE=$HOME/.bash_history
source $HOME/dotfiles/shell/vars.sh
source $HOME/dotfiles/shell/alias.sh
source $HOME/dotfiles/shell/core.sh
source $HOME/dotfiles/shell/func.sh
source $HOME/.profile

source $HOME/dotfiles/shell/alias/git.sh

# load default shell
eval "$(starship init bash)"
eval "$(zoxide init bash --cmd z)"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
[ -f /usr/share/fzf/shell/key-bindings.bash ] && source /usr/share/fzf/shell/key-bindings.bash

set -o vi


# fzf tab
source ${BASHMAN_DIR}/lincheney/fzf-tab-completion/bash/fzf-bash-completion.sh
bind -x '"\t": fzf_bash_completion'
