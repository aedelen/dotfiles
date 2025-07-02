{
  pkgs,
  config,
  lib,
  ...
}:
{
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

        # LSP
        # https://microsoft.github.io/language-server-protocol/implementors/servers/
        # https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md
        bash-language-server
        lua-language-server
        nil # nix
        jdt-language-server
        nodePackages.vscode-json-languageserver

        # Styles
        #  :help conform-formatters
        nixfmt-rfc-style # nix
        stylua
        beautysh # bash
        google-java-format
        jq # json
      ];

      extraLuaConfig = ''
        -- Write lua code here --
        -- Import files --
        ${builtins.readFile ./settings.lua}
        ${builtins.readFile ./conform.lua}
        ${builtins.readFile ./lualine.lua}
        -- LSP
        vim.lsp.enable('lua_ls')
        vim.lsp.enable('nil_ls')
        vim.lsp.enable('bashls')
        vim.lsp.enable('jdtls')
        vim.lsp.enable('jsonls')
        -- End of extraLuaConfig --
      '';

      plugins = with pkgs.vimPlugins; [
        telescope-fzf-native-nvim
        telescope-ui-select-nvim
        tokyonight-nvim
        nvim-lspconfig
        mini-icons
        nvim-web-devicons
        conform-nvim # STYYYYYLE
        lualine-nvim

        {
          plugin = (
            nvim-treesitter.withPlugins (p: [
              p.tree-sitter-nix
              p.tree-sitter-vim
              p.tree-sitter-bash
              p.tree-sitter-lua
              p.tree-sitter-json
              p.tree-sitter-java
            ])
          );
          config = ''${builtins.readFile ./treesitter.lua}'';
          type = "lua";
        }

        {
          plugin = neo-tree-nvim;
          config = ''${builtins.readFile ./neo-tree.lua}'';
          type = "lua";
        }

        {
          plugin = gitsigns-nvim;
          config = ''${builtins.readFile ./gitsigns.lua}'';
          type = "lua";
        }

        {
          plugin = telescope-nvim;
          config = ''${builtins.readFile ./telescope.lua}'';
          type = "lua";
        }

        {
          plugin = which-key-nvim;
          config = ''${builtins.readFile ./which-key.lua}'';
          type = "lua";
        }

      ];

    };
  };
}
