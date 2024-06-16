-- NOTE: Fixing unpack sometimes not working correctly
table.unpack = table.unpack or unpack -- 5.1 compatibility

-- NOTE: Temp fix for a deprecetated function
--
---@diagnostic disable-next-line: duplicate-set-field
vim.tbl_add_reverse_lookup = function(tbl)
	for k, v in pairs(tbl) do
		tbl[v] = k
	end
end

-- Bootstrap Lazy.nvim plugin manager https://github.com/folke/lazy.nvim#-installation
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system {
		'git',
		'clone',
		'--filter=blob:none',
		'https://github.com/folke/lazy.nvim.git',
		'--branch=stable',
		lazypath,
	}
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = ' '
vim.g.maplocalleader = ','
vim.loader.enable()

-------------------------------------------------------------------------------
-- Lazy Setup

--[[ TODO:-List
	[x] Remove bufferline, maybe scope too
	[ ] Add HarpoonV2 ??
  [ ] Redesign lualine
	[ ] Put all keybindings in one file
	[x] Add oil.nvim and try to rework how I access the files
	[x] Simplify config
  [x] Add inlay-hints for jumping and resctirons for spamming hjkl, etc.
--]]

require('lazy').setup('plugins', {
	checker = {
		enabled = true,
		notify = true,
	},
	git = { timeot = 60 }, -- 1 min timeout for tasks
	ui = {
		icons = {
			cmd = '⌘',
			config = '🛠',
			event = '📅',
			ft = '📂',
			init = '⚙',
			keys = '🗝',
			plugin = '🔌',
			runtime = '💻',
			require = '🌙',
			source = '📄',
			start = '🚀',
			task = '📌',
			lazy = '💤 ',
		},
	},
})

-------------------------------------------------------------------------------
-- Configs

if vim.g.neovide then
	require 'config.neovide'
end

require 'config.options'
require 'config.remaps-and-autocmds'
