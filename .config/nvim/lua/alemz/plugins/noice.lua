require("noice").setup({
	lsp = { progress = { enabled = false } },
	views = {
		cmdline_popup = {
			border = {
				style = "none",
				padding = { 1, 2 },
			},
			filter_options = {},
			win_options = {
				winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
			},
		},
	},
})
