local ss = require('smart-splits')
local tsc_builtin = require('telescope.builtin')
local wk = require('which-key')

wk.register({
	['J'] = { ":m '>+1<cr>gv=gv", 'Move selected down' },
	['K'] = { ":m '<-2<cr>gv=gv", 'Move selected up' },
}, { mode = 'v', noremap = true })

wk.register({
	['<leader>'] = {
		['a'] = { -- swapping buffers between windows
			name = 'Swap Buffer',
			h = { ss.swap_buf_left, 'Swap to Left Buffer' },
			j = { ss.swap_buf_down, 'Swap to Down Buffer' },
			k = { ss.swap_buf_up, 'Swap to Up Buffer' },
			l = { ss.swap_buf_right, 'Swap to Right Buffer' },
		},
		['c'] = { -- Code
			name = 'Code',
			p = { '"+p', 'Clip: Paste', mode = { 'n', 'v' } },
			d = { '"+d', 'Clip: Delete', mode = { 'n', 'v' } },
			y = { '"+y', 'Clip: Copy', mode = { 'n', 'v' } },
			Y = { '"+Y', 'Clip: Copy' },
		},
		['s'] = { -- Search
			name = 'Search',
			h = { tsc_builtin.help_tags, 'Help' },
			k = { tsc_builtin.keymaps, 'Keymaps' },
			f = { tsc_builtin.find_files, 'Files' },
			t = { tsc_builtin.git_files, 'Git' },
			s = { tsc_builtin.builtin, 'Select Telescope' },
			w = { tsc_builtin.grep_string, 'Current Word' },
			g = { tsc_builtin.live_grep, 'Grep' },
			d = { tsc_builtin.diagnostics, 'Diagnostics' },
			r = { tsc_builtin.resume, 'Resume' },
			z = { require('telescope').extensions.zoxide.list, 'Zoxide list' },
			b = {
				function()
					require('telescope').extensions.file_browser.file_browser(
						require('telescope.themes').get_dropdown({
							winblend = 10,
						})
					)
				end,
				'Browser',
			},
			p = {
				require('telescope').extensions.pomodori.timers,
				'Pomodori Timers',
			},
			['<leader>'] = { tsc_builtin.oldfiles, 'Search Recent Files' },
			['/'] = {
				function()
					tsc_builtin.live_grep({
						grep_open_files = true,
						prompt_title = 'Live Grep in Open Files',
					})
				end,
				'in Open Files',
			},
			n = {
				function()
					tsc_builtin.find_files({ cwd = vim.fn.stdpath('config') })
				end,
				'Neovim files',
			},
		},
		['n'] = { -- Sessions
			name = 'Sessions',
			s = { require('resession').save, 'Save' },
			l = { require('resession').load, 'Load' },
			d = { require('resession').delete, 'Delete' },
		},
		['b'] = { require('dap').toggle_breakpoint, 'Debug: Toogle Breakpoint' },
		['B'] = {
			function()
				require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))
			end,
			'Debug: Set Breakpoint',
		},
		['e'] = {
			vim.diagnostic.open_float,
			'Show diagnostic Error messages',
		},
		['q'] = {
			vim.diagnostic.setloclist,
			'Open diagnostic Quickfix list',
		},
		['l'] = { '<cmd>Lazy<cr>', 'Open Lazy Plugin Manager' },
		['m'] = { '<cmd>Mason<cr>', 'Open Mason' },
		['h'] = { '<cmd>Alpha<cr>', 'Open Dashboard' },
		['o'] = { '<cmd>Oil<cr>', 'Open Oil' },
		['g'] = { '<cmd>LazyGit<cr>', 'Open LazyGit' },
		['F'] = {
			function()
				require('conform').format({ async = true, lsp_fallback = true })
			end,
			'Format buffer',
		},
		['<leader>'] = { tsc_builtin.buffers, 'Find existing buffers' },
		['/'] = {
			function()
				-- You can pass additional configuration to Telescope to change the theme, layout, etc.
				tsc_builtin.current_buffer_fuzzy_find(
					require('telescope.themes').get_dropdown({
						winblend = 10,
						previewer = false,
					})
				)
			end,
			'Fuzzily search in current buffer',
		},
		['K'] = {
			function()
				local winid = require('ufo').peekFoldedLinesUnderCursor()
				if not winid then
					vim.lsp.buf.hover()
				end
			end,
			'Ufo: Peek Folded Lines Under Cursor',
		},
	},
	['<C-w>'] = {
		desc = 'window',
		z = { '<cmd>WindowsMaximize<CR>', 'Maximize' },
		['_'] = { '<cmd>WindowsMaximizeVertically<CR>', 'Max out the hight' },
		['|'] = { '<cmd>WindowsMaximizeHorizontall<CR>', 'Max out the width' },
		['='] = { '<cmd>WindowsEqualize<CR>', 'Equal high and wide' },
	},
	['<z>'] = {
		R = { require('ufo').openAllFolds, 'Ufo: Open All Folds' },
		M = { require('ufo').closeAllFolds, 'Ufo: Close All Folds' },
		r = {
			require('ufo').openFoldsExceptKinds,
			'Ufo: Open Folds Except Kinds',
		},
		m = { require('ufo').closeFoldsWith, 'Ufo: Close Folds With' },
	},
	['<Esc>'] = { '<cmd>nohlsearch<cr>', 'Cancel active highlight' },
	['J'] = { 'mzJ`z', 'Join line' },
	['<C-d>'] = '<C-d>zz',
	['<C-u>'] = '<C-u>zz',
	['n'] = 'nzzzv',
	['N'] = 'Nzzzv',
	['Q'] = '<nop>',
	['<F1>'] = { require('dap').step_into, 'Debug: Step Into' },
	['<F2>'] = { require('dap').step_over, 'Debug: Step Over' },
	['<F3>'] = { require('dap').step_out, 'Debug: Step Out' },
	['<F4>'] = {
		function()
			require('precognition').toggle()
		end,
		'Toggle Precognition',
	},
	['<F5>'] = { require('dap').continue, 'Debug: Start/Continue' },
	-- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
	['<F7>'] = { require('dapui').toggle, 'Debug: See last session result.' },
	['ű'] = {
		function()
			require('precognition').peek()
		end,
		'Peek Precognition',
	},
	['<C-ö>'] = {
		function()
			if vim.api.nvim_win_get_width(0) > 95 then
				require('toggleterm').toggle(1, nil, nil, 'vertical', nil)
			else
				require('toggleterm').toggle(1, nil, nil, 'horizontal', nil)
			end
		end,
		'Toggle Terminal',
	},
	-- recommended mappings
	-- resizing splits
	-- these keymaps will also accept a range,
	-- for example `10<A-h>` will `resize_left` by `(10 * config.default_amount)`
	-- moving between splits
	['<A-h>'] = { ss.resize_left, 'Resize Left' },
	['<A-j>'] = { ss.resize_down, 'Resize Down' },
	['<A-k>'] = { ss.resize_up, 'Resize Up' },
	['<A-l>'] = { ss.resize_right, 'Resize Right' },
	['<C-h>'] = { ss.move_cursor_left, 'Move to Left Plane' },
	['<C-j>'] = { ss.move_cursor_down, 'Move to Down Plane' },
	['<C-k>'] = { ss.move_cursor_up, 'Move to Up Plane' },
	['<C-l>'] = { ss.move_cursor_right, 'Move to Rigth Plane' },
	['<C-bs>'] = { ss.move_cursor_previous, 'Move to Previous Plane' },
}, { mode = 'n', noremap = true })

-- BUG: It does not work, only if typed in
wk.register({
	['<leader>p'] = { '"_dP', desc = 'Paste (but keep paste data)' },
}, { mode = 'x', noremap = true })

wk.register({
	['<Esc><Esc>'] = { '<C-\\><C-n>', 'Exit terminal mode' },
}, { mode = 't', noremap = true })

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

		map('gr', require('telescope.builtin').lsp_references, 'Goto References')

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

		map('<leader>rn', vim.lsp.buf.rename, 'Rename')

		map('<leader>ca', vim.lsp.buf.code_action, 'Code Action')

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
