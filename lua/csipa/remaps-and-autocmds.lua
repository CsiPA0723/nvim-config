local wk = require('which-key')

wk.add({ -- Clipboard
	{ '<leader>c', group = 'Clipboard', icon = '󱓦' },
	{ '<leader>cp', '"+p', desc = 'Paste down', mode = { 'n', 'v' } },
	{ '<leader>cP', '"+P', desc = 'Paste up', mode = { 'n', 'v' } },
	{ '<leader>cd', '"+d', desc = 'Delete', mode = { 'n', 'v' } },
	{ '<leader>cy', '"+y', desc = 'Copy', mode = { 'n', 'v' } },
	{ '<leader>cY', '"+Y', desc = 'Copy' },
})

wk.add({ -- Buffer
	{ '<leader>b', group = 'Buffer' },
	{ '<leader>bd', Snacks.bufdelete.delete, desc = 'Delete buffer' },
	{ '<leader>bD', Snacks.bufdelete.all, desc = 'Delete ALL buffer' },
})

wk.add({ -- Search
	{ '<leader>s', group = 'Search' },
	{ '<leader>sh', Snacks.picker.help, desc = 'Help' },
	{ '<leader>sk', Snacks.picker.keymaps, desc = 'Keymaps' },
	{ '<leader>sf', Snacks.picker.files, desc = 'Files' },
	{ '<leader>st', Snacks.picker.git_files, desc = 'Git' },
	{ '<leader>sw', Snacks.picker.grep_word, desc = 'Current Word' },
	{ '<leader>sg', Snacks.picker.grep, desc = 'Grep' },
	{ '<leader>sd', Snacks.picker.diagnostics, desc = 'Diagnostics' },
	{ '<leader>sr', Snacks.picker.resume, desc = 'Resume' },
	{ '<leader>se', Snacks.picker.explorer, desc = 'Explorer' },
	{ '<leader>su', Snacks.picker.undo, desc = 'Undotree' },
	{ '<leader>si', Snacks.picker.icons, desc = 'Nerd Icon Search' },
	{ '<leader>sz', Snacks.picker.zoxide, desc = 'Zoxide list' },
	{
		'<leader>s<leader>',
		Snacks.picker.recent,
		desc = 'Search Recent Files',
	},
	{ '<leader>s/', Snacks.picker.grep_buffers, desc = 'in Open Files' },
	{
		'<leader>sn',
		function()
			Snacks.picker.files({ cwd = vim.fn.stdpath('config') })
		end,
		desc = 'Neovim files',
	},
})

wk.add({ -- Workspace
	{ '<leader>w', group = 'Workspace', icon = '' },
	{
		'<leader>wt',
		'<cmd>Trouble todo toggle focus=true win.position=left win.relative=editor<CR>',
		desc = 'Open TODO list',
		icon = '',
	},
})

wk.add({ -- Git
	{ '<leader>g', group = 'Git' },
	{ '<leader>gg', '<cmd>Neogit<CR>', desc = 'Open Neogit' },
	{ '<leader>gc', '<cmd>Neogit commit<CR>', desc = 'Commit' },
	{ '<leader>gd', '<cmd>Neogit diff<CR>', desc = 'Diffview' },
	{ '<leader>gw', '<cmd>Neogit worktree<CR>', desc = 'Worktree' },
	{ '<leader>gs', '<cmd>Gitsigns stage_hunk<CR>', desc = 'Stage Hunk' },
	{ '<leader>ga', '<cmd>Gitsigns stage_buffer<CR>', desc = 'Stage Buffer' },
	{ '<leader>gB', '<cmd>Gitsigns blame<CR>', desc = 'Blame File' },
	{
		'<leader>gb',
		function()
			Snacks.git.blame_line({ count = 3 })
		end,
		desc = 'Blame Line',
	},
	{ '<leader>gl', Snacks.lazygit.open, desc = 'Lazygit' },
})

