---@type LazyPluginSpec[]
return {
	{
		'epwalsh/pomo.nvim',
		version = '*',
		lazy = true,
		cmd = { 'TimerStart', 'TimerRepeat' },
		dependencies = 'rcarriga/nvim-notify',
		opts = { notifiers = { { name = 'Default', opts = { sticky = false } } } },
	},
}
