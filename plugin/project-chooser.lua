local PROJECT_DIR = vim.fn.expand(vim.env.PROJECT_DIR or '~/Shortcuts')
local CMD = 'Project'

---@param data string
---@return string project
---@return string path
local function parse(data)
   local fragments = vim.split(data, ' ', { plain = true, trimempty = true })
   local project = fragments[1] or ''
   local path = PROJECT_DIR .. '/' .. project
   return project, path
end

---@param input vim.api.keyset.create_user_command.command_args
local function execute(input)
   local project, path = parse(input.args)
   if vim.fn.isdirectory(path) then
      local p = require('persistence')
      p.save()
      p.stop()
      vim.uv.chdir(path)
      p.load()
      p.start()
   else
      error('`' .. project .. '` not found: ' .. path, vim.log.levels.ERROR)
   end
end

---@param prefix string
---@param line string
---@param col number
local function complete(prefix, line, col)
   line = line:sub(1, col):match(CMD .. '%s*(.*)$')
   local candidates = vim.fn.readdir(PROJECT_DIR)
   candidates = vim.tbl_filter(function(x)
      return tostring(x):find(prefix, 1, true) == 1
   end, candidates)
   table.sort(candidates)
   return candidates
end

vim.api.nvim_create_user_command(
   CMD,
   execute,
   { complete = complete, nargs = 1 }
)
