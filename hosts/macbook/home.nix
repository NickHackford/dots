{ pkgs, ... }: {
  home.username = "nh470c";
  home.homeDirectory = "/Users/nh470c";
  home.stateVersion = "22.11";
  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    btop
    fnm
    fzf
    highlight
    lf
    neofetch
    neovim
    nixfmt
    ripgrep
    tmux
  ];

  programs.git = { enable = true; };
}