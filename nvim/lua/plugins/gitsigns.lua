return {
	"lewis6991/gitsigns.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		require("gitsigns").setup({
			signs = {
				add = { text = "|" },
				change = { text = "|" },
				delete = { text = "-" },
			},
			current_line_blame = false,

			on_attach = function(bufnr)
				local gs = package.loaded.gitsigns

				local function map(mode, l, r, desc)
					vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
				end

				-- Navigation: Jump between changed hunks
				map("n", "]h", gs.next_hunk, "Next Git Hunk")
				map("n", "[h", gs.prev_hunk, "Previous Git Hunk")

				-- Actions: Stage, reset, and preview hunks
				map("n", "<leader>hs", gs.stage_hunk, "Stage Hunk")
				map("n", "<leader>hr", gs.reset_hunk, "Reset Hunk")

				-- Works in visual mode to stage specific highlighted lines!
				map("v", "<leader>hs", function()
					gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end, "Stage Selection")
				map("v", "<leader>hr", function()
					gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end, "Reset Selection")

				map("n", "<leader>hS", gs.stage_buffer, "Stage Entire Buffer")
				map("n", "<leader>hR", gs.reset_buffer, "Reset Entire Buffer")
				map("n", "<leader>hu", gs.undo_stage_hunk, "Undo Stage Hunk")

				-- Extremely useful: Pop up a floating window showing the diff for the current hunk
				map("n", "<leader>hp", gs.preview_hunk, "Preview Hunk Inline")

				-- Blame
				map("n", "<leader>hb", function()
					gs.blame_line({ full = true })
				end, "Git Blame Line (Full)")
				map("n", "<leader>tb", gs.toggle_current_line_blame, "Toggle Inline Blame")
			end,
		})
	end,
}
