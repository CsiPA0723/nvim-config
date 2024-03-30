return {
	{
		'mrjones2014/smart-splits.nvim',
		config = function()
			local wk = require('which-key')
			local ss = require('smart-splits')

			ss.setup()

			-- recommended mappings
			-- resizing splits
			-- these keymaps will also accept a range,
			-- for example `10<A-h>` will `resize_left` by `(10 * config.default_amount)`
			-- moving between splits

			wk.register({
				['<A-h>'] = { ss.resize_left, 'Resize Left' },
				['<A-j>'] = { ss.resize_down, 'Resize Down' },
				['<A-k>'] = { ss.resize_up, 'Resize Up' },
				['<A-l>'] = { ss.resize_right, 'Resize Right' },
				['<C-h>'] = { ss.move_cursor_left, 'Move to Left Plane' },
				['<C-j>'] = { ss.move_cursor_down, 'Move to Down Plane' },
				['<C-k>'] = { ss.move_cursor_up, 'Move to Up Plane' },
				['<C-l>'] = { ss.move_cursor_right, 'Move to Rigth Plane' },
				['<C-bs>'] = { ss.move_cursor_previous, 'Move to Previous Plane' },
			}, { noremap = true })

			wk.register({
				-- swapping buffers between windows
				['b'] = {
					name = 'Swap [B]uffer',
					h = { ss.swap_buf_left, 'Swap to Left Buffer' },
					j = { ss.swap_buf_down, 'Swap to Down Buffer' },
					k = { ss.swap_buf_up, 'Swap to Up Buffer' },
					l = { ss.swap_buf_right, 'Swap to Right Buffer' },
				},
			}, { noremap = true, prefix = '<leader>' })
		end,
	},
}
