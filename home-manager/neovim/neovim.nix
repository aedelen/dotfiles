{pkgs, config, lib, ...}: { 
	options = { 
		neovimModule.enable = lib.mkEnableOption "enables Neovim module"; 
	}; 
	config = lib.mkIf config.neovimModule.enable {
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
				${builtins.readFile ./settings.lua}
				vim.lsp.enable('lua_ls') 
				vim.lsp.enable('nil_ls') 
				-- End of extraLuaConfig --
			'';

			plugins = with pkgs.vimPlugins; [
				telescope-fzf-native-nvim
				telescope-ui-select-nvim tokyonight-nvim
				nvim-lspconfig mini-icons nvim-web-devicons

				{ 
					plugin = (nvim-treesitter.withPlugins (p: [
						p.tree-sitter-nix 
						p.tree-sitter-vim
						p.tree-sitter-bash 
						p.tree-sitter-lua
						p.tree-sitter-json 
					])); 
					config = ''
						${builtins.readFile
						./treesitter.lua}''; 
					type = "lua"; 
				}

				{ plugin = neo-tree-nvim; config =
					''${builtins.readFile
					./neo-tree.lua}''; type = "lua"; }

				{ plugin = gitsigns-nvim; config =
					''${builtins.readFile
					./gitsigns.lua}''; type = "lua"; }

				{ plugin = telescope-nvim; config =
					''${builtins.readFile
					./telescope.lua}''; type = "lua";
				}

				{ plugin = which-key-nvim; config =
					''${builtins.readFile
					./which-key.lua}''; type = "lua";
				}

			];

		}; }; }
