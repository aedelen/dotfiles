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
    vimPlugins.telescope-nvim
  ];
  
  # Enable Neovim
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    extraLuaConfig = ''
      -- Write lua code here --

      -- Import files --

    '';

    plugins = with pkgs.vimPlugins; [
      telescope-fzf-native-nvim
      {
        plugin = telescope-nvim;
	config = ''
	  require('telescope').setup({
  	extensions = {
      	fzf = {
        	fuzzy = true,                    -- false will only do exact matching
        	override_generic_sorter = true,  -- override the generic sorter
        	override_file_sorter = true,     -- override the file sorter
        	case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                         -- the default case_mode is "smart_case"
      	}
    	}
  })
  
  require('telescope').load_extension('fzf')
	'';
	type = "lua";
      }
      {
        plugin = which-key-nvim;
	#config = ../nvim/.config/nvim/init.lua;
	#config = '' ${builtins.readFile ../nvim/.config/nvim/lua/plugins/which-key.lua} '';
	config = ''
	  require("which-key").setup()

		-- Document existing key chains
		require("which-key").add({
			{ "<leader>c", group = "[C]ode" },
			{ "<leader>d", group = "[D]ocument" },
			{ "<leader>r", group = "[R]ename" },
			{ "<leader>s", group = "[S]earch" },
			{ "<leader>f", group = "[F]ind" },
			{ "<leader>w", group = "[W]orkspace" },
			{ "<leader>t", group = "[T]oggle" },
			{ "<leader>h", group = "Git [H]unk", mode = { "n", "v" } },
		})

        '';
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
