return {
	{
		'akinsho/bufferline.nvim',
		version = '*',
		dependencies = 'nvim-tree/nvim-web-devicons',
		after = 'catppuccin',
		opts = {
			options = {
				themeable = true,
				number = 'original',
				diagnostics = 'nvim_lsp',
				offsets = {
					{
						filetype = 'neo-tree',
						text = 'File Explorer',
						text_align = 'left',
						separator = true,
					},
				},
			},
		},
		config = function(_, opts)
			opts['highlights'] =
				require('catppuccin.groups.integrations.bufferline').get()
			require('bufferline').setup(opts)
		end,
	},
}
