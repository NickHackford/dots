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
-- paste on new line
vim.keymap.set("n", "<leader>o", ":put<CR>")
vim.keymap.set("n", "<leader>O", ":-1put<CR>")

-- super delete
vim.keymap.set({ "n", "v" }, "<leader>x", [["_d]])

-- yank to clipboard
vim.keymap.set("n", "<leader>y", '"+y')
vim.keymap.set("n", "<leader>Y", '"+Y')
vim.keymap.set("v", "<leader>y", '"+y')

-- substitute
vim.keymap.set("v", "<Leader>s", [["ry:<C-u>%s/<C-r>r/<C-r>r/gI<Left><Left><Left>]], { noremap = true, silent = false })
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
-- TODO: Add v(isual) s(ubstitute)

-- vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")

-- navigate through errors
-- vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
-- vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
-- vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
-- vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")