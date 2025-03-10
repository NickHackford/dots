return {
	"chasnovski/mini.nvim",
	lazy = false,
	config = function()
		local starter = require("mini.starter")
		starter.setup({
			evaluate_single = true,
			items = {
				starter.sections.builtin_actions(),
				starter.sections.recent_files(9, true),
			},
			content_hooks = {
				starter.gen_hook.adding_bullet(),
				starter.gen_hook.indexing("all", { "Builtin actions" }),
				starter.gen_hook.padding(3, 2),
				starter.gen_hook.aligning("center", "center"),
			},
			header = [[
███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗  
████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║  
██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║  
██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║  
██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║  
╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝]],
			footer = " ",
		})

		local mininotify = require("mini.notify")
		vim.notify = mininotify.make_notify()
		mininotify.setup({
			window = {
				winblend = 0,
			},
		})
		vim.keymap.set("n", "<leader>nh", function()
			mininotify.show_history()
		end, { desc = "Notification history", noremap = true, silent = true, nowait = true })
		vim.keymap.set("n", "<leader>nd", function()
			mininotify.clear()
		end, { desc = "Dismiss Notifications", noremap = true, silent = true, nowait = true })

		local files = require("mini.files")
		files.setup()
		vim.api.nvim_create_autocmd("User", {
			pattern = "MiniFilesBufferCreate",
			callback = function(args)
				local buf_id = args.data.buf_id
				vim.keymap.set("n", "<CR>", function()
					files.go_in({ close_on_file = true })
				end, { buffer = buf_id })
			end,
		})
		vim.keymap.set("n", "<leader>ft", function()
			if not files.close() then
				local current_buf_name = vim.api.nvim_buf_get_name(0)
				if current_buf_name and current_buf_name ~= "" and vim.fn.filereadable(current_buf_name) == 1 then
					files.open(current_buf_name)
					files.reveal_cwd()
				else
					files.open(vim.fn.getcwd(), false)
				end
			end
		end, { desc = "File Tree", noremap = true })

		require("mini.pick").setup()
		require("mini.git").setup()
		require("mini.diff").setup({
			view = { style = "sign", signs = { add = "│", change = "┆", delete = "_" } },
		})
		require("mini.icons").setup()
		require("mini.indentscope").setup()

		require("mini.cursorword").setup()
		require("mini.surround").setup()
		require("ts_context_commentstring").setup({
			enable_autocmd = false,
		})
		require("mini.comment").setup({
			options = {
				custom_commentstring = function()
					return require("ts_context_commentstring").calculate_commentstring() or vim.bo.commentstring
				end,
			},
		})

		local statusline = require("mini.statusline")
		statusline.setup({
			content = {
				active = function()
					local mode, mode_hl = statusline.section_mode({ trunc_width = 120 })
					local git = statusline.section_git({ trunc_width = 40 })

					local diff = statusline.section_diff({ trunc_width = 75 })
					local added, changed, removed = "", "", ""
					if diff ~= "" then
						added = diff:match("(%+%d+)") or ""
						changed = diff:match("(~%d+)") or ""
						removed = diff:match("(-%d+)") or ""
					end

					local diagnostics = statusline.section_diagnostics({ trunc_width = 75 })
					local errors, warnings, infos, hints = "", "", "", ""
					if diagnostics ~= "" then
						errors = diagnostics:match("(E%d+)") or ""
						warnings = diagnostics:match("(W%d+)") or ""
						infos = diagnostics:match("(I%d+)") or ""
						hints = diagnostics:match("(H%d+)") or ""
					end
					local ai = require("plugins.mini-ai-status")()

					local filename = statusline.section_filename({ trunc_width = 140 })

					local lsp = statusline.section_lsp({ trunc_width = 75 })
					local fileinfo = statusline.section_fileinfo({ trunc_width = 120 })
					local search = statusline.section_searchcount({ trunc_width = 75 })

					local mode_map = {
						["N"] = "󰒘",
						["I"] = "󰓥",
						["V"] = "󱡁",
						["C"] = "󱡄",
					}

					return statusline.combine_groups({
						{ hl = mode_hl, strings = { mode_map[mode:sub(1, 1)] } },
						{ hl = "statuslineDevinfo", strings = { git } },

						{ hl = "MiniDiffSignAdd", strings = { added } },
						{ hl = "Changed", strings = { changed } },
						{ hl = "MiniDiffSignDelete", strings = { removed } },

						{ hl = "DiagnosticError", strings = { errors } },
						{ hl = "DiagnosticWarn", strings = { warnings } },
						{ hl = "DiagnosticInfo", strings = { infos } },
						{ hl = "DiagnosticHint", strings = { hints } },

						"%<", -- Mark general truncate point
						{ hl = "statuslineFilename", strings = { filename } },
						"%=", -- End left alignment
						{ hl = "statuslineDevinfo", strings = { ai } },
						{ hl = "statuslineDevinfo", strings = { lsp } },
						{ hl = "statuslineFileinfo", strings = { fileinfo } },
						{ hl = mode_hl, strings = { search, "%l:%2v" } },
					})
				end,
			},
		})

		local clue = require("mini.clue")
		vim.o.timeoutlen = 300
		clue.setup({
			window = {
				config = {
					width = 40,
					height = 20,
					border = "rounded",
				},
				delay = 300,
			},

			triggers = {
				{ mode = "n", keys = "<Leader>" },
				{ mode = "x", keys = "<Leader>" },

				{ mode = "i", keys = "<C-x>" },

				{ mode = "n", keys = "g" },
				{ mode = "n", keys = "z" },
				{ mode = "n", keys = "]" },
				{ mode = "n", keys = "[" },

				{ mode = "n", keys = "'" },
				{ mode = "n", keys = "`" },
				{ mode = "n", keys = '"' },

				{ mode = "n", keys = "<C-w>" },
			},

			clues = {
				clue.gen_clues.builtin_completion(),
				clue.gen_clues.g(),
				clue.gen_clues.marks(),
				clue.gen_clues.registers(),
				clue.gen_clues.windows(),
				clue.gen_clues.z(),

				{ mode = "n", keys = "<Leader>a", desc = "AI Agent" },
				{ mode = "n", keys = "<Leader>b", desc = "Buffer" },
				{ mode = "n", keys = "<Leader>d", desc = "Diagnostics" },
				{ mode = "n", keys = "<Leader>f", desc = "Find/File" },
				{ mode = "n", keys = "<Leader>fd", desc = "Find in Directory" },
				{ mode = "n", keys = "<Leader>g", desc = "Git" },
				{ mode = "n", keys = "<Leader>n", desc = "Notifications" },
				{ mode = "n", keys = "<Leader>q", desc = "Quickfix" },
				{ mode = "n", keys = "<Leader>t", desc = "Tables" },
				{ mode = "n", keys = "<Leader>v", desc = "View" },
			},
		})
	end,
}
