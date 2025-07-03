{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    #nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      nixos-hardware,
      ...
    }:
    {

      nixosConfigurations = {
        thinkpad = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = {
          };
          modules = [
            nixos/thinkpad/configuration.nix
            nixos-hardware.nixosModules.lenovo-thinkpad-t470s
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.adam = import ./home-manager/thinkpad.nix;
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
