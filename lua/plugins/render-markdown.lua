---@type LazyPluginSpec
return {
   'MeanderingProgrammer/render-markdown.nvim',
   dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-tree/nvim-web-devicons',
   },
   cmd = 'RenderMarkdown',
   ft = { 'markdown', 'quarto' },
   ---@module 'render-markdown'
   ---@type render.md.UserConfig
   opts = {
      completions = { blink = { enabled = true } },
      file_types = { 'markdown', 'quarto' },
   },
}
