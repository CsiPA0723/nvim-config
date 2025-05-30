---@type LazyPluginSpec[]
return {
   {
      'neo451/feed.nvim',
      dependencies = {
         'gregorias/coop.nvim',
         'nvim-treesitter/nvim-treesitter',
      },
      cmd = 'Feed',
      ---@module 'feed'
      ---@type feed.config
      opts = {
         feeds = {
            {
               'https://neovim.io/news.xml',
               name = 'Neovim News',
               tags = { 'tech', 'news' }, -- tags given are inherited by all its entries
            },
            {
               'https://archlinux.org/feeds/news/',
               name = 'Arch News',
               tags = { 'arch', 'news' },
            },
         },
      },
   },
}
