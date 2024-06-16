return {
	{
		'rcarriga/nvim-notify',
		opts = { fps = 60, render = 'default', stages = 'slide' },
		config = function(_, opts)
			require('notify').setup(opts)
			vim.notify = require('notify')
		end,
	},
	{ 'folke/which-key.nvim' },
	{
		'akinsho/toggleterm.nvim',
		version = '*',
		opts = { open_mapping = '<C-ö>' },
	},
	{ 'nanotee/zoxide.vim' },
	{
		'mistricky/codesnap.nvim',
		cmd = { 'CodeSnap', 'CodeSnapSave' },
		build = 'make build_generator',
	},
	{
		'cuducos/yaml.nvim',
		lazy = true,
		ft = { 'yaml' },
		dependencies = {
			'nvim-treesitter/nvim-treesitter',
			'nvim-telescope/telescope.nvim',
		},
	},
	{
		'folke/todo-comments.nvim',
		event = 'VimEnter',
		dependencies = { 'nvim-lua/plenary.nvim' },
		config = true,
	},
	{
		'folke/trouble.nvim',
		dependencies = { 'nvim-tree/nvim-web-devicons' },
		config = true,
	},
	{
		'anuvyklack/windows.nvim',
		dependencies = { 'anuvyklack/middleclass', 'anuvyklack/animation.nvim' },
		event = 'VeryLazy',
		config = true,
	},
	{
		'tris203/precognition.nvim',
		event = 'VeryLazy',
		opts = {
			startVisible = false,
			highlightColor = { link = 'Whitespace' },
		},
	},
}
