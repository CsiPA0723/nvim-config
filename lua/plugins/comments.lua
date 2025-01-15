---@type LazyPluginSpec[]
return {
	{
		'numToStr/Comment.nvim',
		keys = {
			{ 'gb', group = 'Comment toggle blockwise' },
			{ 'gc', group = 'Comment toggle linewise' },
		},
		config = true,
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
