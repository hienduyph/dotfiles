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
