---@type LazyPluginSpec
return {
   'nvim-lualine/lualine.nvim',
   event = 'VimEnter',
   dependencies = { 'nvim-tree/nvim-web-devicons' },
   opts = {
      options = {
         theme = 'catppuccin',
         icons_enabled = true,
         globalstatus = true,
         refresh = { statusline = 10 },
      },
      sections = {
         lualine_a = {
            {
               'mode',
               fmt = function(str)
                  return str:sub(1, 1)
               end,
            },
         },
      },
      tabline = {
         lualine_a = { { 'tabs', mode = 2, max_length = vim.o.columns } },
      },
      extensions = {
         'fzf',
         'lazy',
         'man',
         'mason',
         'nvim-dap-ui',
         'oil',
         'quickfix',
         'trouble',
      },
   },
   config = function(_, opts)
      require('lualine').setup(opts)
      vim.o.showtabline = 1
   end,
}
