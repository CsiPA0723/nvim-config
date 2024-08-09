local ss = require('smart-splits')
local tsc_builtin = require('telescope.builtin')
local wk = require('which-key')

wk.add({
	{ -- Move lines
		mode = 'v',
		{ 'J', ":m '>+1<cr>gv=gv", desc = 'Move selected down' },
		{ 'K', ":m '<-2<cr>gv=gv", desc = 'Move selected up' },
	},
	{ -- Swap Buffer
		{ '<leader>a', group = 'Swap Buffer' },
		{ '<leader>ah', ss.swap_buf_left, desc = 'Swap with Left buffer' },
		{ '<leader>aj', ss.swap_buf_down, desc = 'Swap with Down Buffer' },
		{ '<leader>ak', ss.swap_buf_up, desc = 'Swap with Up Buffer' },
		{ '<leader>al', ss.swap_buf_right, desc = 'Swap with Right Buffer' },
	},
	{ -- Code
		{ '<leader>c', group = 'Code' },
		{ '<leader>cp', '"+p', desc = 'Clip: Paste', mode = { 'n', 'v' } },
		{ '<leader>cP', '"+P', desc = 'Clip: Paste', mode = { 'n', 'v' } },
		{ '<leader>cd', '"+d', desc = 'Clip: Delete', mode = { 'n', 'v' } },
		{ '<leader>cy', '"+y', desc = 'Clip: Copy', mode = { 'n', 'v' } },
		{ '<leader>cY', '"+Y', desc = 'Clip: Copy' },
	},
	{ -- Search
		{ '<leader>s', group = 'Search' },
		{ '<leader>sh', tsc_builtin.help_tags, desc = 'Help' },
		{ '<leader>sk', tsc_builtin.keymaps, desc = 'Keymaps' },
		{ '<leader>sf', tsc_builtin.find_files, desc = 'Files' },
		{ '<leader>st', tsc_builtin.git_files, desc = 'Git' },
		{ '<leader>ss', tsc_builtin.builtin, desc = 'Select Telescope' },
		{ '<leader>sw', tsc_builtin.grep_string, desc = 'Current Word' },
		{ '<leader>sg', tsc_builtin.live_grep, desc = 'Grep' },
		{ '<leader>sd', tsc_builtin.diagnostics, desc = 'Diagnostics' },
		{ '<leader>sr', tsc_builtin.resume, desc = 'Resume' },
		{
			'<leader>sz',
			require('telescope').extensions.zoxide.list,
			desc = 'Zoxide list',
		},
		{
			'<leader>sb',
			function()
				require('telescope').extensions.file_browser.file_browser(
					require('telescope.themes').get_ivy({ winblend = 10 })
				)
			end,
			desc = 'Browser',
		},
		{
			'<leader>sp',
			require('telescope').extensions.pomodori.timers,
			desc = 'Pomodori Timers',
		},
		{ '<leader>s<leader>', tsc_builtin.oldfiles, desc = 'Search Recent Files' },
		{
			'<leader>s/',
			function()
				tsc_builtin.live_grep({
					grep_open_files = true,
					prompt_title = 'Live Grep in Open Files',
				})
			end,
			desc = 'in Open Files',
		},
		{
			'<leader>sn',
			function()
				tsc_builtin.find_files({ cwd = vim.fn.stdpath('config') })
			end,
			desc = 'Neovim files',
		},
	},
	{ -- Workspace
		{ '<leader>w', group = 'Workspace', icon = '' },
		{ -- Session
			{ '<leader>ws', group = 'Session', icon = '󰥔' },
			{
				'<leader>wss',
				'<cmd>SessionManager save_current_session<CR>',
				desc = 'Save Session',
				icon = '󰆓',
			},
			{
				'<leader>wsl',
				'<cmd>SessionManager load_session<CR>',
				desc = 'Load Session',
				icon = '󰞒',
			},
			{
				'<leader>wsd',
				'<cmd>SessionManager delete_session<CR>',
				desc = 'Delete Session',
				icon = '󰆴',
			},
		},
		{
			'<leader>wt',
			'<cmd>Trouble todo toggle win.position=left win.relative=editor<CR>',
			desc = 'Open TODO list',
			icon = '',
		},
		{
			'<leader>wl',
			'<cmd>Trouble lsp toggle focus=false win.position=left win.relative=editor<CR>',
			desc = 'LSP definitions / referencies / ...',
		},
	},
	{ -- resizing splits
		{ '<A-h>', ss.resize_left, desc = 'Resize Left' },
		{ '<A-j>', ss.resize_down, desc = 'Resize Down' },
		{ '<A-k>', ss.resize_up, desc = 'Resize Up' },
		{ '<A-l>', ss.resize_right, desc = 'Resize Right' },
	},
	{ -- moving between splits
		{ '<C-h>', ss.move_cursor_left, desc = 'Move to Left Plane' },
		{ '<C-j>', ss.move_cursor_down, desc = 'Move to Down Plane' },
		{ '<C-k>', ss.move_cursor_up, desc = 'Move to Up Plane' },
		{ '<C-l>', ss.move_cursor_right, desc = 'Move to Rigth Plane' },
		{ '<C-bs>', ss.move_cursor_previous, desc = 'Move to Previous Plane' },
	},
	{ -- Window
		{ '<C-w>z', '<cmd>WindowsMaximize<CR>', desc = 'Maximize' },
		{
			'<C-w>_',
			'<cmd>WindowsMaximizeVertically<CR>',
			desc = 'Max out the hight',
		},
		{
			'<C-w>|',
			'<cmd>WindowsMaximizeHorizontall<CR>',
			desc = 'Max out the width',
		},
		{ '<C-w>=', '<cmd>WindowsEqualize<CR>', desc = 'Equal high and wide' },
	},
	{ -- Fold overrides
		{ 'zR', require('ufo').openAllFolds, desc = 'Ufo: Open All Folds' },
		{ 'zM', require('ufo').closeAllFolds, desc = 'Ufo: Close All Folds' },
		{
			'zr',
			require('ufo').openFoldsExceptKinds,
			desc = 'Ufo: Open Folds Except Kinds',
		},
		{ 'zm', require('ufo').closeFoldsWith, desc = 'Ufo: Close Folds With' },
	},
	{ -- Git
		{ '<leader>g', group = 'Git' },
		{ '<leader>gs', '<cmd>Neogit<CR>', desc = 'Open Neogit' },
		{ '<leader>gc', '<cmd>Neogit commit<CR>', desc = 'Commit' },
		{ '<leader>gd', '<cmd>Neogit diff<CR>', desc = 'Diffview' },
	},
	{ '<leader>d', group = 'Document', hidden = true },
	-- Leader prefix
	{
		'<leader>b',
		require('dap').toggle_breakpoint,
		desc = 'Debug: Toogle Breakpoint',
	},
	{
		'<leader>B',
		function()
			require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))
		end,
		desc = 'Debug: Set Breakpoint',
	},
	{
		'<leader>e',
		vim.diagnostic.open_float,
		desc = 'Show diagnostic Error messages',
	},
	{
		'<leader>q',
		'<cmd>Trouble qflist<CR>',
		desc = 'Open diagnostic Quickfix list',
	},
	{
		'<leader>l',
		'<cmd>Lazy<cr>',
		desc = 'Open Lazy Plugin Manager',
		icon = '󰒲',
	},
	{ '<leader>m', '<cmd>Mason<cr>', desc = 'Open Mason', icon = '' },
	{ '<leader>h', '<cmd>Alpha<cr>', desc = 'Open Dashboard', icon = '' },
	{ '<leader>o', '<cmd>Oil<cr>', desc = 'Open Oil', icon = '󱁓' },
	{
		'<leader>F',
		function()
			require('conform').format({ async = true, lsp_fallback = true })
		end,
		desc = 'Format buffer',
	},
	{ '<leader><leader>', tsc_builtin.buffers, desc = 'Find existing buffers' },
	{
		'<ledaer>/',
		function()
			-- You can pass additional configuration to Telescope to change the theme, layout, etc.
			tsc_builtin.current_buffer_fuzzy_find(
				require('telescope.themes').get_dropdown({
					winblend = 10,
					previewer = false,
				})
			)
		end,
		desc = 'Fuzzily search in current buffer',
	},
	{
		'<leader>K',
		function()
			local winid = require('ufo').peekFoldedLinesUnderCursor()
			if not winid then
				vim.lsp.buf.hover()
			end
		end,
		desc = 'Ufo: Peek Folded Lines Under Cursor',
		icon = '',
	},
	{ '<Esc>', '<cmd>nohlsearch<cr>', desc = 'Cancel active highlight' },
	-- Leaves the cursor in the same place
	{ 'J', 'mzJ`z', desc = 'Join line' },
	{ '<C-d>', '<C-d>zz' },
	{ '<C-u>', '<C-u>zz' },
	{ 'n', 'nzzzv' },
	{ 'N', 'Nzzzv' },
	{ '<F1>', require('dap').step_into, desc = 'Debug: Step Into' },
	{ '<F2>', require('dap').step_over, desc = 'Debug: Step Over' },
	{ '<F3>', require('dap').step_out, desc = 'Debug: Step Out' },
	{ '<F5>', require('dap').continue, desc = 'Debug: Start/Continue' },
	-- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
	{ '<F7>', require('dapui').toggle, desc = 'Debug: See last session result.' },
	{ '<leader>p', '"_dP', desc = 'Paste (but keep paste data)', mode = 'x' },
	{ '<C-space>', '<C-\\><C-n>', desc = 'Exit terminal mode', mode = 't' },
})

