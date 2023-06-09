vim.g.mapleader = " "

-- Dont bind Ex because I have nvim tree
-- vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- keep screen in place
vim.keymap.set("n", "J", "mzJ`z")
-- keep screen centered while paging
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Move highighted lines
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- delete and paste
vim.keymap.set("x", "<leader>p", '"_dP')
-- past on new line
vim.keymap.set("n", "<leader>o", ":put<CR>")
vim.keymap.set("n", "<leader>O", ":-1put<CR>")

-- super delete
vim.keymap.set({ "n", "v" }, "<leader>x", [["_d]])

-- yank to clipboard
vim.keymap.set("n", "<leader>y", '"+y')
vim.keymap.set("n", "<leader>Y", '"+Y')
vim.keymap.set("v", "<leader>y", '"+y')

-- Start find and replace with selected text
function FindAndReplace()
	vim.api.nvim_input(":%s/" .. vim.fn.getreg("r") .. "/")
end
vim.api.nvim_set_keymap("v", "<Leader>r", '"ry:lua FindAndReplace()<CR>', { noremap = true, silent = false })
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
--

-- navigate through errors
-- vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
-- vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
-- vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
-- vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")
