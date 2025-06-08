---@type LazyPluginSpec[]
return {
   {
      'm-demare/hlargs.nvim',
      dependencies = 'nvim-treesitter',
      event = 'VeryLazy',
      opts = { excluded_filetypes = { 'lua' } },
   },
   { -- Highlight, edit, and navigate code
      'nvim-treesitter/nvim-treesitter',
      build = ':TSUpdate',
      lazy = false,
      opts = {
         ignore_install = { 'yaml' }, -- Already installed by a package
         ensure_installed = {
            'angular',
            'bash',
            'c',
            'html',
            'http',
            'java',
            -- 'latex',
            'lua',
            'luadoc',
            'lua_patterns',
            'markdown',
            'markdown_inline',
            'norg',
            'regex',
            'svelte',
            'tsx',
            'typst',
            'vim',
            'vimdoc',
            'vue',
         },
         auto_install = true,
         highlight = {
            enable = true,
            additional_vim_regex_highlighting = false,
         },
         indent = { enable = true },
      },
      config = function(_, opts)
         local parser_configs =
            require('nvim-treesitter.parsers').get_parser_configs()
         ---@diagnostic disable-next-line: inject-field
         parser_configs.lua_patterns = {
            install_info = {
               url = 'https://github.com/OXY2DEV/tree-sitter-lua_patterns',
               files = { 'src/parser.c' },
               branch = 'main',
            },
         }
         require('nvim-treesitter.configs').setup(opts)
         -- There are additional nvim-treesitter modules that you can use to interact
         -- with nvim-treesitter. You should go explore a few and see what interests you:
         --
         --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
         --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
         --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
      end,
   },
}
