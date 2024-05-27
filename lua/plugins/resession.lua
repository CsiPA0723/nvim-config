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
				n = {
					name = 'Sessions',
					s = { resession.save, 'Save' },
					l = { resession.load, 'Load' },
					d = { resession.delete, 'Delete' },
				},
			}, { mode = 'n', noremap = true, prefix = '<leader>' })

			-- TODO: Try to make a better automatic session loader / saver

			vim.api.nvim_create_autocmd('VimLeavePre', {
				callback = function()
					local current = resession.get_current()

					if current ~= nil then -- Save current session if in one
						resession.save(current, { attach = false, notify = false })
						local file = io.open(vim.fn.stdpath('data') .. '/last.json', 'w')
						if file ~= nil then
							file:write(vim.json.encode({ lastSession = current }))
							file:flush()
							file:close()
						end
					end
					-- Save a special session named "last"
					resession.save('last', { attach = false, notify = false })
				end,
			})
		end,
	},
}
