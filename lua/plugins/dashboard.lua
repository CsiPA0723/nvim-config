return {
	{
		'goolord/alpha-nvim',
		dependencies = { 'nvim-tree/nvim-web-devicons' },
		config = function()
			local alpha = require('alpha')
			local startify = require('alpha.themes.startify')
			local resession = require('resession')
			local mru = startify.mru
			local button = startify.button

			local last_session = nil

			local file = io.open(vim.fn.stdpath('data') .. '/last.json', 'r')
			if file ~= nil then
				local str = file:read('*a')
				local json = vim.json.decode(str)
				last_session = json.lastSession
				file:close()
			end

			vim.api.nvim_create_user_command('ReSessionLoad', function(o)
				resession.load(o.args)
			end, { nargs = 1 })

			vim.api.nvim_create_user_command('RestoreLastReSession', function()
				resession.load('last', { attach = false })
			end, { nargs = 0 })

			local function mru_cwd_title()
				return 'MRU ' .. vim.fn.getcwd()
			end

			local my_header = {
				[[ ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ]],
				[[ ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ]],
				[[ ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ]],
				[[ ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ]],
				[[ ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ]],
				[[ ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ]],
			}

			local theme = {
				header = {
					type = 'group',
					val = {
						{ type = 'padding', val = 2 },
						{
							type = 'text',
							val = my_header,
							opts = { hl = 'Type', shrink_margin = false },
						},
					},
				},
				top_buttons = {
					type = 'group',
					val = {
						{ type = 'padding', val = 2 },
						button('e', 'New file', '<cmd>ene <BAR> startinsert <CR>'),
						button(
							's',
							string.format('Last Session (%s)', last_session or 'None'),
							last_session ~= nil
									and string.format('<cmd>ReSessionLoad %s<CR>', last_session)
								or nil
						),
					},
				},
				managers = {
					type = 'group',
					opts = { priority = 1 },
					val = {
						{ type = 'padding', val = 1 },
						{
							type = 'text',
							val = 'Managers',
							opts = { hl = 'SpecialComment' },
						},
						{ type = 'padding', val = 1 },
						button('l', 'Lazy Plugin Manager', '<cmd>Lazy<CR>'),
						button('m', 'Mason LSP Manager', '<cmd>Mason<CR>'),
					},
				},
				sessions = {
					type = 'group',
					val = {
						{ type = 'padding', val = 1 },
						{
							type = 'text',
							val = 'Sessions',
							opts = { hl = 'SpecialComment' },
						},
						{ type = 'padding', val = 1 },
						{
							type = 'group',
							val = function()
								local list = {
									table.unpack(
										vim.tbl_filter(function(str)
											return str ~= 'last'
										end, resession.list()),
										1,
										5
									),
								}
								local sessions = {}

								for i, value in ipairs(list) do
									sessions[i] = button(
										tostring(i - 1),
										value,
										string.format('<cmd>ReSessionLoad %s<CR>', tostring(value))
									)
								end

								return sessions
							end,
						},
					},
				},
				mru_cwd = {
					type = 'group',
					val = {
						{ type = 'padding', val = 1 },
						{
							type = 'text',
							val = mru_cwd_title,
							opts = { hl = 'SpecialComment', shrink_margin = false },
						},
						{ type = 'padding', val = 1 },
						{
							type = 'group',
							val = function()
								return { mru(5, vim.fn.getcwd(), 5) }
							end,
							opts = { shrink_margin = false },
						},
					},
				},
				mru = {
					type = 'group',
					val = {
						{ type = 'padding', val = 1 },
						{ type = 'text', val = 'MRU', opts = { hl = 'SpecialComment' } },
						{ type = 'padding', val = 1 },
						{
							type = 'group',
							val = function()
								return { mru(10, nil, 5) }
							end,
						},
					},
				},
				bottom_buttons = {
					type = 'group',
					val = {
						{ type = 'padding', val = 1 },
						button(
							'r',
							'Restore Last Session',
							'<cmd>RestoreLastReSession<CR>'
						),
						button('q', 'Quit', ':qa<CR>'),
					},
				},
			}

			local config = {
				layout = {
					theme.header,
					theme.top_buttons,
					theme.managers,
					theme.sessions,
					theme.mru_cwd,
					theme.mru,
					theme.bottom_buttons,
					theme.footer,
				},
				opts = {
					margin = 3,
					redraw_on_resize = false,
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

			local wk = require('which-key')

			wk.register({
				h = { '<cmd>Alpha<cr>', 'Open Das[h]board' },
			}, { mode = 'n', prefix = '<leader>' })

			local alpha_on_empty =
				vim.api.nvim_create_augroup('alpha_on_empty', { clear = true })
			vim.api.nvim_create_autocmd('User', {
				pattern = 'BDeletePost*',
				group = alpha_on_empty,
				callback = function(event)
					local fallback_on_empty = vim.bo.buftype == ''
						and vim.o.filetype == ''

					if fallback_on_empty then
						-- require('neo-tree').close_all()
						require('resession').detach()
						vim.cmd('Alpha')
						vim.cmd(event.buf .. 'bwipeout!')
					end
				end,
			})
		end,
	},
}
