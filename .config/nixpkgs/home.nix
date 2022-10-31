{ config, pkgs, ... }:

{
  news.display = "silent";
  programs.home-manager.enable = true;
  home.stateVersion = "22.11";
  manual.manpages.enable = false;

  home.username = "hienduyph";
  home.homeDirectory = "/home/hienduyph";


  home.packages = with pkgs; [
    jq
    fzf
    ripgrep
    tree
    zsh
    gcc
    curl

    inetutils
    ripgrep
    inetutils
    exa
    bat
    fd
    watch
    wget
    wrk
    tldr
    jq
    yq
    htop
    fzf
    git
    git-lfs

    gnupg

    helm
    protobuf
    kubectl
    kustomize

    tmux
    zsh-completions
    gitAndTools.delta
    direnv
    fswatch
    starship

    python310
    go
    nodejs
    yarn

    fd
    grpcurl
    gitui
    procs
    zoxide
    tokei

    gocryptfs

    rustc
    cargo
  ];

  programs.zsh = {
    enable = false;
    shellAliases = {
      cat = "bat";
      ls = "exa";
    };
  };

  programs.bat.enable = true;
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };
  programs.neovim = {
    enable = true;
    vimAlias = true;
  };

  programs.java = {
    enable = true;
    package = pkgs.openjdk11;
  };
}
