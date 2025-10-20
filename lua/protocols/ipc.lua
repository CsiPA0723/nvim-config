---@module 'fidget'

---@class protocols.ipc
---@field private _request_id number
local M = {
   _request_id = 0,
   path = '/tmp/mpv-ipc',
   ---@type uv.uv_pipe_t?
   pipe = nil,
   ---table<request_id, callback>
   ---@type table<number, function>
   pending = {},
   ---@type Options
   notify = {
      annote = 'MPV',
      title = 'MPV',
      group = 'ipc',
   },
   autocmd_group = augroup('csipa-ipc', { clear = true }),
}

require('fidget.notification').set_config('ipc', {
   icon = ' ',
   name = 'IPC',
   ttl = 4,
}, true)

vim.g.ipc_connected = false

local schedule_notify = vim.schedule_wrap(vim.notify)

function M.close()
   M.pipe:close()
   vim.g.ipc_connected = false
   vim.notify('Closed', vim.log.levels.INFO, M.notify)
end

autocmd({ 'VimLeavePre' }, {
   group = M.autocmd_group,
   callback = function()
      M.close()
   end,
})

function M.connect()
   if vim.g.ipc_connected == true then
      vim.notify('Already connected', vim.log.levels.WARN, M.notify)
      return
   end

   M.pipe = vim.uv.new_pipe(true)
   M.pipe:connect(M.path, function(err)
      if err then
         schedule_notify(err, vim.log.levels.ERROR, M.notify)
         return
      end
      vim.g.ipc_connected = true
      schedule_notify('Connected', vim.log.levels.INFO, M.notify)

      M.pipe:read_start(function(r_err, data)
         if r_err then
            schedule_notify(r_err, vim.log.levels.ERROR, M.notify)
            return
         elseif data then
            local ok, resp = pcall(vim.json.decode, data)
            if not ok then
               schedule_notify(resp, vim.log.levels.ERROR, M.notify)
               return
            end

            if resp.request_id then
               local callback = M.pending[resp.request_id]
               if vim.is_callable(callback) then
                  callback(resp.error, resp.data)
                  M.pending[resp.request_id] = nil
               end
            elseif resp.event then
               schedule_notify(
                  vim.inspect(resp.event),
                  vim.log.levels.INFO,
                  M.notify
               )
            else
               schedule_notify(
                  vim.inspect(resp),
                  vim.log.levels.ERROR,
                  M.notify
               )
            end
         else
            M.close()
         end
      end)
   end)
end

---@param command table
---@param callback function?
function M.write(command, callback)
   command =
      vim.tbl_deep_extend('force', command, { request_id = M.request_id() })
   M.pipe:write(vim.json.encode(command) .. '\n', function(err)
      if err then
         schedule_notify('Write: ' .. err, vim.log.levels.ERROR, M.notify)
         return
      end
      if vim.is_callable(callback) then
         M.pending[command.request_id] = callback
      end
   end)
end

function M.request_id()
   local request_id = M._request_id
   M._request_id = M._request_id + 1
   return request_id
end

vim.api.nvim_create_user_command('IPCConnect', function()
   require('protocols.ipc').connect()
end, { nargs = 0 })

vim.api.nvim_create_user_command('IPCVolume', function()
   require('protocols.ipc').write(
      { command = { 'get_property', 'volume' } },
      function(err, data)
         if err ~= 'success' then
            vim.notify(err, vim.log.levels.ERROR, M.notify)
            return
         end
         if data then
            vim.notify('Volume: ' .. data, vim.log.levels.INFO, M.notify)
         end
      end
   )
end, { nargs = 0 })

return M
