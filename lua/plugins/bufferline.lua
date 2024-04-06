return {
	{
		'akinsho/bufferline.nvim',
		version = '*',
		dependencies = {
			'famiu/bufdelete.nvim',
			'nvim-tree/nvim-web-devicons',
		},
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
					{
						filetype = 'dapui_scopes',
						text = 'Debug Scopes',
						text_align = 'left',
						separator = true,
					},
				},
				close_command = 'Bdelete! %d',
				right_mouse_command = 'Bdelete! %d',
			},
		},
		config = function(_, opts)
			opts['highlights'] =
				require('catppuccin.groups.integrations.bufferline').get()
			require('bufferline').setup(opts)

			local wk = require('which-key')

			wk.register({
				['<C-x>'] = { '<cmd>Bd<CR>', 'Nav: Close Buffer' },
				['<C-9>'] = { '<cmd>bn<CR>', 'Nav: 󰜴 Cycle To Right' },
				['<C-8>'] = { '<cmd>bp<CR>', 'Nav: 󰜱 Cycle To Left' },
			}, { mode = 'n', noremap = true })
		end,
	},
}
