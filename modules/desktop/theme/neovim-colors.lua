return {
	{
		"navarasu/onedark.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("onedark").setup({
				style = "dark",
			})
			require("onedark").load()
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = { options = { theme = "auto" } },
	},
	{
		"brenoprata10/nvim-highlight-colors",
		config = function()
			require("nvim-highlight-colors").setup({
				render = 'virtual',
				virtual_symbol = '■',
				enable_named_colors = true,
				enable_tailwind = false,
			})
		end,
	}
}
