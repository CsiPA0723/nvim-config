---@type LazyPluginSpec[]
return {
	{
		'numToStr/Comment.nvim',
		event = 'VeryLazy',
		config = function()
			local wk = require('which-key')
			require('Comment').setup()
			wk.add({
				{ 'gb', group = 'Comment toggle blockwise' },
				{ 'gc', group = 'Comment toggle linewise' },
			})
		end,
	},
	{
		'folke/todo-comments.nvim',
		event = 'VeryLazy',
		dependencies = { 'nvim-lua/plenary.nvim' },
		---@type TodoOptions
		---@diagnostic disable-next-line: missing-fields
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
}
