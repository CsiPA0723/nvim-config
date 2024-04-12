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

local lazyOpts = {
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
}

require('lazy').setup({
	{
		'rcarriga/nvim-notify',
		opts = { fps = 60, render = 'default', stages = 'slide' },
		config = function(_, opts)
			require('notify').setup(opts)
			vim.notify = require('notify')
		end,
	},
	{ 'folke/which-key.nvim', event = 'VimEnter', config = true },
	{
		'akinsho/toggleterm.nvim',
		version = '*',
		opts = { shell = 'pwsh', open_mapping = '<C-ö>' },
	},
	{
		'max397574/better-escape.nvim',
		opts = {
			mapping = { 'jk' },
			timeout = 250,
			clear_empty_lines = false,
			keys = '<Esc>',
		},
	},
	{ 'tpope/vim-sleuth' },
	{ 'numToStr/Comment.nvim', config = true },
	{ 'sindrets/diffview.nvim', config = true },
	{ 'nanotee/zoxide.vim' },
	{
		'mistricky/codesnap.nvim',
		enabled = function()
			return jit.os ~= 'Windows'
		end,
		cmd = { 'CodeSnap', 'CodeSnapSave' },
		build = 'make build_generator',
	},
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
		config = true,
	},
	{
		'folke/trouble.nvim',
		dependencies = { 'nvim-tree/nvim-web-devicons' },
		config = true,
	},
	require 'plugins.lualine',
	require 'plugins.statuscol',
	require 'plugins.resession',
	require 'plugins.barbecue',
	require 'plugins.virt-column',
	require 'plugins.gitsigns',
	require 'plugins.telescope',
	require 'plugins.bufferline',
	require 'plugins.neo-tree',
	require 'plugins.conform',
	require 'plugins.mini',
	require 'plugins.nvim-treesitter',
	require 'plugins.nvim-lspconfig',
	require 'plugins.nvim-cmp',
	require 'plugins.lint',
	require 'plugins.debug',
	require 'plugins.indent_line',
	require 'plugins.lazygit',
	require 'plugins.ufo',
	require 'plugins.smart-splits',
	require 'plugins.windows',
	require 'plugins.dashboard',
	require 'plugins.obsidian',
	require 'plugins.pomo',
	require 'plugins.theme',
}, lazyOpts)

-------------------------------------------------------------------------------
-- Configs

if vim.g.neovide then
	require 'config.neovide'
end

require 'config.options-and-autocmds'
require 'config.keybindings'
