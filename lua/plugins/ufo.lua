return {
	{
		'kevinhwang91/nvim-ufo',
		dependencies = 'kevinhwang91/promise-async',
		event = 'BufReadPost',
		opts = {
			provider_selector = function()
				return { 'lsp', 'indent' }
			end,
			open_fold_hl_timeout = 400,
			enable_get_fold_virt_text = true,
			close_fold_kinds_for_ft = {
				default = { 'imports', 'comment' },
				json = { 'array' },
				c = { 'comment', 'region' },
			},
			preview = {
				win_config = {
					border = { '', '─', '', '', '', '─', '', '' },
					-- winhighlight = "Normal:Folded",
					winblend = 0,
				},
				mappings = {
					scrollU = '<C-u>',
					scrollD = '<C-d>',
					jumpTop = '[',
					jumpBot = ']',
				},
			},
			filetype_exclude = {
				'help',
				'alpha',
				'dashboard',
				-- 'neo-tree',
				'Trouble',
				'lazy',
				'mason',
			},
		},
		init = function()
			vim.o.foldcolumn = '1' -- "0" is not bad
			vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
			vim.o.foldlevelstart = 99
			vim.o.foldenable = true
		end,
		config = function(_, opts)
			local handler = function(virtText, lnum, endLnum, width, truncate)
				local newVirtText = {}
				local totalLines = vim.api.nvim_buf_line_count(0)
				local foldedLines = endLnum - lnum
				local suffix = (' 󰁂 %d %d%%'):format(
					foldedLines,
					foldedLines / totalLines * 100
				)
				local sufWidth = vim.fn.strdisplaywidth(suffix)
				local targetWidth = width - sufWidth
				local curWidth = 0
				for _, chunk in ipairs(virtText) do
					local chunkText = chunk[1]
					local chunkWidth = vim.fn.strdisplaywidth(chunkText)
					if targetWidth > curWidth + chunkWidth then
						table.insert(newVirtText, chunk)
					else
						chunkText = truncate(chunkText, targetWidth - curWidth)
						local hlGroup = chunk[2]
						table.insert(newVirtText, { chunkText, hlGroup })
						chunkWidth = vim.fn.strdisplaywidth(chunkText)
						-- str width returned from truncate() may less than 2nd argument, need padding
						if curWidth + chunkWidth < targetWidth then
							suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
						end
						break
					end
					curWidth = curWidth + chunkWidth
				end
				local rAlignAppndx = math.max(
					math.min(vim.opt.textwidth['_value'], width - 1) - curWidth - sufWidth,
					0
				)
				suffix = (' '):rep(rAlignAppndx) .. suffix
				table.insert(newVirtText, { suffix, 'MoreMsg' })
				return newVirtText
			end
			opts['fold_virt_text_handler'] = handler

			vim.api.nvim_create_autocmd('FileType', {
				group = vim.api.nvim_create_augroup(
					'local_detach_ufo',
					{ clear = true }
				),
				pattern = opts.filetype_exclude,
				callback = function()
					require('ufo').detach()
				end,
			})

			require('ufo').setup(opts)

			local wk = require('which-key')

			wk.register({
				R = { require('ufo').openAllFolds, 'Ufo: Open All Folds' },
				M = { require('ufo').closeAllFolds, 'Ufo: Close All Folds' },
				r = {
					require('ufo').openFoldsExceptKinds,
					'Ufo: Open Folds Except Kinds',
				},
				m = { require('ufo').closeFoldsWith, 'Ufo: Close Folds With' },
			}, { prefix = '<z>' })

			wk.register({
				K = {
					function()
						local winid = require('ufo').peekFoldedLinesUnderCursor()
						if not winid then
							vim.lsp.buf.hover()
						end
					end,
					'Ufo: Peek Folded Lines Under Cursor',
				},
			}, { mode = 'n', noremap = true, prefix = '<space>' })
		end,
	},
}
