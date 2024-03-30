return {
	{
		'lukas-reineke/virt-column.nvim',
		opts = {
			virtcolumn = '+1,80',
			exclude = {
				filetypes = {
					'lspinfo',
					'packer',
					'checkhealth',
					'help',
					'man',
					'gitcommit',
					'TelescopePrompt',
					'TelescopeResults',
					'neo-tree',
				},
				buftypes = {
					'terminal',
					'nofile',
					'quickfix',
					'prompt'
				}
			},
		},
	},
}
