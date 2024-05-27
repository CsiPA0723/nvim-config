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
		name = 'Code',
		d = { '"+d', 'Clip: Delete' },
		y = { '"+y', 'Clip: Copy' },
		p = { '"+p', 'Clip: Paste' },
	},
}, { mode = '', noremap = true, prefix = '<leader>' })

wk.register({
	l = { '<cmd>Lazy<cr>', 'Open Lazy Plugin Manager' },
}, { mode = 'n', noremap = true, prefix = '<leader>' })
