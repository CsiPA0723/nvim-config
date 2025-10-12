---@type LazyPluginSpec[]
return {
   { 'nvim-treesitter/nvim-treesitter', branch = 'master', optional = true },
   {
      'nvim-treesitter/nvim-treesitter-textobjects',
      branch = 'master',
      optional = true,
   },
   { 'nvim-tree/nvim-web-devicons', optional = true },
   { 'nvim-lua/plenary.nvim', optional = true },
   { 'MunifTanjim/nui.nvim', optional = true },
}
