---@type LazyPluginSpec[]
return {
	{
		'Shatur/neovim-session-manager',
		dependencies = 'nvim-lua/plenary.nvim',
		lazy = false,
		config = function()
			local config = require('session_manager.config')
			require('session_manager').setup({
				-- Disabled, CurrentDir, LastSession, GitSession
				autoload_mode = {
					config.AutoloadMode.CurrentDir,
					config.AutoloadMode.GitSession,
				},
				autosave_only_in_session = true,
			})
		end,
	},
}
