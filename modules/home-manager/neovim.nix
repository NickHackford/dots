{
  config,
  pkgs,
  ...
}: let
  # Hubspot plugins
  asset-bender-nvim = pkgs.vimUtils.buildVimPlugin {
    name = "asset-bender-nvim";
    src = pkgs.fetchFromGitHub {
      owner = "bobrown101";
      repo = "asset-bender.nvim";
      rev = "1d715902478cc8f70483ee2f87a1a58a49ebc10f";
      hash = "sha256-JXTMKAbMHXsPR441r3ylvn5or/0YriWzowl5OVy239s=";
    };
  };
  plugin-utils-nvim = pkgs.vimUtils.buildVimPlugin {
    name = "plugin-utils-nvim";
    src = pkgs.fetchFromGitHub {
      owner = "bobrown101";
      repo = "plugin-utils.nvim";
      rev = "c4a755f9df40f3e91205a87830d7eba1ac7f8c73";
      hash = "sha256-oiGWlyt9+zN7ReQtdtVqFHVeaoypg6vFNOwSr9d3I2Y=";
    };
  };
  # Not packaged
  better-vim-tmux-resizer = pkgs.vimUtils.buildVimPlugin {
    name = "better-vim-tmux-resizer";
    src = pkgs.fetchFromGitHub {
      owner = "RyanMillerC";
      repo = "better-vim-tmux-resizer";
      rev = "a791fe5b4433ac43a4dad921e94b7b5f88751048";
      hash = "sha256-1uHcQQUnViktDBZt+aytlBF1ZG+/Ifv5VVoKSyM9ML0=";
    };
  };

  # Updated
  my-CopilotChat-nvim = pkgs.vimUtils.buildVimPlugin {
    name = "CopilotChat.nvim";
    src = pkgs.fetchFromGitHub {
      owner = "CopilotC-Nvim";
      repo = "CopilotChat.nvim";
      rev = "2ebe591cff06018e265263e71e1dbc4c5aa8281e";
      hash = "sha256-IPP5jXIX+05Tb0MEXUu6EjcL/RHgV1qkoXPEdaEfhNM=";
    };
  };
  my-snacks-nvim = pkgs.vimUtils.buildVimPlugin {
    pname = "snacks.nvim";
    version = "2024-12-17";
    src = pkgs.fetchFromGitHub {
      owner = "folke";
      repo = "snacks.nvim";
      rev = "972c61cc1cd254ef3b43ec1dfd51eefbdc441a7d";
      hash = "sha256-OBig3B2S87Ip9pwp38X3gMH2SHACbNMpMQ3JeAGxqQY=";
    };
  };

  hubspotPlugins =
    if config.isHubspot
    then [
      plugin-utils-nvim
      asset-bender-nvim
    ]
    else [];
in {
  programs.neovim = {
    enable = true;

    extraLuaPackages = luaPkgs: with luaPkgs; [luasocket];
    plugins = with pkgs.vimPlugins;
      [
        # Theming
        tokyonight-nvim
        nightfox-nvim
        kanagawa-nvim
        nvim-web-devicons

        # LSP and Autocompletion
        nvim-cmp
        nvim-lspconfig
        cmp-nvim-lsp
        lspkind-nvim
        luasnip
        cmp_luasnip
        #codeium-nvim
        copilot-lua
        my-CopilotChat-nvim
        copilot-cmp
        # nvim-dap
        # nvim-dap-ui

        # UI Enhancements
        gitsigns-nvim
        lualine-nvim
        my-snacks-nvim
        trouble-nvim
        which-key-nvim

        # Navigation
        harpoon2
        nvim-tree-lua
        telescope-fzf-native-nvim
        telescope-nvim
        yazi-nvim

        # Markdown and Writing
        markdown-preview-nvim
        render-markdown-nvim
        obsidian-nvim
        vim-markdown-toc

        # Treesitter and Syntax
        nvim-treesitter.withAllGrammars
        nvim-treesitter-context
        playground
        vim-closetag
        vim-commentary
        nvim-ts-context-commentstring

        # Utilities
        formatter-nvim
        vim-hexokinase
        oil-nvim
        sniprun
        vim-sandwich
        vim-table-mode
        vim-tmux-navigator
        better-vim-tmux-resizer
        vim-visual-multi
      ]
      ++ hubspotPlugins;
  };

  home.file = {
    "nvim" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.homeDirPath}.config/dots/files/config/nvim";
      target = ".config/nvim";
      recursive = true;
    };
  };
}
