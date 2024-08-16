---@type LazyPluginSpec[]
return {
	{
		'Shatur/neovim-session-manager',
		dependencies = 'nvim-lua/plenary.nvim',
		config = function()
			local config = require('session_manager.config')
			require('session_manager').setup({
				-- Disabled, CurrentDir, LastSession, GitSession
				autoload_mode = {
					config.AutoloadMode.CurrentDir,
					config.AutoloadMode.GitSession,
				},
				autosave_only_in_session = true,
				autosave_ignore_filetypes = {
					'alpha',
					'checkhealth',
					'help',
					'netrw',
					'lazy',
					'mason',
					'oil',
					'NvimTree',
					'lspinfo',
					'git',
					'notify',
					'query',
					'gitcommit',
					'gitrebase',
				},
				autosave_ignore_buftypes = {
					'alpha',
					'checkhealth',
					'help',
					'netrw',
					'lazy',
					'mason',
					'oil',
					'NvimTree',
					'lspinfo',
					'git',
					'notify',
					'query',
					'gitcommit',
					'gitrebase',
				},
			})
		end,
	},
}
