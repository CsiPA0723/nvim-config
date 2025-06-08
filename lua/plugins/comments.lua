---@type LazyPluginSpec[]
return {
   {
      'numToStr/Comment.nvim',
      event = 'VeryLazy',
      config = function()
         require('Comment').setup()
         require('which-key').add({
            { 'gb', group = 'Comment toggle blockwise' },
            { 'gc', group = 'Comment toggle linewise' },
         })
      end,
   },
   {
      'folke/todo-comments.nvim',
      event = 'VeryLazy',
      dependencies = { 'nvim-lua/plenary.nvim' },
      ---@module "todo-comments"
      ---@type TodoOptions
      ---@diagnostic disable-next-line: missing-fields
      opts = {
         highlight = {
            -- vimgrep regex, supporting the pattern TODO(name)\:
            pattern = [[.*<((KEYWORDS)%(\(.{-1,}\))?)\s*:]],
         },
         search = {
            -- ripgrep regex, supporting the pattern TODO(name)\:
            pattern = [[(?:\b(KEYWORDS)(?:\(\w*\))*:)]],
         },
      },
   },
}
