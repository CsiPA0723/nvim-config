local wk = require('which-key')

wk.register({
	['J'] = { ":m '>+1<cr>gv=gv", 'Move selected down' },
	['K'] = { ":m '<-2<cr>gv=gv", 'Move selected up' },
}, { mode = 'v', noremap = true })

wk.register({
	['<leader>'] = {
		['l'] = { '<cmd>Lazy<cr>', 'Open Lazy Plugin Manager' },
		['m'] = { '<cmd>Mason<cr>', 'Open Mason' },
		['h'] = { '<cmd>Alpha<cr>', 'Open Dashboard' },
		['o'] = { '<cmd>Oil<cr>', 'Open Oil' },
		['g'] = { '<cmd>LazyGit<cr>', 'Open LazyGit' },
		['c'] = {
			name = 'Code',
			p = { '"+p', 'Clip: Paste', mode = { 'n', 'v' } },
			d = { '"+d', 'Clip: Delete', mode = { 'n', 'v' } },
			y = { '"+y', 'Clip: Copy', mode = { 'n', 'v' } },
			Y = { '"+Y', 'Clip: Copy' },
		},
		['F'] = {
			function()
				require('conform').format({ async = true, lsp_fallback = true })
			end,
			'Format buffer',
		},
	},
	['C-w'] = {
		desc = 'window',
		z = { '<cmd>WindowsMaximize<CR>', 'Maximize' },
		['_'] = { '<cmd>WindowsMaximizeVertically<CR>', 'Max out the hight' },
		['|'] = { '<cmd>WindowsMaximizeHorizontall<CR>', 'Max out the width' },
		['='] = { '<cmd>WindowsEqualize<CR>', 'Equal high and wide' },
	},
	['<Esc>'] = { '<cmd>nohlsearch<cr>', 'Cancel active highlight' },
	['J'] = { 'mzJ`z', 'Join line' },
	['<C-d>'] = '<C-d>zz',
	['<C-u>'] = '<C-u>zz',
	['n'] = 'nzzzv',
	['N'] = 'Nzzzv',
	['Q'] = '<nop>',
	['<F1>'] = {
		function()
			require('precognition').toggle()
		end,
		'Toggle Precognition',
	},
	['ű'] = {
		function()
			require('precognition').peek()
		end,
		'Peek Precognition',
	},
}, { mode = 'n', noremap = true })

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
			-- (ss) Added workaround for an issue that showed up in v 0.10 of NeoVim
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

wk.register({ -- Diagnostic Keymaps
	['[d'] = {
		function()
			vim.diagnostic.jump({ count = -1 })
		end,
		'Go to previous Diagnostic message',
	},
	[']d'] = {
		function()
			vim.diagnostic.jump({ count = 1 })
		end,
		'Go to next Diagnostic message',
	},
	['<leader>e'] = {
		vim.diagnostic.open_float,
		'Show diagnostic Error messages',
	},
	['<leader>q'] = {
		vim.diagnostic.setloclist,
		'Open diagnostic Quickfix list',
	},
}, { mode = 'n', noremap = true })

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
