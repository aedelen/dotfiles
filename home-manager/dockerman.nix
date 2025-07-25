# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{ pkgs, ... }:
{

  imports = [
    # If you want to use home-manager modules from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModule

    # You can also split up your configuration and import pieces of it here:
    # ./nvim.nix
    modules/home-manager-modules.nix
  ];

  home = {
    username = "adam";
    homeDirectory = "/home/adam";
  };

  # Add stuff for your user as you see fit:
  # programs.neovim.enable = true;
  home.packages = with pkgs; [
    #Put packages here
    #neovim
    #vimPlugins.telescope-nvim
    #lua-language-server
  ];

  # Enable home-manager
  programs.home-manager.enable = true;

  home.file = {
    ".config/nvim/init.lua".enable = false;
    #".config/nvim/init.lua".source = ../nvim/.config/nvim/init.lua;
    #".config/nvim/init.lua".source = config.lib.file.mkOutOfStoreSymlink "/home/adam/.dotfiles/nvim/.config/nvim/init.lua";
  };

  neovimModule.obsidianSupport = false;

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "25.05";
}
