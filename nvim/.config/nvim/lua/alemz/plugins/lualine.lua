return {
	"nvim-lualine/lualine.nvim",
	config = function()
		require("lualine").setup({
			options = {
				theme = "moonfly",
			},
			sections = {
				lualine_b = {
					"diff",
					"diagnostics",
				},
				lualine_c = {
					{ "filename", path = 1 },
				},
			},
		})
	end,
}
