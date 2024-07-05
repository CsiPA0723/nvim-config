--- @param sc string
--- @param txt string
--- @param command string|function
--- @param options? table
local function button(sc, txt, command, options)
	local opts = {
		position = 'center',
		shortcut = '[' .. sc .. '] ',
		cursor = 47,
		width = 50,
		keymap = {
			'n',
			sc,
			command,
			{ noremap = true, silent = true, nowait = true },
		},
		hl = { { 'Title', 0, 3 }, { 'Text', 3, 100 } },
		align_shortcut = 'right',
		hl_shortcut = {
			{ 'Operator', 0, 1 },
			{ 'Number', 1, #sc + 1 },
			{ 'Operator', #sc + 1, #sc + 2 },
		},
		shrink_margin = false,
	}

	opts = vim.tbl_extend('force', opts, options or {})

	local function on_press()
		if type(command) == 'string' then
			local key =
				vim.api.nvim_replace_termcodes(command .. '<Ignore>', true, false, true)
			vim.api.nvim_feedkeys(key, 't', false)
		elseif type(command) == 'function' then
			command()
		else
			error('Command argument must be a string or a function!', 2)
		end
	end

	return {
		type = 'button',
		val = txt,
		on_press = on_press,
		opts = opts,
	}
end

return {
	{
		'goolord/alpha-nvim',
		dependencies = { 'nvim-tree/nvim-web-devicons' },
		config = function()
			local alpha = require('alpha')
			local resession = require('resession')

			local header_neovim = {
				[[ ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ]],
				[[ ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ]],
				[[ ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ]],
				[[ ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ]],
				[[ ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ]],
				[[ ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ]],
			}

			local header_neovide = {
				[[ ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗██████╗ ███████╗ ]],
				[[ ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║██╔══██╗██╔════╝ ]],
				[[ ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██║  ██║█████╗   ]],
				[[ ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║  ██║██╔══╝   ]],
				[[ ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██████╔╝███████╗ ]],
				[[ ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═════╝ ╚══════╝ ]],
			}

			local theme = {
				header = {
					type = 'group',
					val = {
						{ type = 'padding', val = 2 },
						{
							type = 'text',
							val = vim.g.neovide and header_neovide or header_neovim,
							opts = { position = 'center', hl = 'Type' },
						},
					},
				},
				buttons = {
					type = 'group',
					val = {
						button('e', '  New file', '<cmd>ene <BAR> startinsert <CR>'),
						button('s', '  Sessions', resession.load),
						button(
							'o',
							'  Recently opened files',
							require('telescope.builtin').oldfiles
						),
						button(
							'f',
							'󰈞  Find file',
							require('telescope.builtin').find_files
						),
						button('b', '󰉋  Browse Files', function()
							require('telescope').extensions.file_browser.file_browser(
								require('telescope.themes').get_dropdown({
									winblend = 10,
								})
							)
						end),
						button(
							'g',
							'󰊄  Live Grep',
							require('telescope.builtin').live_grep
						),
						button('c', '  Configuration', function()
							require('telescope.builtin').find_files({
								cwd = vim.fn.stdpath('config'),
							})
						end),
						button('l', '󰒲  Lazy Plugin Manager', '<cmd>Lazy<CR>'),
						button('m', '󰒍  Mason LSP Manager', '<cmd>Mason<CR>'),
						button('r', '  Restore Last Session', function()
							resession.load('last', { attach = false })
						end),
						button(
							'q',
							'󰅚  Quit',
							':qa<CR>',
							{ hl = { { 'Error', 0, 3 }, { 'Text', 3, 100 } } }
						),
					},
					opts = { spacing = 1, position = 'center' },
				},
			}

			local config = {
				layout = {
					theme.header,
					{ type = 'padding', val = 2 },
					theme.buttons,
				},
				opts = {
					margin = 3,
					redraw_on_resize = true,
					setup = function()
						vim.api.nvim_create_autocmd('DirChanged', {
							pattern = '*',
							group = 'alpha_temp',
							callback = function()
								require('alpha').redraw()
								vim.cmd('AlphaRemap')
							end,
						})
					end,
				},
			}

			alpha.setup(config)

			local alpha_on_empty =
				vim.api.nvim_create_augroup('alpha_on_empty', { clear = true })
			vim.api.nvim_create_autocmd('User', {
				pattern = 'BDeletePost*',
				group = alpha_on_empty,
				callback = function(event)
					local fallback_on_empty = vim.bo.buftype == ''
						and vim.o.filetype == ''

					if fallback_on_empty then
						require('resession').detach()
						vim.cmd('Alpha')
						vim.cmd(event.buf .. 'bwipeout!')
					end
				end,
			})
		end,
	},
}