wk.add({ -- Document
	{ '<leader>d', group = 'Document', icon = '󰈙 ' },
	{ '<leader>dy', 'ggVG"+y', desc = 'Yank all lines' },
	{ '<leader>dP', 'ggVG"+p', desc = 'Paste over all lines' },
	{ '<leader>dD', 'ggVG"+d', desc = 'Delete all lines' },
	{
		'<leader>dl',
		function()
			Snacks.picker.pick({
				source = 'files',
				search = 'license(.md|.adoc|.txt)?$',
				confirm = function(self, item)
					self:action('close')
					---@type List
					local file_lines = vim.fn.readfile(item.file)
					table.insert(file_lines, '\n')
					local line_count = vim.tbl_count(file_lines)
					local cursor_previus_pos = vim.api.nvim_win_get_cursor(0)
					cursor_previus_pos[1] = line_count + cursor_previus_pos[1]
					local comment_api = require('Comment.api')
					local comment_config = require('Comment.config'):get()

					vim.api.nvim_win_set_cursor(0, { 1, 0 })
					vim.api.nvim_paste(table.concat(file_lines, '\n'), false, -1)
					vim.api.nvim_buf_set_mark(0, '<', 1, 0, {})
					vim.api.nvim_buf_set_mark(0, '>', line_count - 1, 0, {})
					comment_api.comment.blockwise('V', comment_config)
					vim.api.nvim_win_set_cursor(0, cursor_previus_pos)
					vim.api.nvim_feedkeys(
						vim.api.nvim_replace_termcodes('<cmd>write<CR>', true, false, true),
						'm',
						false
					)
					return true
				end,
			})
		end,
		desc = 'Instert License',
	},
})

wk.add({ -- Kulala
	cond = function()
		return vim.bo.filetype == 'http' or vim.bo.filetype == 'rest'
	end,
	buffer = true,
	{ '[h', require('kulala').jump_prev, desc = 'Jumpt to prev HTTP request' },
	{ ']h', require('kulala').jump_next, desc = 'Jumpt to next HTTP request' },
	{ '<leader>r', require('kulala').run, desc = 'Run HTTP request (kulala)' },
})

wk.add({ -- Debug
	{ '<F1>', require('dap').step_into, desc = 'Debug: Step Into' },
	{ '<F2>', require('dap').step_over, desc = 'Debug: Step Over' },
	{ '<F3>', require('dap').step_out, desc = 'Debug: Step Out' },
	{ '<F5>', require('dap').continue, desc = 'Debug: Start/Continue' },
	-- NOTE: Toggle to see last session result.
	-- Without this, you can't see session output in case of unhandled exception.
	{ '<F7>', require('dapui').toggle, desc = 'Debug: See last session result' },
})

