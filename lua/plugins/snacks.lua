local header_neovim = [[
███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝]]

local header_neovide = [[
███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗██████╗ ███████╗
████╗  ██║██╔════╝██╔═══██╗██║   ██║██║██╔══██╗██╔════╝
██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██║  ██║█████╗  
██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║  ██║██╔══╝  
██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██████╔╝███████╗
╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═════╝ ╚══════╝]]

---@type LazyPluginSpec[]
return {
	{
		'folke/snacks.nvim',
		priority = 1000,
		lazy = false,
		---@type snacks.Config
		opts = {
			bigfile = { enabled = true },
			input = { enabled = true },
			image = { enabled = true },
			statuscolumn = { enabled = true },
			gitbrowse = { enabled = true },
			picker = { enabled = true },
			lazygit = { enabled = true },
			dashboard = {
				width = 50,
				preset = {
					header = vim.g.neovide and header_neovide or header_neovim,
					keys = {
						{
							icon = ' ',
							key = 'f',
							desc = 'Find File',
							action = ":lua Snacks.dashboard.pick('files')",
						},
						{
							icon = ' ',
							key = 'e',
							desc = 'New File',
							action = ':ene | startinsert',
						},
						{
							icon = '󰊄 ',
							key = 'g',
							desc = 'Live Grep',
							action = ":lua Snacks.dashboard.pick('live_grep')",
						},
						{
							icon = ' ',
							key = 'o',
							desc = 'Recent Files',
							action = ":lua Snacks.dashboard.pick('oldfiles')",
						},
						{
							icon = ' ',
							key = 'c',
							desc = 'Config',
							action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
						},
						{
							icon = ' ',
							key = 's',
							desc = 'Sessions',
							action = ':SessionManager load_session',
						},
						{
							icon = ' ',
							key = 'r',
							desc = 'Restore last session',
							action = ':SessionManager load_last_session',
						},
						{
							icon = '󰒲 ',
							key = 'L',
							desc = 'Lazy',
							action = ':Lazy',
							enabled = package.loaded.lazy ~= nil,
						},
						{
							icon = ' ',
							key = 'M',
							desc = 'Mason LSP Manager',
							action = ':Mason',
						},
						{ icon = ' ', key = 'q', desc = 'Quit', action = ':qa' },
					},
				},
				formats = {
					header = { '%s', hl = 'Type', align = 'center' },
				},
				sections = {
					{ section = 'header' },
					{
						pane = 2,
						section = 'terminal',
						cmd = 'colorscript -e square',
						height = 5,
						padding = 1,
					},
					{ section = 'keys', gap = 1, padding = 1 },
					{
						pane = 2,
						icon = ' ',
						title = 'Recent Files',
						section = 'recent_files',
						indent = 2,
						padding = 1,
					},
					{
						pane = 2,
						icon = ' ',
						title = 'Projects',
						section = 'projects',
						indent = 2,
						padding = 1,
					},
					{
						pane = 2,
						icon = ' ',
						title = 'Git Status',
						section = 'terminal',
						enabled = function()
							return Snacks.git.get_root() ~= nil
						end,
						cmd = 'git status --short --branch --renames',
						height = 5,
						padding = 1,
						ttl = 5 * 60,
						indent = 3,
					},
					{ section = 'startup' },
				},
			},
		},
		init = function()
			vim.api.nvim_create_autocmd('User', {
				pattern = 'VeryLazy',
				callback = function()
					-- Setup some globals for debugging (lazy-loaded)
					_G.dd = function(...)
						Snacks.debug.inspect(...)
					end
					_G.bt = function()
						Snacks.debug.backtrace()
					end
					vim.print = _G.dd -- Override print to use snacks for `:=` command
				end,
			})
		end,
	},
}
