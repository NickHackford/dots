vim.g.mapleader = " "

-- keep screen in place
vim.keymap.set("n", "J", "mzJ`z")
-- keep screen centered while paging
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Move highighted lines
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- delete and paste
vim.keymap.set("x", "<leader>p", '"_dP', { desc = "Super Delete and Paste" })
-- paste on new line
vim.keymap.set("n", "<leader>o", ":put<CR>", { desc = "Paste below" })
vim.keymap.set("n", "<leader>O", ":-1put<CR>", { desc = "Paste above" })

-- super delete
vim.keymap.set({ "n", "v" }, "<leader>x", [["_d]], { desc = "Super Delete" })

-- yank to clipboard
vim.keymap.set("n", "<leader>y", '"+y', { desc = "Yank to clipboard" })
vim.keymap.set("n", "<leader>Y", '"+Y', { desc = "Yank Line to clipboard" })
vim.keymap.set("v", "<leader>y", '"+y', { desc = "Yank to clipboard" })

-- substitute
vim.keymap.set(
	"v",
	"<Leader>s",
	[["ry:<C-u>%s/<C-r>r/<C-r>r/gI<Left><Left><Left>]],
	{ desc = "Substitute Word Under Cursor", noremap = true, silent = false }
)
vim.keymap.set(
	"n",
	"<leader>s",
	[[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
	{ desc = "Substitute Selection", noremap = true, silent = false }
)
-- TODO: Add v(isual) s(ubstitute)