local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

autocmd('TextYankPost', {
	desc = 'Highlight when yanking (copying) text',
	group = augroup('csipa-highlight-yank', { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

autocmd('LspAttach', {
	desc = 'LSP actions',
	group = augroup('csipa-lsp-attach', { clear = true }),
	callback = function(event)
		local map = function(keys, func, desc)
			vim.keymap.set(
				'n',
				keys,
				func,
				{ buffer = event.buf, desc = 'LSP: ' .. desc }
			)
		end

		map('gd', require('telescope.builtin').lsp_definitions, 'Goto Definition')

		map(
			'gI',
			require('telescope.builtin').lsp_implementations,
			'Goto Implementation'
		)

		map(
			'<leader>D',
			require('telescope.builtin').lsp_type_definitions,
			'Type Definition'
		)

		map(
			'<leader>ds',
			require('telescope.builtin').lsp_document_symbols,
			'Document Symbols'
		)

		map(
			'<leader>ws',
			require('telescope.builtin').lsp_dynamic_workspace_symbols,
			'Workspace Symbols'
		)

		map('K', vim.lsp.buf.hover, 'Hover Documentation')

		-- WARN: This is not Goto Definition, this is Goto Declaration.
		--  For example, in C this would take you to the header.
		map('gD', vim.lsp.buf.declaration, 'Goto Declaration')

		-- The following two autocommands are used to highlight references of the
		-- word under your cursor when your cursor rests there for a little while.
		--    See `:help CursorHold` for information about when this is executed
		--
		-- When you move your cursor, the highlights will be cleared (the second autocommand).
		local client = vim.lsp.get_client_by_id(event.data.client_id)
		if client and client.server_capabilities.documentHighlightProvider then
			autocmd({ 'CursorHold', 'CursorHoldI' }, {
				buffer = event.buf,
				callback = vim.lsp.buf.document_highlight,
			})

			autocmd({ 'CursorMoved', 'CursorMovedI' }, {
				buffer = event.buf,
				callback = vim.lsp.buf.clear_references,
			})
		end

		if client and client.supports_method 'textDocument/codeLens' then
			-- NOTE: Added workaround for an issue that showed up in v 0.10 of NeoVim
			-- where codeLens notifications are constantly being sent.
			local silent_refresh = function()
				local _notify = vim.notify
				---@diagnostic disable-next-line:duplicate-set-field
				vim.notify = function()
					-- say nothing
				end
				pcall(vim.lsp.codelens.refresh, { bufnr = event.buf })
				vim.notify = _notify
			end

			-- refresh codelens on TextChanged and InsertLeave as well
			autocmd({ 'TextChanged', 'InsertLeave', 'CursorHold', 'LspAttach' }, {
				buffer = event.buf,
				callback = function()
					-- vim.lsp.codelens.refresh({ bufnr = event.buf })
					silent_refresh()
				end,
			})

			-- trigger codelens refresh
			vim.api.nvim_exec_autocmds('User', { pattern = 'LspAttached' })
		end
	end,
})

local lint_augroup = augroup('lint', { clear = true })
autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
	group = lint_augroup,
	callback = function()
		require('lint').try_lint()
	end,
})

autocmd('FileType', {
	pattern = {
		'checkhealth',
		'git',
		'help',
		'lspinfo',
		'netrw',
		'notify',
		'qf',
		'query',
		'oil',
	},
	callback = function()
		vim.keymap.set(
			'n',
			'q',
			vim.cmd.close,
			{ desc = 'Close the current buffer', buffer = true }
		)
	end,
})

autocmd('TermOpen', {
	desc = 'Remove the numbers and relative numbers from a terminal buffer only',
	group = augroup('csipa-remove-numbers-term', { clear = true }),
	callback = function()
		vim.opt_local.number = false
		vim.opt_local.relativenumber = false
	end,
})

autocmd({ 'User' }, {
	pattern = 'SessionSavePost',
	desc = 'Notify user the session is saved',
	group = augroup('csipa-notify', { clear = true }),
	callback = function()
		vim.notify('Session saved', vim.log.levels.INFO)
	end,
})
