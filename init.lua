-- NOTE: Fixing unpack sometimes not working correctly
table.unpack = table.unpack or unpack -- 5.1 compatibility

-- NOTE: Temp fix for a deprecetated function
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

--[[
	TODO:
	- Remove bufferline, maybe scope too
	- Add marks.nvim and use marks
  - Redesign lualine
	- Rework keybinds
	- Add oil.nvim and try to rework how I access the files
	- Add telescope add-ons from reddit
]]

require('lazy').setup({
	{
		'rcarriga/nvim-notify',
		priority = 100,
		opts = { fps = 60, render = 'default', stages = 'slide' },
		config = function(_, opts)
			require('notify').setup(opts)
			vim.notify = require('notify')
		end,
	},
	{ 'folke/which-key.nvim', priority = 90, config = true },
	{
		'akinsho/toggleterm.nvim',
		version = '*',
		opts = { open_mapping = '<C-ö>' },
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
	{ 'numToStr/Comment.nvim', config = true },
	{ 'sindrets/diffview.nvim', config = true },
	{ 'nanotee/zoxide.vim' },
	{ 'lambdalisue/suda.vim' },
	{
		'mistricky/codesnap.nvim',
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
