---@type LazyPluginSpec
return {
   enabled = false,
   'olimorris/persisted.nvim',
   lazy = false,
   opts = {
      save_dir = vim.fn.expand(vim.fn.stdpath('data') .. '/sessions/'),
      follow_cwd = true,
      use_git_branch = true,
      autoload = true,
      autostart = true,
      on_autoload_no_session = function() end,
      should_save = function()
         -- Ref: https://github.com/folke/persistence.nvim/blob/166a79a55bfa7a4db3e26fc031b4d92af71d0b51/lua/persistence/init.lua#L46
         local bufs = vim.tbl_filter(function(b)
            if
               vim.bo[b].buftype ~= ''
               or vim.tbl_contains(
                  { 'gitcommit', 'gitrebase', 'jj' },
                  vim.bo[b].filetype
               )
            then
               return false
            end
            return vim.api.nvim_buf_get_name(b) ~= ''
         end, vim.api.nvim_list_bufs())
         if #bufs < 1 then
            return false
         end
         return true
      end,
      allowed_dirs = {},
      ignored_dirs = {},
   },
   config = function(_, opts)
      require('persisted').setup(opts)
   end,
}
