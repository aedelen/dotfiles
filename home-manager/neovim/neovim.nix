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
        jdk17
        jdk

        # LSP
        # https://microsoft.github.io/language-server-protocol/implementors/servers/
        # https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md
        bash-language-server
        lua-language-server
        nil # nix
        jdt-language-server
        nodePackages.vscode-json-languageserver
        lemminx # xml

        # Styles
        #  :help conform-formatters
        # Don't forget to add to conform.lua
        nixfmt-rfc-style # nix
        stylua
        beautysh # bash
        jq # json
        xmlstarlet
      ];

      extraLuaConfig = ''
        -- Write lua code here --
        -- Import files --
        ${builtins.readFile ./settings.lua}
        ${builtins.readFile ./conform.lua}
        ${builtins.readFile ./lualine.lua}
        ${builtins.readFile ./undo-tree.lua}
        -- LSP
        vim.lsp.enable('lua_ls')
        vim.lsp.enable('nil_ls')
        vim.lsp.enable('bashls')
        vim.lsp.enable('jsonls')
        vim.lsp.enable('lemminx')
        -- End of extraLuaConfig --
      '';

      plugins = with pkgs.vimPlugins; [
        telescope-fzf-native-nvim
        telescope-ui-select-nvim
        tokyonight-nvim
        nvim-lspconfig # https://github.com/neovim/nvim-lspconfig
        mini-icons
        nvim-web-devicons
        conform-nvim # STYYYYYLE
        lualine-nvim # https://github.com/nvim-lualine/lualine.nvim
        undotree # https://github.com/mbbill/undotree/

        {
          # https://github.com/nvim-treesitter/nvim-treesitter/
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
          # https://github.com/nvim-neo-tree/neo-tree.nvim/
          plugin = neo-tree-nvim;
          config = ''${builtins.readFile ./neo-tree.lua}'';
          type = "lua";
        }

        {
          # https://github.com/lewis6991/gitsigns.nvim
          plugin = gitsigns-nvim;
          config = ''${builtins.readFile ./gitsigns.lua}'';
          type = "lua";
        }

        {
          # https://github.com/nvim-telescope/telescope.nvim
          plugin = telescope-nvim;
          config = ''${builtins.readFile ./telescope.lua}'';
          type = "lua";
        }

        {
          # https://github.com/folke/which-key.nvim/
          plugin = which-key-nvim;
          config = ''${builtins.readFile ./which-key.lua}'';
          type = "lua";
        }

        {
          # https://github.com/mfussenegger/nvim-jdtls/
          # exmaple https://github.com/Gako358/neovim/blob/a0d0fda7ea5dfef1429f606013e4177554dd498a/modules/languages/java.nix#L41
          plugin = nvim-jdtls;
          config = ''
            local jdts_install = "${pkgs.jdt-language-server}"
            local jdk_17_install = "${pkgs.jdk17}"
            local jdk_21_install = "${pkgs.jdk}"
            ${builtins.readFile ./nvim-java.lua}
          '';
          type = "lua";
        }

        {
          # https://github.com/Saghen/blink.cmp
          # https://cmp.saghen.dev/
          plugin = blink-cmp;
          config = ''${builtins.readFile ./blink-cmp.lua} '';
          type = "lua";
        }
      ];

    };
  };
}
