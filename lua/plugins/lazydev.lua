---@type LazyPluginSpec[]
return {
	{
		'folke/lazydev.nvim',
		ft = 'lua', -- only load on lua files
		opts = {
			library = {
				'lazy.nvim',
			},
		},
	},
}
