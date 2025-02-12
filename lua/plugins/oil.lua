---@type LazyPluginSpec[]
return {
	{
		'stevearc/oil.nvim',
		dependencies = { 'nvim-tree/nvim-web-devicons' },
		lazy = false,
		---@type oil.SetupOpts
		opts = {
			default_file_explorer = true,
			columns = {
				'permissions',
				'icon',
			},
			view_options = { show_hidden = true },
			constrain_cursor = 'editable',
			delete_to_trash = true,
		},
	},
}
