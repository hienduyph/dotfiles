# .bashrc
# Source global definitions
if [ -f /etc/bashrc ]; then
  . /etc/bashrc
fi
if [ -f $HOME/.profile ]; then
  . $HOME/.profile
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
  for rc in ~/.bashrc.d/*; do
    if [ -f "$rc" ]; then
      . "$rc"
    fi
  done
fi
unset rc
alias tb="SHELL=/bin/zsh toolbox enter q"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
# source $HOME/apps/ble.sh/out/ble.sh
[ -f /usr/share/fzf/shell/key-bindings.bash ] && source "/usr/share/fzf/shell/key-bindings.bash"
