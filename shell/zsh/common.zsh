# enable istory for multi tmux sessions
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
setopt histignorealldups         # trim all duplicates

# completions source
LINUX_BREW=/home/linuxbrew/.linuxbrew
export FPATH=$HOME/.zsh/completions:$FPATH:/usr/share/zsh/vendor-completions
if [[ -f ${LINUX_BREW}/bin/brew ]]; then
  export FPATH="${LINUX_BREW}share/zsh/site-functions:${FPATH}"
fi

# autoload -Uz compinit && compinit
# https://medium.com/@dannysmith/little-thing-2-speeding-up-zsh-f1860390f92
autoload -Uz compinit
for dump in ~/.zcompdump(N.mh+24); do
  compinit
done
compinit -C

autoload -U +X bashcompinit && bashcompinit

zinit light-mode for  \
  Aloxaf/fzf-tab \
  zsh-users/zsh-autosuggestions \
  zsh-users/zsh-completions \
  zdharma/fast-syntax-highlighting

zinit snippet OMZL::git.zsh
zinit snippet OMZP::git
zinit snippet OMZP::vi-mode
zinit snippet OMZP::colorize
zinit snippet OMZP::systemd
zinit snippet OMZP::vagrant
zinit snippet OMZP::terraform

## 3third plugins
eval "$(direnv hook zsh)"

# direnv support venv
setopt PROMPT_SUBST
