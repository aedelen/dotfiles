# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{ inputs, lib, config, pkgs, ... }: {

  imports = [
    # If you want to use home-manager modules from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModule

    # You can also split up your configuration and import pieces of it here:
    # ./nvim.nix
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
  ];
  
  # Enable Neovim
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    extraPackages = with pkgs; [
      ripgrep
      fd
      gcc
      tree-sitter
      wl-clipboard
    ];

    extraLuaConfig = ''
      -- Write lua code here --

      -- Import files --
      ${builtins.readFile neovim/init.lua}
      -- End of extraLuaConfig --

    '';

    plugins = with pkgs.vimPlugins; [
	telescope-fzf-native-nvim
	telescope-ui-select-nvim

      {
        plugin = (nvim-treesitter.withPlugins (p: [
	  p.tree-sitter-nix
	  p.tree-sitter-vim
	  p.tree-sitter-bash
	  p.tree-sitter-lua
	  p.tree-sitter-json
	]));
	config = ''${builtins.readFile neovim/treesitter.lua}'';
	type = "lua";
      }

      {
        plugin = neo-tree-nvim;
	config = ''${builtins.readFile neovim/neo-tree.lua}'';
	type = "lua";
      }

      {
	plugin = gitsigns-nvim;
	config = ''${builtins.readFile neovim/gitsigns.lua}'';
	type = "lua";
      }

      {
	plugin = telescope-nvim;
	config = ''${builtins.readFile neovim/telescope.lua}'';
	type = "lua";
      }
    ];

  };

  # Enable home-manager and git
  programs.home-manager.enable = true;
  programs.git = {
    enable = true;
    userName= "Adam Edelen";
    userEmail = "aedelen42@gmail.com";
  };

  home.file = {
    ".config/nvim/init.lua".enable = false;
    #".config/nvim/init.lua".source = ../nvim/.config/nvim/init.lua;
    #".config/nvim/init.lua".source = config.lib.file.mkOutOfStoreSymlink "/home/adam/.dotfiles/nvim/.config/nvim/init.lua";
  };


  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "25.05";
}
