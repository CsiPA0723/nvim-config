return {
	'stevearc/oil.nvim',
	opts = {
		default_file_explorer = false,
		columns = {
			'permissions',
			'icon',
		},
		delete_to_trash = true,
	},
	-- Optional dependencies
	dependencies = { 'nvim-tree/nvim-web-devicons' },
}
