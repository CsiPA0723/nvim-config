return {
	{
		'nvim-lualine/lualine.nvim',
		dependencies = { 'nvim-tree/nvim-web-devicons' },
		opts = {
			options = { theme = 'catppuccin' },
			sections = {
				lualine_a = {
					{
						'mode',
						fmt = function(str)
							return str:sub(1, 1)
						end,
					},
				},
			},
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
