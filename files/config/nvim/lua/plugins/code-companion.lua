return {
	"olimorris/codecompanion.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
	},
	config = function()
		require("codecompanion").setup({
			strategies = {
				chat = {
					adapter = "copilot",
				},
			},
		})
		vim.keymap.set("n", "<leader>cv", ":CodeCompanionChat Toggle <CR>", { desc = "View Companion" })
	end,
}
