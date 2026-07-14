---@type LazyPluginSpec
return {
   'chrisgrieser/nvim-origami',
   event = 'VeryLazy',
   opts = {
      foldtext = { lineCount = { template = '󰁂 %d ln' } },
      disableOnFt = { 'lua', 'NeogitStatus', 'snacks_dashboard' },
      foldKeymaps = { setup = false },
   },
   init = function()
      vim.opt.foldlevel = 99
      vim.opt.foldlevelstart = 99
   end,
}
