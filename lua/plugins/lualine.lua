return {
	{
		'nvim-lualine/lualine.nvim',
		dependencies = { 'nvim-tree/nvim-web-devicons' },
		opts = {
			options = { theme = 'catppuccin' },
			extensions = {
				'fzf',
				'lazy',
				'mason',
				'neo-tree',
				'nvim-dap-ui',
				'trouble',
				'toggleterm',
			},
		},
	},
}
