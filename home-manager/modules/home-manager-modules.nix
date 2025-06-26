{ lib, ... }:
{
  imports = [
    ./gitModule.nix
    ../neovim/neovim.nix
  ];
  config = {
    gitModule.enable = lib.mkDefault true;
    neovimModule.enable = lib.mkDefault true;
  };
}
