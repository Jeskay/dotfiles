return {
	"stevearc/oil.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("oil").setup({
			-- Disable if using SSHFS, leave it if running on remote machine
			watch_for_changes = true,
			-- Oil will take over directory buffers
			default_file_explorer = true,
			-- Send deleted files to trash
			delete_to_trash = true,
			skip_confirm_on_simple_edits = true,
			-- Show . directories but hide junk folders
			view_options = {
				show_hidden = true,
				is_always_hidden = function(name, buffer)
					return name == ".git" or name == "node_modules"
				end,
			},
			keymaps = {
				["g?"] = "actions.show_help",
				["<CR>"] = "actions.select",
				["<C-s>"] = "actions.select_vsplit",
				["<C-h>"] = "actions.select_split",
				["<C-c>"] = "actions.close",
				["-"] = "actions.parent", -- Go up one directory
				["_"] = "actions.open_cwd", -- Go to the root of the workspace
				["`"] = "actions.cd", -- Change working directory to this folder
				["~"] = "actions.tcd",
				["gs"] = "actions.change_sort", -- Changes how files are sorted
				["gx"] = "actions.open_external", -- Opens file under the cursor using default program
				["g."] = "actions.toggle_hidden",
				["g\\"] = "actions.toggle_trash",
			},
		})
		vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
	end,
}
