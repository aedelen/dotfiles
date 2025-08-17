{ lib, ... }:
{
  imports = [
    ./gitModule.nix
    ./games.nix
    ../neovim/neovim.nix
    ./tmux.nix
    ./music.nix
    ./reading.nix
  ];
  config = {
    gitModule.enable = lib.mkDefault true;
    neovimModule.enable = lib.mkDefault true;
    tmuxModule.enable = lib.mkDefault true;

    musicModule.enable = lib.mkDefault false;
    readingModule.enable = lib.mkDefault false;
    gamesModule.enable = lib.mkDefault false;
  };
}
