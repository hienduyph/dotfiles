if [[ $ZSH_PROFILNG == "yes" ]]; then
  zmodload zsh/zprof
fi

bindkey -v

export HISTFILE=$HOME/.zsh_history

if [[ "$XDG_SESSION_TYPE" == "wayland" ]]; then
  source $HOME/dotfiles/shell/system/wayland.sh
elif [[ "$XDG_SESSION_TYPE" == "x11" ]]; then
  source $HOME/dotfiles/shell/system/x11.sh
fi

if [[ "$PLATFORM" == "linux" ]]; then
  source $HOME/dotfiles/shell/system/linux_common.sh
elif [[ "$PLATFORM" == "darwin" ]]; then
  source $HOME/dotfiles/shell/system/mac.sh
fi

source $HOME/dotfiles/shell/vars.sh
source $HOME/dotfiles/shell/alias.sh
source $HOME/dotfiles/shell/core.sh
source $HOME/dotfiles/shell/func.sh
source $HOME/dotfiles/shell/zsh/common.zsh
source $HOME/.profile

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

# start our codes
source $HOME/dotfiles/shell/zsh/completion.zsh
source $HOME/dotfiles/shell/zsh/keys.zsh
source $HOME/dotfiles/shell/zsh/kubectl.zsh

if [ -n "${commands[fzf-share]}" ]; then
  source "$(fzf-share)/key-bindings.zsh"
  source "$(fzf-share)/completion.zsh"
fi

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

if [ -n "${commands[direnv]}" ]; then
  eval "$(direnv hook zsh)"
fi

if [ -n "${commands[starship]}" ]; then
  eval "$(starship init zsh)"
fi

if [ -n "${commands[zoxide]}" ]; then
  eval "$(zoxide init zsh --cmd z)"
fi

# direnv support venv
setopt PROMPT_SUBST

set -o vi

bindkey '^n' autosuggest-accept