-- Leader prefix
wk.add({
	{
		'<leader>t',
		function()
			if _G.todo_win == nil then
				_G.todo_win = Snacks.win.new({
					file = vim.fn.expand('~/Documents/todos.md'),
					minimal = false,
					backdrop = false,
					width = 0.9,
					height = 0.9,
					zindex = 50,
					resize = true,
					fixbuf = true,
					border = 'rounded',
					bo = { modifiable = true },
					keys = { q = 'close' },
				})
			else
				_G.todo_win:toggle()
			end
		end,
		desc = 'Edit TODOs',
		icon = '',
	},
	{
		'<leader>e',
		vim.diagnostic.open_float,
		desc = 'Show diagnostic Error messages',
	},
	{
		'<leader>P',
		'<cmd>Patterns explain<CR>',
		desc = 'Explain pattern under cursor',
		icon = { icon = '', color = 'orange' },
	},
	{
		'<leader>p',
		'<cmd>Patterns hover<CR>',
		desc = 'See pattern description',
		icon = { icon = '', color = 'orange' },
	},
	{
		'<leader>q',
		'<cmd>Trouble qflist toggle<CR>',
		desc = 'Open diagnostic Quickfix list',
		icon = { icon = '󱖫', color = 'green' },
	},
	{
		'<leader>l',
		'<cmd>Trouble loclist toggle<CR>',
		desc = 'Location list',
		icon = { icon = '󱖫', color = 'green' },
	},
	{
		'<leader>L',
		'<cmd>Lazy<cr>',
		desc = 'Open Lazy Plugin Manager',
		icon = '󰒲',
	},
	{ '<leader>M', '<cmd>Mason<cr>', desc = 'Open Mason', icon = '' },
	{ '<leader>h', Snacks.dashboard.open, desc = 'Open Dashboard', icon = '' },
	{ '<leader>o', '<cmd>Oil<cr>', desc = 'Open Oil', icon = '󱁓' },
	{
		'<leader>F',
		function()
			require('conform').format({ async = true, lsp_fallback = true })
		end,
		desc = 'Format buffer',
	},
	{
		'<leader><leader>',
		Snacks.picker.buffers,
		desc = 'Find existing buffers',
	},
	{
		'<ledaer>/',
		Snacks.picker.lines,
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
})

wk.add({ -- Misc
	{ --  Move lines
		mode = 'v',
		{ 'J', ":m '>+1<cr>gv=gv", desc = 'Move selected down' },
		{ 'K', ":m '<-2<cr>gv=gv", desc = 'Move selected up' },
	},
	{ '<Esc>', '<cmd>nohlsearch<cr>', desc = 'Cancel active highlight' },
	-- Leaves the cursor in the same place
	{ 'J', 'mzJ`z', desc = 'Join line' },
	-- Tries to keep the cursor at the center
	{ '<C-d>', '<C-d>zz' },
	{ '<C-u>', '<C-u>zz' },
	{ 'n', 'nzzzv' },
	{ 'N', 'Nzzzv' },
	{ '<leader>p', '"_dP', desc = 'Paste (but keep paste data)', mode = 'x' },
	{ '<C-space>', '<C-\\><C-n>', desc = 'Exit terminal mode', mode = 't' },
})

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
		map(
			'grr',
			'<cmd>Trouble lsp_references toggle focus=true<CR>',
			'Reference(s)'
		)

		map(
			'gri',
			'<cmd>Trouble lsp_implementations toggle focus=true<CR>',
			'Implementation(s)'
		)

		map(
			'grd',
			'<cmd>Trouble lsp_definitions toggle focus=true<CR>',
			'Definition'
		)

		map(
			'grD',
			'<cmd>Trouble lsp_declarations toggle focus=true<CR>',
			'Declaration'
		)

		map(
			'grt',
			'<cmd>Trouble lsp_type_definitions toggle focus=true<CR>',
			'Type Definition(s)'
		)

		map('grn', vim.lsp.buf.rename, 'Rename')
		map('gra', vim.lsp.buf.code_action, 'Code Action')
		-- ]]

		-- Document [[
		map(
			'<leader>ds',
			'<cmd>Trouble lsp_document_symbols toggle focus=false win.position=left win.relative=editor win.type=split<CR>',
			'Document Symbols'
		)
		-- ]]

		-- Workspace [[
		---@diagnostic disable-next-line: undefined-field
		map('<leader>wS', Snacks.picker.lsp_workspace_symbols, 'Workspace Symbols')

		map(
			'<leader>wl',
			'<cmd>Trouble lsp toggle focus=false win.position=left win.relative=editor win.type=split<CR>',
			'Definitions / Referencies / ...'
		)
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

		if
			client and client:supports_method('textDocument/codeLens', event.buf)
		then
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
		'gitsigns-blame',
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
	pattern = 'PersistenceSavePost',
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
	pattern = 'PersistenceLoadPre',
	desc = 'Clear lsps before loading new session',
	group = session_group,
	callback = function()
		vim.lsp.stop_client(vim.lsp.get_clients(), true)
		vim.notify(
			vim.fn.getcwd(),
			vim.log.levels.INFO,
			{ group = 'session', annote = 'Loading...', key = 'session_load' }
		)
	end,
})

autocmd({ 'User' }, {
	pattern = 'PersistenceLoadPost',
	desc = 'Notify user the session is loaded and start lsps',
	group = session_group,
	callback = function()
		vim.notify(
			vim.fn.getcwd(),
			vim.log.levels.INFO,
			{ group = 'session', annote = 'Loaded', key = 'session_load' }
		)
	end,
})

autocmd('DirChanged', {
	pattern = '*',
	group = augroup('dashboard_on_dir_change', { clear = true }),
	callback = function()
		if Snacks.dashboard.status.opened then
			Snacks.dashboard.update()
		end
	end,
})
