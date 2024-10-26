local finders = require 'telescope.finders'
local pickers = require 'telescope.pickers'
local conf = require('telescope.config').values
local action_state = require 'telescope.actions.state'
local actions = require 'telescope.actions'
local make_entry = require('telescope.make_entry')

local licenses = function(opts)
	opts = opts or {}
	opts.entry_maker = opts.entry_maker or make_entry.gen_from_file(opts)
	pickers
		.new(opts, {
			prompt_title = 'Licenses',
			finder = finders.new_oneshot_job(
				{ 'fd', '-itf', 'license(.md|.adoc|.txt)?$', './' },
				opts
			),
			sorter = conf.file_sorter(opts),
			attach_mappings = function(prompt_bufnr)
				actions.select_default:replace(function()
					actions.close(prompt_bufnr)
					local selection = action_state.get_selected_entry()[1]
					---@type List
					local file_lines = vim.fn.readfile(selection)
					table.insert(file_lines, '\n')
					local line_count = vim.tbl_count(file_lines)
					local cursor_previus_pos = vim.api.nvim_win_get_cursor(0)
					cursor_previus_pos[1] = line_count + cursor_previus_pos[1]
					local comment_api = require('Comment.api')
					local comment_config = require('Comment.config'):get()

					vim.api.nvim_win_set_cursor(0, { 1, 0 })
					vim.api.nvim_paste(table.concat(file_lines, '\n'), false, -1)
					vim.api.nvim_buf_set_mark(0, '<', 1, 0, {})
					vim.api.nvim_buf_set_mark(0, '>', line_count - 1, 0, {})
					comment_api.comment.blockwise('V', comment_config)
					vim.api.nvim_win_set_cursor(0, cursor_previus_pos)
					vim.api.nvim_feedkeys(
						vim.api.nvim_replace_termcodes('<cmd>write<CR>', true, false, true),
						'm',
						false
					)
				end)
				return true
			end,
			previewer = conf.grep_previewer(opts),
		})
		:find()
end

return require('telescope').register_extension {
	exports = { ['licenses'] = licenses },
}
