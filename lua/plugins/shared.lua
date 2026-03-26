---@type LazyPluginSpec[]
return {
   { 'nvim-treesitter/nvim-treesitter', branch = 'main', optional = true },
   {
      'nvim-treesitter/nvim-treesitter-textobjects',
      branch = 'main',
      optional = true,
   },
   { 'nvim-tree/nvim-web-devicons', optional = true },
   { 'nvim-lua/plenary.nvim', optional = true },
   { 'MunifTanjim/nui.nvim', optional = true },
   {
      'mason-org/mason.nvim',
      ---@module 'mason'
      ---@type MasonSettings
      opts = {
         registries = {
            'github:mason-org/mason-registry',
            'github:Crashdummyy/mason-registry',
         },
      },
      config = function(_, opts)
         require('fidget.notification').set_config('mason', {
            name = 'Mason',
            icon = ' ',
            ttl = 8,
         }, true)
         require('mason').setup(opts)
      end,
   },
}
