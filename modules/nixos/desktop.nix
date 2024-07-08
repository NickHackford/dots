{
  config,
  pkgs,
  ...
}: {
  programs.thunar.enable = true;
  programs.xfconf.enable = true;
  services.gvfs.enable = true;
  services.tumbler.enable = true;
  programs.thunar.plugins = with pkgs; [
    xfce.thunar-archive-plugin
    xfce.thunar-volman
    gnome.file-roller
  ];

  services.gnome.gnome-keyring.enable = true;
  programs.seahorse.enable = true;
  # For obsidian
  nixpkgs.config.permittedInsecurePackages = ["electron-25.9.0"];

  programs.steam.enable = true;
  programs.steam.package = pkgs.steam.override {
    extraProfile = ''export LD_PRELOAD=${pkgs.extest}/lib/libextest.so:$LD_PRELOAD'';
  };

  hardware.steam-hardware.enable = true;

  environment.systemPackages = with pkgs; [
    alacritty
    brave
    drawio
    firefox
    gimp
    gparted
    helvum
    makemkv
    obs-studio
    obsidian
    prismlauncher-unwrapped
    qalculate-gtk
    qbittorrent
    qimgv
    spotify
    todoist-electron
    ungoogled-chromium
    webcord
    wezterm
    vlc
  ];
}
