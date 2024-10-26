local ss = require('smart-splits')
local tsc_builtin = require('telescope.builtin')
local wk = require('which-key')

wk.add({
	{ --  Move lines
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
		{ '<leader>gg', '<cmd>Neogit<CR>', desc = 'Open Neogit' },
		{ '<leader>gc', '<cmd>Neogit commit<CR>', desc = 'Commit' },
		{ '<leader>gd', '<cmd>Neogit diff<CR>', desc = 'Diffview' },
		{ '<leader>gw', '<cmd>Neogit worktree<CR>', desc = 'Worktree' },
		{ '<leader>gs', '<cmd>Gitsigns stage_hunk<CR>', desc = 'Stage Hunk' },
		{ '<leader>ga', '<cmd>Gitsigns stage_buffer<CR>', desc = 'Stage Buffer' },
		{ '<leader>gb', '<cmd>Gitsigns blame<CR>', desc = 'Open Blame' },
	},
	{ -- Document
		{ '<leader>d', group = 'Document', icon = '󰈙 ' },
		{ '<leader>dy', 'ggVG"+y', desc = 'Yank all' },
		{ '<leader>dP', 'ggVG"+p', desc = 'Paste over' },
		{ '<leader>dD', 'ggVG"+d', desc = 'Delete all' },
		{
			'<leader>dl',
			require('telescope').extensions.licenses.licenses,
			desc = 'Instert License',
		},
	},
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
		'<cmd>Trouble quickfix<CR>',
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
	-- Tries to keep the cursor at the center
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

		-- Actions [[
		map('grr', function()
			require('trouble.api').toggle({
				mode = 'lsp_references',
				focus = true,
			})
		end, 'Reference(s)')

		map('gri', function()
			require('trouble.api').toggle({
				mode = 'lsp_implementations',
				focus = true,
			})
		end, 'Implementation(s)')

		map('grd', function()
			require('trouble.api').toggle({
				mode = 'lsp_definitions',
				focus = true,
			})
		end, 'Definition')

		map('grD', function()
			require('trouble.api').toggle({
				mode = 'lsp_declarations',
				focus = true,
			})
		end, 'Declaration')

		map('grt', function()
			require('trouble.api').toggle({
				mode = 'lsp_type_definitions',
				focus = true,
			})
		end, 'Type Definition(s)')

		map('grn', vim.lsp.buf.rename, 'Rename')
		map('gra', vim.lsp.buf.code_action, 'Code Action')
		-- ]]

		-- Document [[
		map('<leader>ds', function()
			require('trouble.api').toggle({
				mode = 'lsp_document_symbols',
				focus = false,
				open_no_results = true,
				win = { position = 'right', relative = 'editor', type = 'split' },
			})
		end, 'Document Symbols')
		-- ]]

		-- Workspace [[
		map(
			'<leader>wS',
			require('telescope.builtin').lsp_dynamic_workspace_symbols,
			'Workspace Symbols'
		)

		map('<leader>wl', function()
			require('trouble.api').toggle({
				mode = 'lsp',
				focus = false,
				open_no_results = true,
				win = { position = 'left', relative = 'editor', type = 'split' },
			})
		end, 'Definitions / Referencies / ...')
		-- ]]

		map('K', vim.lsp.buf.hover, 'Hover Documentation')

		local client = vim.lsp.get_client_by_id(event.data.client_id)

		-- INFO: The following two autocommands are used to highlight references of the
		-- word under your cursor when your cursor rests there for a little while.
		-- When you move your cursor, the highlights will be cleared (the second autocommand).
		if client and client.server_capabilities.documentHighlightProvider then
			local group = augroup('highlight-references', { clear = true })
			autocmd({ 'CursorHold', 'CursorHoldI' }, {
				group = group,
				buffer = event.buf,
				callback = vim.lsp.buf.document_highlight,
			})

			autocmd({ 'CursorMoved', 'CursorMovedI' }, {
				group = group,
				buffer = event.buf,
				callback = vim.lsp.buf.clear_references,
			})
		end

		if client and client.supports_method 'textDocument/codeLens' then
			-- refresh codelens on TextChanged and InsertLeave as well
			autocmd({ 'TextChanged', 'InsertLeave', 'CursorHold', 'LspAttach' }, {
				buffer = event.buf,
				callback = function()
					vim.lsp.codelens.refresh({ bufnr = event.buf })
				end,
			})

			-- trigger codelens refresh
			vim.api.nvim_exec_autocmds('User', { pattern = 'LspAttached' })
		end
	end,
})

autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
	group = augroup('lint', { clear = true }),
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
	},
	group = augroup('csipa-quick-quit', { clear = true }),
	callback = function()
		wk.add({ 'q', vim.cmd.close, desc = 'Close active buffer', buffer = true })
	end,
})

autocmd('FileType', {
	pattern = { 'help' },
	group = augroup('csipa-help', { clear = true }),
	callback = function()
		vim.opt_local.colorcolumn = ''
	end,
})

autocmd('TermOpen', {
	desc = 'Disable some featuers in a terminal buffer',
	group = augroup('csipa-term-open', { clear = true }),
	callback = function()
		vim.opt_local.number = false
		vim.opt_local.relativenumber = false
		vim.opt_local.colorcolumn = ''
	end,
})

local session_group = augroup('csipa-session', { clear = true })

autocmd({ 'User' }, {
	pattern = 'SessionSavePost',
	desc = 'Notify user the session is saved',
	group = session_group,
	callback = function()
		vim.notify(
			vim.fn.getcwd(),
			vim.log.levels.INFO,
			{ group = 'session', annote = 'Saved' }
		)
	end,
})

autocmd({ 'User' }, {
	pattern = 'SessionLoadPre',
	desc = 'Clear lsps before loading new session',
	group = session_group,
	callback = function()
		vim.lsp.stop_client(vim.lsp.get_clients(), true)
	end,
})

autocmd({ 'User' }, {
	pattern = 'SessionLoadPost',
	desc = 'Notify user the session is loaded and start lsps',
	group = session_group,
	callback = function()
		vim.fn.timer_start(1000, function()
			-- HACK: This is a workaround for the lsp not starting
			-- autmatically when loading another session
			vim.cmd('edit')
			vim.notify(
				vim.fn.getcwd(),
				vim.log.levels.INFO,
				{ group = 'session', annote = 'Loaded', key = 'session_load' }
			)
		end)
		vim.notify(
			vim.fn.getcwd(),
			vim.log.levels.INFO,
			{ group = 'session', annote = 'Loading...', key = 'session_load' }
		)
	end,
})
