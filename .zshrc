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

enable-fzf-tab


# load default shell
eval "$(starship init zsh)"

source $HOME/dotfiles/shell/after-hook.sh

export LOCAL_HIS_DIR=$HOME/.local/hisfiles

# https://github.com/junegunn/fzf/blob/764316a53d0eb60b315f0bbcd513de58ed57a876/shell/key-bindings.zsh#L93
q_command() {
  local selected num
  setopt localoptions noglobsubst noposixbuiltins pipefail no_aliases 2> /dev/null

  selected=(
    $(cat <(fc -rl 1 && cat ${LOCAL_HIS_DIR}/*) | perl -ne 'print if !$seen{(/^\s*[0-9]+\**\s+(.*)/, $1)}++' \
    | \
    FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} $FZF_DEFAULT_OPTS -n2..,.. --tiebreak=index --bind=ctrl-r:toggle-sort,ctrl-z:ignore $FZF_CTRL_R_OPTS --query=${(qqq)LBUFFER} +m" $(__fzfcmd))
  )
  local ret=$?
  if [ -n "$selected" ]; then
    num=$selected[1]
    if [ -n "$num" ]; then
      zle vi-fetch-history -n $num
    fi
  fi
  zle reset-prompt
  return $ret
}

zle     -N   q_command
bindkey '^H' q_command
