alias nx='nix-user-chroot $NIX_HOME zsh'

if [ -e "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh" ]; then . $HOME/.nix-profile/etc/profile.d/hm-session-vars.sh; fi

if [ -e $HOME/.nix-profile/etc/profile.d/nix.sh ]; then . $HOME/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
