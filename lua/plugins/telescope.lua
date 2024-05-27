-- Fuzzy Finder (files, lsp, etc)
return {
	{
		'nvim-telescope/telescope.nvim',
		event = 'VimEnter',
		dependencies = {
			{ 'nvim-lua/plenary.nvim' },
			{ -- If encountering errors, see telescope-fzf-native README for installation instructions
				'nvim-telescope/telescope-fzf-native.nvim',

				-- `build` is used to run some command when the plugin is installed/updated.
				-- This is only run then, not every time Neovim starts up.
				build = 'make',

				-- `cond` is a condition used to determine whether this plugin should be
				-- installed and loaded.
				cond = function()
					return vim.fn.executable('make') == 1
				end,
			},
			{ 'nvim-telescope/telescope-ui-select.nvim' },
			{ 'jvgrootveld/telescope-zoxide', config = true },
			{ 'nvim-telescope/telescope-file-browser.nvim' },
			-- Useful for getting pretty icons, but requires a Nerd Font.
			{ 'nvim-tree/nvim-web-devicons' },
		},
		config = function()
			-- Telescope is a fuzzy finder that comes with a lot of different things that
			-- it can fuzzy find! It's more than just a "file finder", it can search
			-- many different aspects of Neovim, your workspace, LSP, and more!
			--
			-- The easiest way to use Telescope, is to start by doing something like:
			--  :Telescope help_tags
			--
			-- After running this command, a window will open up and you're able to
			-- type in the prompt window. You'll see a list of `help_tags` options and
			-- a corresponding preview of the help.
			--
			-- Two important keymaps to use while in Telescope are:
			--  - Insert mode: <c-/>
			--  - Normal mode: ?
			--
			-- This opens a window that shows you all of the keymaps for the current
			-- Telescope picker. This is really useful to discover what Telescope can
			-- do as well as how to actually do it!

			-- [[ Configure Telescope ]]
			-- See `:help telescope` and `:help telescope.setup()`
			require('telescope').setup({
				-- You can put your default mappings / updates / etc. in here
				--  All the info you're looking for is in `:help telescope.setup()`
				--
				-- defaults = {
				--   mappings = {
				--     i = { ['<c-enter>'] = 'to_fuzzy_refine' },
				--   },
				-- },
				-- pickers = {}
				extensions = {
					['ui-select'] = {
						require('telescope.themes').get_dropdown(),
					},
				},
			})

			-- Enable Telescope extensions if they are installed
			pcall(require('telescope').load_extension, 'fzf')
			pcall(require('telescope').load_extension, 'ui-select')
			pcall(require('telescope').load_extension, 'notify')
			pcall(require('telescope').load_extension, 'zoxide')
			pcall(require('telescope').load_extension, 'scope')
			pcall(require('telescope').load_extension, 'file_browser')
			pcall(require('telescope').load_extension, 'pomodori')

			-- See `:help telescope.builtin`
			local builtin = require('telescope.builtin')
			local wk = require('which-key')

			wk.register({
				s = {
					name = '[S]earch',
					h = { builtin.help_tags, '[H]elp' },
					k = { builtin.keymaps, '[K]eymaps' },
					f = { builtin.find_files, '[F]iles' },
					s = { builtin.builtin, '[S]elect Telescope' },
					w = { builtin.grep_string, 'Current [W]ord' },
					g = { builtin.live_grep, '[G]rep' },
					d = { builtin.diagnostics, '[D]iagnostics' },
					r = { builtin.resume, '[R]esume' },
					z = { require('telescope').extensions.zoxide.list, '[Z]oxide list' },
					b = {
						require('telescope').extensions.file_browser.file_browser,
						'[B]rowser',
					},
					p = {
						require('telescope').extensions.pomodori.timers,
						'[P]omodori Timers',
					},
					['<leader>'] = { builtin.oldfiles, 'Search Recent Files' },
					['/'] = {
						function()
							builtin.live_grep({
								grep_open_files = true,
								prompt_title = 'Live Grep in Open Files',
							})
						end,
						'[/] in Open Files',
					},
					n = {
						function()
							builtin.find_files({ cwd = vim.fn.stdpath('config') })
						end,
						'[N]eovim files',
					},
				},
				['<leader>'] = { builtin.buffers, '[ ] Find existing buffers' },
				['/'] = {
					function()
						-- You can pass additional configuration to Telescope to change the theme, layout, etc.
						builtin.current_buffer_fuzzy_find(
							require('telescope.themes').get_dropdown({
								winblend = 10,
								previewer = false,
							})
						)
					end,
					'[/] Fuzzily search in current buffer',
				},
			}, { mode = 'n', prefix = '<leader>' })
		end,
	},
}
