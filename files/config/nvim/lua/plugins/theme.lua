function ColorMyPencils(color)
  color = color or "ron"
  vim.cmd.colorscheme(color)

  vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
  vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

return {
  tokyonight = {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
    config = function()
      require("tokyonight").setup({
        transparent = true,
        style = "moon",
        styles = {
          sidebars = "transparent",
          floats = "transparent",
        },
        on_colors = function(colors)
          colors.fg_gutter = "#636da6"
        end,
      })
      vim.cmd.colorscheme("tokyonight")
    end,
  },
  nightfox = {
    "EdenEast/nightfox.nvim",

    config = function()
      require("nightfox").setup({
        palettes = {
          nordfox = {
            -- bg1 = "#000000", -- Black background
            bg0 = "none", -- Alt backgrounds (floats, statusline, ...)
          },
        },
        options = {
          transparent = true,
        },
      })
      vim.cmd.colorscheme("nordfox")
    end,
  },
  kanagawa = {
    "rebelt/kanagawa.nvim",

    config = function()
      require("kanagawa").setup({
        transparent = true,
      })

      vim.cmd("colorscheme kanagawa")
    end,
  },
}
