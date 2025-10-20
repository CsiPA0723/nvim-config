---@type LazyPluginSpec
return {
   'j-hui/fidget.nvim',
   priority = 999,
   lazy = false,
   opts = {
      notification = {
         filter = vim.log.levels.INFO,
         override_vim_notify = true,
      },
   },
}
