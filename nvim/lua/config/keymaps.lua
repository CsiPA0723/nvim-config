local wk = require('which-key')

wk.register({
	y = { '"+y', 'Copy to clipboard' },
	p = { '"+p', 'Paste from clipboard' },
	P = { '"+P', 'Paste from clipboard' },
}, { mode = '', noremap = true, prefix = '<leader>' })

wk.register({
	l = { '<cmd>Lazy<cr>', 'Open Lazy Plugin Manager' },
}, { mode = 'n', noremap = true, prefix = '<leader>' })
