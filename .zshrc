if [[ $ZSH_PROFILNG == "yes" ]]; then
  zmodload zsh/zprof
fi

export HISTFILE=$HOME/.zsh_history
source $HOME/dotfiles/shell/vars.sh
source $HOME/dotfiles/shell/alias.sh
source $HOME/dotfiles/shell/core.sh
source $HOME/dotfiles/shell/func.sh
source $HOME/dotfiles/shell/zsh/common.zsh
source $HOME/.profile

# load default shell
eval "$(starship init zsh)"
eval "$(zoxide init zsh --cmd z)"


ZNAPDIR=$HOME/.znap/git

# Download Znap, if it's not there yet.
[[ -f ${ZNAPDIR}/znap.zsh ]] ||
    git clone --depth 1 -- \
        https://github.com/marlonrichert/zsh-snap.git ${ZNAPDIR}

source ${ZNAPDIR}/znap.zsh  # Start Znap

# load plugins
znap source ohmyzsh/ohmyzsh lib/git.zsh
znap source ohmyzsh/ohmyzsh plugins/git
znap source ohmyzsh/ohmyzsh plugins/colorize
znap source ohmyzsh/ohmyzsh plugins/terraform
znap source zsh-users/zsh-completions

ZVM_INIT_MODE=sourcing
znap source jeffreytse/zsh-vi-mode

# start our codes
source $HOME/dotfiles/shell/zsh/completion.zsh
source $HOME/dotfiles/shell/zsh/keys.zsh
source $HOME/dotfiles/shell/zsh/kubectl.zsh

[ -f /usr/share/fzf/shell/key-bindings.zsh ] && source /usr/share/fzf/shell/key-bindings.zsh
[ -f ${PORT_PREFIX}/share/fzf/shell/key-bindings.zsh ] && source ${PORT_PREFIX}/share/fzf/shell/key-bindings.zsh

znap source Aloxaf/fzf-tab
znap source zsh-users/zsh-autosuggestions
znap source zdharma-continuum/fast-syntax-highlighting

# set color for fzftab
zstyle ':fzf-tab:*' default-color $'\033[30m'
zstyle ':fzf-tab:*' fzf-flags --color=light

if [[ $ZSH_PROFILNG == "yes" ]]; then
  zprof
fi

# set title of current shell
function set-title-precmd() {
  printf "\e]2;%s\a" "${PWD/#$HOME/~}"
}

function set-title-preexec() {
  printf "\e]2;%s\a" "$1"
}

autoload -Uz add-zsh-hook
add-zsh-hook precmd set-title-precmd
add-zsh-hook preexec set-title-preexec

export GPG_TTY=${TTY}

## 3third plugins
eval "$(direnv hook zsh)"

# direnv support venv
setopt PROMPT_SUBST

source $HOME/dotfiles/shell/zsh/vi.zsh

bindkey '^n' autosuggest-accept
