if [[ $ZSH_PROFILNG == "yes" ]]; then
  zmodload zsh/zprof
fi

bindkey -v

export HISTFILE=${HISTFILE:-$HOME/.zsh_history}

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
znap source zsh-users/zsh-completions
znap source jeffreytse/zsh-vi-mode
znap source romkatv/powerlevel10k

# start our codes
source $HOME/dotfiles/shell/zsh/completion.zsh


znap source Aloxaf/fzf-tab
znap source zsh-users/zsh-autosuggestions
znap source zdharma-continuum/fast-syntax-highlighting


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
command -v direnv > /dev/null 2>&1 && eval "$(direnv hook zsh)"
# command -v mcfly > /dev/null 2>&1 && eval "$(mcfly init zsh)"
export MCFLY_LIGHT=TRUE
export MCFLY_KEY_SCHEME=vim
export MCFLY_FUZZY=2


# direnv support venv
setopt PROMPT_SUBST

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
[[ -s "$HOME/.zprofile" ]] && source "$HOME/.zprofile"

source $HOME/.profile
source $HOME/dotfiles/shell/system/brew.sh
source $HOME/dotfiles/shell/zsh/common.zsh

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

# command -v starship > /dev/null 2>&1 && eval "$(starship init zsh)"
command -v zoxide > /dev/null 2>&1 && eval "$(zoxide init zsh --cmd z)"

# source $HOME/dotfiles/shell/zsh/gitstatusd.zsh
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export ZVM_INSERT_MODE_CURSOR=$ZVM_CURSOR_BLINKING_BLOCK
export ZVM_NORMAL_MODE_CURSOR=$ZVM_CURSOR_BLOCK
export ZVM_OPPEND_MODE_CURSOR=$ZVM_CURSOR_UNDERLINE
