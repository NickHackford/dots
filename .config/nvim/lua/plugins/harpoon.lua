return {
	"ThePrimeagen/harpoon",
	event = "VimEnter",
	config = function()
		require("harpoon").setup({
			menu = {
				width = vim.api.nvim_list_uis()[1].width - 10,
			},
		})

		local mark = require("harpoon.mark")
		local ui = require("harpoon.ui")

		vim.keymap.set("n", "<leader>a", mark.add_file)
		vim.keymap.set("n", "<leader>h", ui.toggle_quick_menu, {}, "view harpoon")

		vim.keymap.set("n", "<leader>j", function()
			ui.nav_file(1)
		end)
		vim.keymap.set("n", "<leader>k", function()
			ui.nav_file(2)
		end)
		vim.keymap.set("n", "<leader>l", function()
			ui.nav_file(3)
		end)
		vim.keymap.set("n", "<leader>;", function()
			ui.nav_file(4)
		end)
	end,
}
