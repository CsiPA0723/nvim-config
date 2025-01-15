---@type LazyPluginSpec[]
return {
	{
		'NeogitOrg/neogit',
		dependencies = {
			'nvim-lua/plenary.nvim',
			{
				'sindrets/diffview.nvim',
				dependencies = { 'nvim-tree/nvim-web-devicons' },
				config = true,
			},
		},
		event = 'VeryLazy',
		---@type NeogitConfig
		opts = { graph_style = 'kitty' },
	},
}
