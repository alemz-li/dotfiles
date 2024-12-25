return {
	"lewis6991/gitsigns.nvim",
	config = function()
		require("gitsigns").setup({
			on_attach = function(bufnr)
				local gitsigns = require("gitsigns")

				local function map(mode, l, r, opts)
					opts = opts or {}
					opts.buffer = bufnr
					vim.keymap.set(mode, l, r, opts)
				end

				-- Navigation
				map("n", "]c", function()
					if vim.wo.diff then
						vim.cmd.normal({ "]c", bang = true })
					else
						gitsigns.nav_hunk("next")
					end
				end, { desc = "Next hunk" })

				map("n", "[c", function()
					if vim.wo.diff then
						vim.cmd.normal({ "[c", bang = true })
					else
						gitsigns.nav_hunk("prev")
					end
				end, { desc = "Previous hunk" })

				-- Actions
				local opts = { noremap = true, silent = true }

				-- Stage/Reset Hunk
				opts.desc = "Stage hunk"
				map("n", "<leader>hs", gitsigns.stage_hunk, opts)

				opts.desc = "Reset hunk"
				map("n", "<leader>hr", gitsigns.reset_hunk, opts)

				-- Visual Mode: Stage/Reset Hunk
				map("v", "<leader>hs", function()
					gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end, { desc = "Stage hunk (visual)" })
				map("v", "<leader>hr", function()
					gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end, { desc = "Reset hunk (visual)" })

				-- Stage/Reset Buffer
				map("n", "<leader>hS", gitsigns.stage_buffer, { desc = "Stage entire buffer" })
				map("n", "<leader>hR", gitsigns.reset_buffer, { desc = "Reset entire buffer" })

				-- Undo Stage Hunk
				map("n", "<leader>hu", gitsigns.undo_stage_hunk, { desc = "Undo stage hunk" })

				-- Preview Hunk
				map("n", "<leader>hp", gitsigns.preview_hunk, { desc = "Preview hunk" })

				-- Blame
				map("n", "<leader>hb", function()
					gitsigns.blame_line({ full = true })
				end, { desc = "Blame line (full)" })
				map("n", "<leader>tb", gitsigns.toggle_current_line_blame, { desc = "Toggle current line blame" })

				-- Diff
				map("n", "<leader>hd", gitsigns.diffthis, { desc = "Diff this file" })
				map("n", "<leader>hD", function()
					gitsigns.diffthis("~")
				end, { desc = "Diff against the last commit" })

				-- Toggle Deleted
				map("n", "<leader>td", gitsigns.toggle_deleted, { desc = "Toggle deleted lines" })

				-- Text object for selecting a hunk
				map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "Select hunk" })
			end,
		})
	end,
}
