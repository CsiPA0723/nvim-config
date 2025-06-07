---@type LazyPluginSpec[]
return {
   {
      'lewis6991/gitsigns.nvim',
      event = 'VeryLazy',
      opts = {
         signs = {
            add = { text = '+' },
            change = { text = '~' },
            delete = { text = '_' },
            topdelete = { text = '‾' },
            changedelete = { text = '~' },
         },
      },
   },
   {
      'sindrets/diffview.nvim',
      cmd = {
         'DiffviewClose',
         'DiffviewFileHistory',
         'DiffviewFocusFiles',
         'DiffviewLog',
         'DiffviewOpen',
         'DiffviewRefresh',
         'DiffviewToggleFiles',
      },
      dependencies = 'nvim-tree/nvim-web-devicons',
      config = true,
   },
   {
      'NeogitOrg/neogit',
      dependencies = {
         'nvim-lua/plenary.nvim',
         'sindrets/diffview.nvim',
      },
      cmd = 'Neogit',
      ---@module "neogit"
      ---@type NeogitConfig
      opts = {
         graph_style = vim.g.neovide and 'unicode' or 'kitty',
         integrations = { diffview = true, snacks = true },
         mappings = { status = { ['q'] = false } },
      },
      init = function(_)
         autocmd('FileType', {
            pattern = { 'NeogitStatus' },
            callback = function(args)
               require('which-key').add({
                  { 'q', vim.cmd.quit, desc = 'Quit' },
                  buffer = args.buf,
               })
            end,
         })
      end,
   },
}
