return {
	"tpope/vim-fugitive",
	config = function()
		vim.keymap.set("n", "<leader>gf", ":vertical Git <CR>")
		-- vim.keymap.set("n", "<leader>gf", vim.cmd.Git)
		-- in diff, grab left or right
		vim.keymap.set("n", "gj", "<cmd>diffget //2<CR>")
		vim.keymap.set("n", "gf", "<cmd>diffget //3<CR>")
	end,
}
