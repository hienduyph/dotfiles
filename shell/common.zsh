# enable history for multi tmux sessions
setopt inc_append_history
export ZSH_DISABLE_COMPFIX='true'
export ZSH_DOTENV_PROMPT='false'

# history config

HISTSIZE=1000000000
SAVEHIST=10000000000
setopt BANG_HIST                 # Treat the '!' character specially during expansion.
setopt EXTENDED_HISTORY          # Write the history file in the ":start:elapsed;command" format.
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space.
setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.
setopt HIST_VERIFY               # Don't execute immediately upon history expansion.
setopt HIST_BEEP                 # Beep when accessing nonexistent history.

source $HOME/.zsh/antigen.zsh

# completions source
export FPATH=$HOME/.zsh/completions:$FPATH
if type brew &>/dev/null; then
  export FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH
fi
autoload -U compinit && compinit
autoload -U +X bashcompinit && bashcompinit

plugins=(
  "Aloxaf/fzf-tab"
  "zsh-users/zsh-autosuggestions"
  "zsh-users/zsh-syntax-highlighting"
)

for p in "$plugins[@]"; do
  antigen bundle $p
done

## 3third plugins
eval "$(direnv hook zsh)"

# direnv support venv
setopt PROMPT_SUBST

show_virtual_env() {
  if [[ -n "$VIRTUAL_ENV" && -n "$DIRENV_DIR" ]]; then
    echo "($(basename $VIRTUAL_ENV))"
  fi
}
PS1='$(show_virtual_env)'$PS1
