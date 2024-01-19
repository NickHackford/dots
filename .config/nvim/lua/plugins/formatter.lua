return {
	-- Apply formatters installed with Mason
	"mhartington/formatter.nvim",
	config = function()
		local util = require("formatter.util")
		-- Provides the Format, FormatWrite, FormatLock, and FormatWriteLock commands
		require("formatter").setup({
			-- Enable or disable logging
			logging = true,
			-- Set the log level
			log_level = vim.log.levels.DEBUG,
			-- All formatter configurations are opt-in
			filetype = {
				lua = {
					require("formatter.filetypes.lua").stylua,
				},

				html = {
					require("formatter.filetypes.html").prettier,
				},

				css = {
					require("formatter.filetypes.css").prettier,
				},

				scss = {
					require("formatter.filetypes.css").prettier,
				},

				less = {
					require("formatter.filetypes.css").prettier,
				},

				javascript = {
					require("formatter.filetypes.javascript").prettier,
				},

				json = {
					require("formatter.filetypes.json").prettier,
				},

				typescript = {
					require("formatter.filetypes.typescript").prettier,
				},

				typescriptreact = {
					require("formatter.filetypes.typescriptreact").prettier,
				},

				nix = {
					require("formatter.filetypes.nix").nixfmt,
				},

				go = {
					require("formatter.filetypes.go").gofmt,
				},

				php = {
					require("formatter.filetypes.php").phpcbf,
					-- You can also define your own configuration
					function()
						-- Full specification of configurations is down below and in Vim help
						-- files
						return {
							exe = "phpcbf",
							args = {
								"--standard=/Users/nh470c/codebase/php/non-web/standardscheck/CSNStores",
							},
							stdin = true,
							ignore_exitcode = true,
						}
					end,
				},

				-- Use the special "*" filetype for defining formatter configurations on
				-- any filetype
				-- ["*"] = {
				-- 	-- "formatter.filetypes.any" defines default configurations for any
				-- 	-- filetype
				-- 	require("formatter.filetypes.any").remove_trailing_whitespace,
				-- },
			},
		})

		vim.keymap.set("n", "<leader>p", ":Format<CR>")
	end,
}
