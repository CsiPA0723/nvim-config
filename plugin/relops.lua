-- Initialize global state for persistence
if vim.g.RELOPS_ACTIVE == nil then
   vim.g.RELOPS_ACTIVE = true
end

local function refresh_line_numbers()
   -- Skip special buffers or non-modifiable files
   if
      not vim.bo.modifiable
      or vim.bo.buftype ~= ''
      or vim.bo.filetype == 'help'
   then
      vim.opt_local.number = false
      vim.opt_local.relativenumber = false
      return
   end

   local mode = vim.api.nvim_get_mode().mode

   if vim.g.RELOPS_ACTIVE then
      -- MODERN RELOPS LOGIC: Enable relative numbers only during actions
      local targeting_modes = {
         ['no'] = true, -- Operator-pending
         ['v'] = true, -- Visual
         ['V'] = true, -- Visual Line
         ['\22'] = true, -- Visual Block
         ['c'] = true, -- Command-line
      }
      vim.opt_local.relativenumber = targeting_modes[mode] or false
   else
      -- STANDARD HYBRID LOGIC: Always on, except Insert mode
      vim.opt_local.relativenumber = (mode ~= 'i')
   end

   vim.opt_local.number = true
end

-- Toggle Keymap
Snacks.toggle
   .new({
      name = 'RelOps',
      icon = ' ',
      id = 'relops',
      which_key = true,
      notify = false,
      wk_desc = { enabled = 'Normal ', disabled = 'Hyprid ' },
      set = function(state)
         vim.g.RELOPS_ACTIVE = state
         refresh_line_numbers()
      end,
      get = function()
         return vim.g.RELOPS_ACTIVE
      end,
   })
   :map('<leader>R')

--[[ vim.keymap.set('n', '<leader>l', function()
   vim.g.RELOPS_ACTIVE = not vim.g.RELOPS_ACTIVE
   refresh_line_numbers()
   print('RelOps Mode: ' .. (vim.g.RELOPS_ACTIVE and 'ENABLED' or 'HYBRID'))
end, { desc = 'Toggle Numbering Profile' }) ]]

-- Autocommands to trigger refresh
autocmd({ 'ModeChanged', 'BufEnter', 'BufWinEnter' }, {
   group = vim.api.nvim_create_augroup('DynamicLineNumbers', { clear = true }),
   callback = refresh_line_numbers,
})

-- Trigger relative numbers when starting a count
--[[ for i = 1, 9 do
   vim.keymap.set('n', tostring(i), function()
      if vim.g.RELOPS_ACTIVE then
         vim.opt_local.relativenumber = true
      end
      return swallow_key and '' or tostring(i) -- Clean return
   end, { expr = true, silent = true })
end ]]

-- Reset on ESC
--[[ vim.keymap.set('n', '<Esc>', function()
   if vim.g.RELOPS_ACTIVE then
      vim.opt_local.relativenumber = false
   end
   return '<Esc>'
end, { expr = true, silent = true, desc = 'Clear search and reset RelOps' }) ]]
