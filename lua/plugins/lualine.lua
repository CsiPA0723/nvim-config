---@type LazyPluginSpec[]
return {
	{
		'nvim-lualine/lualine.nvim',
		dependencies = { 'nvim-tree/nvim-web-devicons' },
		opts = {
			options = {
				theme = 'catppuccin',
				icons_enabled = true,
				globalstatus = true,
			},
			sections = {
				lualine_a = {
					{
						'mode',
						fmt = function(str)
							return str:sub(1, 1)
						end,
					},
				},
				lualine_x = {
					'encoding',
					'fileformat',
					'filetype',
				},
			},
			tabline = {
				lualine_a = { { 'tabs', mode = 2, max_length = vim.o.columns } },
			},
			extensions = {
				'fzf',
				'lazy',
				'mason',
				'nvim-dap-ui',
				'oil',
				'quickfix',
				'toggleterm',
				'trouble',
			},
		},
		config = function(_, opts)
			require('lualine').setup(opts)
			vim.o.showtabline = 1
		end,
	},
}
