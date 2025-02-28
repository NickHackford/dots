return {
	copilot = {
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "VeryLazy",
		config = function()
			require("copilot").setup({
				suggestion = { enabled = false },
				panel = { enabled = false },
			})
		end,
	},
	copilotcmp = {
		"zbirenbaum/copilot-cmp",
		config = function()
			require("copilot_cmp").setup()
		end,
	},
	copilotchat = {
		"CopilotC-Nvim/CopilotChat.nvim",
		branch = "canary",
		dependencies = {
			{ "zbirenbaum/copilot.lua" },
			{ "nvim-lua/plenary.nvim" },
		},
		config = function()
			require("CopilotChat").setup({
				mappings = {
					close = {
						normal = "q",
					},
					reset = {
						normal = "<C-c>",
						insert = "<C-c>",
					},
				},
			})
			vim.keymap.set("n", "<leader>c", ":CopilotChat <CR>", { desc = "View CopilotChat" })
		end,
	},
}
