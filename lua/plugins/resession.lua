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
				local exclude = vim.tbl_contains({
					'help',
					'lazy',
					'mason',
				}, buftype)
				if exclude then
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

			local wk = require('which-key')
			wk.register({
				w = {
					name = 'Workspace',
					a = { resession.save, 'Session: Save' },
					l = { resession.load, 'Session: Load' },
					d = { resession.delete, 'Session: Delete' },
				},
			}, { mode = 'n', noremap = true, prefix = '<leader>' })

			-- TODO: Try to make a better automatic session loader / saver

			vim.api.nvim_create_autocmd('VimLeavePre', {
				callback = function()
					local current = resession.get_current()

					if current ~= 'last' then
						resession.save(current, { attach = false, notify = false })
					else -- Save a special session named "last" if no session is defined
						resession.save('last', { attach = false, notify = false })
					end
				end,
			})
		end,
	},
}
