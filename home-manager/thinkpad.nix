# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{ config, pkgs, ... }:
{
  # You can import other home-manager modules here
  imports = [
    # If you want to use home-manager modules from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModule

    # You can also split up your configuration and import pieces of it here:
    # ./nvim.nix
    modules/home-manager-modules.nix
    modules/hyprland.nix
  ];

  home = {
    username = "adam";
    homeDirectory = "/home/adam";
  };

  # Add stuff for your user as you see fit:
  # programs.neovim.enable = true;
  home.packages = with pkgs; [
    #communications
    discord
    thunderbird
    ghostty
    obsidian
    alacritty
    filezilla
  ];

  # Play some games
  gamesModule.enable = false;

  # Enable home-manager
  programs.home-manager.enable = true;

  musicModule.enable = true;
  readingModule.enable = true;

  # Enable hyprland
  hyprlandConfig.enable = true;

  # Install Jetbrains IDEs
  jetbrainsModule.enable = true;
  home.file =
    let
      symlink = config.lib.file.mkOutOfStoreSymlink;
      dotfiles = config.home.homeDirectory + "/.dotfiles";
    in
    {
      ".ssh/config".source = symlink dotfiles + "/ssh/.ssh/config";
      ".config/kanshi/config".source = ../kanshi/.config/kanshi/config;
      ".npmrc".source = symlink dotfiles + "/node/.npmrc";
    };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "24.11";
}
