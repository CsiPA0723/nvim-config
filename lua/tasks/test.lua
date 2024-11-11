---@type TaskRunner.ModuleConfig
local M = {
	tasks = {
		Test = {
			command = 'echo',
			args = { 'Testing echo' },
		},
	},
}

return M
