---@type LazyPluginSpec[]
return {
	{
		'rcarriga/nvim-notify',
		opts = { fps = 60, render = 'compact', stages = 'slide' },
		config = function(_, opts)
			require('notify').setup(opts)
			vim.notify = require('notify')
		end,
	},
	{
		'folke/which-key.nvim',
		---@class wk.Opts
		opts = { preset = 'modern', win = { no_overlap = false } },
	},
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
	{
		'jiaoshijie/undotree',
		dependencies = 'nvim-lua/plenary.nvim',
		config = true,
		keys = { -- load the plugin only when using it's keybinding:
			{
				'<leader>u',
				'<cmd>lua require("undotree").toggle()<cr>',
				desc = 'Toggle UndoTree',
			},
		},
	},
	{
		'mrjones2014/smart-splits.nvim',
		build = './kitty/install-kittens.bash',
		config = true,
	},
	{
		'sindrets/diffview.nvim',
		event = 'VeryLazy',
		dependencies = { 'nvim-tree/nvim-web-devicons' },
		config = true,
	},
	{ 'tpope/vim-fugitive' },
}
