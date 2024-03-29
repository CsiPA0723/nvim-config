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
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = ' '
vim.g.maplocalleader = ','
vim.loader.enable()

-------------------------------------------------------------------------------
-- Lazy Setup

local lazyOpts = {
	checker = {
		enabled = true, -- automatically check for plugin updates
		notify = false, -- done on my own to with minimum condition for less noise
		frequency = 60 * 60 * 24, -- = 1 day
	},
	git = { timeot = 60 }, -- 1min timeout for tasks
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
}

require('lazy').setup({
	{
		'rcarriga/nvim-notify',
		config = function()
			vim.notify = require('notify')
		end,
	},
	{ 'tpope/vim-sleuth' },
	{ 'numToStr/Comment.nvim', config = true },
	{ 'sindrets/diffview.nvim', lazy = true },
	{ 'nanotee/zoxide.vim' },
	{
		'cuducos/yaml.nvim',
		lazy = true,
		ft = { 'yaml' },
		dependencies = {
			'nvim-treesitter/nvim-treesitter',
			'nvim-telescope/telescope.nvim',
		},
	},
	{
		'folke/todo-comments.nvim',
		event = 'VimEnter',
		dependencies = { 'nvim-lua/plenary.nvim' },
	},
	{
		'nvim-lualine/lualine.nvim',
		dependencies = { 'nvim-tree/nvim-web-devicons' },
		opts = {
			options = { theme = 'catppuccin' },
			extensions = { 'lazy', 'neo-tree', 'aerial', 'trouble' },
		},
	},
	{
		'folke/trouble.nvim',
		dependencies = { 'nvim-tree/nvim-web-devicons' },
		config = true,
	},
	require 'plugins.gitsigns',
	require 'plugins.which-key',
	require 'plugins.telescope',
	require 'plugins.neo-tree',
	require 'plugins.conform',
	require 'plugins.mini',
	require 'plugins.nvim-treesitter',
	require 'plugins.indent_line',
	require 'plugins.lazygit',
	require 'plugins.ufo',
	require 'plugins.smart-splits',
	require 'plugins.dashboard',
	require 'plugins.theme',
}, lazyOpts)

-------------------------------------------------------------------------------
-- More Configs

if vim.g.neovide then
	require 'config.neovide'
end

require 'config.options'
require 'config.keymaps'

-------------------------------------------------------------------------------
-- 5s after startup, notify if there are more update
vim.defer_fn(function()
	if not require('lazy.status').has_updates() then
		return
	end
	local threshold = 10
	local numberOfUpdates =
		tonumber(require('lazy.status').updates():match('%d+'))
	if numberOfUpdates < threshold then
		return
	end
	vim.notify(('󱧕 %s plugin updates'):format(numberOfUpdates))
end, 5000)
