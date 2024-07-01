{
  config,
  pkgs,
  ...
}: let
  info = builtins.readFile ./info;
in {
  imports = [
    ./hardware-configuration.nix
  ];

  boot = {
    kernelModules = ["sg"];
    supportedFilesystems = ["ntfs"];
    loader = {
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot/efi";
      };
      grub = {
        enable = true;
        efiSupport = true;
        useOSProber = true;
        copyKernels = true;
        device = "nodev";
        default = "saved";
        extraEntriesBeforeNixOS = true;
        extraEntries = ''
          menuentry "UEFI Firmware Settings" {
            fwsetup
          }
          menuentry "Reboot" {
            reboot
          }
          menuentry "Power" {
            halt
          }
        '';
      };
    };
  };

  time.timeZone = "America/New_York";

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  networking.hostName = "meraxes";
  networking.wireless.iwd.enable = true;
  networking.networkmanager.wifi.backend = "iwd";
  networking.networkmanager.enable = true;
  services.avahi.enable = true;

  security.polkit.enable = true;
  services.openssh.enable = true;

  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  # /mnt/windows/Windows/System32/config
  # chntpw -e SYSTEM
  # > cd ControlSet001\Services\BTHPORT\Parameters\Keys

  # systemd.tmpfiles.rules = [
  #   "f+ /var/lib/bluetooth/00:28:F8:2F:1D:71/DC:2C:EE:3E:A6:75/info - - - - "
  #   "w+ /var/lib/bluetooth/00:28:F8:2F:1D:71/DC:2C:EE:3E:A6:75/info - - - - ${info}"
  # ];

  services.printing.enable = true;

  hardware = {
    opengl = {enable = true;};
    nvidia = {
      modesetting.enable = true;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
    };
  };

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber = {
      enable = true;
      configPackages = [
        (pkgs.writeTextDir
          "share/wireplumber/wireplumber.conf.d/51-device-setup.conf" ''
            monitor.alsa.rules = [
              {
                matches = [
                  {
                    device.name = "alsa_card.usb-C-Media_Electronics_Inc._USB_Audio_Device-00"
                  }
                ]
                actions = {
                  update-props = {
                    device.nick = "Headset"
                    device.description = "Headset"
                  }
                }
              }
              {
                matches = [
                  {
                    device.name = "alsa_card.usb-C-Media_Electronics_Inc._USB_Audio_Device-00.2"
                  }
                ]
                actions = {
                  update-props = {
                    device.nick = "Soundbar"
                    device.description = "Soundbar"
                  }
                }
              }
              {
                matches = [
                  {
                    node.name = "alsa_output.pci-0000_01_00.1.hdmi-stereo"
                  }
                ]
                actions = {
                  update-props = {
                    node.description = "TV"
                    node.nick = "TV"
                    node.disabled = true
                  }
                }
              }
              {
                matches = [
                  {
                    device.name = "alsa_card.pci-0000_00_1f.3"
                  }
                ]
                actions = {
                  update-props = {
                    device.disabled = true
                  }
                }
              }
            ]
          '')
      ];
    };
  };

  users.users.nick = {
    isNormalUser = true;
    description = "nick";
    extraGroups = ["networkmanager" "wheel" "docker"];
    packages = with pkgs; [];
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
}
