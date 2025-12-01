{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    # Keeping syncthingtray 1.7.7 - in newer versions the pop up does not
    # dismiss when window looses focus
    nixpkgs-syncthingtray.url = "github:NixOS/nixpkgs/62462eb71a3a9a6490bce7b7d8a2ee7ab16ccf2e";

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    nixpkgs-jetbrains.url = "github:NixOS/nixpkgs/f02fa2f654c7bcc45f0e815c29d093da7f1245b4";
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      nixos-hardware,
      nixpkgs-syncthingtray,
      nixpkgs-jetbrains,
      nixpkgs-unstable,
      ...
    }:
    {
      nixosConfigurations = {
        thinkpad = nixpkgs.lib.nixosSystem rec {
          system = "x86_64-linux";
          specialArgs = {
            pkgs-syncthing = import nixpkgs-syncthingtray {
              inherit system;
              config.allowUnfree = true;
            };
            pkgs-unstable = import nixpkgs-unstable {
              inherit system;
              config.allowUnfree = true;
            };
          };
          modules = [
            nixos/thinkpad/configuration.nix
            nixos-hardware.nixosModules.lenovo-thinkpad-t470s
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.adam = import ./home-manager/thinkpad.nix;
              home-manager.extraSpecialArgs = {
                pkgs-jetbrains = import nixpkgs-jetbrains {
                  inherit system;
                  config.allowUnfree = true;
                };
              };
            }
          ];
        };

        dockerman = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = {
          };
          modules = [
            nixos/dockerman/configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.adam = import ./home-manager/dockerman.nix;
            }
          ];
        };
      };

    };
}
