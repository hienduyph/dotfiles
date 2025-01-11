# .bashrc
# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi
if [ -f $HOME/.profile ]; then
	. $HOME/.profile
fi
if [ -f $HOME/.bash_profile ]; then
	. $HOME/.bash_profile
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

shopt -s histappend
export HISTSIZE=1000000
export HISTFILESIZE=10000000


alias be="distrobox enter"
[ -f /usr/share/fzf/shell/key-bindings.bash ] && source "/usr/share/fzf/shell/key-bindings.bash"
