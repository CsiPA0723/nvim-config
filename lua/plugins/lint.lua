---@type LazyPluginSpec[]
return {
	{ -- Linting
		'mfussenegger/nvim-lint',
		event = { 'BufReadPre', 'BufNewFile' },
		config = function()
			local lint = require 'lint'
			lint.linters_by_ft = {
				markdown = { 'markdownlint' },
				docker = { 'hadolint' },
				javascript = { 'eslint_d' },
				typescript = { 'eslint_d' },
			}
		end,
	},
}
