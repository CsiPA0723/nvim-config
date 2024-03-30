return {
	{
		'stevearc/resession.nvim',
		lazy = false,
		dependencies = {
			{
				'tiagovla/scope.nvim',
				lazy = false,
				config = true,
			},
		},
		opts = {
			-- override default filter
			buf_filter = function(bufnr)
				local buftype = vim.bo[bufnr].buftype
				if buftype == 'help' then
					return true
				end
				if buftype ~= '' and buftype ~= 'acwrite' then
					return false
				end
				if vim.api.nvim_buf_get_name(bufnr) == '' then
					return false
				end

				-- this is required, since the default filter skips nobuflisted buffers
				return true
			end,
			autosave = {
				enabled = true,
				interval = 60,
				notify = true,
			},
			extensions = { scope = {} }, -- add scope.nvim extension
		},
		config = function(_, opts)
			local resession = require('resession')
			resession.setup(opts)

			--local wk = require('which-key')
			--wk.register({})

			vim.api.nvim_create_autocmd('VimLeavePre', {
				callback = function()
					-- Always save a special session named "last"
					resession.save('last')
				end,
			})

			local function get_session_name()
				local name = vim.fn.getcwd()
				local branch = vim.trim(vim.fn.system('git branch --show-current'))
				if vim.v.shell_error == 0 then
					return name .. branch
				else
					return name
				end
			end

			vim.api.nvim_create_autocmd('VimEnter', {
				callback = function()
					-- Only load the session if nvim was started with no args
					if vim.fn.argc(-1) == 0 then
						resession.load(
							get_session_name(),
							{ dir = 'dirsession', silence_errors = true }
						)
					end
				end,
			})

			vim.api.nvim_create_autocmd('VimLeavePre', {
				callback = function()
					resession.save(
						get_session_name(),
						{ dir = 'dirsession', notify = false }
					)
				end,
			})
		end,
	},
}
