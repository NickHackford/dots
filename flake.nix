{
  description = "Nix configuration for my machines";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    base16-vim = {
      url = "github:tinted-theming/base16-vim";
      flake = false;
    };
  };

  outputs = { nixpkgs, home-manager, hyprland, stylix, base16-vim, ... }:
    let
      system = "x86_64-linux";
      commonConfig = { lib, pkgs, config, ... }: {
        nix = {
          package = pkgs.nixFlakes;
          extraOptions = "experimental-features = nix-command flakes";
        };
        nixpkgs.config.allowUnfree = true;
      };
    in {
      nixosConfigurations = {
        nixos = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            commonConfig
            ./hosts/meraxes/configuration.nix
            home-manager.nixosModules.home-manager
            stylix.nixosModules.stylix
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.nick = import ./hosts/meraxes/home.nix;
              home-manager.extraSpecialArgs = { inherit base16-vim; };
            }
          ];
        };
      };
    };
}
