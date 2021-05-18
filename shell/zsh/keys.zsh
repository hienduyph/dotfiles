# bind auto complete key for zsh-autosuggestions
bindkey '^n' autosuggest-accept

export LOCAL_HIS_DIR=$HOME/.local/hisfiles

# https://github.com/junegunn/fzf/blob/764316a53d0eb60b315f0bbcd513de58ed57a876/shell/key-bindings.zsh#L93
q_command() {
  local selected
  setopt localoptions noglobsubst noposixbuiltins pipefail no_aliases 2> /dev/null

  selected=(
    $(cat <(fc -rl 1 && cat ${LOCAL_HIS_DIR}/*.his) | perl -ne 'print if !$seen{(/^\s*[0-9]+\**\s+(.*)/, $1)}++' \
    | \
    FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} $FZF_DEFAULT_OPTS -n2..,.. --tiebreak=index --bind=ctrl-r:toggle-sort,ctrl-z:ignore $FZF_CTRL_R_OPTS --query=${(qqq)LBUFFER} +m" $(__fzfcmd))
  )
  if [ -n "$selected" ]; then
    LBUFFER="${selected[@]:1}"
  fi
  local ret=$?
  zle reset-prompt
  return $ret
}

zle     -N   q_command
bindkey '^H' q_command
bindkey '^n' autosuggest-accept

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

enable-fzf-tab

# Check if 'kubectl' is a command in $PATH
alias k="kubectl"
if [ $commands[kubectl] ]; then
  # Placeholder 'kubectl' shell function:
  # Will only be executed on the first call to 'kubectl'
  kubectl() {

    # Remove this function, subsequent calls will execute 'kubectl' directly
    unfunction "$0"

    # Load auto-completion
    source <(kubectl completion zsh)

    # Execute 'kubectl' binary
    $0 "$@"
  }
fi
