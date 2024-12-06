{
  config,
  pkgs,
  inputs,
  ...
}: {
  services = {
    displayManager = {
      ly.enable = false;
      sddm = {
        enable = true;
        package = pkgs.kdePackages.sddm;
        theme = "where_is_my_sddm_theme";
        extraPackages = with pkgs.kdePackages; [
          qtvirtualkeyboard
          qtsvg
        ];
        settings.General = {
          InputMethod = "";
        };
        # wayland.enable = true;
        # setupScript = ''
        #   wlr-randr >> /tmp/nick.txt
        #   wlr-randr --output DP-3 --off
        #   wlr-randr --output HDMI-A-1 --off
        # '';
      };
    };
    xserver = {
      enable = true;
      videoDrivers = ["nvidia"];
      xrandrHeads = [
        {
          output = "DP-2";
          primary = true;
        }
        {
          output = "DP-0";
          monitorConfig = ''Option "Enable" "false"'';
        }
        {
          output = "HDMI-0";
          monitorConfig = ''Option "Enable" "false"'';
        }
      ];
    };
  };

  environment.systemPackages = with pkgs; [
    (pkgs.where-is-my-sddm-theme.override {
      themeConfig.General = {
        background = "${config.theme.wallLarge}";
        passwordCharacter = "•";
        passwordFontSize = 96;
        passwordCursorColor = "#ffffff";
        sessionsFontSize = 24;
        usersFontSize = 48;
      };
    })
    wlr-randr
  ];
}