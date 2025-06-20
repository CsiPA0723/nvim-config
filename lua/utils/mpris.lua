local notif_group = 'mpris'

local notify = vim.schedule_wrap(vim.notify)

local on_stderr = function(error, data)
   error = error or 'Error'
   data = data or 'Unknown error'
   notify(error .. '\n' .. data, vim.log.levels.ERROR, { group = notif_group })
end

---@class CsiPA.mpris
---@field private _set_enable fun(state: boolean): nil
---@field private _get_enable fun(): boolean
local M = {
   enabled = true,
   can_fit = true,
   title = 'Unknown',
   artist = 'Unknown',
   track = 'Unknown - Unknown',
   lualine_component = 'Unknown - Unknown',
   playing = false,
   changed_song = false,
   media_players = { 'tidal-hifi', 'strawberry', 'spotify' },
}

function M.setup()
   require('fidget.notification').set_config(notif_group, {
      name = 'Media',
      icon = ' ',
      ttl = 4,
   }, true)

   Snacks.toggle
      .new({
         name = 'Media Player',
         icon = ' ',
         id = 'mpris',
         which_key = true,
         notify = false,
         set = M._set_enable,
         get = M._get_enable,
      })
      :map('<leader>m')

   M.job_metadata = vim.system({
      'playerctl',
      '--all-players',
      '--player',
      table.concat(M.media_players, ','),
      '--follow',
      'metadata',
   }, {
      text = true,
      stderr = on_stderr,
      stdout = function(error, data)
         if error then
            on_stderr(error, data)
         end
         if data then
            local artist = string.match(data, '%s+xesam:artist%s+(.-)\n')
            local title = string.match(data, '%s+xesam:title%s+(.-)\n')

            if nil == M.artist or artist ~= M.artist and nil ~= artist then
               M.artist = artist or M.artist
               M.changed_song = true
            end
            if nil == M.title or title ~= M.title and nil ~= title then
               M.title = title or M.title
               M.changed_song = true
            end
         end
      end,
   })

   M.job_status = vim.system({
      'playerctl',
      '--all-players',
      '--player',
      table.concat(M.media_players, ','),
      '--follow',
      'status',
   }, {
      text = true,
      stderr = on_stderr,
      stdout = function(error, data)
         if error then
            on_stderr(error, data)
         end
         local start = string.find(data or '', 'Playing\n', 1, true)
         M.playing = start ~= nil
      end,
   })

   autocmd('VimLeavePre', {
      group = vim.api.nvim_create_augroup('mpris', {}),
      callback = function()
         M.job_metadata:kill(15)
         M.job_status:kill(15)
      end,
   })

   local track_index = 1
   local direction = 1
   local wait = false

   vim.fn.timer_start(500, function(_)
      local max_size = math.floor(vim.o.columns / 3) - 1
      if vim.o.columns < 90 and M.can_fit then
         M.can_fit = false
         return
      elseif vim.o.columns >= 90 then
         M.can_fit = true
      end

      if M.changed_song then
         track_index = 1
         direction = 1
         M.track = (M.artist or 'Unknown') .. ' - ' .. (M.title or 'Unknown')
         M.changed_song = false
      end

      local str = M.track

      if #M.track > max_size then
         str = string.sub(str, track_index, max_size + track_index)

         if not wait then
            track_index = track_index + direction
         else
            wait = false
         end

         if track_index <= 0 or track_index + max_size > #M.track then
            if track_index <= 0 then
               track_index = 1
            else
               track_index = #M.track - max_size
            end
            direction = direction * -1
            wait = true
         end
      end

      M.lualine_component = '  ' .. str .. '  '
   end, { ['repeat'] = -1 })
end

function M.get_status()
   return M.playing and M.can_fit and M.enabled
end

function M.lualine()
   return M.lualine_component
end

function M._set_enable(state)
   M.enabled = state
end

function M._get_enable()
   return M.enabled
end

return M
