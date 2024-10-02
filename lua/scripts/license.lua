-- TODO: Telescope picker making
-- [ ] Filter to applicable license files
-- [ ] Preview the files
-- [ ] Instert picked file before the cursor
-- [ ] Before insertion make a comment block

-- local licenseSpace = vim.api.nvim_create_namespace('license')
-- vim.api.nvim_create_user_command('License', function()
-- 	-- local files = Utils.scandir('./', true, 'license(.md|.adoc|.txt)?$')
-- end, { nargs = 0, desc = 'Adds license to the top of the file' })

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
					-- NOTE: Insert 3 lines at the top,
					-- create comment block,
					-- instert the selected license,
					-- bring back the cursor and save
					vim.api.nvim_input(
						'mzgg0O<C-u><CR><CR><esc>'
							.. 'kVkgb'
							.. ('<cmd>.read ' .. selection .. '<CR>`m')
							.. '<cmd>w<CR>'
					)
				end)
				return true
			end,
			previewer = conf.grep_previewer(opts),
		})
		:find()
end

licenses()
