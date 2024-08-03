---@type LazyPluginSpec[]
return {
	{
		'stevearc/oil.nvim',
		opts = {
			default_file_explorer = true,
			columns = {
				'permissions',
				'icon',
			},
			delete_to_trash = true,
		},
		dependencies = { 'nvim-tree/nvim-web-devicons' },
	},
}
