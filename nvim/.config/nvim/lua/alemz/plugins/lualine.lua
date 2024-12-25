local colors = {
	color3 = nil,
	color6 = "#9e9e9e",
	color7 = "#80a0ff",
	color8 = "#ae81ff",
	color0 = "#1c1c1c",
	color1 = "#ff5189",
	color2 = "#c6c6c6",
}

local moonfly = {
	replace = {
		a = { fg = colors.color0, bg = colors.color1, gui = "bold" },
		b = { fg = colors.color2, bg = colors.color3 },
	},
	inactive = {
		a = { fg = colors.color6, bg = colors.color3, gui = "bold" },
		b = { fg = colors.color6, bg = colors.color3 },
		c = { fg = colors.color6, bg = colors.color3 },
	},
	normal = {
		a = { fg = colors.color0, bg = colors.color7, gui = "bold" },
		b = { fg = colors.color2, bg = colors.color3 },
		c = { fg = colors.color2, bg = colors.color3 },
	},
	visual = {
		a = { fg = colors.color0, bg = colors.color8, gui = "bold" },
		b = { fg = colors.color2, bg = colors.color3 },
	},
	insert = {
		a = { fg = colors.color0, bg = colors.color2, gui = "bold" },
		b = { fg = colors.color2, bg = colors.color3 },
	},
}

return {
	"nvim-lualine/lualine.nvim",
	config = function()
		require("lualine").setup({
			options = {
				theme = moonfly,
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
