# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
_p10k_theme() {
  if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
  fi

  # To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
  [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
  PS1='$(show_virtual_env)'$PS1
}

source $HOME/dotfiles/shell/core.sh
source $HOME/dotfiles/shell/common.zsh

antigen use oh-my-zsh

# antigen theme romkatv/powerlevel10k
export FORGIT_NO_ALIASES=1

plugins=(
  git
  kubectl
  vi-mode
  colorize
  tmux
  wfxr/forgit
)

for p in "$plugins[@]"; do
  antigen bundle "$p"
done

antigen apply

# load default shell
eval "$(starship init zsh)"

source $HOME/dotfiles/shell/after-hook.sh
