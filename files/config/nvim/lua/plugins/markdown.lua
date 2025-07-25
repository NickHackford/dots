return {
	{
		"iamcco/markdown-preview.nvim",
		init = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
		ft = { "markdown" },
		cmd = {
			"MarkdownPreview",
			"MarkdownPreviewStop",
			"MarkdownPreviewToggle",
		},
		event = "BufRead",
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
	},
	{
		"dhruvasagar/vim-table-mode",
		ft = { "markdown" },
	},
	{
		"mzlogin/vim-markdown-toc",
		ft = { "markdown" },
		config = function()
			vim.g["vmt_list_item_char"] = "-"
			vim.g["vmt_fence_text"] = "TOC"
			vim.g["vmt_fence_closing_text"] = "/TOC"
		end,
	},
	{
		"MeanderingProgrammer/render-markdown.nvim",
		ft = { "markdown" },
		config = function()
			require("render-markdown").setup({
				file_types = { "markdown", "codecompanion" },
				checkbox = {
					position = "overlay",
					custom = {
						todo = { raw = "[-]", rendered = "󰥔 ", highlight = "RenderMarkdownTodo" },
						blocked = { raw = "[!]", rendered = "󰥕 ", highlight = "RenderMarkdownError" },
					},
				},
				win_options = {
					conceallevel = {
						default = 0,
						rendered = 0,
					},
				},
			})
		end,
	},
}
