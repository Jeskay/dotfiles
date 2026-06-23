return {
	"nvim-telescope/telescope.nvim",
	branch = "master",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
		},
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")

		telescope.setup({
			defaults = {
				vimgrep_arguments = {
					"rg",
					"--column",
					"--color=never",
					"--no-heading",
					"--with-filename",
					"--line-number",
					"--smart-case",
					"--hidden",
					"--glob=!.git/",
				},
				prompt_prefix = " > ",
				selection_caret = " ",
				path_display = { "truncate" },
				sorting_strategy = "ascending",
				layout_config = {
					horizontal = {
						prompt_position = "top",
						preview_width = 0.55,
						results_width = 0.8,
					},
					vertical = {
						mirror = false,
					},
					width = 0.87,
					height = 0.80,
					preview_cutoff = 120,
				},
				-- Shortcuts inside the Telescope window
				mappings = {
					i = {
						["<C-j>"] = actions.move_selection_next,
						["<C-k>"] = actions.move_selection_previous,
						-- Send current search results to the Quickfix list
						["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
						["<esc>"] = actions.close,
					},
				},
			},
			pickers = {
				find_files = {
					hidden = true,
					find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
				},
				buffers = {
					sort_mru = true,
					ignore_current_buffer = true,
				},
			},
		})
		-- Load C-compiled sorter
		telescope.load_extension("fzf")

		local builtin = require("telescope.builtin")
		local keymap = vim.keymap

		keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Fuzzy find files in workspace" })
		keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live grep text in workspace" })
		keymap.set("n", "<leader>fc", builtin.grep_string, { desc = "Find string in workspace" })
		keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find open buffers" })
		keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Find help tags" })
		keymap.set("n", "<leader>fr", builtin.oldfiles, { desc = "Find recently opened files" })
		keymap.set("n", "<leader>fs", builtin.current_buffer_fuzzy_find, { desc = "Fuzzy find in current buffer" })
	end,
}
