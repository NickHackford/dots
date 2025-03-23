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
					slash_commands = {
						["file"] = {
							opts = {
								provider = "telescope",
							},
						},
						["rules"] = {
							description = "Search for rules files in .cursor/rules directory",
							callback = function(chat)
								local File = require("codecompanion.strategies.chat.slash_commands.file")
								local SlashCommand = File.new({
									Chat = chat,
									config = {
										opts = {
											contains_code = true,
										},
									},
								})

								require("telescope.builtin").find_files({
									prompt_title = "Rules Files",
									cwd = ".cursor/rules/",
									file_ignore_patterns = { "^%.git/" },
									attach_mappings = function(prompt_bufnr, map)
										local actions = require("telescope.actions")
										local action_state = require("telescope.actions.state")

										local function process_rules()
											local selections = {}
											require("telescope.actions.utils").map_selections(
												prompt_bufnr,
												function(selection)
													table.insert(selections, selection)
												end
											)

											if #selections == 0 then
												local selection = action_state.get_selected_entry()
												if selection then
													table.insert(selections, selection)
												end
											end

											actions.close(prompt_bufnr)

											for _, selection in ipairs(selections) do
												local path = vim.fn.getcwd() .. "/.cursor/rules/" .. selection.value
												SlashCommand:output({
													path = path,
													relative_path = ".cursor/rules/" .. selection.value,
													description = "Rules from " .. selection.value,
												})
											end
										end

										actions.select_default:replace(process_rules)
										return true
									end,
								})
							end,
							opts = {
								provider = "telescope",
								contains_code = true,
							},
						},
					},
				},
				inline = {
					adapter = "claude",
				},
			},
			opts = {
				system_prompt = require("plugins.cc-system-prompt"),
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
								default = "claude-3.5-sonnet",
							},
							max_tokens = {
								default = 65536,
							},
						},
					})
				end,
				claude7 = function()
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
			{ "n", "v" },
			"<leader>ae",
			"<cmd>CodeCompanionChat claude<cr><cr>@editor #buffer<cr>",
			{ desc = "New AI Editor", noremap = true, silent = true }
		)

		vim.keymap.set(
			{ "n", "v" },
			"<leader>af",
			"<cmd>CodeCompanionChat claude<cr><cr>@full_stack_dev #buffer<cr>",
			{ desc = "New AI Full Stack Dev", noremap = true, silent = true }
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
		vim.cmd([[cab ccc CodeCompanionChat]])
	end,
}
