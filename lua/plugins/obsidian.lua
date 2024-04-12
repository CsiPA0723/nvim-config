return {
	'epwalsh/obsidian.nvim',
	version = '*',
	lazy = true,
	ft = 'markdown',
	-- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
	-- event = {
	--   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
	--   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
	--   "BufReadPre path/to/my-vault/**.md",
	--   "BufNewFile path/to/my-vault/**.md",
	-- },
	dependencies = {
		'nvim-lua/plenary.nvim',
		'nvim-telescope/telescope.nvim',
		'nvim-treesitter/nvim-treesitter',
		'epwalsh/pomo.nvim',
	},
	opts = {
		workspaces = {
			{
				name = 'personal',
				path = '~/vaults/personal',
			},
			{
				name = 'work',
				path = '~/vaults/work',
				overrides = {
					notes_subdir = 'notes',
				},
			},
			{
				name = 'no-vault',
				path = function()
					-- alternatively use the CWD:
					-- return assert(vim.fn.getcwd())
					return assert(vim.fs.dirname(vim.api.nvim_buf_get_name(0)))
				end,
				overrides = {
					notes_subdir = vim.NIL, -- have to use 'vim.NIL' instead of 'nil'
					new_notes_location = 'current_dir',
					templates = {
						subdir = vim.NIL,
					},
					disable_frontmatter = true,
				},
			},
		},
		completion = {
			nvim_cmp = true,
			min_chars = 2,
		},
	},
	config = function(opts)
		vim.o.conceallevel = 1

		require('obsidian').setup(opts)

	end,
}
