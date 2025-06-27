{ lib, ... }:
{
  imports = [
    ./gitModule.nix
    ./games.nix
    ../neovim/neovim.nix
    ./tmux.nix
  ];
  config = {
    gitModule.enable = lib.mkDefault true;
    neovimModule.enable = lib.mkDefault true;
    tmuxModule.enable = lib.mkDefault true;

    gamesModule.enable = lib.mkDefault false;
  };
}
