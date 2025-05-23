return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  dependencies = {
    "nvim-treesitter/playground",
    "nvim-treesitter/nvim-treesitter-context",
  },
  config = function()
    local autocmd = vim.api.nvim_create_autocmd

    -- autocmd("BufRead", {
    --   pattern = "*rc",
    --   command = "set filetype=sh",
    -- })

    autocmd("BufRead", {
      pattern = "*.conf",
      command = "set filetype=sh",
    })

    autocmd("BufRead", {
      pattern = "*.region",
      command = "set filetype=html",
    })

    autocmd("BufRead", {
      pattern = "*config",
      command = "set filetype=json5",
    })

    vim.api.nvim_set_hl(0, "TreesitterContext", {})
    vim.api.nvim_set_hl(0, "TreesitterContextBottom", {})

    require("nvim-treesitter.configs").setup({
      -- A list of parser names, or "all" (the five listed parsers should always be installed)
      -- ensure_installed = { "php", "javascript", "typescript", "c", "lua", "vimdoc", "query" },

      -- Install parsers synchronously (only applied to `ensure_installed`)
      sync_install = false,

      -- Automatically install missing parsers when entering buffer
      -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
      -- auto_install = true,

      highlight = {
        enable = true,

        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = false,
      },
    })
  end,
}
