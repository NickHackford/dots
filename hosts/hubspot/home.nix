{
  config,
  pkgs,
  lib,
  ...
}: {
  isHubspot = true;
  home.homeDirectory = "/Users/nhackford";

  home = {
    stateVersion = "24.05"; # Please read the comment before changing.
    sessionVariables = {NIX_SHELL_PRESERVE_PROMPT = 1;};
  };

  fonts.fontconfig.enable = true;
  home.packages = with pkgs; [
    nerd-fonts.sauce-code-pro
    font-awesome
    raleway

    spotify
  ];

  programs = {
    home-manager.enable = true;
  };

  home.file = {
    ".hammerspoon" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/dots/files/config/hammerspoon";
      target = ".hammerspoon";
      recursive = true;
    };
  };

  home.activation = {
    rsync-home-manager-applications = lib.hm.dag.entryAfter ["writeBoundary"] ''
      rsyncArgs="--archive --checksum --chmod=-w --copy-unsafe-links --delete"
      apps_source="$genProfilePath/home-path/Applications"
      moniker="Home Manager Trampolines"
      app_target_base="${config.home.homeDirectory}/Applications"
      app_target="$app_target_base/$moniker"
      mkdir -p "$app_target"
      ${pkgs.rsync}/bin/rsync $rsyncArgs "$apps_source/" "$app_target"
    '';
  };
}
