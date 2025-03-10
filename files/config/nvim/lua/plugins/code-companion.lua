return {
	"olimorris/codecompanion.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
	},
	config = function()
		require("codecompanion").setup({
			display = {
				action_palette = {
					-- broken for now
					-- provider = "mini_pick",
				},
				chat = {
					intro_message = "󱙺 Press ? for options",
					start_in_insert_mode = true,
				},
				diff = {
					provider = "mini_diff",
				},
			},
			strategies = {
				chat = {
					adapter = "claude",
				},
				inline = {
					adapter = "claude",
				},
			},
			adapters = {
				opts = {
					show_defaults = false,
				},
				-- ml_nlp = require("plugins.cc-ml-nlp"),
				claude = function()
					return require("codecompanion.adapters").extend("copilot", {
						schema = {
							model = {
								default = "claude-3.7-sonnet",
							},
							max_tokens = {
								default = 65536,
							},
						},
					})
				end,
				o3 = function()
					return require("codecompanion.adapters").extend("copilot", {
						schema = {
							model = {
								default = "o3-mini-2025-01-31",
							},
							max_tokens = {
								default = 65536,
							},
						},
					})
				end,
				["4o"] = function()
					return require("codecompanion.adapters").extend("copilot", {
						schema = {
							model = {
								default = "gpt-4o",
							},
							max_tokens = {
								default = 65536,
							},
						},
					})
				end,
			},
		})

		vim.keymap.set(
			{ "n", "v" },
			"<leader>at",
			"<cmd>CodeCompanionChat Toggle<cr>",
			{ desc = "AI Chat Toggle", noremap = true, silent = true }
		)

		vim.keymap.set(
			{ "n", "v" },
			"<leader>ac",
			"<cmd>CodeCompanionChat claude<cr>",
			{ desc = "New AI Chat", noremap = true, silent = true }
		)

		vim.keymap.set(
			"n",
			"<leader>ae",
			"<cmd>CodeCompanionChat claude<cr>@editor #buffer<cr>",
			{ desc = "New AI Editor", noremap = true, silent = true }
		)
		vim.keymap.set(
			"v",
			"<leader>ae",
			"<cmd>CodeCompanionChat claude<cr><cr>@editor #buffer<cr>",
			{ desc = "New AI Editor", noremap = true, silent = true }
		)

		vim.keymap.set(
			{ "n", "v" },
			"<leader>aA",
			"<cmd>CodeCompanionActions<cr>",
			{ desc = "AI Actions", noremap = true, silent = true }
		)

		vim.keymap.set(
			"v",
			"<leader>aa",
			"<cmd>CodeCompanionChat Add<cr>",
			{ desc = "Add to AI Chat", noremap = true, silent = true }
		)

		-- Expand 'cc' into 'CodeCompanion' in the command line
		vim.cmd([[cab cc CodeCompanion]])
	end,
}
