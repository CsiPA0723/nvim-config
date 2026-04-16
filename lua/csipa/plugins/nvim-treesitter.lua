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
      branch = 'main',
      lazy = false,
      config = function(_, _)
         autocmd('User', {
            pattern = 'TSUpdate',
            callback = function()
               ---@diagnostic disable-next-line: missing-fields
               require('nvim-treesitter.parsers').lua_patterns = {
                  ---@diagnostic disable-next-line: missing-fields
                  install_info = {
                     url = 'https://github.com/OXY2DEV/tree-sitter-lua_patterns',
                  },
               }
            end,
         })
         autocmd('FileType', {
            pattern = { '*' },
            callback = function(ev)
               local lang = vim.treesitter.language.get_lang(ev.match)
               local installed = vim.api.nvim_get_runtime_file('parser/*', true)
               if
                  lang
                  and vim.tbl_contains(installed, function(parser)
                     return lang == vim.fn.fnamemodify(parser, ':t:r')
                  end, { predicate = true })
               then
                  vim.treesitter.start()
               end
            end,
         })
         -- There are additional nvim-treesitter modules that you can use to interact
         -- with nvim-treesitter. You should go explore a few and see what interests you:
         --
         --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
         --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
         --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
         require('nvim-treesitter').install({
            'angular',
            'bash',
            'c',
            'css',
            'html',
            'http',
            'java',
            'javascript',
            'latex',
            'lua',
            'luadoc',
            'lua_patterns',
            'markdown',
            'markdown_inline',
            'regex',
            'svelte',
            'scss',
            'norg',
            'tsx',
            'typst',
            'vim',
            'vimdoc',
            'vue',
         })
      end,
   },
}
