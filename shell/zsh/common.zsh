# enabl istory for multi tmux sessions
setopt inc_append_history
export ZSH_DISABLE_COMPFIX='true'
export ZSH_DOTENV_PROMPT='false'


# history config
export HISTSIZE=1000000000
export SAVEHIST=10000000000
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
CF_PATH=$HOME/.zsh/completions:/usr/share/zsh/vendor-completions:/usr/share/zsh/site-functions
export FPATH=$FPATH:${CF_PATH}

# case insensitive completion
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'


# znap already set completion for us.
# https://medium.com/@dannysmith/little-thing-2-speeding-up-zsh-f1860390f92

alias less="bat"
alias ls="lsd"
alias cat="bat"
alias fm="yazi"
alias k="kubectl"
alias cm="chezmoi"
alias vim="nvim"
alias vi="nvim"

export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export GIT_PAGER=delta

export FZF_DEFAULT_COMMAND="fd --type f --hidden --follow -E .git -E node_modules -E vendor -E .direnv -E .mypy_cache -E __pycache__ -E target -E .pytest_cache -E .next -E vendor"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd -t d"
