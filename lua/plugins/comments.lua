---@type LazyPluginSpec[]
return {
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
}
