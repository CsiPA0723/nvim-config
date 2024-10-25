---@type LazyPluginSpec[]
return {
	{
		'folke/which-key.nvim',
		---@class wk.Opts
		opts = { preset = 'modern', win = { no_overlap = false }, delay = 500 },
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
		event = 'VeryLazy',
		dependencies = { 'nvim-lua/plenary.nvim' },
		---@type TodoOptions
		opts = {
			highlight = {
				-- vimgrep regex, supporting the pattern TODO(name)\:
				pattern = [[.*<((KEYWORDS)%(\(.{-1,}\))?)\s*:]],
			},
			search = {
				-- ripgrep regex, supporting the pattern TODO(name)\:
				pattern = [[(?:\b(KEYWORDS)(?:\(\w*\))*:)]],
			},
		},
	},
	{
		'folke/trouble.nvim',
		dependencies = { 'nvim-tree/nvim-web-devicons' },
		event = 'VeryLazy',
		config = true,
	},
	{
		'anuvyklack/windows.nvim',
		dependencies = { 'anuvyklack/middleclass', 'anuvyklack/animation.nvim' },
		event = 'VeryLazy',
		config = true,
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
		event = 'VeryLazy',
		config = true,
	},
	{
		'NeogitOrg/neogit',
		dependencies = {
			'nvim-lua/plenary.nvim',
			'nvim-telescope/telescope.nvim',
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
	{
		'mistweaverco/kulala.nvim',
		opts = { vscode_rest_client_environmentvars = true },
	},
	{
		'numToStr/Comment.nvim',
		config = function()
			require('Comment').setup()
			vim.keymap.del('n', 'gc')
			vim.keymap.del('n', 'gb')
			local wk = require('which-key')
			wk.add({
				{ 'gb', group = 'Comment toggle blockwise' },
				{ 'gc', group = 'Comment toggle linewise' },
			})
		end,
	},
	{
		'OXY2DEV/helpview.nvim',
		lazy = false,
		dependencies = { 'nvim-treesitter/nvim-treesitter' },
	},
	{ 'neolooong/whichpy.nvim', config = true },
}
