{ config, pkgs, base16-vim, ... }:
let
  harpoon2 = pkgs.vimUtils.buildVimPlugin {
    name = "harpoon2";
    src = pkgs.fetchFromGitHub {
      owner = "ThePrimeagen";
      repo = "harpoon";
      rev = "7d1aef462a880fcb68419cb63abc50dbdc22d922";
      hash = "sha256-AXWN7HqlnSsmtCK8jK5vqyzHwKJY3eJL6fnjeJhoNMU=";
    };
  };
in {
  programs.neovim = {
    enable = true;
    extraLuaPackages = luaPkgs: with luaPkgs; [ luasocket ];
    plugins = with pkgs.vimPlugins; [
      # nvim-dap
      # nvim-dap-ui
      (pkgs.vimUtils.buildVimPlugin {
        name = "base16-vim";
        src = base16-vim;
      })
      # nightfox-nvim

      nvim-lspconfig
      nvim-cmp
      codeium-nvim
      cmp-nvim-lsp
      luasnip
      lspkind-nvim

      alpha-nvim
      bufferline-nvim
      formatter-nvim
      gitsigns-nvim
      vim-hexokinase
      harpoon2
      lualine-nvim
      # FIXME Doesn't work for some reason
      markdown-preview-nvim
      nvim-tree-lua
      nvim-treesitter.withAllGrammars
      # TODO disabled because it breaks on format
      # nvim-treesitter-context
      playground
      sniprun
      telescope-fzf-native-nvim
      telescope-nvim
      trouble-nvim
      vim-closetag
      vim-commentary
      vim-fugitive
      vim-markdown-toc
      vim-sleuth
      vim-sandwich
      vim-table-mode
      vim-tmux-navigator
      vim-visual-multi
      which-key-nvim
    ];
    extraLuaConfig = ''
      require('core.nix-init')

      vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
      vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
      vim.api.nvim_set_hl(0, "LineNr", { bg = "none" })
      vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
    '';
    extraConfig = ''
      colorscheme base16-tokyo-night-terminal-dark
      let base16_background_transparent=1 
    '';
  };
  home.file = {
    "nvim-settings" = {
      source = ../../files/config/nvim/lua/core;
      target = ".config/nvim/lua/core";
      recursive = true;
    };
    "nvim-plugins" = {
      source = ../../files/config/nvim/lua/plugins;
      target = ".config/nvim/lua/plugins";
      recursive = true;
    };
  };
}
