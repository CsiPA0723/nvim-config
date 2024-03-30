local wk = require('which-key')

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set(
	't',
	'<Esc><Esc>',
	'<C-\\><C-n>',
	{ desc = 'Exit terminal mode' }
)

wk.register({
	c = {
		name = '[C]lipboard',
		d = { '"+d', 'Cut to clipboar[d]' },
		y = { '"+y', 'Cop[y] to clipboard' },
		p = { '"+p', '[p]aste down from clipboard' },
		P = { '"+P', '[P]aste up from clipboard' },
	},
}, { mode = '', noremap = true, prefix = '<leader>' })

wk.register({
	l = { '<cmd>Lazy<cr>', 'Open [L]azy Plugin Manager' },
}, { mode = 'n', noremap = true, prefix = '<leader>' })

wk.register({ -- Diagnostic Keymaps
	['[d'] = { vim.diagnostic.goto_prev, 'Go to previous [D]iagnostic message' },
	[']d'] = { vim.diagnostic.goto_next, 'Go to next [D]iagnostic message' },
	['<leader>e'] = {
		vim.diagnostic.open_float,
		'Show diagnostic [E]rror messages',
	},
	['<leader>q'] = {
		vim.diagnostic.setloclist,
		'Open diagnostic [Q]uickfix list',
	},
}, { mode = 'n', noremap = true })
