require("core.set")
require("core.remap")

require("plugins.alpha").config()
require("plugins.bufferline").config()
require("plugins.better-vim-tmux-resizer")
-- require("plugins.codeium").config()
require("plugins.copilot").copilot.config()
require("plugins.copilot").copilotcmp.config()
require("plugins.copilot").copilotchat.config()
require("plugins.commentary").config()
--require('plugins.dap').config();
require("plugins.formatter").config()
require("plugins.fugitive").config()
require("plugins.gitsigns").config()
require("plugins.harpoon").config()
require("plugins.hexokinase").config()
require("plugins.lazygit").config()
require("plugins.lsp")
require("plugins.lualine").config()
require("plugins.markdown").toc.config()
require("plugins.markdown").render.config()
require("plugins.nvim-tree").config()
require("plugins.obsidian").config()
require("plugins.oil").config()
require("plugins.telescope").config()

require("plugins.theme").tokyonight.config()
require("plugins.treesitter").config()
require("plugins.trouble").config()
require("plugins.whichkey").config()
require("plugins.sniprun").config()
